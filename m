From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH v3 1/5] ata: add Palmchip BK3710 PATA controller driver
Date: Thu, 23 Mar 2017 13:37:44 +0300
Message-ID: <103c435e-206c-aaaa-59ba-1eb2a4f77780@cogentembedded.com>
References: <1490206862-26065-1-git-send-email-b.zolnierkie@samsung.com>
 <CGME20170322182131epcas1p26b2402ec94ca08d2a6a332579a65e269@epcas1p2.samsung.com>
 <1490206862-26065-2-git-send-email-b.zolnierkie@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-lf0-f44.google.com ([209.85.215.44]:35219 "EHLO
        mail-lf0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752928AbdCWKhw (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 23 Mar 2017 06:37:52 -0400
Received: by mail-lf0-f44.google.com with SMTP id j90so79887929lfk.2
        for <linux-ide@vger.kernel.org>; Thu, 23 Mar 2017 03:37:51 -0700 (PDT)
In-Reply-To: <1490206862-26065-2-git-send-email-b.zolnierkie@samsung.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Tejun Heo <tj@kernel.org>
Cc: Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@baylibre.com>, Arnd Bergmann <arnd@arndb.de>, Russell King <linux@arm.linux.org.uk>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, linux-ide@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org

Hello!

On 3/22/2017 9:20 PM, Bartlomiej Zolnierkiewicz wrote:

> Add Palmchip BK3710 PATA controller driver.
>
> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
[...]
> diff --git a/drivers/ata/pata_bk3710.c b/drivers/ata/pata_bk3710.c
> new file mode 100644
> index 0000000..1a1223f
> --- /dev/null
> +++ b/drivers/ata/pata_bk3710.c
> @@ -0,0 +1,382 @@
[...]
> +static int __init pata_bk3710_probe(struct platform_device *pdev)
> +{
> +	struct clk *clk;
> +	struct resource *mem;
> +	struct ata_host *host;
> +	struct ata_port *ap;
> +	void __iomem *base;
> +	unsigned long rate;
> +	int irq;
> +
> +	clk = devm_clk_get(&pdev->dev, NULL);
> +	if (IS_ERR(clk))
> +		return -ENODEV;
> +
> +	clk_enable(clk);
> +	rate = clk_get_rate(clk);
> +	if (!rate)
> +		return -EINVAL;
> +
> +	/* NOTE:  round *down* to meet minimum timings; we count in clocks */
> +	ideclk_period = 1000000000UL / rate;
> +
> +	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);

    I'd put this close to devm_iorempe_resource() and would probably even get 
rid of 'mem' altogether...

[...]

Acked-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

MBR, Sergei

