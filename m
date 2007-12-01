From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 2/8] libata: implement protocol tests
Date: Sat, 01 Dec 2007 18:06:26 -0500
Message-ID: <4751E8F2.60403@garzik.org>
References: <11961593392491-git-send-email-htejun@gmail.com> <11961593392138-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:47190 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751754AbXLAXG2 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 1 Dec 2007 18:06:28 -0500
In-Reply-To: <11961593392138-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org, bzolnier@gmail.com

Tejun Heo wrote:
> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
> index 5eb5983..8d5cd16 100644
> --- a/drivers/ata/libata-core.c
> +++ b/drivers/ata/libata-core.c
> @@ -5969,7 +5946,7 @@ void ata_qc_issue(struct ata_queued_cmd *qc)
>  	 */
>  	WARN_ON(ap->ops->error_handler && ata_tag_valid(link->active_tag));
>  
> -	if (qc->tf.protocol == ATA_PROT_NCQ) {
> +	if (prot == ATA_PROT_NCQ) {
>  		WARN_ON(link->sactive & (1 << qc->tag));
>  
>  		if (!link->sactive)

missed one?

