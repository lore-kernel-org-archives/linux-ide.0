From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH REPOST] libata: lengthen interval between SRST set and
 clear
Date: Thu, 28 Sep 2006 05:53:20 -0400
Message-ID: <451B9B90.5020009@pobox.com>
References: <20060928091334.GM25800@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:5089 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751815AbWI1JxY (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 28 Sep 2006 05:53:24 -0400
In-Reply-To: <20060928091334.GM25800@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>, justin@jmicron.com
Cc: linux-ide@vger.kernel.org

Tejun Heo wrote:
> 20us delay is not enough for some controllers and they end up not
> sending the second H2D FIS to clear SRST resulting in softreset
> failure.  This problem has been spotted and diagnosed with SATA trace
> by JMicron on sata_nv.
> 
> This patch makes ata_bus_softreset() use msleep(1) instead of
> udelay(20) between SRST set and clear.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>
> Cc: Justin Tsai <justin@jmicron.com>
> 
> diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
> index 753b015..007020e 100644
> --- a/drivers/ata/libata-core.c
> +++ b/drivers/ata/libata-core.c
> @@ -2414,15 +2414,15 @@ static unsigned int ata_bus_softreset(st
>  	/* software reset.  causes dev0 to be selected */
>  	if (ap->flags & ATA_FLAG_MMIO) {
>  		writeb(ap->ctl, (void __iomem *) ioaddr->ctl_addr);
> -		udelay(20);	/* FIXME: flush */
> +		msleep(1);	/* FIXME: flush */
>  		writeb(ap->ctl | ATA_SRST, (void __iomem *) ioaddr->ctl_addr);
> -		udelay(20);	/* FIXME: flush */
> +		msleep(1);	/* FIXME: flush */
>  		writeb(ap->ctl, (void __iomem *) ioaddr->ctl_addr);
>  	} else {
>  		outb(ap->ctl, ioaddr->ctl_addr);
> -		udelay(10);
> +		msleep(1);
>  		outb(ap->ctl | ATA_SRST, ioaddr->ctl_addr);
> -		udelay(10);
> +		msleep(1);
>  		outb(ap->ctl, ioaddr->ctl_addr);

I'm gonna NAK this one.  The controller is operating out of spec 
(hardware bug) if this is necessary.

The effect of msleep(1) is really msleep(10) or msleep(100) depending on 
the length of a timer tick.  That's just far too long a length of time 
to be asserting SRST, especially for PATA.

I suppose you can create a jmicron_soft_reset() inside ahci.c...

	Jeff



