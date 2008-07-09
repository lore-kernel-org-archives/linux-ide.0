From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH] palm_bk3710: fix IDECLK period calculation
Date: Wed, 09 Jul 2008 18:46:58 +0400
Message-ID: <4874CF62.6080103@ru.mvista.com>
References: <200807081829.06199.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:28658 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750955AbYGIOqz (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 9 Jul 2008 10:46:55 -0400
In-Reply-To: <200807081829.06199.sshtylyov@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: bzolnier@gmail.com, linux-ide@vger.kernel.org, mcherkashin@ru.mvista.com

Hello, I wrote:

> The driver uses completely bogus rounding formula for calculating period from
> the IDECLK frequency which gives one-off period values (e.g. 11 ns with 100 MHz
> IDECLK) which in turn can lead to overclocked IDE transfer timings.  Actually,
> rounding is just wrong in this case, so use a mere division for a safe result.

> While at it, also:

> - give 'ide_palm_clk' variable a more suitable name;

> - get rid of the useless 'ideclkp' variable;

> - drop the LISP stype 'p' postfix from the 'clkp' variable's name. :-)

> Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

> Index: linux-2.6/drivers/ide/arm/palm_bk3710.c
> ===================================================================
> --- linux-2.6.orig/drivers/ide/arm/palm_bk3710.c
> +++ linux-2.6/drivers/ide/arm/palm_bk3710.c
[...]
> @@ -350,22 +348,22 @@ static const struct ide_port_info __devi
>  
>  static int __devinit palm_bk3710_probe(struct platform_device *pdev)
>  {
> -	struct clk *clkp;
> +	struct clk *clk;
>  	struct resource *mem, *irq;
>  	ide_hwif_t *hwif;
> -	unsigned long base;
> +	unsigned long base, rate;
>  	int i;
>  	hw_regs_t hw;
>  	u8 idx[4] = { 0xff, 0xff, 0xff, 0xff };
>  
> -	clkp = clk_get(NULL, "IDECLK");
> -	if (IS_ERR(clkp))
> +	clk = clk_get(NULL, "IDECLK");
> +	if (IS_ERR(clk))
>  		return -ENODEV;

    Oh, crap! My original patch had NULL changed to &pdev->dev here but I 
mis-fixed the reject when importing it to the recent tree... Well, too late 
now, so till next time. :-)

MBR, Sergei

