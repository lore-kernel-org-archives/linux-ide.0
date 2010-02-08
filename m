From: =?UTF-8?B?SMOla29uIEzDuHZkYWw=?= <hlovdal@gmail.com>
Subject: "raid5:md0: read error not correctable (sector 795463080 on sdf1)"
	error on controller with SIL 3114
Date: Mon, 8 Feb 2010 12:11:51 +0100
Message-ID: <a01a16b51002080311i420f6429ld3545c44c04603eb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-fx0-f211.google.com ([209.85.220.211]:63370 "EHLO
	mail-fx0-f211.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750772Ab0BHLLx convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 8 Feb 2010 06:11:53 -0500
Received: by fxm3 with SMTP id 3so7452416fxm.39
        for <linux-ide@vger.kernel.org>; Mon, 08 Feb 2010 03:11:52 -0800 (PST)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hi. I have had some trouble with the machine I want to have as a file s=
erver.

After having let the "get raid up and running reliably" project lie
dormant for some time, I tried again this Friday. After connecting the
disks, the status was the following: 4 out of 6 disk in a raid6 setup
were recognised (see log-1). I was able to mount the volume when the
machine was finished booting.

I then added the two missing disks with mdadm, one of them started
rebuilding and the other one were not recognised in some way (log-2).
The rebuild of the disk was successfull (log-3), but later some errors
occured, see log-4 below, and now only three disks are left in the
array (log-5).

Are these errors related to Tejun's recent statement "Sil3112/3114 are
now virtually the only controllers with occassional and unresolved data
corruption issues."? Disks sda (hosting root file system for os), sdb
sdc and sdd are connected the motherboard while sde, sdf and sdg are
connected to a controller card using 3114:

01:04.0 RAID bus controller: Silicon Image, Inc. SiI 3114
[SATALink/SATARaid] Serial ATA Controller (rev 02)

=46eb  6 01:55:34 localhost kernel: sata_sil 0000:01:04.0: version 2.3
=46eb  6 01:55:34 localhost kernel: ACPI: PCI Interrupt Link [LNKA]
enabled at IRQ 19
=46eb  6 01:55:34 localhost kernel: sata_sil 0000:01:04.0: PCI INT A ->
Link[LNKA] -> GSI 19 (level, low) -> IRQ 19
=46eb  6 01:55:34 localhost kernel: sata_sil 0000:01:04.0: Applying
R_ERR on DMA activate FIS errata fix
=46eb  6 01:55:34 localhost kernel: scsi6 : sata_sil
=46eb  6 01:55:34 localhost kernel: scsi7 : sata_sil
=46eb  6 01:55:34 localhost kernel: scsi8 : sata_sil
=46eb  6 01:55:34 localhost kernel: scsi9 : sata_sil
=46eb  6 01:55:34 localhost kernel: ata7: SATA max UDMA/100 mmio
m1024@0xfebffc00 tf 0xfebffc80 irq 19
=46eb  6 01:55:34 localhost kernel: ata8: SATA max UDMA/100 mmio
m1024@0xfebffc00 tf 0xfebffcc0 irq 19
=46eb  6 01:55:34 localhost kernel: ata9: SATA max UDMA/100 mmio
m1024@0xfebffc00 tf 0xfebffe80 irq 19
=46eb  6 01:55:34 localhost kernel: ata10: SATA max UDMA/100 mmio
m1024@0xfebffc00 tf 0xfebffec0 irq 19


While I have not tested this time, I have previously when getting simil=
ar
errors run spinrite (http://www.grc.com/sr/spinrite.htm) on the disks
without finding any problems. So I do believe that this is not disk err=
ors.

The machine is running Fedora 10 with kernel 2.6.27.41-170.2.117.fc10.x=
86_64,
mdadm updated to the latest 3.0.3 release from Fedora 12.

Unfortunately I have too little time to do any thorough investigation
on this. My plan is to upgrade to Fedora 12 and maybe build some latest
kernel to see if that makes any difference, and if not (or probably in
any case) swap out the 3114 card with a Promise TX4 card instead.


BR H=C3=A5kon L=C3=B8vdal



---BEGIN log-1---
=46eb  6 01:55:34 localhost kernel: md: md0 stopped.
=46eb  6 01:55:34 localhost kernel: md: bind<sdc1>
=46eb  6 01:55:34 localhost kernel: md: bind<sdd1>
=46eb  6 01:55:34 localhost kernel: md: bind<sde1>
=46eb  6 01:55:34 localhost kernel: md: bind<sdf1>
=46eb  6 01:55:34 localhost kernel: md: bind<sdg1>
=46eb  6 01:55:34 localhost kernel: md: bind<sdb1>
=46eb  6 01:55:34 localhost kernel: md: kicking non-fresh sdd1 from arr=
ay!
=46eb  6 01:55:34 localhost kernel: md: unbind<sdd1>
=46eb  6 01:55:34 localhost kernel: md: export_rdev(sdd1)
=46eb  6 01:55:34 localhost kernel: md: kicking non-fresh sdc1 from arr=
ay!
=46eb  6 01:55:34 localhost kernel: md: unbind<sdc1>
=46eb  6 01:55:34 localhost kernel: md: export_rdev(sdc1)
=2E..
=46eb  6 01:55:34 localhost kernel: raid6: using algorithm sse2x4 (7152=
 MB/s)
=46eb  6 01:55:34 localhost kernel: md: raid6 personality registered fo=
r level 6
=46eb  6 01:55:34 localhost kernel: md: raid5 personality registered fo=
r level 5
=46eb  6 01:55:34 localhost kernel: md: raid4 personality registered fo=
r level 4
=46eb  6 01:55:34 localhost kernel: raid5: device sdb1 operational as r=
aid disk 0
=46eb  6 01:55:34 localhost kernel: raid5: device sdg1 operational as r=
aid disk 5
=46eb  6 01:55:34 localhost kernel: raid5: device sdf1 operational as r=
aid disk 4
=46eb  6 01:55:34 localhost kernel: raid5: device sde1 operational as r=
aid disk 3
=46eb  6 01:55:34 localhost kernel: raid5: allocated 6396kB for md0
=46eb  6 01:55:34 localhost kernel: raid5: raid level 6 set md0 active
with 4 out of 6 devices, algorithm 2
=46eb  6 01:55:34 localhost kernel: RAID5 conf printout:
=46eb  6 01:55:34 localhost kernel: --- rd:6 wd:4
=46eb  6 01:55:34 localhost kernel: disk 0, o:1, dev:sdb1
=46eb  6 01:55:34 localhost kernel: disk 3, o:1, dev:sde1
=46eb  6 01:55:34 localhost kernel: disk 4, o:1, dev:sdf1
=46eb  6 01:55:34 localhost kernel: disk 5, o:1, dev:sdg1
=46eb  6 01:55:34 localhost kernel: md0: bitmap initialized from disk:
read 22/22 pages, set 350044 bits
=46eb  6 01:55:34 localhost kernel: created bitmap (350 pages) for devi=
ce md0
=46eb  6 01:55:34 localhost kernel: device-mapper: multipath: version 1=
=2E0.5 loaded
---END log-1---




---BEGIN log-2---
prompt>cat /proc/mdstat
Personalities : [raid6] [raid5] [raid4]
md0 : active raid6 sdd1[2](S) sdc1[1] sdb1[0] sdg1[5] sdf1[4] sde1[3]
      2930287360 blocks super 1.2 level 6, 64k chunk, algorithm 2 [6/4]=
 [U__UUU]
      [=3D=3D>..................]  recovery =3D 10.5% (77381344/7325718=
40)
finish=3D1096.9min speed=3D9954K/sec
      bitmap: 350/350 pages [1400KB], 1024KB chunk

unused devices: <none>
prompt>mdadm --detail /dev/md0
/dev/md0:
        Version : 1.2
  Creation Time : Sun Apr  5 02:04:26 2009
     Raid Level : raid6
     Array Size : 2930287360 (2794.54 GiB 3000.61 GB)
  Used Dev Size : 732571840 (698.63 GiB 750.15 GB)
   Raid Devices : 6
  Total Devices : 6
    Persistence : Superblock is persistent

  Intent Bitmap : Internal

    Update Time : Sat Feb  6 03:39:42 2010
          State : active, degraded, recovering
 Active Devices : 4
Working Devices : 6
 Failed Devices : 0
  Spare Devices : 2

     Chunk Size : 64K

 Rebuild Status : 10% complete

           Name : localhost:0  (local to host localhost)
           UUID : 21dc7bab:50f114aa:d3cfc5e4:24d0ec1f
         Events : 201694

    Number   Major   Minor   RaidDevice State
       0       8       17        0      active sync   /dev/sdb1
       1       8       33        1      spare rebuilding   /dev/sdc1
       2       0        0        2      removed
       3       8       65        3      active sync   /dev/sde1
       4       8       81        4      active sync   /dev/sdf1
       5       8       97        5      active sync   /dev/sdg1

       2       8       49        -      spare   /dev/sdd1
---END log-2---



---BEGIN log-3---
=46eb  6 03:04:45 localhost kernel: md: bind<sdc1>
=46eb  6 03:04:46 localhost kernel: RAID5 conf printout:
=46eb  6 03:04:46 localhost kernel: --- rd:6 wd:4
=46eb  6 03:04:46 localhost kernel: disk 0, o:1, dev:sdb1
=46eb  6 03:04:46 localhost kernel: disk 1, o:1, dev:sdc1
=46eb  6 03:04:46 localhost kernel: disk 3, o:1, dev:sde1
=46eb  6 03:04:46 localhost kernel: disk 4, o:1, dev:sdf1
=46eb  6 03:04:46 localhost kernel: disk 5, o:1, dev:sdg1
=46eb  6 03:04:46 localhost kernel: md: recovery of RAID array md0
=46eb  6 03:04:46 localhost kernel: md: minimum _guaranteed_  speed:
1000 KB/sec/disk.
=46eb  6 03:04:46 localhost kernel: md: using maximum available idle IO
bandwidth (but not more than 200000 KB/sec) for recovery.
=46eb  6 03:04:46 localhost kernel: md: using 128k window, over a total
of 732571840 blocks.
=46eb  6 03:05:01 localhost CROND[4458]: (root) CMD (LANG=3DC LC_ALL=3D=
C
/usr/bin/mrtg /etc/mrtg/mrtg.cfg --lock-file /var/lock/mrtg/mrtg_l
--confcache-file /var/lib/mrtg/mrtg.ok)
=46eb  6 03:05:13 localhost kernel: md: bind<sdd1>
=46eb  6 03:08:22 localhost kernel: kjournald2 starting.  Commit
interval 5 seconds
=46eb  6 03:08:22 localhost kernel: EXT4-fs warning: checktime reached,
running e2fsck is recommended
=46eb  6 03:08:22 localhost kernel: EXT4 FS on dm-0, internal journal
=46eb  6 03:08:22 localhost kernel: EXT4-fs: delayed allocation enabled
=46eb  6 03:08:22 localhost kernel: EXT4-fs: file extents enabled
=46eb  6 03:08:22 localhost kernel: EXT4-fs: mballoc enabled
=46eb  6 03:08:22 localhost kernel: EXT4-fs: mounted filesystem with
writeback data mode.
=46eb  6 03:08:22 localhost kernel: SELinux: initialized (dev dm-0, typ=
e
ext4), uses xattr
---END log-3---


---BEGIN log-4---
=46eb  6 07:09:57 localhost kernel: ata8.00: exception Emask 0x0 SAct
0x0 SErr 0x0 action 0x0
=46eb  6 07:09:57 localhost kernel: ata8.00: BMDMA2 stat 0x6c0009
=46eb  6 07:09:57 localhost kernel: ata8.00: cmd
25/00:80:cf:cd:69/00:00:2f:00:00/e0 tag 0 dma 65536 in
=46eb  6 07:09:57 localhost kernel:         res
51/40:00:e4:cd:69/00:00:2f:00:00/e0 Emask 0x9 (media error)
=46eb  6 07:09:57 localhost kernel: ata8.00: status: { DRDY ERR }
=46eb  6 07:09:57 localhost kernel: ata8.00: error: { UNC }
=46eb  6 07:09:58 localhost kernel: ata8.00: configured for UDMA/100
=46eb  6 07:09:58 localhost kernel: ata8: EH complete
=46eb  6 07:09:59 localhost kernel: ata8.00: exception Emask 0x0 SAct
0x0 SErr 0x0 action 0x0
=46eb  6 07:09:59 localhost kernel: ata8.00: BMDMA2 stat 0x6c0009
=46eb  6 07:09:59 localhost kernel: ata8.00: cmd
25/00:80:cf:cd:69/00:00:2f:00:00/e0 tag 0 dma 65536 in
=46eb  6 07:09:59 localhost kernel:         res
51/40:00:e4:cd:69/00:00:2f:00:00/e0 Emask 0x9 (media error)
=46eb  6 07:09:59 localhost kernel: ata8.00: status: { DRDY ERR }
=46eb  6 07:09:59 localhost kernel: ata8.00: error: { UNC }
=46eb  6 07:10:00 localhost kernel: ata8.00: configured for UDMA/100
=46eb  6 07:10:00 localhost kernel: ata8: EH complete
=46eb  6 07:10:01 localhost kernel: ata8.00: exception Emask 0x0 SAct
0x0 SErr 0x0 action 0x0
=46eb  6 07:10:01 localhost kernel: ata8.00: BMDMA2 stat 0x6c0009
=46eb  6 07:10:01 localhost kernel: ata8.00: cmd
25/00:80:cf:cd:69/00:00:2f:00:00/e0 tag 0 dma 65536 in
=46eb  6 07:10:01 localhost kernel:         res
51/40:00:e4:cd:69/00:00:2f:00:00/e0 Emask 0x9 (media error)
=46eb  6 07:10:01 localhost kernel: ata8.00: status: { DRDY ERR }
=46eb  6 07:10:01 localhost kernel: ata8.00: error: { UNC }
=46eb  6 07:10:01 localhost CROND[8331]: (root) CMD (LANG=3DC LC_ALL=3D=
C
/usr/bin/mrtg /etc/mrtg/mrtg.cfg --lock-file /var/lock/mrtg/mrtg_l
--confcache-file /var/lib/mrtg/mrtg.ok)
=46eb  6 07:10:02 localhost kernel: ata8.00: configured for UDMA/100
=46eb  6 07:10:02 localhost kernel: ata8: EH complete
=46eb  6 07:10:03 localhost kernel: ata8.00: exception Emask 0x0 SAct
0x0 SErr 0x0 action 0x0
=46eb  6 07:10:03 localhost kernel: ata8.00: BMDMA2 stat 0x6c0009
=46eb  6 07:10:03 localhost kernel: ata8.00: cmd
25/00:80:cf:cd:69/00:00:2f:00:00/e0 tag 0 dma 65536 in
=46eb  6 07:10:03 localhost kernel:         res
51/40:00:e4:cd:69/00:00:2f:00:00/e0 Emask 0x9 (media error)
=46eb  6 07:10:03 localhost kernel: ata8.00: status: { DRDY ERR }
=46eb  6 07:10:03 localhost kernel: ata8.00: error: { UNC }
=46eb  6 07:10:04 localhost kernel: ata8.00: configured for UDMA/100
=46eb  6 07:10:04 localhost kernel: ata8: EH complete
=46eb  6 07:10:05 localhost kernel: ata8.00: exception Emask 0x0 SAct
0x0 SErr 0x0 action 0x0
=46eb  6 07:10:05 localhost kernel: ata8.00: BMDMA2 stat 0x6c0009
=46eb  6 07:10:05 localhost kernel: ata8.00: cmd
25/00:80:cf:cd:69/00:00:2f:00:00/e0 tag 0 dma 65536 in
=46eb  6 07:10:05 localhost kernel:         res
51/40:00:e4:cd:69/00:00:2f:00:00/e0 Emask 0x9 (media error)
=46eb  6 07:10:05 localhost kernel: ata8.00: status: { DRDY ERR }
=46eb  6 07:10:05 localhost kernel: ata8.00: error: { UNC }
=46eb  6 07:10:06 localhost kernel: ata8.00: configured for UDMA/100
=46eb  6 07:10:06 localhost kernel: ata8: EH complete
=46eb  6 07:10:07 localhost kernel: ata8.00: exception Emask 0x0 SAct
0x0 SErr 0x0 action 0x0
=46eb  6 07:10:07 localhost kernel: ata8.00: BMDMA2 stat 0x6c0009
=46eb  6 07:10:07 localhost kernel: ata8.00: cmd
25/00:80:cf:cd:69/00:00:2f:00:00/e0 tag 0 dma 65536 in
=46eb  6 07:10:07 localhost kernel:         res
51/40:00:e4:cd:69/00:00:2f:00:00/e0 Emask 0x9 (media error)
=46eb  6 07:10:07 localhost kernel: ata8.00: status: { DRDY ERR }
=46eb  6 07:10:07 localhost kernel: ata8.00: error: { UNC }
=46eb  6 07:10:08 localhost kernel: ata8.00: configured for UDMA/100
=46eb  6 07:10:08 localhost kernel: sd 7:0:0:0: [sdf] Result:
hostbyte=3DDID_OK driverbyte=3DDRIVER_SENSE,SUGGEST_OK
=46eb  6 07:10:08 localhost kernel: sd 7:0:0:0: [sdf] Sense Key : Mediu=
m
Error [current] [descriptor]
=46eb  6 07:10:08 localhost kernel: Descriptor sense data with sense
descriptors (in hex):
=46eb  6 07:10:08 localhost kernel:        72 03 11 04 00 00 00 0c 00 0=
a
80 00 00 00 00 00
=46eb  6 07:10:08 localhost kernel:        2f 69 cd e4
=46eb  6 07:10:08 localhost kernel: sd 7:0:0:0: [sdf] Add. Sense:
Unrecovered read error - auto reallocate failed
=46eb  6 07:10:08 localhost kernel: end_request: I/O error, dev sdf,
sector 795463140
=46eb  6 07:10:08 localhost kernel: raid5:md0: read error not
correctable (sector 795463072 on sdf1).
=46eb  6 07:10:08 localhost kernel: raid5: Disk failure on sdf1, disabl=
ing device.
=46eb  6 07:10:08 localhost kernel: raid5: Operation continuing on 3 de=
vices.
=46eb  6 07:10:08 localhost kernel: raid5:md0: read error not
correctable (sector 795463080 on sdf1).
=46eb  6 07:10:08 localhost kernel: raid5:md0: read error not
correctable (sector 795463088 on sdf1).
=46eb  6 07:10:08 localhost kernel: raid5:md0: read error not
correctable (sector 795463096 on sdf1).
=46eb  6 07:10:08 localhost kernel: raid5:md0: read error not
correctable (sector 795463104 on sdf1).
=46eb  6 07:10:08 localhost kernel: raid5:md0: read error not
correctable (sector 795463112 on sdf1).
=46eb  6 07:10:08 localhost kernel: raid5:md0: read error not
correctable (sector 795463120 on sdf1).
=46eb  6 07:10:08 localhost kernel: raid5:md0: read error not
correctable (sector 795463128 on sdf1).
=46eb  6 07:10:08 localhost kernel: raid5:md0: read error not
correctable (sector 795463136 on sdf1).
=46eb  6 07:10:08 localhost kernel: raid5:md0: read error not
correctable (sector 795463144 on sdf1).
=46eb  6 07:10:08 localhost kernel: ata8: EH complete
=46eb  6 07:10:09 localhost kernel: ata8.00: exception Emask 0x0 SAct
0x0 SErr 0x0 action 0x0
=46eb  6 07:10:09 localhost kernel: ata8.00: BMDMA2 stat 0x6c0009
=46eb  6 07:10:09 localhost kernel: ata8.00: cmd
25/00:10:4f:ce:69/00:03:2f:00:00/e0 tag 0 dma 401408 in
=46eb  6 07:10:09 localhost kernel:         res
51/40:00:65:ce:69/00:00:2f:00:00/e0 Emask 0x9 (media error)
=46eb  6 07:10:09 localhost kernel: ata8.00: status: { DRDY ERR }
=46eb  6 07:10:09 localhost kernel: ata8.00: error: { UNC }
=46eb  6 07:10:11 localhost kernel: ata8.00: configured for UDMA/100
=46eb  6 07:10:11 localhost kernel: ata8: EH complete
=46eb  6 07:10:12 localhost kernel: ata8.00: exception Emask 0x0 SAct
0x0 SErr 0x0 action 0x0
=46eb  6 07:10:12 localhost kernel: ata8.00: BMDMA2 stat 0x6c0009
=46eb  6 07:10:12 localhost kernel: ata8.00: cmd
25/00:10:4f:ce:69/00:03:2f:00:00/e0 tag 0 dma 401408 in
=46eb  6 07:10:12 localhost kernel:         res
51/40:00:66:ce:69/00:00:2f:00:00/e0 Emask 0x9 (media error)
=46eb  6 07:10:12 localhost kernel: ata8.00: status: { DRDY ERR }
=46eb  6 07:10:12 localhost kernel: ata8.00: error: { UNC }
=46eb  6 07:10:13 localhost kernel: ata8.00: configured for UDMA/100
=46eb  6 07:10:13 localhost kernel: ata8: EH complete
=46eb  6 07:10:14 localhost kernel: ata8.00: exception Emask 0x0 SAct
0x0 SErr 0x0 action 0x0
=46eb  6 07:10:14 localhost kernel: ata8.00: BMDMA2 stat 0x6c0009
=46eb  6 07:10:14 localhost kernel: ata8.00: cmd
25/00:10:4f:ce:69/00:03:2f:00:00/e0 tag 0 dma 401408 in
=46eb  6 07:10:14 localhost kernel:         res
51/40:00:66:ce:69/00:00:2f:00:00/e0 Emask 0x9 (media error)
=46eb  6 07:10:14 localhost kernel: ata8.00: status: { DRDY ERR }
=46eb  6 07:10:14 localhost kernel: ata8.00: error: { UNC }
=46eb  6 07:10:15 localhost kernel: ata8.00: configured for UDMA/100
=46eb  6 07:10:15 localhost kernel: ata8: EH complete
=46eb  6 07:10:16 localhost kernel: ata8.00: exception Emask 0x0 SAct
0x0 SErr 0x0 action 0x0
=46eb  6 07:10:16 localhost kernel: ata8.00: BMDMA2 stat 0x6c0009
=46eb  6 07:10:16 localhost kernel: ata8.00: cmd
25/00:10:4f:ce:69/00:03:2f:00:00/e0 tag 0 dma 401408 in
=46eb  6 07:10:16 localhost kernel:         res
51/40:00:66:ce:69/00:00:2f:00:00/e0 Emask 0x9 (media error)
=46eb  6 07:10:16 localhost kernel: ata8.00: status: { DRDY ERR }
=46eb  6 07:10:16 localhost kernel: ata8.00: error: { UNC }
=46eb  6 07:10:17 localhost kernel: ata8.00: configured for UDMA/100
=46eb  6 07:10:17 localhost kernel: ata8: EH complete
=46eb  6 07:10:18 localhost kernel: ata8.00: exception Emask 0x0 SAct
0x0 SErr 0x0 action 0x0
=46eb  6 07:10:18 localhost kernel: ata8.00: BMDMA2 stat 0x6c0009
=46eb  6 07:10:18 localhost kernel: ata8.00: cmd
25/00:10:4f:ce:69/00:03:2f:00:00/e0 tag 0 dma 401408 in
=46eb  6 07:10:18 localhost kernel:         res
51/40:00:66:ce:69/00:00:2f:00:00/e0 Emask 0x9 (media error)
=46eb  6 07:10:18 localhost kernel: ata8.00: status: { DRDY ERR }
=46eb  6 07:10:18 localhost kernel: ata8.00: error: { UNC }
=46eb  6 07:10:19 localhost kernel: ata8.00: configured for UDMA/100
=46eb  6 07:10:19 localhost kernel: ata8: EH complete
=46eb  6 07:10:20 localhost kernel: ata8.00: exception Emask 0x0 SAct
0x0 SErr 0x0 action 0x0
=46eb  6 07:10:20 localhost kernel: ata8.00: BMDMA2 stat 0x6c0009
=46eb  6 07:10:20 localhost kernel: ata8.00: cmd
25/00:10:4f:ce:69/00:03:2f:00:00/e0 tag 0 dma 401408 in
=46eb  6 07:10:20 localhost kernel:         res
51/40:00:66:ce:69/00:00:2f:00:00/e0 Emask 0x9 (media error)
=46eb  6 07:10:20 localhost kernel: ata8.00: status: { DRDY ERR }
=46eb  6 07:10:20 localhost kernel: ata8.00: error: { UNC }
=46eb  6 07:10:21 localhost kernel: ata8.00: configured for UDMA/100
=46eb  6 07:10:21 localhost kernel: sd 7:0:0:0: [sdf] Result:
hostbyte=3DDID_OK driverbyte=3DDRIVER_SENSE,SUGGEST_OK
=46eb  6 07:10:21 localhost kernel: sd 7:0:0:0: [sdf] Sense Key : Mediu=
m
Error [current] [descriptor]
=46eb  6 07:10:21 localhost kernel: Descriptor sense data with sense
descriptors (in hex):
=46eb  6 07:10:21 localhost kernel:        72 03 11 04 00 00 00 0c 00 0=
a
80 00 00 00 00 00
=46eb  6 07:10:21 localhost kernel:        2f 69 ce 66
=46eb  6 07:10:21 localhost kernel: sd 7:0:0:0: [sdf] Add. Sense:
Unrecovered read error - auto reallocate failed
=46eb  6 07:10:21 localhost kernel: end_request: I/O error, dev sdf,
sector 795463270
=46eb  6 07:10:21 localhost kernel: __ratelimit: 4 callbacks suppressed
=46eb  6 07:10:21 localhost kernel: raid5:md0: read error not
correctable (sector 795463200 on sdf1).
=46eb  6 07:10:21 localhost kernel: raid5:md0: read error not
correctable (sector 795463208 on sdf1).
=46eb  6 07:10:21 localhost kernel: raid5:md0: read error not
correctable (sector 795463216 on sdf1).
=46eb  6 07:10:21 localhost kernel: raid5:md0: read error not
correctable (sector 795463224 on sdf1).
=46eb  6 07:10:21 localhost kernel: raid5:md0: read error not
correctable (sector 795463232 on sdf1).
=46eb  6 07:10:21 localhost kernel: raid5:md0: read error not
correctable (sector 795463240 on sdf1).
=46eb  6 07:10:21 localhost kernel: raid5:md0: read error not
correctable (sector 795463248 on sdf1).
=46eb  6 07:10:21 localhost kernel: raid5:md0: read error not
correctable (sector 795463256 on sdf1).
=46eb  6 07:10:21 localhost kernel: raid5:md0: read error not
correctable (sector 795463264 on sdf1).
=46eb  6 07:10:21 localhost kernel: raid5:md0: read error not
correctable (sector 795463272 on sdf1).
=46eb  6 07:10:21 localhost kernel: ata8: EH complete
=46eb  6 07:10:21 localhost kernel: sd 7:0:0:0: [sdf] 1465149168
512-byte hardware sectors (750156 MB)
=46eb  6 07:10:21 localhost kernel: sd 7:0:0:0: [sdf] Write Protect is =
off
=46eb  6 07:10:21 localhost kernel: sd 7:0:0:0: [sdf] Mode Sense: 00 3a=
 00 00
=46eb  6 07:10:21 localhost kernel: sd 7:0:0:0: [sdf] Write cache:
enabled, read cache: enabled, doesn't support DPO or FUA
=46eb  6 07:10:21 localhost kernel: sd 7:0:0:0: [sdf] 1465149168
512-byte hardware sectors (750156 MB)
=46eb  6 07:10:21 localhost kernel: sd 7:0:0:0: [sdf] Write Protect is =
off
=46eb  6 07:10:21 localhost kernel: sd 7:0:0:0: [sdf] Mode Sense: 00 3a=
 00 00
=46eb  6 07:10:21 localhost kernel: sd 7:0:0:0: [sdf] Write cache:
enabled, read cache: enabled, doesn't support DPO or FUA
=46eb  6 07:10:21 localhost kernel: md: md0: recovery done.
=46eb  6 07:10:21 localhost kernel: RAID5 conf printout:
=46eb  6 07:10:21 localhost kernel: --- rd:6 wd:3
=46eb  6 07:10:21 localhost kernel: disk 0, o:1, dev:sdb1
=46eb  6 07:10:21 localhost kernel: disk 1, o:1, dev:sdc1
=46eb  6 07:10:21 localhost kernel: disk 3, o:1, dev:sde1
=46eb  6 07:10:21 localhost kernel: disk 4, o:0, dev:sdf1
=46eb  6 07:10:21 localhost kernel: disk 5, o:1, dev:sdg1
=46eb  6 07:10:21 localhost kernel: RAID5 conf printout:
=46eb  6 07:10:21 localhost kernel: --- rd:6 wd:3
=46eb  6 07:10:21 localhost kernel: disk 0, o:1, dev:sdb1
=46eb  6 07:10:21 localhost kernel: disk 3, o:1, dev:sde1
=46eb  6 07:10:21 localhost kernel: disk 4, o:0, dev:sdf1
=46eb  6 07:10:21 localhost kernel: disk 5, o:1, dev:sdg1
=46eb  6 07:10:21 localhost kernel: RAID5 conf printout:
=46eb  6 07:10:21 localhost kernel: --- rd:6 wd:3
=46eb  6 07:10:21 localhost kernel: disk 0, o:1, dev:sdb1
=46eb  6 07:10:21 localhost kernel: disk 3, o:1, dev:sde1
=46eb  6 07:10:21 localhost kernel: disk 4, o:0, dev:sdf1
=46eb  6 07:10:21 localhost kernel: disk 5, o:1, dev:sdg1
=46eb  6 07:10:21 localhost kernel: RAID5 conf printout:
=46eb  6 07:10:21 localhost kernel: --- rd:6 wd:3
=46eb  6 07:10:21 localhost kernel: disk 0, o:1, dev:sdb1
=46eb  6 07:10:21 localhost kernel: disk 3, o:1, dev:sde1
=46eb  6 07:10:21 localhost kernel: disk 5, o:1, dev:sdg1
---END log-4---


---BEGIN log-5---
localhost>mdadm --detail /dev/md0
/dev/md0:
        Version : 1.2
  Creation Time : Sun Apr  5 02:04:26 2009
     Raid Level : raid6
     Array Size : 2930287360 (2794.54 GiB 3000.61 GB)
  Used Dev Size : 732571840 (698.63 GiB 750.15 GB)
   Raid Devices : 6
  Total Devices : 6
    Persistence : Superblock is persistent

  Intent Bitmap : Internal

    Update Time : Sat Feb  6 07:10:21 2010
          State : active, degraded
 Active Devices : 3
Working Devices : 5
 Failed Devices : 1
  Spare Devices : 2

     Chunk Size : 64K

           Name : localhost:0  (local to host localhost)
           UUID : 21dc7bab:50f114aa:d3cfc5e4:24d0ec1f
         Events : 202400

    Number   Major   Minor   RaidDevice State
       0       8       17        0      active sync   /dev/sdb1
       1       0        0        1      removed
       2       0        0        2      removed
       3       8       65        3      active sync   /dev/sde1
       4       0        0        4      removed
       5       8       97        5      active sync   /dev/sdg1

       1       8       33        -      spare   /dev/sdc1
       2       8       49        -      spare   /dev/sdd1
       4       8       81        -      faulty spare   /dev/sdf1
---END log-5---
