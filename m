From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 3/3] palm_bk3710: factor out cable detection
Date: Thu, 7 Feb 2008 21:51:49 +0100
Message-ID: <200802072151.49510.bzolnier@gmail.com>
References: <200802071542.29628.bzolnier@gmail.com> <47AB1882.8060103@ru.mvista.com> <58cb370e0802070814y44e37cf4h91f57fd4bc993133@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.178]:58553 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755149AbYBGUij (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 7 Feb 2008 15:38:39 -0500
Received: by wa-out-1112.google.com with SMTP id v27so49181wah.23
        for <linux-ide@vger.kernel.org>; Thu, 07 Feb 2008 12:38:39 -0800 (PST)
In-Reply-To: <58cb370e0802070814y44e37cf4h91f57fd4bc993133@mail.gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Anton Salnikov <asalnikov@ru.mvista.com>

On Thursday 07 February 2008, Bartlomiej Zolnierkiewicz wrote:
> On Feb 7, 2008 3:41 PM, Sergei Shtylyov <sshtylyov@ru.mvista.com> wrote:
> > Bartlomiej Zolnierkiewicz wrote:
> >
> > > Factor out cable detection to palm_bk3710_cable_detect().
> >
> > > Cc: Anton Salnikov <asalnikov@ru.mvista.com>
> > > Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> >
> > > Index: b/drivers/ide/arm/palm_bk3710.c
> > > ===================================================================
> > > --- a/drivers/ide/arm/palm_bk3710.c
> > > +++ b/drivers/ide/arm/palm_bk3710.c
> > > @@ -311,6 +311,12 @@ static void __devinit palm_bk3710_chipin
> > >       palm_bk3710_setpiomode(base, NULL, 0, 600, 0);
> > >       palm_bk3710_setpiomode(base, NULL, 1, 600, 0);
> > >  }
> > > +
> > > +static u8 __devinit palm_bk3710_cable_detect(ide_hwif_t *hwif)
> > > +{
> > > +     return ATA_CBL_PATA80;
> > > +}
> > > +
> > >  static int __devinit palm_bk3710_probe(struct platform_device *pdev)
> > >  {
> > >       struct clk *clkp;
> > > @@ -381,7 +387,7 @@ static int __devinit palm_bk3710_probe(s
> > >       hwif->set_dma_mode = &palm_bk3710_set_dma_mode;
> > >       hwif->mmio = 1;
> > >       default_hwif_mmiops(hwif);
> > > -     hwif->cbl = ATA_CBL_PATA80;
> > > +     hwif->cbl = palm_bk3710_cable_detect(hwif);
> > >       hwif->ultra_mask = 0x1f;        /* Ultra DMA Mode 4 Max
> > >                                               (input clk 99MHz) */
> > >       hwif->mwdma_mask = 0x7;
> >
> >     Hm, how does it help if you don't make it into driver's method? :-O
> 
> This was meant to be a preparation before converting palm_bk3710 to
> use struct ide_port_info.  On the second thought this change may be as
> well integrated into the future patch (which I'll try to cook later
> today, unless somebody beats me to it ;-).

From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] palm_bk3710: use struct ide_port_info

* Factor out cable detection to palm_bk3710_cable_detect().

* Add palm_bk3710_init_hwif() (->init_hwif method implementation).

* Remove needless ->quirkproc initialization.

* Add missing ->pio_mask initialization.

* Use ATA_* defines for setting ->{ultra,mwdma}_mask.

* Add 'struct ide_port_info palm_bk3710_port_info' and pass it to
  ide_device_add().  Then remove open-coded 'hwif' initialization.

Cc: Anton Salnikov <asalnikov@ru.mvista.com>
Cc: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/arm/palm_bk3710.c |   33 +++++++++++++++++++++++----------
 1 file changed, 23 insertions(+), 10 deletions(-)

Index: b/drivers/ide/arm/palm_bk3710.c
===================================================================
--- a/drivers/ide/arm/palm_bk3710.c
+++ b/drivers/ide/arm/palm_bk3710.c
@@ -311,6 +311,28 @@ static void __devinit palm_bk3710_chipin
 	palm_bk3710_setpiomode(base, NULL, 0, 600, 0);
 	palm_bk3710_setpiomode(base, NULL, 1, 600, 0);
 }
+
+static u8 __devinit palm_bk3710_cable_detect(ide_hwif_t *hwif)
+{
+	return ATA_CBL_PATA80;
+}
+
+static void __devinit palm_bk3710_init_hwif(ide_hwif_t *hwif)
+{
+	hwif->set_pio_mode = palm_bk3710_set_pio_mode;
+	hwif->set_dma_mode = palm_bk3710_set_dma_mode;
+
+	hwif->cable_detect = palm_bk3710_cable_detect;
+}
+
+static const struct ide_port_info __devinitdata palm_bk3710_port_info = {
+	.init_hwif		= palm_bk3710_init_hwif,
+	.host_flags		= IDE_HFLAG_NO_DMA, /* hack (no PCI) */
+	.pio_mask		= ATA_PIO4,
+	.udma_mask		= ATA_UDMA4,	/* (input clk 99MHz) */
+	.mwdma_mask		= ATA_MWDMA2,
+};
+
 static int __devinit palm_bk3710_probe(struct platform_device *pdev)
 {
 	struct clk *clkp;
@@ -368,24 +390,15 @@ static int __devinit palm_bk3710_probe(s
 		ide_init_port_data(hwif, i);
 
 	ide_init_port_hw(hwif, &hw);
-	hwif->quirkproc = NULL;
 
-	hwif->set_pio_mode = &palm_bk3710_set_pio_mode;
-	hwif->set_dma_mode = &palm_bk3710_set_dma_mode;
 	hwif->mmio = 1;
 	default_hwif_mmiops(hwif);
-	hwif->cbl = ATA_CBL_PATA80;
-	hwif->ultra_mask = 0x1f;	/* Ultra DMA Mode 4 Max
-						(input clk 99MHz) */
-	hwif->mwdma_mask = 0x7;
-	hwif->drives[0].autotune = 1;
-	hwif->drives[1].autotune = 1;
 
 	ide_setup_dma(hwif, mem->start);
 
 	idx[0] = i;
 
-	ide_device_add(idx, NULL);
+	ide_device_add(idx, &palm_bk3710_port_info);
 
 	if (!hwif->present)
 		goto out;

