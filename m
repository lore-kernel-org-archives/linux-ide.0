From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 19/19] ide: use PIO/MMIO operations directly where possible
Date: Thu, 21 Jun 2007 20:19:17 +0200
Message-ID: <200706212019.18001.bzolnier@gmail.com>
References: <20070112042621.28794.6937.sendpatchset@localhost.localdomain> <20070112042807.28794.8251.sendpatchset@localhost.localdomain> <467AB253.8010902@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.174]:15025 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755865AbXFUSDg (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 21 Jun 2007 14:03:36 -0400
Received: by ug-out-1314.google.com with SMTP id j3so631702ugf
        for <linux-ide@vger.kernel.org>; Thu, 21 Jun 2007 11:03:35 -0700 (PDT)
In-Reply-To: <467AB253.8010902@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org


Hi Sergei,

On Thursday 21 June 2007, Sergei Shtylyov wrote:
> Hello.
> 
> Bartlomiej Zolnierkiewicz wrote:
> > [PATCH] ide: use PIO/MMIO operations directly where possible
> 
> > This results in smaller/faster/simpler code and allows future optimizations.
> > Also remove no longer needed ide[_mm]_{inl,outl}() and ide_hwif_t.{INL,OUTL}.
> 
> > Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> 
> > Index: a/drivers/ide/pci/hpt366.c
> > ===================================================================
> > --- a.orig/drivers/ide/pci/hpt366.c
> > +++ a/drivers/ide/pci/hpt366.c
> > @@ -836,7 +836,7 @@ static int hpt374_ide_dma_test_irq(ide_d
> >  		return 0;
> >  	}
> >  
> > -	dma_stat = hwif->INB(hwif->dma_status);
> > +	dma_stat = inb(hwif->dma_status);
> >  	/* return 1 if INTR asserted */
> >  	if (dma_stat & 4)
> >  		return 1;
> 
>     Hmm... this driver *still* has a lot more indirect I/O accessors -- I 
> wonder why only this one had been converted then?

The reason for this is that my patch was done before some of your patches
for HPT IDE driver and I never really got to doing follow-up patch.

IIRC piix.c and and tc86c100.c may also want an update.

Thanks,
Bart
