# Lab 2 - Linux Volume Manager

### Objective:-
    To create logical volumes as part of a single logical volume group for a new hard drive. The volumes should be formated as xfs. 

### Steps:-

* Since the physical volume is not added to the system, the first thing to do is to create the physical disk /dev/sdb.

  ```
    pvcreate /dev/sdb
  ```

  The above command will create the /dev/sdb volume in the system.

  Output:
  ```
  [root@machinee ~]# pvcreate /dev/sdb
  Physical volume "/dev/sdb" successfully created.
  ```

  Confirmation:
  ```
  [root@machinee ~]# pvs
    PV         VG     Fmt  Attr PSize  PFree
    /dev/sda2  centos lvm2 a--  <5.51g    0 
    /dev/sdb          lvm2 ---   5.72g 5.72g

  [root@machinee ~]# lvmdiskscan 
    /dev/centos/swap [     512.00 MiB] 
    /dev/sda1        [     500.00 MiB] 
    /dev/centos/root [      <5.01 GiB] 
    /dev/sda2        [       5.51 GiB] LVM physical volume
    /dev/sdb         [       5.72 GiB] LVM physical volume
    2 disks
    1 partition
    1 LVM physical volume whole disk
    1 LVM physical volume
  ```

* Create a volume group and adding physical volumes to the volume group.

  Command and Output:
  ```
  [root@machinee ~]# vgcreate vg_new /dev/sdb 
    Volume group "vg_new" successfully created
  ```

  Confirmation:
  ```
  [root@machinee ~]# pvs
    PV         VG     Fmt  Attr PSize  PFree 
    /dev/sda2  centos lvm2 a--  <5.51g     0 
    /dev/sdb   vg_new lvm2 a--  <5.72g <5.72g
  [root@machinee ~]# vgs
    VG     #PV #LV #SN Attr   VSize  VFree 
    centos   1   2   0 wz--n- <5.51g     0 
    vg_new   1   0   0 wz--n- <5.72g <5.72g
  ```

* Next, we can start creating the logical volumes on the volume group. 

  Command and Output:
  ```
  [root@machinee ~]# lvcreate -L 4G -n lv_home vg_new
    Logical volume "lv_home" created.
  [root@machinee ~]# lvcreate -L 1G -n lv_tmp vg_new
    Logical volume "lv_tmp" created.
  ```

  Confirmation:
  ```
  [root@machinee ~]# vgs -o +lv_size,lv_name
  VG     #PV #LV #SN Attr   VSize  VFree   LSize   LV     
  centos   1   2   0 wz--n- <5.51g      0  512.00m swap   
  centos   1   2   0 wz--n- <5.51g      0   <5.01g root   
  vg_new   1   2   0 wz--n- <5.72g 736.00m   4.00g lv_home
  vg_new   1   2   0 wz--n- <5.72g 736.00m   1.00g lv_tmp
  ```

* Format the volumes

  Command and Output:
  ```
  [root@machinee ~]# mkfs.xfs /dev/vg_new/lv_home 
  meta-data=/dev/vg_new/lv_home    isize=512    agcount=4, agsize=262144 blks
           =                       sectsz=512   attr=2, projid32bit=1
           =                       crc=1        finobt=0, sparse=0
  data     =                       bsize=4096   blocks=1048576, imaxpct=25
           =                       sunit=0      swidth=0 blks
  naming   =version 2              bsize=4096   ascii-ci=0 ftype=1
  log      =internal log           bsize=4096   blocks=2560, version=2
           =                       sectsz=512   sunit=0 blks, lazy-count=1
  realtime =none                   extsz=4096   blocks=0, rtextents=0
  ```
  
  ```
  [root@machinee ~]# mkfs.xfs /dev/vg_new/lv_tmp 
  meta-data=/dev/vg_new/lv_tmp     isize=512    agcount=4, agsize=65536 blks
           =                       sectsz=512   attr=2, projid32bit=1
           =                       crc=1        finobt=0, sparse=0
  data     =                       bsize=4096   blocks=262144, imaxpct=25
           =                       sunit=0      swidth=0 blks
  naming   =version 2              bsize=4096   ascii-ci=0 ftype=1
  log      =internal log           bsize=4096   blocks=2560, version=2
           =                       sectsz=512   sunit=0 blks, lazy-count=1
  realtime =none                   extsz=4096   blocks=0, rtextents=0
  ```

* Create mount points for the logical volumes

  Command and Output:
  ```
  [root@machinee ~]# mkdir /mnt/lv_home
  [root@machinee ~]# mkdir /mnt/lv_tmp
  ```
  
  Confirmation:
  ```
  [root@machinee ~]# ls /mnt*
    lv_home  lv_tmp
  ```
* Mount the logical volumes to the created mount points

  Command and Output:
  ```
  [root@machinee ~]# mount /dev/vg_new/lv_home /mnt/lv_home
  [root@machinee ~]# mount /dev/vg_new/lv_tmp /mnt/lv_tmp/
  ```

  Confirmation:
  ```
  [root@machinee ~]# mount | grep "vg_new"
    /dev/mapper/vg_new-lv_home on /mnt/lv_home type xfs (rw,relatime,seclabel,attr2,inode64,noquota)
    /dev/mapper/vg_new-lv_tmp on /mnt/lv_tmp type xfs (rw,relatime,seclabel,attr2,inode64,noquota)
  ```

The mount command above confirms that a logical volume mapped via /dev/mapper/ of file system type xfs has been mounted to /mnt/

* Confirmation via `fsdisk -l`

  ```
    Disk /dev/mapper/vg_new-lv_home: 4294 MB, 4294967296 bytes, 8388608 sectors
    Units = sectors of 1 * 512 = 512 bytes
    Sector size (logical/physical): 512 bytes / 512 bytes
    I/O size (minimum/optimal): 512 bytes / 512 bytes

    Disk /dev/mapper/vg_new-lv_tmp: 1073 MB, 1073741824 bytes, 2097152 sectors
    Units = sectors of 1 * 512 = 512 bytes
    Sector size (logical/physical): 512 bytes / 512 bytes
    I/O size (minimum/optimal): 512 bytes / 512 bytes

    [root@machinee ~]# vgs -o +lv_size,lv_name
      VG     #PV #LV #SN Attr   VSize  VFree   LSize   LV     
      centos   1   2   0 wz--n- <5.51g      0  512.00m swap   
      centos   1   2   0 wz--n- <5.51g      0   <5.01g root   
      vg_new   1   2   0 wz--n- <5.72g 736.00m   4.00g lv_home
      vg_new   1   2   0 wz--n- <5.72g 736.00m   1.00g lv_tmp
  ```

8. Output of /etc/fstab

```
[root@machinee ~]# cat /etc/fstab 

#
# /etc/fstab
# Created by anaconda on Sun Mar 22 18:53:23 2015
#
# Accessible filesystems, by reference, are maintained under '/dev/disk'
# See man pages fstab(5), findfs(8), mount(8) and/or blkid(8) for more info
#
/dev/mapper/centos-root /                       xfs     defaults        1 1
UUID=71438877-2509-4eb2-9c1d-dd119fb7b77f /boot                   xfs     defaults        1 2
/dev/mapper/centos-swap swap                    swap    defaults        0 0
/dev/mapper/vg_new-lv_home /mnt/lv_home xfs nodev 0 0
/dev/mapper/vg_new-lv_tmp /mnt/lv_tmp   xfs nodev,nosuid,noexec 0 0
```

#### References:
[DigitalOcean](https://www.digitalocean.com/community/tutorials/an-introduction-to-lvm-concepts-terminology-and-operations)

