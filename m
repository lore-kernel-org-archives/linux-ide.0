From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] libata: Be a bit more slack about early devices
Date: Sat, 12 Apr 2008 00:35:30 -0400
Message-ID: <48003C12.40509@garzik.org>
References: <20080408163644.322f5a6d@core>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:40283 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752192AbYDLEfc (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 12 Apr 2008 00:35:32 -0400
In-Reply-To: <20080408163644.322f5a6d@core>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-ide@vger.kernel.org, akpm@osdl.org

Alan Cox wrote:
> We have a certain number of 'ATA' emulations often on CF or other flash
> devices that are at best "loosely based" on the CF 1.1 standard. These
> devices report themselves as disk but don't support the ATA minimal
> command set only the CF 1.1 set.
> 
> Relax the PIO checking for devices reporting ATA rev 0, or no iordy
> support, or CFA. Rework the code a bit as it was already messy and this
> made it quite ugly.
> 
> Signed-off-by: Alan Cox <alan@redhat.com>
> 
> diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.25-rc8-mm1/drivers/ata/libata-core.c linux-2.6.25-rc8-mm1/drivers/ata/libata-core.c
> --- linux.vanilla-2.6.25-rc8-mm1/drivers/ata/libata-core.c	2008-04-08 11:34:51.000000000 +0100
> +++ linux-2.6.25-rc8-mm1/drivers/ata/libata-core.c	2008-04-08 12:01:30.000000000 +0100
> @@ -3342,16 +3342,21 @@
>  	if (rc)
>  		return rc;
>  
> -	/* Old CFA may refuse this command, which is just fine */
> -	if (dev->xfer_shift == ATA_SHIFT_PIO && ata_id_is_cfa(dev->id))
> -		ign_dev_err = 1;
> -
> -	/* Some very old devices and some bad newer ones fail any kind of
> -	   SET_XFERMODE request but support PIO0-2 timings and no IORDY */
> -	if (dev->xfer_shift == ATA_SHIFT_PIO && !ata_id_has_iordy(dev->id) &&
> -			dev->pio_mode <= XFER_PIO_2)
> -		ign_dev_err = 1;
> -
> +	if (dev->xfer_shift == ATA_SHIFT_PIO) {
> +		/* Old CFA may refuse this command, which is just fine */
> +		if (ata_id_is_cfa(dev->id))
> +			ign_dev_err = 1;
> +		/* Catch several broken garbage emulations plus some pre
> +		   ATA devices */
> +		if (ata_id_major_version(dev->id) == 0 &&
> +					dev->pio_mode <= XFER_PIO_2)
> +			ign_dev_err = 1;
> +		/* Some very old devices and some bad newer ones fail
> +		   any kind of SET_XFERMODE request but support PIO0-2
> +		   timings and no IORDY */
> +		if (!ata_id_has_iordy(dev->id) && dev->pio_mode <= XFER_PIO_2)
> +			ign_dev_err = 1;
> +	}

applied


