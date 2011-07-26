From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: [patch v3 1/1] ata: Add iMX pata support
Date: Tue, 26 Jul 2011 14:15:37 +0200
Message-ID: <20110726121537.GL20587@pengutronix.de>
References: <20110724183805.992906251@rtp-net.org>
 <20110724183823.420642781@rtp-net.org>
 <20110726073911.GG20587@pengutronix.de>
 <877h75mk7o.fsf@lebrac.rtp-net.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:57926 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751832Ab1GZMPm (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 26 Jul 2011 08:15:42 -0400
Content-Disposition: inline
In-Reply-To: <877h75mk7o.fsf@lebrac.rtp-net.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Arnaud Patard <arnaud.patard@rtp-net.org>
Cc: linux-ide@vger.kernel.org, jgarzik@pobox.com

On Tue, Jul 26, 2011 at 12:04:27PM +0200, Arnaud Patard wrote:
> Sascha Hauer <s.hauer@pengutronix.de> writes:
> 
> > Hi Arnaud,
> 
> Hi,
> >
> > On Sun, Jul 24, 2011 at 08:38:07PM +0200, Arnaud Patard wrote:
> >> Add basic support for pata on iMX. It has been tested only on imx51.
> >> SDMA support will probably be added later so this version supports only
> >> PIO.
> >> 
> >> v2:
> >>   - enable only when needed IORDY
> >>   - use dev_get_drvdata
> >> v3:
> >>   - add missing clk_put() calls
> >>   - use platform_get_irq()
> >>   - fix resume code to avoid disabling IORDY on resume
> >> 
> >> Signed-off-by: Arnaud Patard <arnaud.patard@rtp-net.org>
> >> Index: linux-2.6-submit/drivers/ata/Kconfig
> >> ===================================================================
> >> --- linux-2.6-submit.orig/drivers/ata/Kconfig	2011-07-22 23:29:06.000000000 +0200
> >> +++ linux-2.6-submit/drivers/ata/Kconfig	2011-07-22 23:30:58.000000000 +0200
> >> @@ -467,6 +467,15 @@ config PATA_ICSIDE
> >>  	  interface card.  This is not required for ICS partition support.
> >>  	  If you are unsure, say N to this.
> >>  
> >> +config PATA_IMX
> >> +	tristate "PATA support for Freescale iMX (Experimental)"
> >> +	depends on ARCH_MX5 && EXPERIMENTAL
> >
> > Should this really depend on EXPERIMENTAL? This driver looks pretty
> > straightforward.
> 
> I've been wondering about it but given that it has been tested only on
> efika platforms, I prefered to keep it. If you think it's better to
> remove it, fine. I'll do it.

Only the efika platform registers the device, so there's no risk to
harm other boards.

> >
> > IS_ERR(priv->clk)
> >
> > (also for the checks below)
> >
> > Does it really make sense to continue when the clock failed?
> 
> if you have uboot version like the one I have, the clock will be already
> enabled before booting linux so the driver will work. Maybe too fragile ?
> I've changed the checks on my local version and about to test it. Let me
> know if you think it should really be a failure, in order to avoid
> having to send a new version only to make it a failure.

Yes, it should be a failure.

> >> +	ap->ioaddr.cmd_addr = devm_ioremap(&pdev->dev,
> >> +					io_res->start + PATA_IMX_DRIVE_DATA,
> >> +					0x20);
> >> +	ap->ioaddr.ctl_addr = devm_ioremap(&pdev->dev,
> >> +					io_res->start + PATA_IMX_DRIVE_CONTROL,
> >> +					0x04);
> >
> > It looks strange to ioremap the register offsets again. Why not just a
> >
> > 	ap->ioaddr.cmd_addr = priv->host_regs + PATA_IMX_DRIVE_DATA
> > 	ap->ioaddr.ctl_addr = priv->host_regs + PATA_IMX_DRIVE_CONTROL
> >
> > Hm, probably copied from the pxa driver, but this uses different
> > resources which makes different ioremaps necessary.
> 
> There are holes in the register map in the manual, that's why I used
> several ioremap. I prefer staying near to what the manual says and avoid
> remapping unknown registers.

Having holes in the register space is a very common case, no need to do
several ioremaps. Besides, ioremap will give you a whole page anyway.

Sascha


-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
