Return-Path: <SRS0=S1Gt=3T=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42E2EC33C9E
	for <linux-ide@archiver.kernel.org>; Thu, 30 Jan 2020 11:22:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2934206D3
	for <linux-ide@archiver.kernel.org>; Thu, 30 Jan 2020 11:22:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="KeZi5EFs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727001AbgA3LWH (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 30 Jan 2020 06:22:07 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:34940 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726980AbgA3LWH (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 30 Jan 2020 06:22:07 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20200130112203euoutp0192664af5a91c6c943fb0b410625fb2c1~upkJan1ov2488524885euoutp01j
        for <linux-ide@vger.kernel.org>; Thu, 30 Jan 2020 11:22:03 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20200130112203euoutp0192664af5a91c6c943fb0b410625fb2c1~upkJan1ov2488524885euoutp01j
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1580383323;
        bh=8kjgophszmShAvSEvpGS7QkFWodqzpMJQMnLkv9nYw8=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=KeZi5EFsqoAT2t75kHfkzdCw6XrHKFTuj2+Gep6DFBp2uoEt5S4D/KGN3OvDiT3Mk
         6ORkZsGrbohNXqzQCnauo+PrB6hw6V1aVJZ2ptza9EQhfuZLWjL5eqwBQzTE1mVbCh
         kgzr7KV6kebU0r+O+BX2WTyRBDM38tVnjsCcBQjA=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200130112203eucas1p26cea84bf533185d085f73a22b290c807~upkJQjO2B3196331963eucas1p2I;
        Thu, 30 Jan 2020 11:22:03 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id C6.0E.61286.A5CB23E5; Thu, 30
        Jan 2020 11:22:02 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200130112202eucas1p140a1bb9b603b2747d8451a1ad1a4ef85~upkI_1xTg1913019130eucas1p1d;
        Thu, 30 Jan 2020 11:22:02 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200130112202eusmtrp18615780d4a07db1a0958d602309e61f3~upkI_RwL-0077500775eusmtrp1o;
        Thu, 30 Jan 2020 11:22:02 +0000 (GMT)
X-AuditID: cbfec7f2-f0bff7000001ef66-8c-5e32bc5a5ceb
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 69.A3.08375.A5CB23E5; Thu, 30
        Jan 2020 11:22:02 +0000 (GMT)
