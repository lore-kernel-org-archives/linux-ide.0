From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH] Palmchip BK3710 IDE driver
Date: Thu, 15 May 2008 22:32:45 +0400
Message-ID: <482C81CD.10402@ru.mvista.com>
References: <200802051904.42668.asalnikov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.155]:4930 "EHLO
	imap.sh.mvista.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754305AbYEOSdR (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 15 May 2008 14:33:17 -0400
In-Reply-To: <200802051904.42668.asalnikov@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Anton Salnikov <asalnikov@ru.mvista.com>
Cc: linux-ide@vger.kernel.org, bzolnier@gmail.com

Anton Salnikov wrote:

> I've tested the driver on 2.6.24.

    Unfortunately, I've never seen the platofrm device registration code until 
now...

> Signed-off-by: Anton Salnikov <asalnikov@ru.mvista.com>

> Index: 2.6.25.ide/drivers/ide/arm/palm_bk3710.c
> ===================================================================
> --- /dev/null
> +++ 2.6.25.ide/drivers/ide/arm/palm_bk3710.c
> @@ -0,0 +1,420 @@
[...]
> +	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	if (mem == NULL) {
> +		printk(KERN_ERR "failed to get memory region resource\n");
> +		return -ENODEV;
> +	}
> +	irq = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
> +	if (irq == NULL) {
> +		printk(KERN_ERR "failed to get IRQ resource\n");
> +		return -ENODEV;
> +	}
> +
> +	base = (void *)mem->start;

   Crrap! You shouldn't specify virtual addresses in the device resources 
whatever arch you are using. Should've been ioremap() here. And where did only 
my eyes were?

MBR, Sergei
