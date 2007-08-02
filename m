From: Mikko Rapeli <mikko.rapeli@iki.fi>
Subject: Re: ST340823A disk size issue
Date: Thu, 2 Aug 2007 23:03:57 +0300
Message-ID: <20070802200357.GA1178@nalle>
References: <20070801092903.GA1199@nalle> <200708020019.25742.bzolnier@gmail.com> <20070801233221.34e2ff0c@the-village.bc.nu> <200708020117.58916.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gw02.mail.saunalahti.fi ([195.197.172.116]:46426 "EHLO
	gw02.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758609AbXHBUEI (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 2 Aug 2007 16:04:08 -0400
Content-Disposition: inline
In-Reply-To: <200708020117.58916.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org

On Thu, Aug 02, 2007 at 01:17:58AM +0200, Bartlomiej Zolnierkiewicz wrote:
> Mikko, could you please revert any patches that you have applied, uncomment
> #define DEBUG in ide-disk.c, recompile and note the sectors count in the
> 
> "hdd: reading: block=78165360 sectors=..."
> 
> debug message?

Full log at http://bugzilla.kernel.org/attachment.cgi?id=12235

Here's a summary:

$ egrep hdd\|ide1\|current\ capacity\|native\ \ capacity
dmesg_ide_debug_26221.txt

    ide1: BM-DMA at 0xe008-0xe00f, BIOS settings: hdc:pio, hdd:pio
Probing IDE interface ide1...
probing for hdd: present=0, media=32, probetype=ATA
hdd: ST340823A, ATA DISK drive
hdd: selected mode 0x42
ide1 at 0x170-0x177,0x376 on irq 15
hdd: max request size: 128KiB
ide1: start_request: current=0xc18f5c28
hdd: do_special: 0x03
ide1: start_request: current=0xc18f5c28
hdd: do_special: 0x02
ide1: start_request: current=0xc18f5c28
hdd: Host Protected Area detected.
        current capacity is 78165360 sectors (40020 MB)
        native  capacity is 78165361 sectors (40020 MB)
ide1: start_request: current=0xc18f5c28
hdd: Host Protected Area disabled.
hdd: 78165361 sectors (40020 MB) w/1024KiB Cache, CHS=65535/16/63,
UDMA(33)
hdd: cache flushes not supported
 hdd:ide1: start_request: current=0xc1e0b578
hdd: reading: block=0, sectors=8, buffer=0xc18b7000
 hdd1 hdd2 hdd3
ide1: start_request: current=0xc1e0b578
hdd: reading: block=78165120, sectors=8, buffer=0xc1e54000
ide1: start_request: current=0xc1e0b578
hdd: reading: block=78165352, sectors=1, buffer=0xc1e2e000
ide1: start_request: current=0xc1e0b408
hdd: reading: block=78165353, sectors=7, buffer=0xc1e2e200
ide1: start_request: current=0xc1e0b408
hdd: reading: block=78165360, sectors=1, buffer=0xc1e63000
hdd: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hdd: dma_intr: error=0x10 { SectorIdNotFound }, LBAsect=78165360,
sector=78165360
ide1: start_request: current=0xc1e0b408
hdd: reading: block=78165360, sectors=1, buffer=0xc1e63000
hdd: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hdd: dma_intr: error=0x10 { SectorIdNotFound }, LBAsect=78165360,
sector=78165360
ide1: start_request: current=0xc1e0b408
hdd: do_special: 0x02
ide1: start_request: current=0xc1e0b408
hdd: reading: block=78165360, sectors=1, buffer=0xc1e63000
hdd: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hdd: dma_intr: error=0x10 { SectorIdNotFound }, LBAsect=78165360,
sector=78165360
ide1: start_request: current=0xc1e0b408
hdd: reading: block=78165360, sectors=1, buffer=0xc1e63000
hdd: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hdd: dma_intr: error=0x10 { SectorIdNotFound }, LBAsect=78165360,
sector=78165360
hdd: DMA disabled
ide1: reset: master: error (0x00?)
ide1: start_request: current=0xc1e0b408
hdd: do_special: 0x03
ide1: start_request: current=0xc1e0b408
hdd: do_special: 0x02
ide1: start_request: current=0xc1e0b408
hdd: reading: block=78165360, sectors=1, buffer=0xc1e63000
hdd: task_in_intr: status=0x59 { DriveReady SeekComplete DataRequest
Error }
hdd: task_in_intr: error=0x10 { SectorIdNotFound }, LBAsect=78230639,
sector=78165360
ide1: start_request: current=0xc1e0b408
hdd: reading: block=78165360, sectors=1, buffer=0xc1e63000
hdd: task_in_intr: status=0x59 { DriveReady SeekComplete DataRequest
Error }
hdd: task_in_intr: error=0x10 { SectorIdNotFound }, LBAsect=78230639,
sector=78165360
ide1: start_request: current=0xc1e0b408
hdd: do_special: 0x02
ide1: start_request: current=0xc1e0b408
hdd: reading: block=78165360, sectors=1, buffer=0xc1e63000
hdd: task_in_intr: status=0x59 { DriveReady SeekComplete DataRequest
Error }
hdd: task_in_intr: error=0x10 { SectorIdNotFound }, LBAsect=78230639,
sector=781
65360
ide1: start_request: current=0xc1e0b408
hdd: reading: block=78165360, sectors=1, buffer=0xc1e63000
hdd: task_in_intr: status=0x59 { DriveReady SeekComplete DataRequest
Error }
hdd: task_in_intr: error=0x10 { SectorIdNotFound }, LBAsect=78230639,
sector=78165360
ide1: reset: master: error (0x00?)
ide1: start_request: current=0xc1e0b408
end_request: I/O error, dev hdd, sector 78165360
Buffer I/O error on device hdd, logical block 78165360
ide1: start_request: current=0xc1e0b408
end_request: I/O error, dev hdd, sector 78165360
Buffer I/O error on device hdd, logical block 78165360
ide1: start_request: current=0xc1e0b408
end_request: I/O error, dev hdd, sector 78165360
Buffer I/O error on device hdd, logical block 78165360
ide1: start_request: current=0xc1e0b408
end_request: I/O error, dev hdd, sector 78165360
Buffer I/O error on device hdd, logical block 78165360
ide1: start_request: current=0xc1e0b408
end_request: I/O error, dev hdd, sector 78165296
...
