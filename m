From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH v2] IDE: palm_bk3710: use ioremap instead of arch-specific
 IO_ADDRESS()
Date: Fri, 30 Jan 2009 23:03:47 +0300
Message-ID: <49835D23.5040604@ru.mvista.com>
References: <1233345567-643-1-git-send-email-khilman@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:17613 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752731AbZA3UDT (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 30 Jan 2009 15:03:19 -0500
In-Reply-To: <1233345567-643-1-git-send-email-khilman@deeprootsystems.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: linux-ide@vger.kernel.org, davinci-linux-open-source@linux.davincidsp.com

Kevin Hilman wrote:

> Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>

Acked-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

> diff --git a/drivers/ide/palm_bk3710.c b/drivers/ide/palm_bk3710.c
> index f38aac7..6196f76 100644
> --- a/drivers/ide/palm_bk3710.c
> +++ b/drivers/ide/palm_bk3710.c
> @@ -347,7 +347,7 @@ static int __init palm_bk3710_probe(struct platform_device *pdev)
>  	struct clk *clk;
>  	struct resource *mem, *irq;
>  	void __iomem *base;
> -	unsigned long rate;
> +	unsigned long rate, mem_size;
>  	int i, rc;
>  	hw_regs_t hw, *hws[] = { &hw, NULL, NULL, NULL };
>  
> @@ -374,13 +374,19 @@ static int __init palm_bk3710_probe(struct platform_device *pdev)
>  		return -ENODEV;
>  	}
>  
> -	if (request_mem_region(mem->start, mem->end - mem->start + 1,
> +	mem_size = mem->end - mem->start + 1;
> +	if (request_mem_region(mem->start, mem_size,
>  			       "palm_bk3710") == NULL) {

    No point in keeping *if* occupying 2 lines, I think...

MBR, Sergei

