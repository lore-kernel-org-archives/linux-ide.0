From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: PATCH for initial review: EFAR IDE
Date: Thu, 15 Dec 2005 22:35:46 +0000
Message-ID: <1134686146.20495.17.camel@localhost.localdomain>
References: <1134496645.11732.119.camel@localhost.localdomain>
	 <43A1E8DE.7080801@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from clock-tower.bc.nu ([81.2.110.250]:15547 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751161AbVLOWfe (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 15 Dec 2005 17:35:34 -0500
In-Reply-To: <43A1E8DE.7080801@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org

On Iau, 2005-12-15 at 17:06 -0500, Jeff Garzik wrote:

> > 	struct pci_dev *pdev = to_pci_dev(ap->host_set->dev);
> > 	static struct pci_bits efar_enable_bits[] = {
> 
> const

Fixed

> > 	/* FIXME: Check for PIO2 if the required timing needs IORDY
> > 	   We should push this up into libata and have a requires_iordy() */
> 
> Yes, you should :)

The old IDE driver doesn't (but then it gets all this wrong). I've added
a function to look at old EIDE drive bits and see if PIO2 is iordy or
not and used it in the various intel drivers and this now.

There are some corner cases left (Are there drives that don't support
iordy at all but can do > PIO0 cycle time because some controllers
don't)


> >  *	efar_init_one - Register PIIX ATA PCI device with kernel services
> 
> s/PIIX/EFAR/ ?

Yep

> 
> >  *	@pdev: PCI device to register
> >  *	@ent: Entry in efar_pci_tbl matching with @pdev
> >  *
> >  *	Called from kernel PCI layer.  We probe for combined mode (sigh),
> 
> You probe for combined mode?

Umm no, the joys of cut and waste.

