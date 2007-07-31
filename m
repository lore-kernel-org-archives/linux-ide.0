From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: hpt374 sata (Highpoint Rocket 1540)
Date: Tue, 31 Jul 2007 23:32:10 +0200
Message-ID: <200707312332.10820.bzolnier@gmail.com>
References: <1185880124.3483.25.camel@localhost> <46AF76D7.8050800@ru.mvista.com> <1185916925.8484.23.camel@orchid.arb.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.191]:16474 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1764381AbXGaVlP (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 31 Jul 2007 17:41:15 -0400
Received: by nf-out-0910.google.com with SMTP id g13so2567nfb
        for <linux-ide@vger.kernel.org>; Tue, 31 Jul 2007 14:41:13 -0700 (PDT)
In-Reply-To: <1185916925.8484.23.camel@orchid.arb.net>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bob Ham <rah@bash.sh>
Cc: Sergei Shtylyov <sshtylyov@ru.mvista.com>, linux-ide@vger.kernel.org


Hi,

On Tuesday 31 July 2007, Bob Ham wrote:
> On Tue, 2007-07-31 at 21:52 +0400, Sergei Shtylyov wrote:
> > Hello, I wrote:
> > 
> > >> I've had a Highpoint Rocket 1540 (not "RocketRAID") SATA controller for
> > >> a while now, using a proprietary binary driver from Highpoint in a linux
> > >> 2.4 kernel.  The chipset is an hpt374.  The hpt366 driver freezes on
> > >> boot, as reported by others.
> > 
> > >    Can we see a bootlog please?
> > 
> >     ... and the output of 'lspci -v' too.
> 
> The machine locks hard when the driver is loaded so I can't give a full
> transcription, but here is the driver's output:
> 
> HPT374: IDE controller at PCI slot 0000:00:0d.0
> ACPI: PCI Interrupt 0000:00:0d.0[A] -> GSI 16 (level, low) -> IRQ 16
> HPT374: chipset revision 7
> HPT374: DPLL base: 48 MHz, f_CNT: 141, assuming 33 MHz PCI
> HPT374: using 50 MHz DPLL clock
> HPT374: 100% native mode on irq 16
>     ide2: BM-DMA at 0xec00-0xec07, BIOS settings: hde:DMA, hdf:pio
>     ide3: BM-DMA at 0xec08-0xec0f, BIOS settings: hdg:DMA, hdh:pio
> ACPI: PCI Interrupt 0000:00:0d.1[A] -> GSI 16 (level, low) -> IRQ 16
> HPT374: no clock data saved by BIOS
> HPT374: DPLL base: 48 MHz, f_CNT: 93, assuming 33 MHz PCI
> HPT374: using 50 MHz DPLL clock
>     ide4: BM-DMA at 0xed00-0xed07, BIOS settings: hdi:DMA, hdj:pio
>     ide5: BM-DMA at 0xed08-0xed0f, BIOS settings: hdk:DMA, hdl:pio
> 
> 
> The pata_hpt37x driver is refusing to work as well but it doesn't crash
> the machine.  Here is the relevant error message:
> 
> hpt37x: DPLL did not stabilize.
> pata_hpt37x: BIOS has not set timing clocks.
> hpt37x: DPLL did not stabilize.

Does this patch change anything?

[PATCH] hpt366: always tune PIO

Cc: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/pci/hpt366.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

Index: b/drivers/ide/pci/hpt366.c
===================================================================
--- a/drivers/ide/pci/hpt366.c
+++ b/drivers/ide/pci/hpt366.c
@@ -1,5 +1,5 @@
 /*
- * linux/drivers/ide/pci/hpt366.c		Version 1.10	Jun 29, 2007
+ * linux/drivers/ide/pci/hpt366.c		Version 1.11	Jul 29, 2007
  *
  * Copyright (C) 1999-2003		Andre Hedrick <andre@linux-ide.org>
  * Portions Copyright (C) 2001	        Sun Microsystems, Inc.
@@ -1265,10 +1265,10 @@ static void __devinit init_hwif_hpt366(i
 	if (new_mcr != old_mcr)
 		pci_write_config_byte(dev, hwif->select_data + 1, new_mcr);
 
-	if (!hwif->dma_base) {
-		hwif->drives[0].autotune = hwif->drives[1].autotune = 1;
+	hwif->drives[0].autotune = hwif->drives[1].autotune = 1;
+
+	if (hwif->dma_base == 0)
 		return;
-	}
 
 	hwif->ultra_mask = hwif->cds->udma_mask;
 	hwif->mwdma_mask = 0x07;
