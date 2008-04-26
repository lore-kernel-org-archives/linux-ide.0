From: Alek Du <alek.du@intel.com>
Subject: Re: [PATCH] ata: Add Intel SCH PATA support
Date: Sun, 27 Apr 2008 07:51:15 +0800
Message-ID: <20080427075115.3ea40204@dxy.sh.intel.com>
References: <20080426140007.63cfeede@dxy.sh.intel.com>
	<20080426103012.21dcf0fb@core>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:55840 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753010AbYDZX6E (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 26 Apr 2008 19:58:04 -0400
In-Reply-To: <20080426103012.21dcf0fb@core>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-ide@vger.kernel.org, jgarzik@pobox.com

Alan,
	Thanks for your comments:

On Sat, 26 Apr 2008 17:30:12 +0800
"Alan Cox" <alan@lxorguk.ukuu.org.uk> wrote:

> Re: [PATCH] ata: Add Intel SCH PATA support
> 
> > +struct sch_80 {
> > +       u16 device;
> > +};
> 
> That seems somewhat overkill

I have to consider there would be other PATA controllers work this way.
> 
> > +       /* Check for specials - Intel SCH chipset */
> > +       while (sch->device) {
> > +               if (sch->device == pdev->device)
> > +                       return ATA_CBL_PATA80;
> > +               sch++;
> 
> PATA_80 means "controller *knows* we are 80 wire". PATA_UNK means
> "controller can't do detect."

I need to force SCH to use PATA 80 pins to enable UDMA5, just like the way ich_laptop force
to use 40 pins.
> 
> > +       /* Check for specials - Intel SCH chipset */
> > +       while (sch->device) {
> > +               if (sch->device == pdev->device) {
> > +                       skip_check = 1;
> > +                       break;
> > +               }
> > +               sch++;
> 
> This is horrible. If you just defined a new set of methods for your new
> controller (remembering we now have inheritance anyway) you'd just use
> the ata_sff_prereset and remove all the special casing code. At the very
> least write the routine once only;)
> 
hmmm... for non-sch chipsets, there is no impact, this will only affect sch. You mean
I should create a ata_sch.c file instead of patching ata_piix.c ?

> > +       }
> > +       if (!skip_check)
> > +               if (!pci_test_config_bits(pdev, &piix_enable_bits[ap->port_no]))
> > +                       return -ENOENT;
> >         return ata_sff_prereset(link, deadline);
> >  }
> >
