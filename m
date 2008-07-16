From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH] ide-floppy fix
Date: Wed, 16 Jul 2008 17:59:16 +0200
Message-ID: <200807161759.16803.bzolnier@gmail.com>
References: <20080715053356.GA18628@gollum.tnic>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from yw-out-2324.google.com ([74.125.46.30]:61350 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752117AbYGOQ5Q (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 15 Jul 2008 12:57:16 -0400
Received: by yw-out-2324.google.com with SMTP id 9so2620411ywe.1
        for <linux-ide@vger.kernel.org>; Tue, 15 Jul 2008 09:57:02 -0700 (PDT)
In-Reply-To: <20080715053356.GA18628@gollum.tnic>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: petkovbb@gmail.com
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, stable@kernel.org


Hi,

On Tuesday 15 July 2008, Borislav Petkov wrote:

[...]

> On a different note, the current pata tree on top of v2.6.25-2125-g50515af blows
> up here with the following error:
> 
> [    4.296729] Uniform Multi-Platform E-IDE driver
> [    4.297905] ICH4: IDE controller (0x8086:0x24cb rev 0x02) at  PCI slot 0000:00:1f.1
> [    4.297986] ACPI: PCI Interrupt 0000:00:1f.1[A] -> GSI 18 (level, low) -> IRQ 18
> [    4.298153] ICH4: not 100% native mode: will probe irqs later
> [    4.298213]     ide0: BM-DMA at 0xfc00-0xfc07
> [    4.298282]     ide1: BM-DMA at 0xfc08-0xfc0f
> [    4.561768] hda: QUANTUM FIREBALLlct10 20, ATA DISK drive
> [    4.816724] hdb: SAMSUNG SP2014N, ATA DISK drive
> [    4.867959] hda: drive side 80-wire cable detection failed, limiting max speed to UDMA33
> [    4.868027] hda: UDMA/33 mode selected
> [    4.868441] hdb: UDMA/100 mode selected
> [    5.540683] hdc: IOMEGA ZIP 100 ATAPI, ATAPI FLOPPY drive
> [    5.795564] hdd: IC35L120AVV207-0, ATA DISK drive
> [    5.847295] hdd: host side 80-wire cable detection failed, limiting max speed to UDMA33
> [    5.847362] hdd: UDMA/33 mode selected
> [    5.847715] ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
> [    5.855487] ide1 at 0x170-0x177,0x376 on irq 15
> [    5.875927] ide_generic: please use "probe_mask=0x3f" module parameter for probing all legacy ISA IDE ports
> [    5.876012] ide_generic: I/O resource 0x1F0-0x1F7 not free.
> [    5.876074] ide_generic: I/O resource 0x170-0x177 not free.
> [   11.342504] hde: no response (status = 0xa1), resetting drive
> [   17.206535] hdf: no response (status = 0xa1), resetting drive

hde? hdf?

[...]

> I tracked the error down to the call to ide_register_port(hwif) in
> ide-probe.c:ide_host_register() which does device_register(&hwif->gendev) and
> the hwif->gendev->kobj seems unitialized thus the WARN_ON on its refcount in
> kref_get(). Will look into it more when i get some free time.

Unfortunately I couldn't reproduce this problem here (2.6.26 + pata tree)
so please try to debug it and/or narrow it down to the guilty change.

> --
> From: Borislav Petkov <petkovbb@gmail.com>
> 
> Check the correct flags-location for set features.
> 
> Signed-off-by: Borislav Petkov <petkovbb@gmail.com>

Thanks, I folded the fix into original patch (->dev_flags is not yet
upstream so -stable fix shouldn't be necessary).

While on it: I later noticed that there will be also need for common
ATA/ATAPI ->dev_flags in the future so I wonder whether current
->dev_flags should be renamed to ->atapi_flags (& s/*DFLAG*/*AFLAG*/).

If there is agreement on this I'll fix it in pata tree.
