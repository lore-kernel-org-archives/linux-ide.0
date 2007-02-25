From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] sata_sil: ignore and clear spurious IRQs while executing
 commands by polling
Date: Sat, 24 Feb 2007 20:52:39 -0500
Message-ID: <45E0EBE7.2030707@garzik.org>
References: <20070224133036.GB20322@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:58337 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933620AbXBYBwl (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 24 Feb 2007 20:52:41 -0500
In-Reply-To: <20070224133036.GB20322@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org, stable@kernel.org

Tejun Heo wrote:
> sata_sil used to trigger HSM error if IRQ occurs during polling
> command.  This didn't matter because polling wasn't used in sata_sil.
> However, as of 2.6.20, all IDENTIFYs are performed by polling and
> device detection sometimes fails due to spurious IRQ.  This patch
> makes sata_sil ignore and clear spurious IRQ while executing commands
> by polling.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>
> ---
> This fixes bug#7996 and IMHO should also be included in -stable.
> Thanks.
> 
> diff --git a/drivers/ata/sata_sil.c b/drivers/ata/sata_sil.c
> index 1487255..aaff357 100644
> --- a/drivers/ata/sata_sil.c
> +++ b/drivers/ata/sata_sil.c
> @@ -386,9 +386,15 @@ static void sil_host_intr(struct ata_port *ap, u32 bmdma2)
>  		goto freeze;
>  	}
>  
> -	if (unlikely(!qc || qc->tf.ctl & ATA_NIEN))
> +	if (unlikely(!qc))
>  		goto freeze;
>  
> +	if (unlikely(qc->tf.flags & ATA_TFLAG_POLLING)) {
> +		/* this sometimes happens, just clear IRQ */
> +		ata_chk_status(ap);
> +		return;

applied


