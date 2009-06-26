From: Andrei Martynov <andrei.martynov@web.de>
Subject: Re[2]: porting IDE patches to PATA driver
Date: Fri, 26 Jun 2009 16:40:52 +0200
Message-ID: <792909512.20090626164052@web.de>
References: <323951117.20090625100956@web.de>
 <20090625092324.2dd4de5a@lxorguk.ukuu.org.uk> <14164712.20090625103834@web.de>
 <20090625100542.525dba02@lxorguk.ukuu.org.uk> <951976828.20090625123021@web.de>
 <20090625122958.510c28ad@lxorguk.ukuu.org.uk> <96179821.20090626152440@web.de>
 <20090626144639.4bc822b8@lxorguk.ukuu.org.uk>
Reply-To: Andrei Martynov <andrei.martynov@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fmmailgate03.web.de ([217.72.192.234]:34709 "EHLO
	fmmailgate03.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751839AbZFZOk4 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 26 Jun 2009 10:40:56 -0400
In-Reply-To: <20090626144639.4bc822b8@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-ide@vger.kernel.org

Hello Alan,

Friday, June 26, 2009, 3:46:39 PM, you wrote:

> The bmdma_start shouldn't be needed. Libata knows about using the cache
> coherency dma interfaces and uses them.

Correct, libata does call corresponding interface and the functions
are defined for the cpu. But this architecture is buggy. It is
necessary to clean (write back) complete cache before DMA write
operation even if the corresponding range is already cleaned,
otherwise few bytes in the written block are corrupted at random
offset. I've spent many days playing with dma interface and even
calculating md5sum of every written block before I had to accept this
fact.

> The bmdma end is no standard and polls the status up to 100 times until
> it gives a sensible looking answer. That may be needed but its hard to
> guess from just horrible code if that was someone's random debug hacks or
> a real chip erratum.

Chip is really weird. A group of enthusiasts implemented slave device
support for it. As I could understand from their explanation the
controller switches to a specific DVD-LOADER mode as soon as kernel
sends any command to the slave device, so they had to patch sources
and add a strange looking command

OUT_BYTE((head|drive->select.all) & ~(1<<4), IDE_SELECT_REG);

everywhere the slave device is accessed to cheat the controller and
let it believe it talks to the master. Slave device remains active
because it was already selected but the controller assumes we are
talking to the master and does not switch to DVD-LOADER mode.

> I notice the 2.4.17 patches you are referencing don't enable MWDMA either
> (#undef EBABLE_BMDMA) so does MWDMA actually work on the hardware ?

Here is a part of the boot log with 2.4.17 kernel. Speed is set to
0x22 (XFER_MW_DMA_2), that's why I assume it should work. I can limit
allowed modes to PIO-only in 2.6 kernel, the driver is working but it
is too slow.

Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 50MHz system bus speed for PIO modes; override with idebus=xx
JASPER ide controller activated
ide0: BM-DMA at 0x500e00-0x500e0f, BIOS settings: hda:pio, hdb:pio
hda: IDE_SELECT Reg = 000000a0
hda: IDE_SIDETIM Reg = 00000000
hda: IDE_SELECT Reg = 000000a0
hda: IDE_SIDETIM Reg = 00000000
hda: 9929D05E59V1.500P3311077, ATAPI CD/DVD-ROM drive
IDE: waiting for drives to settle...
hdb: IDE_SELECT Reg = 000000b0
hdb: IDE_SIDETIM Reg = 00000000
hdb: SAMSUNG HD300LD, ATA DISK drive
ide0 at 0x500bf0-0x500bf7,0x500be6 on irq 11
hdb: ignore DMA off message.
model = SAMSUNG HD300LD
firmware version = WK100-12
jasper_config_drive_for_dma:
capability = 0x002f
field_valid = 0x0007
dma_ultra = 0x003f
dma_1word (s) = 0x0000
dma_mword (m) = 0x0407
autodma = 0x0001
jasper_tune_chipset: speed = 22
***** init_idedisk_capacity: set_max_ext=15647024, capacity_2=586070255
hdb: 586070255 sectors (300068 MB) w/8192KiB Cache, CHS=36481/255/63, (U)DMA
hda: ignore DMA off message.
model = 9929D05E59V1.500P3311077
firmware version =
jasper_config_drive_for_dma:
capability = 0x000b
field_valid = 0x0002
dma_ultra = 0x0000
dma_1word (s) = 0x0000
dma_mword (m) = 0x0407
autodma = 0x0001
jasper_tune_chipset: speed = 22
hda: ATAPI 32X DVD-ROM drive, 256kB Cache, DMA
Uniform CD-ROM driver Revision: 3.12
Partition check:
/dev/ide/host0/bus0/target1/lun0: p1 < p5 p6 >

-- 
Best regards,
 Andrei                            mailto:andrei.martynov@web.de

