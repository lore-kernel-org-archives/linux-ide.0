From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 11/11] ide: remove ->ide_dma_check
Date: Mon, 6 Aug 2007 20:14:43 +0200
Message-ID: <200708062014.43106.bzolnier@gmail.com>
References: <200708042213.15674.bzolnier@gmail.com> <46B7390E.5070408@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.184]:27621 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757479AbXHGK4k (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 7 Aug 2007 06:56:40 -0400
Received: by nf-out-0910.google.com with SMTP id g13so438127nfb
        for <linux-ide@vger.kernel.org>; Tue, 07 Aug 2007 03:56:38 -0700 (PDT)
In-Reply-To: <46B7390E.5070408@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linux-ide@vger.kernel.org

On Monday 06 August 2007, Sergei Shtylyov wrote:
> Bartlomiej Zolnierkiewicz wrote:

> > Index: b/drivers/ide/arm/icside.c
> > ===================================================================
> > --- a/drivers/ide/arm/icside.c
> > +++ b/drivers/ide/arm/icside.c
> > @@ -309,14 +309,6 @@ static int icside_dma_on(ide_drive_t *dr
> >  	return 0;
> >  }
> >  
> > -static int icside_dma_check(ide_drive_t *drive)
> > -{
> > -	if (ide_tune_dma(drive))
> > -		return 0;
> > -
> > -	return -1;
> > -}
> > -
> >  static int icside_dma_end(ide_drive_t *drive)
> >  {
> >  	ide_hwif_t *hwif = HWIF(drive);
> 
>     Hm, looks like there's going to be some functionality change for this 
> driver -- it didn't fallback to PIO before this patch... ;-)

It won't because this driver lacks ->set_pio_mode method... :-)

Bart
