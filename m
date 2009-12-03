From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 4/5] libata/sff: Use ops->bmdma_stop instead of ata_bmdma_stop()
Date: Thu, 03 Dec 2009 02:35:51 -0500
Message-ID: <4B176A57.5040605@garzik.org>
References: <20091202003629.4342710080C@ozlabs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yx0-f187.google.com ([209.85.210.187]:55473 "EHLO
	mail-yx0-f187.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751020AbZLCHfr (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 3 Dec 2009 02:35:47 -0500
Received: by yxe17 with SMTP id 17so926735yxe.33
        for <linux-ide@vger.kernel.org>; Wed, 02 Dec 2009 23:35:54 -0800 (PST)
In-Reply-To: <20091202003629.4342710080C@ozlabs.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linux-ide@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, tj@kernel.org

On 12/01/2009 07:36 PM, Benjamin Herrenschmidt wrote:
> In libata-sff, ata_sff_post_internal_cmd() directly calls ata_bmdma_stop()
> instead of ap->ops->bmdma_stop(). This can be a problem for controllers
> that use their own bmdma_stop for which the generic sff one isn't suitable
>
> Signed-off-by: Benjamin Herrenschmidt<benh@kernel.crashing.org>
> ---
>
>   drivers/ata/libata-sff.c |    2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> --- linux-work.orig/drivers/ata/libata-sff.c	2009-12-01 17:48:27.000000000 +1100
> +++ linux-work/drivers/ata/libata-sff.c	2009-12-01 17:48:48.000000000 +1100
> @@ -2384,7 +2384,7 @@ void ata_sff_post_internal_cmd(struct at
>   	ap->hsm_task_state = HSM_ST_IDLE;
>
>   	if (ap->ioaddr.bmdma_addr)
> -		ata_bmdma_stop(qc);
> +		ap->ops->bmdma_stop(qc);
>
>   	spin_unlock_irqrestore(ap->lock, flags);

applied

As we discussed, feel free to carry this in your tree as well.  git 
should be able to sort it out.

Acked-by: Jeff Garzik <jgarzik@redhat.com>


