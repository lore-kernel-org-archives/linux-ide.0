From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] libata-sff: Reenable Port Multiplier after libata-sff
 remodeling.
Date: Tue, 31 Aug 2010 10:04:48 +0200
Message-ID: <4C7CB7A0.3000003@kernel.org>
References: <4C7A22CF.3090403@kernel.org> <1283188678-1696-1-git-send-email-gwendal@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:42407 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756916Ab0HaIFK (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 31 Aug 2010 04:05:10 -0400
In-Reply-To: <1283188678-1696-1-git-send-email-gwendal@google.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Gwendal Grignou <gwendal@google.com>
Cc: jeff@garzik.org, nicolas@jungers.net, linux-ide@vger.kernel.org

Hello,

On 08/30/2010 07:17 PM, Gwendal Grignou wrote:
> Keep track of the link on the which the current request is in progress.
> It allows support of links behind port multiplier.
> 
> Not all libata-sff is PMP compliant. Code for native BMDMA controller
> does not take in accound PMP.

Can you please elaborate a bit more on what broke and how this patch
fixes the problem?

> -void ata_sff_queue_pio_task(struct ata_port *ap, unsigned long delay)
> +void ata_sff_queue_pio_task(struct ata_link *link, unsigned long delay)
>  {
> +	struct ata_port *ap = link->ap;

New line here, please.

> +	ap->sff_pio_task_link = link;

It would also be useful to have WARN/BUG_ON() to make sure no two
links try to use pio_task at the same time.  ie. Set
ap->sff_pio_task_link here and clear it with NULL when done and make
sure it's NULL before setting it.

Otherwise, looks good to me.

Thanks!

-- 
tejun
