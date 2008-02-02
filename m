From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: PCI: Remove users of pci_enable_device_bars()
Date: Sat, 2 Feb 2008 21:01:10 +0100
Message-ID: <200802022101.11095.bzolnier@gmail.com>
References: <200802020506.m1256FVn024064@hera.kernel.org> <47A40D54.70509@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from qb-out-0506.google.com ([72.14.204.238]:51011 "EHLO
	qb-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933363AbYBBTsi (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 2 Feb 2008 14:48:38 -0500
Received: by qb-out-0506.google.com with SMTP id e11so1480938qbe.15
        for <linux-ide@vger.kernel.org>; Sat, 02 Feb 2008 11:48:36 -0800 (PST)
In-Reply-To: <47A40D54.70509@garzik.org>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Greg Kroah-Hartman <gregkh@suse.de>, Linux IDE mailing list <linux-ide@vger.kernel.org>

On Saturday 02 February 2008, Jeff Garzik wrote:
> Linux Kernel Mailing List wrote:
> > Commit:     0948391641918b95d8d96c15089eb5ac156850b3
> 
> >     PCI: Remove users of pci_enable_device_bars()
> >     
> >     This patch converts users of pci_enable_device_bars() to the new
> >     pci_enable_device_{io,mem} interface.
> >     
> >     The new API fits nicely, except maybe for the QLA case where a bit of
> >     code re-organization might be a good idea but I prefer sticking to the
> >     simple patch as I don't have hardware to test on.
> >     
> >     I'll also need some feedback on the cs5520 change.
> >     
> >     Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> >     Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
> 
> > --- a/drivers/ata/pata_cs5520.c
> > +++ b/drivers/ata/pata_cs5520.c
> > @@ -229,7 +229,7 @@ static int __devinit cs5520_init_one(struct pci_dev *pdev, const struct pci_devi
> >  		return -ENOMEM;
> >  
> >  	/* Perform set up for DMA */
> > -	if (pci_enable_device_bars(pdev, 1<<2)) {
> > +	if (pci_enable_device_io(pdev)) {
> >  		printk(KERN_ERR DRV_NAME ": unable to configure BAR2.\n");
> >  		return -ENODEV;
> >  	}
> > diff --git a/drivers/ide/pci/cs5520.c b/drivers/ide/pci/cs5520.c
> > index 6ec00b8..10adc49 100644
> > --- a/drivers/ide/pci/cs5520.c
> > +++ b/drivers/ide/pci/cs5520.c
> > @@ -156,8 +156,14 @@ static int __devinit cs5520_init_one(struct pci_dev *dev, const struct pci_devic
> >  	ide_setup_pci_noise(dev, d);
> >  
> >  	/* We must not grab the entire device, it has 'ISA' space in its
> > -	   BARS too and we will freak out other bits of the kernel */
> > -	if (pci_enable_device_bars(dev, 1<<2)) {
> > +	 * BARS too and we will freak out other bits of the kernel
> > +	 *
> > +	 * pci_enable_device_bars() is going away. I replaced it with
> > +	 * IO only enable for now but I'll need confirmation this is
> > +	 * allright for that device. If not, it will need some kind of
> > +	 * quirk. --BenH.
> > +	 */
> > +	if (pci_enable_device_io(dev)) {
> >  		printk(KERN_WARNING "%s: Unable to enable 55x0.\n", d->name);
> >  		return -ENODEV;
> >  	}
> 
> So...  did the feedback mentioned in the commit log ever appear?  :)

Since Alan has commented on it:

http://lkml.org/lkml/2007/12/17/422

"5520 in fact is always enabled as it is the host bridge.
pci_enable_device_io will do just fine. The 5520 fun is if you disable it
the system hangs."

I moved on assuming that either submitter or integrator would follow up...
but it seems that it didn't happen. :(

PS Could somebody remove the stale comment from cs5520.c?

Thanks,
Bart
