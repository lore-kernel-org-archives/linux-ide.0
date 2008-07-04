From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] sata_mv: safer logic for limit_warnings
Date: Fri, 04 Jul 2008 09:11:29 -0400
Message-ID: <486E2181.5070808@pobox.com>
References: <485933A4.3010409@rtr.ca> <4859340E.60203@rtr.ca> <4859BD16.4020600@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:46244 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755910AbYGDNLd (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 4 Jul 2008 09:11:33 -0400
In-Reply-To: <4859BD16.4020600@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>, Tejun Heo <htejun@gmail.com>

Mark Lord wrote:
> There is a miniscule chance that two separate host controllers
> might be in sata_mv at the same time and manage to decrement
> the static limit_warnings variable below zero.
> 
> Fix the comparison to deal with it.
> 
> Signed-off-by: Mark Lord <mlord@pobox.com>
> ---
> 
> (blush) How did I miss that ???
> 
> --- old/drivers/ata/sata_mv.c    2008-06-17 19:22:15.000000000 -0400
> +++ linux//drivers/ata/sata_mv.c    2008-06-18 21:52:19.000000000 -0400
> @@ -1607,7 +1607,7 @@
>          * Much of the time, this could just work regardless.
>          * So for now, just log the incident, and allow the attempt.
>          */
> -        if (limit_warnings && (qc->nbytes / qc->sect_size) > 1) {
> +        if (limit_warnings > 0 && (qc->nbytes / qc->sect_size) > 1) {
>             --limit_warnings;
>             ata_link_printk(qc->dev->link, KERN_WARNING, DRV_NAME

applied.  sorry, this got buried, should have gone in sooner.


