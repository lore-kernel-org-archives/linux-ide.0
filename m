From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 4/5] sis5513: backport short cables support from pata_sis.c
Date: Wed, 27 Jun 2007 21:15:31 +0200
Message-ID: <200706272115.31807.bzolnier@gmail.com>
References: <200706101558.33636.bzolnier@gmail.com> <46816011.70000@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mu-out-0910.google.com ([209.85.134.184]:63652 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753818AbXF0TzN (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 27 Jun 2007 15:55:13 -0400
Received: by mu-out-0910.google.com with SMTP id i10so427322mue
        for <linux-ide@vger.kernel.org>; Wed, 27 Jun 2007 12:55:10 -0700 (PDT)
In-Reply-To: <46816011.70000@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Tuesday 26 June 2007, Sergei Shtylyov wrote:
> Bartlomiej Zolnierkiewicz wrote:
> 
> > Backport short cables support from pata_sis.c.
> 
> > This patch should allow UDMA > 2 modes on ASUS A6K.
> 
> > Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> 
> Acked-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>
> 
> > Index: b/drivers/ide/pci/sis5513.c
> > ===================================================================
> > --- a/drivers/ide/pci/sis5513.c
> > +++ b/drivers/ide/pci/sis5513.c
> [...]
> > @@ -796,10 +796,33 @@ static unsigned int __devinit init_chips
> >  	return 0;
> >  }
> >  
> > +struct sis_laptop {
> > +	u16 device;
> > +	u16 subvendor;
> > +	u16 subdevice;
> > +};
> > +
> > +static const struct sis_laptop sis_laptop[] = {
> > +	/* devid, subvendor, subdev */
> > +	{ 0x5513, 0x1043, 0x1107 },	/* ASUS A6K */
> > +	/* end marker */
> > +	{ 0, }
> > +};
> > +
> >  static u8 __devinit ata66_sis5513(ide_hwif_t *hwif)
> >  {
> > +	struct pci_dev *pdev = hwif->pci_dev;
> > +	const struct sis_laptop *lap = &sis_laptop[0];
> >  	u8 ata66 = 0;
> >  
> > +	while (lap->device) {
> > +		if (lap->device == pdev->device &&
> > +		    lap->subvendor == pdev->subsystem_vendor &&
> > +		    lap->subdevice == pdev->subsystem_device)
> > +			return ATA_CBL_PATA40_SHORT;
> > +		lap++;
> > +	}
> > +
> 
>    The code even starts looking generic enough to be put into helper...

Hmm, agreed, now if somebody could send me a patch...

Thanks,
Bart
