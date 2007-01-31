From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] libata: Fix (hopefully) all the remaining problems with
 devices failing setup/identify
Date: Wed, 31 Jan 2007 12:22:24 -0500
Message-ID: <45C0D050.4030302@garzik.org>
References: <20070131172605.2c5dfc78@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1030363AbXAaRWf@vger.kernel.org>
In-Reply-To: <20070131172605.2c5dfc78@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
To: Alan <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

Alan wrote:
> @@ -5142,6 +5174,20 @@
>  	status = ata_chk_status(ap);
>  	if (unlikely(status & ATA_BUSY))
>  		goto idle_irq;
> +		
> +	if (unlikely(qc->tf.command == ATA_CMD_SET_FEATURES && 
> +			qc->tf.feature == SETFEATURES_XFER)) {
> +		/* Let the timings change settle and the drive catch up as
> +		   some hardware needs up to 10uS to get its brain back in
> +		   gear. Taken from the workarounds in drivers/ide done by
> +		   Matthew Faupel/Niccolo Rigacci */
> +		for (i = 0; i < 10; i++) {
> +			if ((status & (ATA_BUSY | ATA_DRQ | ATA_ERR)) == 0)
> +				break;
> +			udelay(1);
> +			status = ata_chk_status(ap);
> +		}


Looks like you should use ata_busy_wait() here, rather than reproducing 
the same code again.

	Jeff
