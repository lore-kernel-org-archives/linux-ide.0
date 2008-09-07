From: Antonio Cardoso Martins <digiplan.pt@gmail.com>
Subject: UDMA with CS5530 using IBM Netvista N2200 (8363)
Date: Sun, 07 Sep 2008 23:55:43 +0100
Message-ID: <48C45BEF.5090502@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.170]:5167 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750739AbYIGW4A (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 7 Sep 2008 18:56:00 -0400
Received: by ug-out-1314.google.com with SMTP id s2so99929uge.37
        for <linux-ide@vger.kernel.org>; Sun, 07 Sep 2008 15:55:58 -0700 (PDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hello,

I have been trying to compile kernel 2.6.24.7 to boot from an IBM
Netvista N220 (8363) http://jeanchristophe.duber.free.fr/netvista_8363/
however, some people points that the IDE DMA driver is broken
(http://www.selfservix.org/n2200.htm).

For sure, i cannot have the kernel option "Cyrix/National Semiconductor
CS5530 MediaGX chipset support (BLK_DEV_CS5530)" enabled, or the
Netvista will complain with the messages bellow, using kernel 2.6.24.7
(i haven't used any more recent kernel because since kernel 2.6.24.7
they just fail to boot in Netvista 8363).

...
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
CS5530: IDE controller (0x1078:0x0102 rev 0x00) at PCI slot 0000:00:12.2
CS5530: not 100% native mode: will probe irqs later
          ide0: BM-DMA at 0xfc00-0xfc07, BIOS settings: hda:pio, hdb:pio
          ide1: BM-DMA at 0xfc08-0xfc0f, BIOS settings: hdc:pio, hdd:pio
hda: SILICON POWER, ATA DISK drive
hda: UDMA/33 mode selected
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hda: max request size: 128KiB
hda: 2000880 sectors (1024 MB) w/2KiB Cache, CHS=1985/16/63
 hda:<4>hda: dma_timer_expiry: dma status == 0x20
hda: DMA timeout retry
hda: timeout waiting for DMA
hda: status error: status=0x58 { DriveReady SeekComplete DataRequest }
ide: failed opcode was: unknown
hda: drive not ready for command
ide0: reset: success
Clocksource tsc unstable (delta = 119999355 ns)
time: pit clocksource has been installed.
hda: irq timeout: status=0xd0 { Busy }
ide: failed opcode was: unknown
ide0: reset timed-out: status=0x80
hda: status timeout: status=0x80 { Busy }
ide: failed opcode was: unknown
end_request: I/O error, dev hda, sector 0
Buffer I/O error on device hda, logical block 0
hda: drive not ready for command
hda: status timeout: status=0x80 { Busy }
ide: failed opcode was: unknown
hda: DMA disabled
hda: drive not ready for command
ide0: reset timed-out, status=0x80
end_request: I/O error, dev hda, sector 0
Buffer I/O error on device hda, logical block 0
 unable to read partition table
...
VFS: Cannot open root device "<NULL>" or unknown-block(0,0)
Please append a correct "root=" boot option; here are the available
partitions:
0300      1000440 hda driver: ide-disk
Kernel panic - not syncing: VFS: Unable to mount root fs on
unknown-block(0,0)


Does anyone know what could be the problem here?

IBM Netvista is a thin client with Geode GX1 and boots the kernel
directly from ext3 without any boot loader. It does not support any
kernel boot parameters.

Thank you

-- 
-----------------------------------------
Antonio Cardoso Martins
        digiplan.pt@gmail.com
-----------------------------------------


