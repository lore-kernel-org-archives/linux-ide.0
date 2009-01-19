From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 3/6] ide: small ide_register_port() cleanup
Date: Mon, 19 Jan 2009 12:43:13 +0100
Message-ID: <200901191243.13939.bzolnier@gmail.com>
References: <200811122216.06257.bzolnier@gmail.com> <jeocy58l15.fsf@sykes.suse.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mu-out-0910.google.com ([209.85.134.185]:48292 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759723AbZASM6T (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 19 Jan 2009 07:58:19 -0500
Received: by mu-out-0910.google.com with SMTP id g7so1386948muf.1
        for <linux-ide@vger.kernel.org>; Mon, 19 Jan 2009 04:58:17 -0800 (PST)
In-Reply-To: <jeocy58l15.fsf@sykes.suse.de>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andreas Schwab <schwab@suse.de>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>

On Sunday 18 January 2009, Andreas Schwab wrote:
> Bartlomiej Zolnierkiewicz <bzolnier@gmail.com> writes:
> 
> > Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> > ---
> >  drivers/ide/ide-probe.c |    9 ++-------
> >  1 file changed, 2 insertions(+), 7 deletions(-)
> >
> > Index: b/drivers/ide/ide-probe.c
> > ===================================================================
> > --- a/drivers/ide/ide-probe.c
> > +++ b/drivers/ide/ide-probe.c
> > @@ -640,14 +640,9 @@ static int ide_register_port(ide_hwif_t 
> >  	/* register with global device tree */
> >  	dev_set_name(&hwif->gendev, hwif->name);
> >  	hwif->gendev.driver_data = hwif;
> > -	if (hwif->gendev.parent == NULL) {
> > -		if (hwif->dev)
> > -			hwif->gendev.parent = hwif->dev;
> > -		else
> > -			/* Would like to do = &device_legacy */
> > -			hwif->gendev.parent = NULL;
> > -	}
> > +	hwif->gendev.parent = hwif->dev;
> 
> This breaks ide-pmac.  It overwrites the parent that
> pmac_ide_macio_attach has set.
> 
> Signed-off-by: Andreas Schwab <schwab@suse.de>
> 
> diff --git a/drivers/ide/ide-probe.c b/drivers/ide/ide-probe.c
> index 312127e..0db1ed9 100644
> --- a/drivers/ide/ide-probe.c
> +++ b/drivers/ide/ide-probe.c
> @@ -649,7 +649,8 @@ static int ide_register_port(ide_hwif_t *hwif)
>  	/* register with global device tree */
>  	dev_set_name(&hwif->gendev, hwif->name);
>  	hwif->gendev.driver_data = hwif;
> -	hwif->gendev.parent = hwif->dev;
> +	if (hwif->gendev.parent == NULL)
> +		hwif->gendev.parent = hwif->dev;
>  	hwif->gendev.release = hwif_release_dev;
>  
>  	ret = device_register(&hwif->gendev);

Applied, thanks for fixing it.

Since it is the second time this ->parent special case bited us in the *ss:

pmac_ide_macio_attach():
...
	hw.dev = &mdev->bus->pdev->dev;
	hw.parent = &mdev->ofdev.dev;
...

I again wonder what is the reason for having different struct device-s used
for DBDMA and for device tree on MACIO PMAC controllers.  Maybe there is no
real reason after all and we can use &mdev->ofdev.dev also for hwif->dev?

Thanks,
Bart
