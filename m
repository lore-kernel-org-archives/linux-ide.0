From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 20/21] ide: fix host drivers depending on ide_generic to probe for interfaces
Date: Wed, 12 Dec 2007 22:57:05 +0100
Message-ID: <200712122257.05258.bzolnier@gmail.com>
References: <200711182341.27444.bzolnier@gmail.com> <475FE32F.2000601@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.170]:40413 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751859AbXLLW6B (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 12 Dec 2007 17:58:01 -0500
Received: by ug-out-1314.google.com with SMTP id z38so724490ugc.16
        for <linux-ide@vger.kernel.org>; Wed, 12 Dec 2007 14:58:00 -0800 (PST)
In-Reply-To: <475FE32F.2000601@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linux-ide@vger.kernel.org, Mikael Starvik <starvik@axis.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Roman Zippel <zippel@linux-m68k.org>

On Wednesday 12 December 2007, Sergei Shtylyov wrote:
> Hello.
> 
> Bartlomiej Zolnierkiewicz wrote:
> 
> > * Add mpc8xx_ide_probe() to mpc8xx.c and call it from probe_for_hwifs().
> 
> > * Convert ide_arm, ide-cris, ide-h8300, ide-pnp, buddha, falconide, gayle,
> >   macide, q40ide, cmd640 and mpc8xx host drivers to use ide_device_add().
> 
> >   This removes dependency on ide_generic for these drivers so update
> >   ide/Kconfig accordingly.
> 
> > Cc: Mikael Starvik <starvik@axis.com>
> > Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> > Cc: Roman Zippel <zippel@linux-m68k.org>
> > Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> 
> > Index: b/drivers/ide/arm/ide_arm.c
> > ===================================================================
> > --- a/drivers/ide/arm/ide_arm.c
> > +++ b/drivers/ide/arm/ide_arm.c
> > @@ -28,6 +28,7 @@ void __init ide_arm_init(void)
> >  {
> >  	ide_hwif_t *hwif;
> >  	hw_regs_t hw;
> > +	u8 idx[4] = { 0xff, 0xff, 0xff, 0xff };
> >  
> >  	memset(&hw, 0, sizeof(hw));
> >  	ide_std_init_ports(&hw, IDE_ARM_IO, IDE_ARM_IO + 0x206);
> > @@ -36,5 +37,8 @@ void __init ide_arm_init(void)
> >  	hwif = ide_find_port(hw.io_ports[IDE_DATA_OFFSET]);
> >  	if (hwif) {
> >  		ide_init_port_hw(hwif, &hw);
> > +		idx[0] = hwif->index;
> > +
> > +		ide_device_idx(idx);
> 
>     You surely meant ide_device_add() here. Worth test compiling the files 
> you're changing... ;-)

Huh?  I thought this is what we have -mm for?  ;-)

http://lkml.org/lkml/2007/11/28/296

Bart
