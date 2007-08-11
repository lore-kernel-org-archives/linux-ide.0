From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH] pata_cmd64x: Set up MWDMA modes properly
Date: Sat, 11 Aug 2007 23:37:48 +0200
Message-ID: <200708112337.48458.bzolnier@gmail.com>
References: <20070808143320.0de8c5d9@the-village.bc.nu> <46BE1452.4010603@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fk-out-0910.google.com ([209.85.128.187]:18520 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760519AbXHKVil (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 11 Aug 2007 17:38:41 -0400
Received: by fk-out-0910.google.com with SMTP id z23so1036110fkz
        for <linux-ide@vger.kernel.org>; Sat, 11 Aug 2007 14:38:39 -0700 (PDT)
In-Reply-To: <46BE1452.4010603@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org, akpm@osdl.org, jeff@garzik.org

On Saturday 11 August 2007, Sergei Shtylyov wrote:
> Hello.
> 
> Alan Cox wrote:
> 
> > Set the MWDMA timing by updating the correct registers. Split the PIO
> > path as this is mostly shared code. Wants testing.
> 
>     Cool! So much simpler than my fix to the old IDE driver...
> 
> > Signed-off-by: Alan Cox <alan@redhat.com>
> 
> Acked-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>
> 
> > diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.23rc1-mm1/drivers/ata/pata_cmd64x.c linux-2.6.23rc1-mm1/drivers/ata/pata_cmd64x.c
> > --- linux.vanilla-2.6.23rc1-mm1/drivers/ata/pata_cmd64x.c	2007-07-26 15:01:52.000000000 +0100
> > +++ linux-2.6.23rc1-mm1/drivers/ata/pata_cmd64x.c	2007-08-08 11:52:23.000000000 +0100
> [...]
> > @@ -117,8 +118,9 @@
> >  	int arttim = arttim_port[ap->port_no][adev->devno];
> >  	int drwtim = drwtim_port[ap->port_no][adev->devno];
> >  
> > -
> > -	if (ata_timing_compute(adev, adev->pio_mode, &t, T, 0) < 0) {
> > +	/* ata_timing_compute is smart and will produce timings for MWDMA
> > +	   that don't violate the drives PIO capabilities. */
> > +	if (ata_timing_compute(adev, mode, &t, T, 0) < 0) {
> >  		printk(KERN_ERR DRV_NAME ": mode computation failed.\n");
> >  		return;
> >  	}
> 
>     That function rocks (except I didn't get what the address setup timings 
> mean to SW/MW DMA)...

JFYI: this function was "borrowed" from drivers/ide/ide-timing.h,
you can use it in IDE host drivers as well... ;)

Bart
