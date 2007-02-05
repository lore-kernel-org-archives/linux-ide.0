From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] libata: Early CFA adapters are not required to support
 mode setting
Date: Mon, 5 Feb 2007 14:52:20 -0800
Message-ID: <20070205145220.4eb3269b.akpm@linux-foundation.org>
References: <20070205162830.5f9cff4a@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.24]:37247 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964830AbXBEWw2 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 5 Feb 2007 17:52:28 -0500
In-Reply-To: <20070205162830.5f9cff4a@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan <alan@lxorguk.ukuu.org.uk>
Cc: linux-ide@vger.kernel.org, jeff@garzik.org

On Mon, 5 Feb 2007 16:28:30 +0000
Alan <alan@lxorguk.ukuu.org.uk> wrote:

> If we are doing a PIO setup for a CFA card and it blows up with a device
> error then assume it is an older CFA card which doesn't support this
> rather than failing the device out of existance.
> 
> Stands seperate to the quieting patch but that is obviously useful with
> this change.
> 
> Signed-off-by: Alan Cox <alan@redhat.com>
> 
> diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.20-rc6-mm3/drivers/ata/libata-core.c linux-2.6.20-rc6-mm3/drivers/ata/libata-core.c
> --- linux.vanilla-2.6.20-rc6-mm3/drivers/ata/libata-core.c	2007-01-31 14:20:39.000000000 +0000
> +++ linux-2.6.20-rc6-mm3/drivers/ata/libata-core.c	2007-02-01 16:14:01.000000000 +0000
> @@ -2404,6 +2460,10 @@
>  		dev->flags |= ATA_DFLAG_PIO;
>  
>  	err_mask = ata_dev_set_xfermode(dev);
> +	/* Old CFA may refuse this command, which is just fine */
> +	if (dev->xfer_shift == ATA_SHIFT_PIO && ata_id_is_cfa(dev->id))
> +        	err_mask &= ~AC_ERR_DEV;
> +
>  	if (err_mask) {
>  		ata_dev_printk(dev, KERN_ERR, "failed to set xfermode "
>  			       "(err_mask=0x%x)\n", err_mask);

This hunk is already in
libata-fix-hopefully-all-the-remaining-problems-with.patch.  Should I drop
libata-fix-hopefully-all-the-remaining-problems-with.patch?

If its presence can affect the validity of testing these four patches then
perhaps yes..

