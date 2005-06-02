From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: sata_sil problem / oops
Date: Thu, 02 Jun 2005 17:45:14 -0400
Message-ID: <429F7DEA.9050506@pobox.com>
References: <20050602100358.GA28855@suse.de> <200506021847.j52IlYi28562@epz01.nefonline.de> <20050602192327.GA13964@suse.de> <20050602193037.GB13964@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dvmed.net ([216.237.124.58]:47547 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S261407AbVFBVpU (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 2 Jun 2005 17:45:20 -0400
In-Reply-To: <20050602193037.GB13964@suse.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jens Axboe <axboe@suse.de>
Cc: Daniela Engert <dani@ngrt.de>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, meissner@suse.de

Jens Axboe wrote:
> Seems that is so, from looking at the driver. If I were to guess at a
> fix for this, it would be as follows.
> 
> diff --git a/drivers/scsi/sata_sil.c b/drivers/scsi/sata_sil.c
> --- a/drivers/scsi/sata_sil.c
> +++ b/drivers/scsi/sata_sil.c
> @@ -432,7 +432,13 @@ static int sil_init_one (struct pci_dev 
>  		writeb(cls, mmio_base + SIL_FIFO_R0);
>  		writeb(cls, mmio_base + SIL_FIFO_W0);
>  		writeb(cls, mmio_base + SIL_FIFO_R1);
> -		writeb(cls, mmio_base + SIL_FIFO_W2);
> +		writeb(cls, mmio_base + SIL_FIFO_W1);
> +		if (ent->driver_data == sil_3114) {
> +			writeb(cls, mmio_base + SIL_FIFO_R2);
> +			writeb(cls, mmio_base + SIL_FIFO_W2);
> +			writeb(cls, mmio_base + SIL_FIFO_R3);
> +			writeb(cls, mmio_base + SIL_FIFO_W3);
> +		}


This definitely looks like a needed fix to me.

Can someone confirm that this fixes the reported problem?

	Jeff


