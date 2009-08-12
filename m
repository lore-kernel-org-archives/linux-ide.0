From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] Soften up the dmesg on SB600 PMP softreset failure recovery
Date: Wed, 12 Aug 2009 06:26:20 -0400
Message-ID: <4A8298CC.4040908@pobox.com>
References: <1249438241.3583.5.camel@zm-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:52549 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932496AbZHLK0V (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 12 Aug 2009 06:26:21 -0400
In-Reply-To: <1249438241.3583.5.camel@zm-desktop>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: shane.huang@amd.com
Cc: linux-ide@vger.kernel.org, tj@kernel.org, pgnet.dev@gmail.com

Shane Huang wrote:
> Too strong words led to spurious bug reports: Novell bugzilla #527748,
> RedHat bugzilla #468800. This patch is used to soften up the dmesg on
> SB600 PMP softreset failure recovery, so as to remove the scariness and
> concern from community.
> 
> Reported-by: pgnet Dev <pgnet.dev@gmail.com>
> Signed-off-by: Shane Huang <shane.huang@amd.com>
> Cc: Tejun Heo <tj@kernel.org>
> 
> diff -ruN a/drivers/ata/ahci.c b/drivers/ata/ahci.c
> --- a/drivers/ata/ahci.c	2009-07-29 14:38:39.000000000 +0800
> +++ b/drivers/ata/ahci.c	2009-08-04 17:24:34.000000000 +0800
> @@ -1769,7 +1769,8 @@
>  		irq_sts = readl(port_mmio + PORT_IRQ_STAT);
>  		if (irq_sts & PORT_IRQ_BAD_PMP) {
>  			ata_link_printk(link, KERN_WARNING,
> -					"failed due to HW bug, retry pmp=0\n");
> +					"applying SB600 PMP SRST workaround "
> +					"and retrying\n");
>  			rc = ahci_do_softreset(link, class, 0, deadline,
>  					       ahci_check_ready);

applied