Received: from [106.120.51.71] (unknown [106.120.51.71]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200130112202eusmtip2258ca6f5a4c8862efa7e2ab20123acd3~upkIjewvi2716727167eusmtip2P;
        Thu, 30 Jan 2020 11:22:02 +0000 (GMT)
Subject: Re: [PATCH 15/24] pata_pdc2027x: Replace PDPRINTK() with dynamic
 debugging
To:     Hannes Reinecke <hare@suse.de>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-ide@vger.kernel.org,
        Hannes Reinecke <hare@suse.com>
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Message-ID: <de4dcceb-1759-8390-684d-ce9e258832a7@samsung.com>
Date:   Thu, 30 Jan 2020 12:22:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20181213104716.31930-27-hare@suse.de>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprKKsWRmVeSWpSXmKPExsWy7djP87pRe4ziDI6etLZYfbefzWLBm71s
        FnsWTWKyOLbjEZMDi8fls6Ue67dcZfHYfLra4/MmuQCWKC6blNSczLLUIn27BK6Mp9eb2Aum
        +lQcOfeduYHxt3UXIyeHhICJRN+7Z+xdjFwcQgIrGCWuX97BBOF8YZTomdbFAuF8ZpSYfOQU
        E0zL46VzoFqWM0pMf7oBquUto8SzC3cZQaqEBUIlPq6dzQJiiwgoSXxsP8QOYjMLxEk0XbkL
        ZrMJWElMbF8FVM/BwStgJ3H6VhZImEVAVeLm6vVgY0QFIiQ+PTjMCmLzCghKnJz5BGwkp4Cx
        xMtr3YwQI8Ulbj2ZzwRhy0tsfzuHGeQeCYF+dolrfV+hrnaR6Oo8wgxhC0u8Or6FHcKWkTg9
        uYcFomEdo8TfjhdQ3dsZJZZP/scGUWUtcefcLzaQS5kFNCXW79KHCDtKtH7ZwwwSlhDgk7jx
        VhDiCD6JSdumQ4V5JTrahCCq1SQ2LNvABrO2a+dK5gmMSrOQvDYLyTuzkLwzC2HvAkaWVYzi
        qaXFuempxYZ5qeV6xYm5xaV56XrJ+bmbGIGJ5fS/4592MH69lHSIUYCDUYmHV2ODUZwQa2JZ
        cWXuIUYJDmYlEV5RV8M4Id6UxMqq1KL8+KLSnNTiQ4zSHCxK4rzGi17GCgmkJ5akZqemFqQW
        wWSZODilGhiz5121/P7S09gt+dNvt2OJpupx3jtPcjtHNlve3Cgp4SD3WT3KfVK88LT6C9e1
        GD98YOx+dcy11EVz9XYLDbOj63mlIhuEJluJb/ZYxHf4UVZSz9ytL508VZy1mXWCgoVOVVpI
        aB048u7L6q6DBXUc7YZ2vLezCqyOLrqn6PxMXmNpVcpZJyWW4oxEQy3mouJEANwvIn4oAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrGIsWRmVeSWpSXmKPExsVy+t/xe7pRe4ziDJ5+V7NYfbefzWLBm71s
        FnsWTWKyOLbjEZMDi8fls6Ue67dcZfHYfLra4/MmuQCWKD2bovzSklSFjPziElulaEMLIz1D
        Sws9IxNLPUNj81grI1MlfTublNSczLLUIn27BL2Mp9eb2Aum+lQcOfeduYHxt3UXIyeHhICJ
        xOOlc9i7GLk4hASWMkocmT4LyOEASshIHF9fBlEjLPHnWhcbRM1rRomuE6tZQBLCAqESH9fO
        BrNFBJQkPrYfYgexmQXiJP717WaCaFjHKHH+zSmwBJuAlcTE9lWMIAt4BewkTt/KAgmzCKhK
        3Fy9nhHEFhWIkDi8YxaYzSsgKHFy5hOw+ZwCxhIvr3UzQsxXl/gz7xIzhC0ucevJfCYIW15i
        +9s5zBMYhWYhaZ+FpGUWkpZZSFoWMLKsYhRJLS3OTc8tNtQrTswtLs1L10vOz93ECIyjbcd+
        bt7BeGlj8CFGAQ5GJR5ejQ1GcUKsiWXFlbmHGCU4mJVEeEVdDeOEeFMSK6tSi/Lji0pzUosP
        MZoCPTeRWUo0OR8Y43kl8YamhuYWlobmxubGZhZK4rwdAgdjhATSE0tSs1NTC1KLYPqYODil
        GhjnhJt3F/OrFmfu/1t5UFRIzydBwFIo+XNcrmWarM+Cb87f01gtM7kvOS+6P9Wev0Lm3dtA
        K/6tXuvdT6Y4Mmt9PN/OlTJ1YaxJROFa4fknJx8MqXhZoOE2fWv+ypmrS9nLc5bOVsiurmGz
        y+K2+7H9paLPIQNGQ46NmyMiWiq+fvaoLG/xUmIpzkg01GIuKk4EANFmSsG5AgAA
X-CMS-MailID: 20200130112202eucas1p140a1bb9b603b2747d8451a1ad1a4ef85
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20181213104753epcas4p3d7c28762331751d9dc184213ece87774
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20181213104753epcas4p3d7c28762331751d9dc184213ece87774
References: <20181213104716.31930-1-hare@suse.de>
        <CGME20181213104753epcas4p3d7c28762331751d9dc184213ece87774@epcas4p3.samsung.com>
        <20181213104716.31930-27-hare@suse.de>
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org


On 12/13/18 11:47 AM, Hannes Reinecke wrote:
> Use dyndebug to allow the user to enable debugging during runtime.

This patch also converts ordinary printks() to dev_*() helpers and
removes some redundant debug messages. Please remember to also mention
all this in the patch description.

> Signed-off-by: Hannes Reinecke <hare@suse.com>
> ---
>  drivers/ata/pata_pdc2027x.c | 72 ++++++++++++++++++---------------------------
>  1 file changed, 29 insertions(+), 43 deletions(-)
> 
> diff --git a/drivers/ata/pata_pdc2027x.c b/drivers/ata/pata_pdc2027x.c
> index 1a18e675ba9f..8ba41c14e1ee 100644
> --- a/drivers/ata/pata_pdc2027x.c
> +++ b/drivers/ata/pata_pdc2027x.c
> @@ -36,13 +36,6 @@
>  
>  #define DRV_NAME	"pata_pdc2027x"
>  #define DRV_VERSION	"1.0"
> -#undef PDC_DEBUG
> -
> -#ifdef PDC_DEBUG
> -#define PDPRINTK(fmt, args...) printk(KERN_ERR "%s: " fmt, __func__, ## args)
> -#else
> -#define PDPRINTK(fmt, args...)
> -#endif
>  
>  enum {
>  	PDC_MMIO_BAR		= 5,
> @@ -220,11 +213,13 @@ static int pdc2027x_cable_detect(struct ata_port *ap)
>  	if (cgcr & (1 << 26))
>  		goto cbl40;
>  
> -	PDPRINTK("No cable or 80-conductor cable on port %d\n", ap->port_no);
> +	ata_port_dbg(ap, "No cable or 80-conductor cable on port %d\n",
> +		     ap->port_no);

Please preserve __func__ printing in the conversion.

Also please use dev_*() helper instead.

>  
>  	return ATA_CBL_PATA80;
>  cbl40:
> -	printk(KERN_INFO DRV_NAME ": 40-conductor cable detected on port %d\n", ap->port_no);
> +	ata_port_info(ap, "40-conductor cable detected on port %d\n",
> +		      ap->port_no);

please use dev_*() helper instead.

>  	return ATA_CBL_PATA40;
>  }
>  
> @@ -298,17 +293,17 @@ static void pdc2027x_set_piomode(struct ata_port *ap, struct ata_device *adev)
>  	unsigned int pio = adev->pio_mode - XFER_PIO_0;
>  	u32 ctcr0, ctcr1;
>  
> -	PDPRINTK("adev->pio_mode[%X]\n", adev->pio_mode);
> +	ata_port_dbg(ap, "adev->pio_mode[%X]\n", adev->pio_mode);

Please preserve __func__ printing in the conversion.

Also please use dev_*() helper instead.

>  
>  	/* Sanity check */
>  	if (pio > 4) {
> -		printk(KERN_ERR DRV_NAME ": Unknown pio mode [%d] ignored\n", pio);
> +		ata_port_err(ap, "Unknown pio mode [%d] ignored\n", pio);

Please use dev_*() helper instead.

>  		return;
>  
>  	}
>  
>  	/* Set the PIO timing registers using value table for 133MHz */
> -	PDPRINTK("Set pio regs... \n");
> +	ata_port_dbg(ap, "Set pio regs... \n");

Please preserve __func__ printing in the conversion.

Also please use dev_*() helper instead.

>  
>  	ctcr0 = ioread32(dev_mmio(ap, adev, PDC_CTCR0));
>  	ctcr0 &= 0xffff0000;
> @@ -321,9 +316,7 @@ static void pdc2027x_set_piomode(struct ata_port *ap, struct ata_device *adev)
>  	ctcr1 |= (pdc2027x_pio_timing_tbl[pio].value2 << 24);
>  	iowrite32(ctcr1, dev_mmio(ap, adev, PDC_CTCR1));
>  
> -	PDPRINTK("Set pio regs done\n");
> -
> -	PDPRINTK("Set to pio mode[%u] \n", pio);
> +	ata_port_dbg(ap, "Set to pio mode[%u] \n", pio);

ditto

>  }
>  
>  /**
> @@ -356,7 +349,7 @@ static void pdc2027x_set_dmamode(struct ata_port *ap, struct ata_device *adev)
>  			iowrite32(ctcr1 & ~(1 << 7), dev_mmio(ap, adev, PDC_CTCR1));
>  		}
>  
> -		PDPRINTK("Set udma regs... \n");
> +		ata_port_dbg(ap, "Set udma regs... \n");

ditto

>  
>  		ctcr1 = ioread32(dev_mmio(ap, adev, PDC_CTCR1));
>  		ctcr1 &= 0xff000000;
> @@ -365,16 +358,14 @@ static void pdc2027x_set_dmamode(struct ata_port *ap, struct ata_device *adev)
>  			(pdc2027x_udma_timing_tbl[udma_mode].value2 << 16);
>  		iowrite32(ctcr1, dev_mmio(ap, adev, PDC_CTCR1));
>  
> -		PDPRINTK("Set udma regs done\n");
> -
> -		PDPRINTK("Set to udma mode[%u] \n", udma_mode);
> +		ata_port_dbg(ap, "Set to udma mode[%u] \n", udma_mode);

ditto

>  
>  	} else  if ((dma_mode >= XFER_MW_DMA_0) &&
>  		   (dma_mode <= XFER_MW_DMA_2)) {
>  		/* Set the MDMA timing registers with value table for 133MHz */
>  		unsigned int mdma_mode = dma_mode & 0x07;
>  
> -		PDPRINTK("Set mdma regs... \n");
> +		ata_port_dbg(ap, "Set mdma regs... \n");

