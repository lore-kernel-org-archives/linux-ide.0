From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [RFT PATCH] libata: implement ATA_FLAG_SETXFER_POLLING and use
 it in pata_via
Date: Thu, 28 Sep 2006 07:25:21 -0400
Message-ID: <451BB121.9020702@garzik.org>
References: <20060928111151.GN25800@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from [207.36.208.214] ([207.36.208.214]:13796 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1161084AbWI1LZ1 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 28 Sep 2006 07:25:27 -0400
In-Reply-To: <20060928111151.GN25800@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: castet.matthieu@free.fr, alan@lxorguk.ukuu.org.uk, linux-ide@vger.kernel.org, akpm@osdl.org

Tejun Heo wrote:
> This patch implements ATA_FLAG_SETXFER_POLLING and use in pata_via.
> If this flag is set, transfer mode setting performed by polling not by
> interrupt.  This should help those controllers which raise interrupt
> before the command is actually complete on SETXFER.
> 
> Rationale for this approach.
> 
> * uses existing facility and relatively simple
> * no busy sleep in the interrupt handler
> * updating drivers is easy
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>
> ---
> 
> Matthieu Castet, can you please test this patch?  It's against
> libata-dev#upstream, but -mm might work too.  If you want a patch
> against -mm, just let me know.
> 
> Jeff, Alan, what do you think about this approach?

If it works, I have no complaints...



> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
> index 753b015..c71d896 100644
> --- a/drivers/ata/libata-core.c
> +++ b/drivers/ata/libata-core.c
> @@ -4082,7 +4082,8 @@ int ata_hsm_move(struct ata_port *ap, st
>  
>  fsm_start:
>  	DPRINTK("ata%u: protocol %d task_state %d (dev_stat 0x%X)\n",
> -		ap->id, qc->tf.protocol, ap->hsm_task_state, status);
> +		ap->id, qc->tf.protocol, ap->hsm_task_state, status,
> +		qc->tf.flags & ATA_TFLAG_POLLING);

You need to update the format string too...

	Jeff


