From: Eddie Atherton <stunnel@attglobal.net>
Subject: ST340823A disk size issue - Revisited
Date: Wed, 15 Aug 2007 11:56:03 -0700
Message-ID: <46C34C43.3020705@attglobal.net>
Reply-To: stunnel@attglobal.net
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from kcout03.prserv.net ([12.154.55.33]:59040 "EHLO
	kcout03.prserv.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754893AbXHOTBA (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 15 Aug 2007 15:01:00 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hi,

I found the above thread while searching for the reason I was getting 
lots of errors while trying to build out a new server.  Yes, I am using 
an ST340823A drive.  However, I am getting slightly different results 
for the drive capacity, which I'm not sure if that could cause issues 
with the patch.

I actually have 2 of these drives.  One is in a WinBlows machine, and 
the other is in my new server.  Using an Ubuntu Live CD, I was able to 
verify that the drive in the WinBlows machine is behaving exactly the 
same as the original problem report.  However, the drive in my server, 
running Slackware 11.0, reports a different "current capacity", as shown 
here:

Linux version 2.6.17.13 (root@tree) (gcc version 3.4.6) #1 Sat Sep 9 
01:11:49 CDT 2006
...
Probing IDE interface ide0...
hda: ST340823A, ATA DISK drive
hdb: ATAPI CDROM, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
Probing IDE interface ide1...
hda: max request size: 128KiB
hda: Host Protected Area detected.
        current capacity is 78165359 sectors (40020 MB)
        native  capacity is 78165361 sectors (40020 MB)
hda: Host Protected Area disabled.
hda: 78165361 sectors (40020 MB) w/512KiB Cache, CHS=65535/16/63, UDMA(100)
hda: cache flushes not supported
 hda: hda1 hda2
hdb: ATAPI 44X CD-ROM drive, 128kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20
...
hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hda: dma_intr: error=0x10 { SectorIdNotFound }, LBAsect=78165360, 
sector=78165360
ide: failed opcode was: unknown
hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hda: dma_intr: error=0x10 { SectorIdNotFound }, LBAsect=78165360, 
sector=78165360
ide: failed opcode was: unknown
hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hda: dma_intr: error=0x10 { SectorIdNotFound }, LBAsect=78165360, 
sector=78165360
ide: failed opcode was: unknown
hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hda: dma_intr: error=0x10 { SectorIdNotFound }, LBAsect=78165360, 
sector=78165360
ide: failed opcode was: unknown
hda: DMA disabled
hdb: DMA disabled
ide0: reset: success
hda: task_in_intr: status=0x59 { DriveReady SeekComplete DataRequest Error }
hda: task_in_intr: error=0x10 { SectorIdNotFound }, LBAsect=78230639, 
sector=78165360
ide: failed opcode was: unknown
hda: task_in_intr: status=0x59 { DriveReady SeekComplete DataRequest Error }
hda: task_in_intr: error=0x10 { SectorIdNotFound }, LBAsect=78230639, 
sector=78165360
ide: failed opcode was: unknown
hda: task_in_intr: status=0x59 { DriveReady SeekComplete DataRequest Error }
hda: task_in_intr: error=0x10 { SectorIdNotFound }, LBAsect=78230639, 
sector=78165360
ide: failed opcode was: unknown
hda: task_in_intr: status=0x59 { DriveReady SeekComplete DataRequest Error }
hda: task_in_intr: error=0x10 { SectorIdNotFound }, LBAsect=78230639, 
sector=78165360
ide: failed opcode was: unknown
ide0: reset: success
hda: task_in_intr: status=0x59 { DriveReady SeekComplete DataRequest Error }
hda: task_in_intr: error=0x10 { SectorIdNotFound }, LBAsect=78230639, 
sector=78165360
ide: failed opcode was: unknown
end_request: I/O error, dev hda, sector 78165360
Buffer I/O error on device hda, logical block 78165360
etc. etc.


Here is the hdparm information from the server:

/dev/hda:

ATA device, with non-removable media
        Model Number:       ST340823A
        Serial Number:      6EF00RGK
        Firmware Revision:  3.54
Standards:
        Supported: 4 3 2
        Likely used: 6
Configuration:
        Logical         max     current
        cylinders       16383   16383
        heads           16      16
        sectors/track   63      63
        --
        CHS current addressable sectors:   16514064
        LBA    user addressable sectors:   78165360
        device size with M = 1024*1024:       38166 MBytes
        device size with M = 1000*1000:       40020 MBytes (40 GB)
Capabilities:
        LBA, IORDY(can be disabled)
        Standby timer values: spec'd by Standard
        R/W multiple sector transfer: Max = 16  Current = ?
        Recommended acoustic management value: 128, current value: 0
        DMA: mdma0 mdma1 mdma2 udma0 udma1 udma2 udma3 udma4 *udma5
             Cycle time: min=120ns recommended=120ns
        PIO: pio0 pio1 pio2 pio3 pio4
             Cycle time: no flow control=240ns  IORDY flow control=120ns
Commands/features:
        Enabled Supported:
           *    SMART feature set
                Security Mode feature set
           *    Power Management feature set
           *    Write cache
           *    Look-ahead
           *    Host Protected Area feature set
           *    WRITE_BUFFER command
           *    READ_BUFFER command
           *    DOWNLOAD_MICROCODE
           *    SET_MAX security extension
                Automatic Acoustic Management feature set
Security:
        Master password revision code = 65534
                supported
        not     enabled
        not     locked
                frozen
        not     expired: security count
        not     supported: enhanced erase
HW reset results:
        CBLID- below Vih
        Device num = 1
Checksum: correct


And a diff between the 2 disks:

6c6
<       Serial Number:      6EF00RGK
---
 >       Serial Number:      6EF0043Y
48c48
<               frozen
---
 >       not     frozen
52c52
<       CBLID- below Vih
---
 >       CBLID- above Vih


I also ran the Ubuntu Live CD against the server, and it reported 
exactly the same values and errors as Slackware, so the difference in 
kernel level is not an issue.

I'm quite happy to try and build a kernel with the patches, to see if it 
helps/fails with this different capacity, as long as someone can point 
me at which level to download, and which patches I need to apply.

Cheers,
Eddie

