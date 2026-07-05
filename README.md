# Установка NixOS (Btrfs + LUKS)

## 1. Установить переменные:

Если диск определяется как /dev/nvme0n1:
```
DISKSUB=nvme0n1
DISK=/dev/$DISKSUB
DISK_P1="${DISK}p1"
DISK_P2="${DISK}p2"
```

Если диск определяется как /dev/sda:
```
DISKSUB=sda
DISK=/dev/$DISKSUB
DISK_P1="${DISK}1"
DISK_P2="${DISK}2"
```

где `DISKSUB` - диск, на который нужно установить систему.

## 2. Разметка диска

1. Стереть текущую разметку на диске:
```
sudo sgdisk --zap-all $DISK
```

2. Создать EFI-раздел (1 ГБ):
```
sudo sgdisk -n 1:0+1G -t 1:EF00 $DISK
```

3. Создать системный раздел:
```
sudo sgdisk -n 2:0:0 -t 2:8300 $DISK
```

## 3. Настройка шифрования

1. Создать LUKS-контейнер и установить метку
```
sudo cryptsetup luksFormat ${DISK_P2}
sudo cryptsetup config ${DISK_P2} --label NIXCRYPT
```

2. Расшифровать LUKS-контейнер
```
sudo cryptsetup luksOpen ${DISK_P2} NIXCRYPT
```

## 4. Создание файловых систем

1. Создать EFI-раздел:
```
sudo mkfs.vfat -F32 -n NIXBOOT ${DISK_P1}
```

2. Создать Btrfs-раздел:
```
sudo mkfs.btrfs -L NIXROOT /dev/mapper/NIXCRYPT
```

3. Создать подразделы в Btrfs:
```
sudo mkdir /mnt-tmp
sudo mount /dev/mapper/NIXCRYPT /mnt-tmp
sudo btrfs subvolume create /mnt-tmp/@nix
sudo btrfs subvolume create /mnt-tmp/@persistent
sudo umount /mnt-tmp
sudo rm -rf /mnt-tmp
```

## 5. Монтирование файловых систем

1. Монтировать подразделы NixOS:
```
sudo mkdir -p /mnt
sudo mount -o subvol=@nix,noatime,discard,compress=zstd /dev/mapper/NIXCRYPT /mnt

sudo mkdir -p /mnt/persistent
sudo mount -o subvol=@persistent,noatime,discard,compress=zstd /dev/mapper/NIXCRYPT /mnt/persistent
```

2. Монтировать EFI-раздел:
```
sudo mkdir -p /mnt/boot
sudo mount ${DISK_P1} /mnt/boot
```

## 6. Применение конфигурации

```
sudo nixos-install --flake github:jorlyf/dotfiles#HOST
```

где `HOST` - название конфигурации
