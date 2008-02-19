From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 4/5] ide-generic: use ide_find_port()
Date: Tue, 19 Feb 2008 22:20:08 +0100
Message-ID: <200802192220.08554.bzolnier@gmail.com>
References: <20080217185105.16210.26582.sendpatchset@localhost.localdomain> <20080217185133.16210.73293.sendpatchset@localhost.localdomain> <47BACC7C.6030305@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.186]:1634 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754864AbYBSWDz (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 19 Feb 2008 17:03:55 -0500
Received: by nf-out-0910.google.com with SMTP id g13so756836nfb.21
        for <linux-ide@vger.kernel.org>; Tue, 19 Feb 2008 14:03:53 -0800 (PST)
In-Reply-To: <47BACC7C.6030305@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Tuesday 19 February 2008, Sergei Shtylyov wrote:
> Bartlomiej Zolnierkiewicz wrote:
> 
> > There should be no functional changes caused by this patch.
> 
> > Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> 
> Acked-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>
> 
> > Index: b/drivers/ide/ide-generic.c
> > ===================================================================
> > --- a/drivers/ide/ide-generic.c
> > +++ b/drivers/ide/ide-generic.c
> > @@ -90,18 +90,27 @@ static int __init ide_generic_init(void)
> >  	int i;
> >  
> >  	for (i = 0; i < MAX_HWIFS; i++) {
> > -		ide_hwif_t *hwif = &ide_hwifs[i];
> > +		ide_hwif_t *hwif;
> >  		unsigned long io_addr = ide_default_io_base(i);
> >  		hw_regs_t hw;
> >  
> > -		if (hwif->chipset == ide_unknown && io_addr) {
> > -			u8 oldnoprobe = hwif->noprobe;
> > +		if (io_addr) {
> > +			u8 oldnoprobe;
> > +
> > +			/*
> > +			 * Skip probing if the corresponding
> > +			 * slot entry is already occupied.
> 
>     IMHO, it's either "slot" or "entry", else it sounds superfluous. :-)

I made 'take 2' with "entry" removed, thanks.
