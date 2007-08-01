From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: ST340823A disk size issue
Date: Thu, 2 Aug 2007 00:19:25 +0200
Message-ID: <200708020019.25742.bzolnier@gmail.com>
References: <20070801092903.GA1199@nalle> <200708012234.03375.bzolnier@gmail.com> <20070801215003.GA1864@nalle>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.188]:52370 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751533AbXHAWVC (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 1 Aug 2007 18:21:02 -0400
Received: by nf-out-0910.google.com with SMTP id g13so88505nfb
        for <linux-ide@vger.kernel.org>; Wed, 01 Aug 2007 15:21:01 -0700 (PDT)
In-Reply-To: <20070801215003.GA1864@nalle>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mikko Rapeli <mikko.rapeli@iki.fi>
Cc: linux-ide@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>

On Wednesday 01 August 2007, Mikko Rapeli wrote:
> On Wed, Aug 01, 2007 at 10:34:03PM +0200, Bartlomiej Zolnierkiewicz wrote:
> > Could you try attached patch?
> > 
> > [PATCH] ide-disk: workaround for buggy HPA support on ST340823A
> 
> Umh, it's getting late but some makefile magic maybe missing, or I
> should do a clean build?

[...]

> ERROR: "ide_in_drive_list" [drivers/ide/ide-disk.ko] undefined!
> make[1]: *** [__modpost] Error 1
> make: *** [drivers/ide/ide-disk.ko] Error 2

There is "EXPORT_SYMBOL(ide_in_drive_list);" missing from ide-dma.c.

I overlooked it since here ide-disk is built-in, sorry for that.

> Based on Alan's comments I'm already running 2.6.22.1 with this:

Ah, I see it now.

> diff -ru linux-2.6.22.1/drivers/ide/ide-disk.c linux-2.6.22.1.new/drivers/ide/ide-disk.c
> --- linux-2.6.22.1/drivers/ide/ide-disk.c	2007-07-10 21:56:30.000000000 +0300
> +++ linux-2.6.22.1.new/drivers/ide/ide-disk.c	2007-08-01 22:59:47.000000000 +0300
> @@ -502,6 +502,17 @@
>  			 capacity, sectors_to_MB(capacity),
>  			 set_max, sectors_to_MB(set_max));
>  
> +	if ((set_max % 2) && (set_max == capacity + 1)) {
> +		printk(KERN_INFO "Old drive detected, keeping current capacity.\n");

Please either remove this printk() or change it to:

"Buggy HPA implementation, keeping current capacity."

The disk is not odd sized since the command to read the last sectors fail
with "SectorIdNotFound". This is a buggy HPA implementation as explained in
the description of my patch.

BTW libata wouldn't help since HPA code is almost a direct copy of the code
from ide-disk (I did the comparision before writing my patch)

> +		return;
> +	}
> +
>  	if (lba48)
>  		set_max = idedisk_set_max_address_ext(drive, set_max);
>  	else

Otherwise this patch looks fine and is a bit simpler than my patch.

If you fix the printk, add patch description (can use the one from my patch)
and add "Signed-off-by:" I would happily apply it and dump mine version.

Thanks,
Bart
