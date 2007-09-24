From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH] ide: remove ->ide_dma_check (take 2)
Date: Mon, 24 Sep 2007 22:33:06 +0200
Message-ID: <200709242233.06851.bzolnier@gmail.com>
References: <200709210118.28047.bzolnier@gmail.com> <46F7F156.4000201@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.185]:29604 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752568AbXIXUqC (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 24 Sep 2007 16:46:02 -0400
Received: by nf-out-0910.google.com with SMTP id g13so1485932nfb
        for <linux-ide@vger.kernel.org>; Mon, 24 Sep 2007 13:46:01 -0700 (PDT)
In-Reply-To: <46F7F156.4000201@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linux-ide@vger.kernel.org

On Monday 24 September 2007, Sergei Shtylyov wrote:
> Bartlomiej Zolnierkiewicz wrote:

[...]

> > @@ -783,6 +783,23 @@ int ide_tune_dma(ide_drive_t *drive)
> >  
> >  EXPORT_SYMBOL_GPL(ide_tune_dma);
> 
>     You're converting it to static and yet leaving exportable -- what for?

Oversight, export should be removed (already spotted/fixed by Adrian).

> > Index: b/drivers/ide/ide-probe.c
> > ===================================================================
> > --- a/drivers/ide/ide-probe.c
> > +++ b/drivers/ide/ide-probe.c
> > @@ -844,7 +844,7 @@ static void probe_hwif(ide_hwif_t *hwif,
> >  			 * Move here to prevent module loading clashing.
> >  			 */
> >  	//		drive->autodma = hwif->autodma;
> 
>     I hope this gets killed by the "autodma" patch?

Yep.

> > Index: b/drivers/ide/pci/hpt34x.c
> > ===================================================================
> > --- a/drivers/ide/pci/hpt34x.c
> > +++ b/drivers/ide/pci/hpt34x.c
> > @@ -80,16 +80,6 @@ static void hpt34x_set_pio_mode(ide_driv
> >  	hpt34x_set_mode(drive, XFER_PIO_0 + pio);
> >  }
> >  
> > -static int hpt34x_config_drive_xfer_rate (ide_drive_t *drive)
> > -{
> > -	if (ide_tune_dma(drive))
> > -		return -1;
> 
>     Hm, why -1 in this driver and 0 in all the others? Looks like a 
> functionality change?..

-1 is wrong (commit 76e1faa7cfd464fa06a9c2cafd633d643daafeae is to blame),
not a big issue since according to Alan this driver is broken ATM

I'll address this in "pre-patch".

Thanks,
Bart
