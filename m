From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 2/5] sata_mv clean up mv_stop_edma usage
Date: Wed, 02 Apr 2008 10:59:42 +0900
Message-ID: <47F2E88E.4000401@gmail.com>
References: <47F1736F.8020104@rtr.ca> <47F17510.7060902@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.237]:32584 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753059AbYDBB7t (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 1 Apr 2008 21:59:49 -0400
Received: by wr-out-0506.google.com with SMTP id c48so1612250wra.1
        for <linux-ide@vger.kernel.org>; Tue, 01 Apr 2008 18:59:48 -0700 (PDT)
In-Reply-To: <47F17510.7060902@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>, Jeff Garzik <jgarzik@pobox.com>

Hello, Mark.

Mark Lord wrote:
> -    /* now properly wait for the eDMA to stop */
> -    for (i = 1000; i > 0; i--) {
> -        reg = readl(port_mmio + EDMA_CMD_OFS);
> +    /* Wait for the chip to confirm eDMA is off. */
> +    for (i = 10000; i > 0; i--) {
> +        u32 reg = readl(port_mmio + EDMA_CMD_OFS);
>         if (!(reg & EDMA_EN))
> -            break;
> -
> -        udelay(100);
> -    }
> -
> -    if (reg & EDMA_EN) {
> -        ata_port_printk(ap, KERN_ERR, "Unable to stop eDMA\n");
> -        err = -EIO;
> +            return 0;
> +        udelay(10);

Unless the hardware calls for really short polling interval, I think 
it's generally better to limit polling with jiffies and using msleep() 
instead of delays.

Also, mv_stop_edma() skips actual operation if EDMA_EN isn't set, which 
I think is the correct way to do it in hot paths but I think it's better 
to stop the edma engine unconditionally prior to reset as that's where 
we try to bring the controller back into senses.

Thanks.

-- 
tejun
