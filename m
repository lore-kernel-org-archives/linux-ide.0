From: "Wesley Lim" <wesleylim@gmail.com>
Subject: sata_sil or libata?
Date: Sat, 1 Apr 2006 12:15:34 -0800
Message-ID: <a8b98fc60604011215u4c426e21qc3c4c1e852d28b60@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wproxy.gmail.com ([64.233.184.232]:35763 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932168AbWDAUPf convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 1 Apr 2006 15:15:35 -0500
Received: by wproxy.gmail.com with SMTP id i22so1092686wra
        for <linux-ide@vger.kernel.org>; Sat, 01 Apr 2006 12:15:34 -0800 (PST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com
Cc: linux-ide@vger.kernel.org

Jeff,

I have encountered a problem with my SATA controller and would like to
report the bug - I'm not sure if you are the person to contact but
here goes:

2.6.16.1 from kernel.org
Syba SD-SATA150R PCI (Silicon Image 3112A flashed to 4.2.76)
Maxtor 6L250M0 Rev:BACE

I have it running as part of a degraded RAID 5 (I was planning to
transition to a full RAID 5 but I guess not with the errors I'm
getting =(
When I was copying from a regular device (hdc3) to the degraded array
md2 (composed of hda3 and sda3) ata1 would start to report errors. I
keep getting errors reporting the same sectors.

I was wondering if this could possibly be firmware related?

Let me know if I can provide any additional information to help solve this bug.

Thanks for the help!
Wesley

dmesg:
libata version 1.20 loaded.
sata_sil 0000:00:09.0: version 0.9
ACPI: PCI Interrupt 0000:00:09.0[A] -> GSI 17 (level, low) -> IRQ 16
ata1: SATA max UDMA/100 cmd 0xCC802E80 ctl 0xCC802E8A bmdma 0xCC802E00 irq 16
ata2: SATA max UDMA/100 cmd 0xCC802EC0 ctl 0xCC802ECA bmdma 0xCC802E08 irq 16
ata1: SATA link up 1.5 Gbps (SStatus 113)
ata1: dev 0 cfg 49:2f00 82:7c6b 83:7f09 84:4673 85:7c69 86:3e01 87:4663 88:407f
ata1: dev 0 ATA-7, max UDMA/133, 490234752 sectors: LBA48
ata1: dev 0 configured for UDMA/100
scsi0 : sata_sil
ata2: SATA link down (SStatus 0)
scsi1 : sata_sil
  Vendor: ATA       Model: Maxtor 6L250M0    Rev: BACE
  Type:   Direct-Access                      ANSI SCSI revision: 05
SCSI device sda: 490234752 512-byte hdwr sectors (251000 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
SCSI device sda: 490234752 512-byte hdwr sectors (251000 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
 sda: sda1 sda2 sda3
sd 0:0:0:0: Attached scsi disk sda

ERROR WHILE rsync -avx / /mnt/:
ata1: no sense translation for status: 0x51
ata1: translated ATA stat/err 0x51/00 to SCSI SK/ASC/ASCQ 0x3/11/04
ata1: status=0x51 { DriveReady SeekComplete Error }
ata1: no sense translation for status: 0x51
ata1: translated ATA stat/err 0x51/00 to SCSI SK/ASC/ASCQ 0x3/11/04
ata1: status=0x51 { DriveReady SeekComplete Error }
ata1: no sense translation for status: 0x51
ata1: translated ATA stat/err 0x51/00 to SCSI SK/ASC/ASCQ 0x3/11/04
ata1: status=0x51 { DriveReady SeekComplete Error }
ata1: no sense translation for status: 0x51
ata1: translated ATA stat/err 0x51/00 to SCSI SK/ASC/ASCQ 0x3/11/04
ata1: status=0x51 { DriveReady SeekComplete Error }
ata1: no sense translation for status: 0x51
ata1: translated ATA stat/err 0x51/00 to SCSI SK/ASC/ASCQ 0x3/11/04
ata1: status=0x51 { DriveReady SeekComplete Error }
ata1: no sense translation for status: 0x51
ata1: translated ATA stat/err 0x51/00 to SCSI SK/ASC/ASCQ 0x3/11/04
ata1: status=0x51 { DriveReady SeekComplete Error }
sd 0:0:0:0: SCSI error: return code = 0x8000002
sda: Current: sense key: Medium Error
    Additional sense: Unrecovered read error - auto reallocate failed
end_request: I/O error, dev sda, sector 63268998
raid5: read error not correctable.
raid5: Disk failure on sda3, disabling device. Operation continuing on 1 devices
ata1: no sense translation for status: 0x51
ata1: translated ATA stat/err 0x51/00 to SCSI SK/ASC/ASCQ 0x3/11/04
ata1: status=0x51 { DriveReady SeekComplete Error }
ata1: no sense translation for status: 0x51
ata1: translated ATA stat/err 0x51/00 to SCSI SK/ASC/ASCQ 0x3/11/04
ata1: status=0x51 { DriveReady SeekComplete Error }
ata1: no sense translation for status: 0x51
ata1: translated ATA stat/err 0x51/00 to SCSI SK/ASC/ASCQ 0x3/11/04
ata1: status=0x51 { DriveReady SeekComplete Error }
ata1: no sense translation for status: 0x51
ata1: translated ATA stat/err 0x51/00 to SCSI SK/ASC/ASCQ 0x3/11/04
ata1: status=0x51 { DriveReady SeekComplete Error }
ata1: no sense translation for status: 0x51
ata1: translated ATA stat/err 0x51/00 to SCSI SK/ASC/ASCQ 0x3/11/04
ata1: status=0x51 { DriveReady SeekComplete Error }
ata1: no sense translation for status: 0x51
ata1: translated ATA stat/err 0x51/00 to SCSI SK/ASC/ASCQ 0x3/11/04
ata1: status=0x51 { DriveReady SeekComplete Error }
sd 0:0:0:0: SCSI error: return code = 0x8000002
sda: Current: sense key: Medium Error
    Additional sense: Unrecovered read error - auto reallocate failed
end_request: I/O error, dev sda, sector 63269006
raid5: read error not correctable.
ata1: no sense translation for status: 0x51
ata1: translated ATA stat/err 0x51/00 to SCSI SK/ASC/ASCQ 0x3/11/04
ata1: status=0x51 { DriveReady SeekComplete Error }
ata1: no sense translation for status: 0x51
ata1: translated ATA stat/err 0x51/00 to SCSI SK/ASC/ASCQ 0x3/11/04
ata1: status=0x51 { DriveReady SeekComplete Error }
ata1: no sense translation for status: 0x51
ata1: translated ATA stat/err 0x51/00 to SCSI SK/ASC/ASCQ 0x3/11/04
ata1: status=0x51 { DriveReady SeekComplete Error }
ata1: no sense translation for status: 0x51
ata1: translated ATA stat/err 0x51/00 to SCSI SK/ASC/ASCQ 0x3/11/04
ata1: status=0x51 { DriveReady SeekComplete Error }
ata1: no sense translation for status: 0x51
ata1: translated ATA stat/err 0x51/00 to SCSI SK/ASC/ASCQ 0x3/11/04
ata1: status=0x51 { DriveReady SeekComplete Error }
ata1: no sense translation for status: 0x51
ata1: translated ATA stat/err 0x51/00 to SCSI SK/ASC/ASCQ 0x3/11/04
ata1: status=0x51 { DriveReady SeekComplete Error }
sd 0:0:0:0: SCSI error: return code = 0x8000002
sda: Current: sense key: Medium Error
    Additional sense: Unrecovered read error - auto reallocate failed
end_request: I/O error, dev sda, sector 63269014
raid5: read error not correctable.
ata1: no sense translation for status: 0x51
ata1: translated ATA stat/err 0x51/00 to SCSI SK/ASC/ASCQ 0x3/11/04
ata1: status=0x51 { DriveReady SeekComplete Error }
ata1: no sense translation for status: 0x51
ata1: translated ATA stat/err 0x51/00 to SCSI SK/ASC/ASCQ 0x3/11/04
ata1: status=0x51 { DriveReady SeekComplete Error }
ata1: no sense translation for status: 0x51
ata1: translated ATA stat/err 0x51/00 to SCSI SK/ASC/ASCQ 0x3/11/04
ata1: status=0x51 { DriveReady SeekComplete Error }
ata1: no sense translation for status: 0x51
ata1: translated ATA stat/err 0x51/00 to SCSI SK/ASC/ASCQ 0x3/11/04
ata1: status=0x51 { DriveReady SeekComplete Error }
ata1: no sense translation for status: 0x51
ata1: translated ATA stat/err 0x51/00 to SCSI SK/ASC/ASCQ 0x3/11/04
ata1: status=0x51 { DriveReady SeekComplete Error }
ata1: no sense translation for status: 0x51
ata1: translated ATA stat/err 0x51/00 to SCSI SK/ASC/ASCQ 0x3/11/04
ata1: status=0x51 { DriveReady SeekComplete Error }
sd 0:0:0:0: SCSI error: return code = 0x8000002
sda: Current: sense key: Medium Error
    Additional sense: Unrecovered read error - auto reallocate failed
end_request: I/O error, dev sda, sector 63269022
raid5: read error not correctable.
I/O error in filesystem ("md2") meta-data dev md2 block 0x1cfaa598    
  ("xlog_iodone") error 5 buf count 4096
xfs_force_shutdown(md2,0x2) called from line 959 of file
fs/xfs/xfs_log.c.  Return address = 0xc0207a0c
Filesystem "md2": Log I/O Error Detected.  Shutting down filesystem: md2
Please umount the filesystem, and rectify the problem(s)
RAID5 conf printout:
 --- rd:3 wd:1 fd:2
 disk 0, o:0, dev:sda3
 disk 1, o:1, dev:hda3
I/O error in filesystem ("md2") meta-data dev md2 block 0x1cfaa580    
  ("xlog_iodone") error 5 buf count 12288
xfs_force_shutdown(md2,0x2) called from line 959 of file
fs/xfs/xfs_log.c.  Return address = 0xc0207a0c
printk: 2552 messages suppressed.
Buffer I/O error on device md2, logical block 14766033
lost page write due to I/O error on md2
Buffer I/O error on device md2, logical block 14766034
lost page write due to I/O error on md2
Buffer I/O error on device md2, logical block 14766035
lost page write due to I/O error on md2
Buffer I/O error on device md2, logical block 14766036
lost page write due to I/O error on md2
Buffer I/O error on device md2, logical block 14766037
lost page write due to I/O error on md2
Buffer I/O error on device md2, logical block 14766038
lost page write due to I/O error on md2
Buffer I/O error on device md2, logical block 14766039
lost page write due to I/O error on md2
Buffer I/O error on device md2, logical block 14766040
lost page write due to I/O error on md2
Buffer I/O error on device md2, logical block 14766041
lost page write due to I/O error on md2
Buffer I/O error on device md2, logical block 14766042
lost page write due to I/O error on md2
RAID5 conf printout:
 --- rd:3 wd:1 fd:2
 disk 1, o:1, dev:hda3
xfs_force_shutdown(md2,0x1) called from line 338 of file
fs/xfs/xfs_rw.c.  Return address = 0xc0207a0c