ditto

>  		ctcr0 = ioread32(dev_mmio(ap, adev, PDC_CTCR0));
>  
>  		ctcr0 &= 0x0000ffff;
> @@ -382,11 +373,10 @@ static void pdc2027x_set_dmamode(struct ata_port *ap, struct ata_device *adev)
>  			(pdc2027x_mdma_timing_tbl[mdma_mode].value1 << 24);
>  
>  		iowrite32(ctcr0, dev_mmio(ap, adev, PDC_CTCR0));
> -		PDPRINTK("Set mdma regs done\n");
>  
> -		PDPRINTK("Set to mdma mode[%u] \n", mdma_mode);
> +		ata_port_dbg(ap, "Set to mdma mode[%u] \n", mdma_mode);

ditto

>  	} else {
> -		printk(KERN_ERR DRV_NAME ": Unknown dma mode [%u] ignored\n", dma_mode);
> +		ata_port_err(ap, "Unknown dma mode [%u] ignored\n", dma_mode);
>  	}
>  }
>  
> @@ -420,7 +410,7 @@ static int pdc2027x_set_mode(struct ata_link *link, struct ata_device **r_failed
>  			ctcr1 |= (1 << 25);
>  			iowrite32(ctcr1, dev_mmio(ap, dev, PDC_CTCR1));
>  
> -			PDPRINTK("Turn on prefetch\n");
> +			ata_dev_dbg(dev, "Turn on prefetch\n");

ditto

>  		} else {
>  			pdc2027x_set_dmamode(ap, dev);
>  		}
> @@ -491,8 +481,8 @@ static long pdc_read_counter(struct ata_host *host)
>  
>  	counter = (bccrh << 15) | bccrl;
>  
> -	PDPRINTK("bccrh [%X] bccrl [%X]\n", bccrh,  bccrl);
> -	PDPRINTK("bccrhv[%X] bccrlv[%X]\n", bccrhv, bccrlv);
> +	dev_dbg(host->dev, "bccrh [%X] bccrl [%X]\n", bccrh,  bccrl);
> +	dev_dbg(host->dev, "bccrhv[%X] bccrlv[%X]\n", bccrhv, bccrlv);

