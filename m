From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 01/14] sata_mv EH fixes
Date: Fri, 25 Jan 2008 23:09:41 -0500
Message-ID: <479AB285.2000707@pobox.com>
References: <4798FB68.70400@rtr.ca> <4798FBA1.20202@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:52248 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751992AbYAZEJo (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 25 Jan 2008 23:09:44 -0500
In-Reply-To: <4798FBA1.20202@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>

Mark Lord wrote:
> sata_mv EH fixes.
> 
> A hard reset is necessary after hotplug events.
> Only clear the error irq bits that were set on entry.
> 
> Signed-off-by: Mark Lord <mlord@pobox.com>
> 
> --- old/drivers/ata/sata_mv.c    2008-01-24 10:40:11.000000000 -0500
> +++ new/drivers/ata/sata_mv.c    2008-01-24 11:11:26.000000000 -0500
> @@ -1437,6 +1437,7 @@
>         ata_ehi_hotplugged(ehi);
>         ata_ehi_push_desc(ehi, edma_err_cause & EDMA_ERR_DEV_DCON ?
>             "dev disconnect" : "dev connect");
> +        action |= ATA_EH_HARDRESET;
>     }
> 
>     if (IS_GEN_I(hpriv)) {
> @@ -1465,7 +1466,7 @@
>     }
> 
>     /* Clear EDMA now that SERR cleanup done */
> -    writelfl(0, port_mmio + EDMA_ERR_IRQ_CAUSE_OFS);
> +    writelfl(~edma_err_cause, port_mmio + EDMA_ERR_IRQ_CAUSE_OFS);

ACK


