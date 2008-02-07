From: "Bartlomiej Zolnierkiewicz" <bzolnier@gmail.com>
Subject: Re: [PATCH 3/3] palm_bk3710: factor out cable detection
Date: Thu, 7 Feb 2008 17:14:18 +0100
Message-ID: <58cb370e0802070814y44e37cf4h91f57fd4bc993133@mail.gmail.com>
References: <200802071542.29628.bzolnier@gmail.com>
	 <47AB1882.8060103@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fk-out-0910.google.com ([209.85.128.186]:31019 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760817AbYBGQOV (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 7 Feb 2008 11:14:21 -0500
Received: by fk-out-0910.google.com with SMTP id z23so3067912fkz.5
        for <linux-ide@vger.kernel.org>; Thu, 07 Feb 2008 08:14:20 -0800 (PST)
In-Reply-To: <47AB1882.8060103@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Anton Salnikov <asalnikov@ru.mvista.com>

On Feb 7, 2008 3:41 PM, Sergei Shtylyov <sshtylyov@ru.mvista.com> wrote:
> Bartlomiej Zolnierkiewicz wrote:
>
> > Factor out cable detection to palm_bk3710_cable_detect().
>
> > Cc: Anton Salnikov <asalnikov@ru.mvista.com>
> > Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
>
> > Index: b/drivers/ide/arm/palm_bk3710.c
> > ===================================================================
> > --- a/drivers/ide/arm/palm_bk3710.c
> > +++ b/drivers/ide/arm/palm_bk3710.c
> > @@ -311,6 +311,12 @@ static void __devinit palm_bk3710_chipin
> >       palm_bk3710_setpiomode(base, NULL, 0, 600, 0);
> >       palm_bk3710_setpiomode(base, NULL, 1, 600, 0);
> >  }
> > +
> > +static u8 __devinit palm_bk3710_cable_detect(ide_hwif_t *hwif)
> > +{
> > +     return ATA_CBL_PATA80;
> > +}
> > +
> >  static int __devinit palm_bk3710_probe(struct platform_device *pdev)
> >  {
> >       struct clk *clkp;
> > @@ -381,7 +387,7 @@ static int __devinit palm_bk3710_probe(s
> >       hwif->set_dma_mode = &palm_bk3710_set_dma_mode;
> >       hwif->mmio = 1;
> >       default_hwif_mmiops(hwif);
> > -     hwif->cbl = ATA_CBL_PATA80;
> > +     hwif->cbl = palm_bk3710_cable_detect(hwif);
> >       hwif->ultra_mask = 0x1f;        /* Ultra DMA Mode 4 Max
> >                                               (input clk 99MHz) */
> >       hwif->mwdma_mask = 0x7;
>
>     Hm, how does it help if you don't make it into driver's method? :-O

This was meant to be a preparation before converting palm_bk3710 to
use struct ide_port_info.  On the second thought this change may be as
well integrated into the future patch (which I'll try to cook later
today, unless somebody beats me to it ;-).

Thanks,
Bart