ditto

>  	/*
>  	 * The 30-bit decreasing counter are read by 2 pieces.
> @@ -501,7 +491,7 @@ static long pdc_read_counter(struct ata_host *host)
>  	 */
>  	if (retry && !(bccrh == bccrhv && bccrl >= bccrlv)) {
>  		retry--;
> -		PDPRINTK("rereading counter\n");
> +		dev_dbg(host->dev, "rereading counter\n");

ditto

>  		goto retry;
>  	}
>  
> @@ -526,20 +516,18 @@ static void pdc_adjust_pll(struct ata_host *host, long pll_clock, unsigned int b
>  
>  	/* Sanity check */
>  	if (unlikely(pll_clock_khz < 5000L || pll_clock_khz > 70000L)) {
> -		printk(KERN_ERR DRV_NAME ": Invalid PLL input clock %ldkHz, give up!\n", pll_clock_khz);
> +		dev_err(host->dev, "Invalid PLL input clock %ldkHz, give up!\n", pll_clock_khz);
>  		return;
>  	}
>  
> -#ifdef PDC_DEBUG
> -	PDPRINTK("pout_required is %ld\n", pout_required);
> +	dev_dbg(host->dev, "pout_required is %ld\n", pout_required);

Please preserve __func__ printing in the conversion.


>  	/* Show the current clock value of PLL control register
>  	 * (maybe already configured by the firmware)
>  	 */
>  	pll_ctl = ioread16(mmio_base + PDC_PLL_CTL);
>  
> -	PDPRINTK("pll_ctl[%X]\n", pll_ctl);
> -#endif
> +	dev_dbg(host->dev, "pll_ctl[%X]\n", pll_ctl);

ditto
 
>  	/*
>  	 * Calculate the ratio of F, R and OD
> @@ -558,7 +546,7 @@ static void pdc_adjust_pll(struct ata_host *host, long pll_clock, unsigned int b
>  		R = 0x00;
>  	} else {
>  		/* Invalid ratio */
> -		printk(KERN_ERR DRV_NAME ": Invalid ratio %ld, give up!\n", ratio);
> +		dev_err(host->dev, "Invalid ratio %ld, give up!\n", ratio);
>  		return;
>  	}
>  
> @@ -566,15 +554,15 @@ static void pdc_adjust_pll(struct ata_host *host, long pll_clock, unsigned int b
>  
>  	if (unlikely(F < 0 || F > 127)) {
>  		/* Invalid F */
> -		printk(KERN_ERR DRV_NAME ": F[%d] invalid!\n", F);
> +		dev_err(host->dev, "F[%d] invalid!\n", F);
>  		return;
>  	}
>  
> -	PDPRINTK("F[%d] R[%d] ratio*1000[%ld]\n", F, R, ratio);
> +	dev_dbg(host->dev, "F[%d] R[%d] ratio*1000[%ld]\n", F, R, ratio);

ditto

>  	pll_ctl = (R << 8) | F;
>  
> -	PDPRINTK("Writing pll_ctl[%X]\n", pll_ctl);
> +	dev_dbg(host->dev, "Writing pll_ctl[%X]\n", pll_ctl);

ditto

>  	iowrite16(pll_ctl, mmio_base + PDC_PLL_CTL);
>  	ioread16(mmio_base + PDC_PLL_CTL); /* flush */
> @@ -582,15 +570,13 @@ static void pdc_adjust_pll(struct ata_host *host, long pll_clock, unsigned int b
>  	/* Wait the PLL circuit to be stable */
>  	msleep(30);
>  
> -#ifdef PDC_DEBUG
>  	/*
>  	 *  Show the current clock value of PLL control register
>  	 * (maybe configured by the firmware)
>  	 */
>  	pll_ctl = ioread16(mmio_base + PDC_PLL_CTL);
>  
> -	PDPRINTK("pll_ctl[%X]\n", pll_ctl);
> -#endif
> +	dev_dbg(host->dev, "pll_ctl[%X]\n", pll_ctl);

ditto
 
>  	return;
>  }
> @@ -611,7 +597,7 @@ static long pdc_detect_pll_input_clock(struct ata_host *host)
>  
>  	/* Start the test mode */
>  	scr = ioread32(mmio_base + PDC_SYS_CTL);
> -	PDPRINTK("scr[%X]\n", scr);
> +	dev_dbg(host->dev, "scr[%X]\n", scr);

ditto

>  	iowrite32(scr | (0x01 << 14), mmio_base + PDC_SYS_CTL);
>  	ioread32(mmio_base + PDC_SYS_CTL); /* flush */
>  
> @@ -628,7 +614,7 @@ static long pdc_detect_pll_input_clock(struct ata_host *host)
>  
>  	/* Stop the test mode */
>  	scr = ioread32(mmio_base + PDC_SYS_CTL);
> -	PDPRINTK("scr[%X]\n", scr);
> +	dev_dbg(host->dev, "scr[%X]\n", scr);

ditto

>  	iowrite32(scr & ~(0x01 << 14), mmio_base + PDC_SYS_CTL);
>  	ioread32(mmio_base + PDC_SYS_CTL); /* flush */
>  
> @@ -638,8 +624,8 @@ static long pdc_detect_pll_input_clock(struct ata_host *host)
>  	pll_clock = ((start_count - end_count) & 0x3fffffff) / 100 *
>  		(100000000 / usec_elapsed);
>  
> -	PDPRINTK("start[%ld] end[%ld] \n", start_count, end_count);
> -	PDPRINTK("PLL input clock[%ld]Hz\n", pll_clock);
> +	dev_dbg(host->dev, "start[%ld] end[%ld] \n", start_count, end_count);
> +	dev_dbg(host->dev, "PLL input clock[%ld]Hz\n", pll_clock);

ditto

>  	return pll_clock;
>  }

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
