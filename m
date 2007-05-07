From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH pata-2.6] hpt366: simplify UltraDMA filtering (take 2)
Date: Mon, 7 May 2007 20:24:13 +0200
Message-ID: <200705072024.13695.bzolnier@gmail.com>
References: <200705060024.54748.sshtylyov@ru.mvista.com> <463E2720.500@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.170]:35983 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934500AbXEGSM2 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 7 May 2007 14:12:28 -0400
Received: by ug-out-1314.google.com with SMTP id 44so1172366uga
        for <linux-ide@vger.kernel.org>; Mon, 07 May 2007 11:12:27 -0700 (PDT)
In-Reply-To: <463E2720.500@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linux-ide@vger.kernel.org

On Sunday 06 May 2007, Sergei Shtylyov wrote:
> Hello, I wrote:
> > Simplify UltraDMA mode filtering in the driver:
> 
> > - make use of the newly introduced 'udma_mask' field of 'ide_pci_device_t' to
> >   set the correct hwif->ultra_mask, modifying init_setup_hpt366() to select
> >   the correct mask based on the chip revision;
> 
> > - replace 'max_mode' field of the 'struct hpt_info' with 'max_ultra' specifying
> >   the maximum UltraDMA mode allowed;
> 
> > - rewrite hpt3xx_udma_filter() to differ the filters based on the 'chip_type'
> >   field, and only use it for HPT366 and HPT370[A] where it's really necessary.
> > 
> > Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>
> > 
> > Index: linux-2.6/drivers/ide/pci/hpt366.c
> > ===================================================================
> > --- linux-2.6.orig/drivers/ide/pci/hpt366.c
> > +++ linux-2.6/drivers/ide/pci/hpt366.c
> > @@ -1502,9 +1490,33 @@ static int __devinit init_setup_hpt366(s
> >  
> >  	pci_read_config_byte(dev, PCI_REVISION_ID, &rev);
> >  
> > -	if (rev > 6)
> > +	switch (rev) {
> > +	case 0:
> > +	case 1:
> > +	case 2:
> > +		/*
> > +		 * HPT36x chips are single channel and
> > +		 * do not seem to have the channel enable bit...
> > +		 */
> > +		d->channels = 1;
> > +		d->enablebits[0].reg = 0;
> > +
> > +		d->udma_mask = HPT366_ALLOW_ATA66_3 ?
> > +			      (HPT366_ALLOW_ATA66_4 ? 0x1f : 0x0f) : 0x07;
> > +		break;
> > +	case 3:
> > +	case 4:
> > +		d->udma_mask = HPT370_ALLOW_ATA100_5 ? 0x3f : 0x1f;
> > +		break;
> > +	default:
> >  		rev = 6;
> > -		
> > +		/* fall thru */
> > +	case 5:
> > +	case 6:
> > +		d->udma_mask = HPT372_ALLOW_ATA133_6 ? 0x7f : 0x3f;
> > +		break;
> > +	}
> > +
> >  	d->name = chipset_names[rev];
> >  
> >  	pci_set_drvdata(dev, info[rev]);
> > @@ -1512,12 +1524,7 @@ static int __devinit init_setup_hpt366(s
> >  	if (rev > 2)
> >  		goto init_single;
> >  
> > -	/*
> > -	 * HPT36x chips are single channel and
> > -	 * do not seem to have the channel enable bit...
> > -	 */
> >  	d->channels = 1;
> 
>     Duh, don't know how this slipped in!
>     Bart, could you please this duplicate line?

done (duplicate line has been removed)
