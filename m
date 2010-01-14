From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH #upstream-fixes 1/2] libata: cleanup ata_sff_interrupt()
Date: Thu, 14 Jan 2010 13:20:41 +0300
Message-ID: <4B4EEFF9.8060805@ru.mvista.com>
References: <4B4ECCCD.1040902@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([206.112.117.35]:52204 "HELO
	imap.sh.mvista.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with SMTP id S1755607Ab0ANKVI (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 14 Jan 2010 05:21:08 -0500
In-Reply-To: <4B4ECCCD.1040902@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Jeff Garzik <jeff@garzik.org>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Hans Werner <hwerner4@gmx.de>

Hello.

Tejun Heo wrote:

> host->ports[i] is never NULL if i < host->n_ports and non-NULL return
> from ata_qc_from_tag() guarantees that the returned qc is active.
> Drop unnecessary tests.
>
> Signed-off-by: Tejun Heo <tj@kernel.org>
> ---
>  drivers/ata/libata-sff.c |   17 +++++++----------
>  1 file changed, 7 insertions(+), 10 deletions(-)
>
> Index: ata/drivers/ata/libata-sff.c
> ===================================================================
> --- ata.orig/drivers/ata/libata-sff.c
> +++ ata/drivers/ata/libata-sff.c
> @@ -1767,18 +1767,15 @@ irqreturn_t ata_sff_interrupt(int irq, v
>  	spin_lock_irqsave(&host->lock, flags);
>  
>  	for (i = 0; i < host->n_ports; i++) {
> -		struct ata_port *ap;
> +		struct ata_port *ap = host->ports[i];
> +		struct ata_queued_cmd *qc;
>  
> -		ap = host->ports[i];
> -		if (ap &&
> -		    !(ap->flags & ATA_FLAG_DISABLED)) {
> -			struct ata_queued_cmd *qc;
> +		if (unlikely(ap->flags & ATA_FLAG_DISABLED))
> +			continue;
>  
> -			qc = ata_qc_from_tag(ap, ap->link.active_tag);
> -			if (qc && (!(qc->tf.flags & ATA_TFLAG_POLLING)) &&
> -			    (qc->flags & ATA_QCFLAG_ACTIVE))
> -				handled |= ata_sff_host_intr(ap, qc);
> -		}
> +		qc = ata_qc_from_tag(ap, ap->link.active_tag);
> +		if (qc && (!(qc->tf.flags & ATA_TFLAG_POLLING)))
>   

   () not needed around !x.

WBR, Sergei


