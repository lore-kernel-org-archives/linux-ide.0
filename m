From: Phil Sutter <n0-1@freewrt.org>
Subject: Re: [PATCH] include old-style rb532 CompactFlash support
Date: Wed, 29 Oct 2008 20:59:12 +0100
Message-ID: <20081029195911.GB17108@nuty>
References: <20081027205124.GB27227@nuty> <1225304359-11290-1-git-send-email-n0-1@freewrt.org> <200810292025.53762.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from orbit.nwl.cc ([81.169.176.177]:38602 "EHLO
	mail.ifyouseekate.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752146AbYJ2T6L (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 29 Oct 2008 15:58:11 -0400
Received: from nuty (localhost [127.0.0.1])
	by mail.ifyouseekate.net (Postfix) with ESMTP id DF1313891A92
	for <linux-ide@vger.kernel.org>; Wed, 29 Oct 2008 20:58:08 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <200810292025.53762.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

On Wed, Oct 29, 2008 at 08:25:53PM +0100, Bartlomiej Zolnierkiewicz wrote:
> On Wednesday 29 October 2008, Phil Sutter wrote:
> > I copied the driver from the OpenWrt project to FreeWRT at Thu, 16 Nov
> > 2006 and since then maintain it. As the current kernel for rb532 in
> > FreeWRT is 2.6.19.1, intense testing has only been done basing on the
> > local patches for the board support. After porting it to the linux-mips
> > git tree, I could verify the functionality by mounting an ext2
> > filesystem on the disk and reading/writing files in it.
> 
> Hmm, I thought that the old driver is an IDE driver not a stand-alone one
> so I'm not much in favor of merging it as it is.  However it still should
> be useful in figuring out why pata_rb532_cf doesn't work correctly.

I doubt having a non-working pata driver _only_ mainstream makes sense.
But porting it around just to drop it afterwards in favour of a new
shiny pata driver doesn't make sense, either. :)

> > +static irqreturn_t cf_irq_handler(int irq, void *dev_id)
> > +{
> > +	/* While tasklet has not disabled irq, irq will be retried all the time
> > +	 * because of ILEVEL matching GPIO pin status => deadlock.
> > +	 * To avoid this, we change ILEVEL to 0.
> > +	 */
> > +	struct cf_mips_dev *dev = dev_id;
> > +
> > +	rb532_gpio_set_ilevel(0, dev->pin);
> > +	rb532_gpio_set_istat(0, dev->pin);
> 
> I cannot find the corresponding functionality in the new driver or arch code?

Right, that somehow was left out. As I originally wasn't involved in it's
development, I can't tell why this happened. But this will be my
starting point when I continue with it, now that I have functions I can
depend on.

> [ It seems that ->set_int_{level,status} methods from arch/mips/rb532/gpio.c
>   are not used anywhere in the kernel? ]

Yeah, well. Not anywhere else. rb532_gpio_init() at the bottom of gpio.c
calls them, but in fact this is also code taken over from the cf driver
(see prepare_cf_irq() in ata.c).

Greetings, Phil
