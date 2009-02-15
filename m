From: "George Spelvin" <linux@horizon.com>
Subject: Promise SATA error-handling not quite working (2.6.29-rc4)
Date: Sun, 15 Feb 2009 18:49:04 -0500
Message-ID: <20090215234904.29178.qmail@science.horizon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from science.horizon.com ([192.35.100.1]:18179 "HELO
	science.horizon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752027AbZBOXzq (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 15 Feb 2009 18:55:46 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: linux@horizon.com

I have a problematic drive hooked up to a
02:00.0 RAID bus controller [0104]: Promise Technology, Inc. Device [105a:3f20]
which uses the AHCI driver.

The drive itself is:
/dev/sde:

 Model=ST3400832AS                             , FwRev=3.03    , SerialNo=            3NF167BM
 Config={ HardSect NotMFM HdSw>15uSec Fixed DTR>10Mbs RotSpdTol>.5% }
 RawCHS=16383/16/63, TrkSize=0, SectSize=0, ECCbytes=4
 BuffType=unknown, BuffSize=8192kB, MaxMultSect=16, MultSect=?16?
 CurCHS=16383/16/63, CurSects=16514064, LBA=yes, LBAsects=781422768
 IORDY=on/off, tPIO={min:240,w/IORDY:120}, tDMA={min:120,rec:120}
 PIO modes:  pio0 pio1 pio2 pio3 pio4 
 DMA modes:  mdma0 mdma1 mdma2 
 UDMA modes: udma0 udma1 udma2 udma3 udma4 udma5 *udma6 
 AdvancedPM=no WriteCache=enabled
 Drive conforms to: Unspecified:  ATA/ATAPI-1,2,3,4,5,6,7

 * signifies the current active mode

Anyway, last night during a RAID check operation, it stopped responding and dropped out of the array:

03:33:17 kernel: ata5.00: qc timeout (cmd 0x2f)
03:33:17 kernel: ata5: failed to read log page 10h (errno=-5)
03:33:17 kernel: ata5.00: exception Emask 0x1 SAct 0xff SErr 0x0 action 0x6 frozen
03:33:17 kernel: ata5.00: irq_stat 0x40000000
03:33:17 kernel: ata5.00: cmd 60/00:00:d2:f8:2c/01:00:20:00:00/40 tag 0 ncq 131072 in
03:33:17 kernel:          res 40/00:00:d2:f8:2c/3e:00:20:00:00/40 Emask 0x1 (device error)
03:33:17 kernel: ata5.00: status: { DRDY }
03:33:17 kernel: ata5.00: cmd 60/00:08:d2:f9:2c/01:00:20:00:00/40 tag 1 ncq 131072 in
03:33:17 kernel:          res 40/00:00:d2:f8:2c/00:00:20:00:00/40 Emask 0x1 (device error)
03:33:17 kernel: ata5.00: status: { DRDY }
03:33:17 kernel: ata5.00: cmd 60/00:10:d2:fa:2c/01:00:20:00:00/40 tag 2 ncq 131072 in
03:33:17 kernel:          res 40/00:00:d2:f8:2c/3e:00:20:00:00/40 Emask 0x1 (device error)
03:33:17 kernel: ata5.00: status: { DRDY }
03:33:17 kernel: ata5.00: cmd 60/00:18:d2:f3:2c/01:00:20:00:00/40 tag 3 ncq 131072 in
03:33:17 kernel:          res 40/00:00:d2:f8:2c/3e:00:20:00:00/40 Emask 0x1 (device error)
03:33:17 kernel: ata5.00: status: { DRDY }
03:33:17 kernel: ata5.00: cmd 60/00:20:d2:f4:2c/01:00:20:00:00/40 tag 4 ncq 131072 in
03:33:17 kernel:          res 40/00:00:d2:f8:2c/3e:00:20:00:00/40 Emask 0x1 (device error)
03:33:17 kernel: ata5.00: status: { DRDY }
03:33:17 kernel: ata5.00: cmd 60/00:28:d2:f5:2c/01:00:20:00:00/40 tag 5 ncq 131072 in
03:33:17 kernel:          res 40/00:00:d2:f8:2c/00:00:20:00:00/40 Emask 0x1 (device error)
03:33:17 kernel: ata5.00: status: { DRDY }
03:33:17 kernel: ata5.00: cmd 60/00:30:d2:f6:2c/01:00:20:00:00/40 tag 6 ncq 131072 in
03:33:17 kernel:          res 40/00:00:d2:f8:2c/3e:00:20:00:00/40 Emask 0x1 (device error)
03:33:17 kernel: ata5.00: status: { DRDY }
03:33:17 kernel: ata5.00: cmd 60/00:38:d2:f7:2c/01:00:20:00:00/40 tag 7 ncq 131072 in
03:33:17 kernel:          res 40/00:00:d2:f8:2c/00:00:20:00:00/40 Emask 0x1 (device error)
03:33:17 kernel: ata5.00: status: { DRDY }
03:33:17 kernel: ata5: hard resetting link
03:33:17 kernel: ata5: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
03:33:22 kernel: ata5.00: qc timeout (cmd 0xec)
03:33:22 kernel: ata5.00: failed to IDENTIFY (I/O error, err_mask=0x4)
03:33:22 kernel: ata5.00: revalidation failed (errno=-5)
03:33:22 kernel: ata5: hard resetting link
03:33:23 kernel: ata5: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
03:33:33 kernel: ata5.00: qc timeout (cmd 0xec)
03:33:33 kernel: ata5.00: failed to IDENTIFY (I/O error, err_mask=0x4)
03:33:33 kernel: ata5.00: revalidation failed (errno=-5)
03:33:33 kernel: ata5: limiting SATA link speed to 1.5 Gbps
03:33:33 kernel: ata5: hard resetting link
03:33:33 kernel: ata5: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
03:34:03 kernel: ata5.00: qc timeout (cmd 0xec)
03:34:03 kernel: ata5.00: failed to IDENTIFY (I/O error, err_mask=0x4)
03:34:03 kernel: ata5.00: revalidation failed (errno=-5)
03:34:03 kernel: ata5.00: disabled
03:34:03 kernel: ata5: hard resetting link
03:34:04 kernel: ata5: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
03:34:04 kernel: ata5: EH complete
03:34:04 kernel: sd 4:0:0:0: [sde] Unhandled error code
03:34:04 kernel: sd 4:0:0:0: [sde] Result: hostbyte=0x04 driverbyte=0x00
03:34:04 kernel: end_request: I/O error, dev sde, sector 539817938
03:34:04 kernel: sd 4:0:0:0: [sde] Unhandled error code
03:34:04 kernel: sd 4:0:0:0: [sde] Result: hostbyte=0x04 driverbyte=0x00
03:34:04 kernel: end_request: I/O error, dev sde, sector 539817682
03:34:04 kernel: sd 4:0:0:0: [sde] Unhandled error code
03:34:04 kernel: sd 4:0:0:0: [sde] Result: hostbyte=0x04 driverbyte=0x00
03:34:04 kernel: end_request: I/O error, dev sde, sector 539817426
03:34:04 kernel: sd 4:0:0:0: [sde] Unhandled error code
03:34:04 kernel: sd 4:0:0:0: [sde] Result: hostbyte=0x04 driverbyte=0x00
03:34:04 kernel: end_request: I/O error, dev sde, sector 539817170
03:34:04 kernel: sd 4:0:0:0: [sde] Unhandled error code
03:34:04 kernel: sd 4:0:0:0: [sde] Result: hostbyte=0x04 driverbyte=0x00
03:34:04 kernel: end_request: I/O error, dev sde, sector 539816914
03:34:04 kernel: sd 4:0:0:0: [sde] Unhandled error code
03:34:04 kernel: sd 4:0:0:0: [sde] Result: hostbyte=0x04 driverbyte=0x00
03:34:04 kernel: end_request: I/O error, dev sde, sector 539818706
03:34:04 kernel: sd 4:0:0:0: [sde] Unhandled error code
03:34:04 kernel: sd 4:0:0:0: [sde] Result: hostbyte=0x04 driverbyte=0x00
03:34:04 kernel: end_request: I/O error, dev sde, sector 539818450
03:34:04 kernel: sd 4:0:0:0: [sde] Unhandled error code
03:34:04 kernel: sd 4:0:0:0: [sde] Result: hostbyte=0x04 driverbyte=0x00
03:34:04 kernel: end_request: I/O error, dev sde, sector 539818194
03:34:04 kernel: sd 4:0:0:0: [sde] Unhandled error code
03:34:04 kernel: sd 4:0:0:0: [sde] Result: hostbyte=0x04 driverbyte=0x00
03:34:04 kernel: end_request: I/O error, dev sde, sector 91795259
03:34:04 kernel: end_request: I/O error, dev sde, sector 91795259
03:34:04 kernel: md: super_written gets error=-5, uptodate=0
03:34:04 kernel: raid10: Disk failure on sde3, disabling device.
03:34:04 kernel: raid10: Operation continuing on 5 devices.
03:34:04 kernel: sd 4:0:0:0: [sde] Unhandled error code
03:34:04 kernel: sd 4:0:0:0: [sde] Result: hostbyte=0x04 driverbyte=0x00
03:34:04 kernel: end_request: I/O error, dev sde, sector 539816914
03:34:04 kernel: raid5: Disk failure on sde4, disabling device.
03:34:04 kernel: raid5: Operation continuing on 5 devices.
03:34:04 kernel: sd 4:0:0:0: [sde] Unhandled error code
03:34:04 kernel: sd 4:0:0:0: [sde] Result: hostbyte=0x04 driverbyte=0x00
03:34:04 kernel: end_request: I/O error, dev sde, sector 539817170
03:34:04 kernel: sd 4:0:0:0: [sde] Unhandled error code
03:34:04 kernel: sd 4:0:0:0: [sde] Result: hostbyte=0x04 driverbyte=0x00
03:34:04 kernel: sd 4:0:0:0: [sde] Unhandled error code
03:34:04 kernel: sd 4:0:0:0: [sde] Result: hostbyte=0x04 driverbyte=0x00
03:34:04 kernel: end_request: I/O error, dev sde, sector 539818450
03:34:04 kernel: sd 4:0:0:0: [sde] Unhandled error code
03:34:04 kernel: sd 4:0:0:0: [sde] Result: hostbyte=0x04 driverbyte=0x00
03:34:04 kernel: end_request: I/O error, dev sde, sector 539818706
03:34:04 kernel: sd 4:0:0:0: [sde] Unhandled error code
03:34:04 kernel: sd 4:0:0:0: [sde] Result: hostbyte=0x04 driverbyte=0x00
03:34:04 kernel: end_request: I/O error, dev sde, sector 539818194
03:34:04 kernel: sd 4:0:0:0: [sde] Unhandled error code
03:34:04 kernel: sd 4:0:0:0: [sde] Result: hostbyte=0x04 driverbyte=0x00
03:34:04 kernel: end_request: I/O error, dev sde, sector 539818458
03:34:04 kernel: RAID10 conf printout:
03:34:04 kernel:  --- wd:5 rd:6
03:34:04 kernel:  disk 0, wo:0, o:1, dev:sdb3
03:34:04 kernel:  disk 1, wo:0, o:1, dev:sdc3
03:34:04 kernel:  disk 2, wo:0, o:1, dev:sdd3
03:34:04 kernel:  disk 3, wo:1, o:0, dev:sde3
03:34:04 kernel:  disk 4, wo:0, o:1, dev:sdf3
03:34:04 kernel:  disk 5, wo:0, o:1, dev:sda3
03:34:04 kernel: RAID10 conf printout:
03:34:04 kernel:  --- wd:5 rd:6
03:34:04 kernel:  disk 0, wo:0, o:1, dev:sdb3
03:34:04 kernel:  disk 1, wo:0, o:1, dev:sdc3
03:34:04 kernel:  disk 2, wo:0, o:1, dev:sdd3
03:34:04 kernel:  disk 4, wo:0, o:1, dev:sdf3
03:34:04 kernel:  disk 5, wo:0, o:1, dev:sda3
03:34:04 kernel: md: md5: data-check done.
03:34:04 kernel: RAID5 conf printout:
03:34:04 kernel:  --- rd:6 wd:5
03:34:04 kernel:  disk 0, o:1, dev:sda4
03:34:04 kernel:  disk 1, o:1, dev:sdb4
03:34:04 kernel:  disk 2, o:1, dev:sdc4
03:34:04 kernel:  disk 3, o:1, dev:sdd4
03:34:04 kernel:  disk 4, o:0, dev:sde4
03:34:04 kernel:  disk 5, o:1, dev:sdf4
03:34:04 kernel: RAID5 conf printout:
03:34:04 kernel:  --- rd:6 wd:5
03:34:04 kernel:  disk 0, o:1, dev:sda4
03:34:04 kernel:  disk 1, o:1, dev:sdb4
03:34:04 kernel:  disk 2, o:1, dev:sdc4
03:34:04 kernel:  disk 3, o:1, dev:sdd4
03:34:04 kernel:  disk 5, o:1, dev:sdf4

After this point, commands like hdparm -I /dev/sde just aren't working.

"hdparm -w" just says
 HDIO_DRIVE_RESET failed: Inappropriate ioctl for device

Unplugging and replugging the drive produces
23:00:05 kernel: ata5: exception Emask 0x10 SAct 0x0 SErr 0x10000 action 0xe frozen
23:00:05 kernel: ata5: irq_stat 0x00400000, PHY RDY changed
23:00:05 kernel: ata5: SError: { PHYRdyChg }
23:00:05 kernel: ata5: hard resetting link
23:00:05 kernel: ata5: SATA link down (SStatus 0 SControl 300)
23:00:05 kernel: ata5: EH complete
23:00:05 kernel: ata5.00: detaching (SCSI 4:0:0:0)
23:00:05 kernel: sd 4:0:0:0: [sde] Synchronizing SCSI cache
23:00:05 kernel: sd 4:0:0:0: [sde] Result: hostbyte=0x04 driverbyte=0x00
23:00:05 kernel: sd 4:0:0:0: [sde] Stopping disk
23:00:05 kernel: sd 4:0:0:0: [sde] START_STOP FAILED
23:00:05 kernel: sd 4:0:0:0: [sde] Result: hostbyte=0x04 driverbyte=0x00
23:00:09 kernel: ata5: exception Emask 0x10 SAct 0x0 SErr 0x4050000 action 0xe frozen
23:00:09 kernel: ata5: irq_stat 0x00000040, connection status changed
23:00:09 kernel: ata5: SError: { PHYRdyChg CommWake DevExch }
23:00:09 kernel: ata5: hard resetting link
23:00:11 kernel: ata5: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
23:00:11 kernel: ata5: link online but device misclassified, retrying
23:00:11 kernel: ata5: reset failed (errno=-11), retrying in 9 secs
23:00:19 kernel: ata5: hard resetting link
23:00:20 kernel: ata5: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
23:00:25 kernel: ata5.00: qc timeout (cmd 0xec)
23:00:25 kernel: ata5.00: failed to IDENTIFY (I/O error, err_mask=0x4)
23:00:25 kernel: ata5: hard resetting link
23:00:26 kernel: ata5: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
23:00:36 kernel: ata5.00: qc timeout (cmd 0xec)
23:00:36 kernel: ata5.00: failed to IDENTIFY (I/O error, err_mask=0x4)
23:00:36 kernel: ata5: limiting SATA link speed to 1.5 Gbps
23:00:36 kernel: ata5: hard resetting link
23:00:36 kernel: ata5: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
23:01:06 kernel: ata5.00: qc timeout (cmd 0xec)
23:01:06 kernel: ata5.00: failed to IDENTIFY (I/O error, err_mask=0x4)
23:01:06 kernel: ata5: hard resetting link
23:01:07 kernel: ata5: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
23:01:07 kernel: ata5: EH complete

... and I still don't have an accessible drive.  Rebooting, however,
brings everything right back (even with no power cycle).

this, to me, suggests that the error handling is not doing a particularly
good job resetting the drive.

Actually, let me try hot-pulling it while it's running normally.  To
start with it idle...
23:43:08 kernel: ata5: exception Emask 0x10 SAct 0x0 SErr 0x10000 action 0xe frozen
23:43:08 kernel: ata5: irq_stat 0x00400000, PHY RDY changed
23:43:08 kernel: ata5: SError: { PHYRdyChg }
23:43:08 kernel: ata5: hard resetting link
23:43:09 kernel: ata5: SATA link down (SStatus 0 SControl 300)
23:43:14 kernel: ata5: hard resetting link
23:43:15 kernel: ata5: SATA link down (SStatus 0 SControl 300)
23:43:15 kernel: ata5: limiting SATA link speed to 1.5 Gbps
23:43:20 kernel: ata5: hard resetting link
23:43:20 kernel: ata5: SATA link down (SStatus 0 SControl 310)
23:43:20 kernel: ata5.00: disabled
23:43:20 kernel: ata5: EH complete
23:43:20 kernel: ata5.00: detaching (SCSI 4:0:0:0)
23:43:20 kernel: sd 4:0:0:0: [sde] Synchronizing SCSI cache
23:43:20 kernel: sd 4:0:0:0: [sde] Result: hostbyte=0x04 driverbyte=0x00
23:43:20 kernel: sd 4:0:0:0: [sde] Stopping disk
23:43:20 kernel: sd 4:0:0:0: [sde] START_STOP FAILED
23:43:20 kernel: sd 4:0:0:0: [sde] Result: hostbyte=0x04 driverbyte=0x00
23:43:25 kernel: ata5: exception Emask 0x10 SAct 0x0 SErr 0x4050000 action 0xe frozen
23:43:25 kernel: ata5: irq_stat 0x00000040, connection status changed
23:43:25 kernel: ata5: SError: { PHYRdyChg CommWake DevExch }
23:43:25 kernel: ata5: hard resetting link
23:43:32 kernel: ata5: link is slow to respond, please be patient (ready=0)
23:43:34 kernel: ata5: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
23:43:34 kernel: ata5.00: ATA-7: ST3400832AS, 3.03, max UDMA/133
23:43:34 kernel: ata5.00: 781422768 sectors, multi 0: LBA48 NCQ (depth 31/32)
23:43:34 kernel: ata5.00: configured for UDMA/133
23:43:34 kernel: ata5: EH complete
23:43:34 kernel: scsi 4:0:0:0: Direct-Access     ATA      ST3400832AS      3.03 PQ: 0 ANSI: 5
23:43:34 kernel: sd 4:0:0:0: [sdg] 781422768 512-byte hardware sectors: (400 GB/372 GiB)
23:43:34 kernel: sd 4:0:0:0: [sdg] Write Protect is off
23:43:34 kernel: sd 4:0:0:0: [sdg] Mode Sense: 00 3a 00 00
23:43:34 kernel: sd 4:0:0:0: [sdg] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
23:43:34 kernel: sd 4:0:0:0: [sdg] 781422768 512-byte hardware sectors: (400 GB/372 GiB)
23:43:34 kernel: sd 4:0:0:0: [sdg] Write Protect is off
23:43:34 kernel: sd 4:0:0:0: [sdg] Mode Sense: 00 3a 00 00
23:43:34 kernel: sd 4:0:0:0: [sdg] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
23:43:34 kernel:  sdg: sdg1 sdg2 sdg3 sdg4
23:43:34 kernel: sd 4:0:0:0: [sdg] Attached SCSI disk

H'm... that seemed to work.  I don't know what was going on with the drive,
but a reboot fixed it while a remove/reinsert didn't.  Just a data point
in case it helps anyone.
