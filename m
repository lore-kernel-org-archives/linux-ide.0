From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] cy82c693: fix PCI device selection
Date: Wed, 12 Oct 2011 18:58:21 +0100
Message-ID: <20111012185821.2955b861@lxorguk.ukuu.org.uk>
References: <201110111937.32501.bzolnier@gmail.com>
	<20111011.152040.662786307819949300.davem@davemloft.net>
	<201110121652.10495.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:45963 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751855Ab1JLR6T (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 12 Oct 2011 13:58:19 -0400
In-Reply-To: <201110121652.10495.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: David Miller <davem@davemloft.net>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, 12 Oct 2011 16:52:10 +0200
Bartlomiej Zolnierkiewicz <bzolnier@gmail.com> wrote:

> David Miller wrote:
> 
> > From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> > Date: Tue, 11 Oct 2011 19:37:32 +0200
> > 
> > > While at it remove redundant pci_get_slot() call as cy82c693_init_one()
> > > already takes care of keeping the reference on the second port's PCI
> > > device.
> > 
> > Please do not submit unrelated changes with a bug fix, and as IDE is
> > in long-term maintainence I would not accept a risky refinement like
> > this anyways.
> 
> Removed code is just bogus, we cannot fail in ->set_pio_mode method.
> 
> Please take a look at the code:
>  
> -	/* select primary or secondary channel */
> -	if (hwif->index > 0) {  /* drive is on the secondary channel */
> -		dev = pci_get_slot(dev->bus, dev->devfn+1);
> -		if (!dev) {
> -			printk(KERN_ERR "%s: tune_drive: "
> -				"Cannot find secondary interface!\n",
> -				drive->name);
> -			return;
> -		}
> -	}
> 
> Please apply the patch, libata's pata_cypress doesn't support secondary
> port currently and cy82c693 driver is the only way to use this hardware.

I've not found anyone using an Alpha 164SX in years so it's not been
possible to do the updates and test them. And no ... do not offer to send
me an Alpha, donate it to a museum.

Alan
