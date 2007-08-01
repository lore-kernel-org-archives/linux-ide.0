From: Mikko Rapeli <mikko.rapeli@iki.fi>
Subject: ST340823A disk size issue
Date: Wed, 1 Aug 2007 12:29:04 +0300
Message-ID: <20070801092903.GA1199@nalle>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gw01.mail.saunalahti.fi ([195.197.172.115]:45720 "EHLO
	gw01.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760220AbXHAJkD (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 1 Aug 2007 05:40:03 -0400
Received: from nalle.dyndns.tv (GYKMMMDXX.dsl.saunalahti.fi [85.77.39.121])
	by gw01.mail.saunalahti.fi (Postfix) with ESMTP id 60168151A8B
	for <linux-ide@vger.kernel.org>; Wed,  1 Aug 2007 12:29:05 +0300 (EEST)
Received: from mcfrisk by nalle.dyndns.tv with local (Exim 4.63)
	(envelope-from <mikko.rapeli@iki.fi>)
	id 1IGAVs-0001PW-9K
	for linux-ide@vger.kernel.org; Wed, 01 Aug 2007 12:29:04 +0300
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hello, 

(More details at http://bugzilla.kernel.org/show_bug.cgi?id=8816 )

My home server disk doesn't work with latest kernels since its size is
reported or probed correctly. With 2.6.22.1 I get:

Probing IDE interface ide1...
hdd: ST340823A, ATA DISK drive
hdd: selected mode 0x42
...
hdd: max request size: 128KiB
hdd: Host Protected Area detected.
        current capacity is 78165360 sectors (40020 MB)
        native  capacity is 78165361 sectors (40020 MB)
hdd: Host Protected Area disabled.
hdd: 78165361 sectors (40020 MB) w/1024KiB Cache, CHS=65535/16/63,
UDMA(33)
hdd: cache flushes not supported
 hdd: hdd1 hdd2 hdd3
hdd: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hdd: dma_intr: error=0x10 { SectorIdNotFound }, LBAsect=78165360, 
sector=78165360
ide: failed opcode was: unknown
hdd: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hdd: dma_intr: error=0x10 { SectorIdNotFound }, LBAsect=78165360,
sector=78165360
ide: failed opcode was: unknown
hdd: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hdd: dma_intr: error=0x10 { SectorIdNotFound }, LBAsect=78165360,
sector=78165360
...

And as said shows in bugzilla, badblocks, fsck and smartctl think the
drive is not broken or going to die too soon.

What's the difference between the size formats of
WIN_READ_NATIVE_MAX_EXT read by
ide-disk.c/idedisk_read_native_max_address_ext() and (hdreg.h) 
hd_driveid->lba_capacity_2 read by, if I read drivers/ide/* code
correctly, ide-probe.c/do_identify()?

If this disk is reporting one of these wrong, which fix could be
applied? 

Both disabling 'stroke' and removing addr++ in
ide-disk.c/idedisk_read_native_max_address*() fix the problem, but if
kernel code is correct and standard compliant, these fixes are out of
the question.

Perhaps a boot parameter to kernel could force the disk sector count to
some value for buggy drives?

-Mikko
