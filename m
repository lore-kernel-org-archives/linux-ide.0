From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] pata_hpt37x: Updates from drivers/ide work
Date: Fri, 9 Mar 2007 16:53:24 +0000
Message-ID: <20070309165324.180cf6fc@lxorguk.ukuu.org.uk>
References: <20070308232852.37b0ed54@lxorguk.ukuu.org.uk>
	<45F1775E.5050703@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:54762 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S2993110AbXCIPte (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 9 Mar 2007 10:49:34 -0500
In-Reply-To: <45F1775E.5050703@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: akpm@osdl.org, linux-ide@vger.kernel.org, jgarzik@pobox.com

>     HPT370 chips aren't clockable to 66MHz -- they neither support Ultra133 
> nor are PCI66 capable.

Ok. Easily fixed thanks (Unfortunately HPT docs are one thing I don't
have just their various at times contradictory and weird drivers).


> >  	"HPT374",
> >  	48,
> >  	{
> > -		hpt374_timings_33,
> > +		hpt37x_timings_33,
> >  		NULL,
> >  		NULL,
> >  		NULL
> 
>     But HPT374 is DPLL-clockable to 50 MHz!
>     That effectivy means that we don't need the separate clock tables for each 
> chip anymore -- they should be all the same, with only 66 MHz capability 
> disabled for earlier chips (by other means)...

That should be fine as we cantry and use the DPLL in that case and will
go for a 50MHz or 66MHz DPLL timing not the timing array.

> 
> > @@ -463,8 +336,7 @@
> >  		ap->cbl = ATA_CBL_PATA80;
> 
>     Erm, no cable_detect() here?

Not yet. 

> >  	} else {
> >  		port->private_data = (void *)chip_table->clocks[clock_slot];
> >  		/*
> >  		 *	Perform a final fixup. The 371 and 372 clock determines
> > -		 *	if UDMA133 is available.
> > +		 *	if UDMA133 is available. (FIXME: should we use DPLL then ?)
> >  		 */
> >  
> >  		if (clock_slot == 2 && chip_table == &hpt372) {	/* 50Mhz */
> 
>     This else block won't be reachable with prefer_dpll == 1 anyway...

Good point

> 
> > @@ -1215,8 +1142,13 @@
> >  				port = &info_hpt372_50;
> >  			else BUG();
> >  		}
> > +		if (clock_slot < 2 && port == &info_hpt370)
> > +			port = &info_hpt370_33;
> > +		if (clock_slot < 2 && port == &info_hpt370a)
> > +			port = &info_hpt370a_33;
> 
>     I didn't get this change at all... Ultra/66 is perfectly reachable at 33 
> MHz PCI.

I'll investigate that further with your driver and the HPT "code".

Alan
