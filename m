From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 16/16] libata-eh-fw: update ata_interrupt() to handle
 frozen port properly
Date: Wed, 12 Apr 2006 18:40:46 -0400
Message-ID: <443D81EE.7090800@pobox.com>
References: <1144762975582-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:32182 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932372AbWDLWkw (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 12 Apr 2006 18:40:52 -0400
In-Reply-To: <1144762975582-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: alan@lxorguk.ukuu.org.uk, axboe@suse.de, albertcc@tw.ibm.com, lkosewsk@gmail.com, linux-ide@vger.kernel.org

Tejun Heo wrote:
> Update the stock interrupt handler such that it unconditionally clears
> interrupts from a frozen port.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>
> 
> ---
> 
>  drivers/scsi/libata-core.c |   14 +++++++++++---
>  1 files changed, 11 insertions(+), 3 deletions(-)
> 
> 07f4b12b7a523dc928576fd5a2f18f40969a47ee
> diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
> index c7b7de9..d4c75cb 100644
> --- a/drivers/scsi/libata-core.c
> +++ b/drivers/scsi/libata-core.c
> @@ -4517,12 +4517,20 @@ irqreturn_t ata_interrupt (int irq, void
>  
>  	for (i = 0; i < host_set->n_ports; i++) {
>  		struct ata_port *ap;
> +		struct ata_queued_cmd *qc;
>  
>  		ap = host_set->ports[i];
> -		if (ap &&
> -		    !(ap->flags & (ATA_FLAG_DISABLED | ATA_FLAG_NOINTR))) {
> -			struct ata_queued_cmd *qc;
> +		if (unlikely(!ap || ap->flags & ATA_FLAG_DISABLED))
> +			continue;
>  
> +		if (unlikely(ap->flags & ATA_FLAG_FROZEN)) {
> +			/* port frozen, ack unconditionally */
> +			ata_irq_ack(ap, 0);
> +			handled = 1;
> +			continue;

NAK unless you can give me some reasonable justification for clearing 
the interrupts here.

Frozen or not, this is not really an appropriate place to put this.

	Jeff



