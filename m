Return-Path: <SRS0=vLfT=36=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5045EC352A3
	for <linux-ide@archiver.kernel.org>; Mon, 10 Feb 2020 15:59:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7F2D20714
	for <linux-ide@archiver.kernel.org>; Mon, 10 Feb 2020 15:59:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="nCBTfODl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727652AbgBJP7k (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 10 Feb 2020 10:59:40 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:56581 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727143AbgBJP7k (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 10 Feb 2020 10:59:40 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20200210155937euoutp02dc3a70ac7e22400e92158b2205a72e75~yFco8QW7d3161831618euoutp02P
        for <linux-ide@vger.kernel.org>; Mon, 10 Feb 2020 15:59:37 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20200210155937euoutp02dc3a70ac7e22400e92158b2205a72e75~yFco8QW7d3161831618euoutp02P
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1581350377;
        bh=vBM0ewhgjSppZboJkSz9wlPb1hz8NF8BpFhTSSHDsBs=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=nCBTfODlbU5N9O9C+j/4T6slbhRZNjPAoDvfLbqZhryYrCbgzm+Kv7OX1X9HPvlck
         PAfNdI5lIru7e3t5/akylFu0XFpwfdPZPPjtQ2B79iKLi4WGrZWGVVsMUY3Oxm+U39
         RJ4891aw0ymUuDW0FOPbpuMIiu0LY5QXhoEllq0Y=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200210155937eucas1p24d298678d9230aece1a5afccf2b67ced~yFco15e_E2113821138eucas1p2W;
        Mon, 10 Feb 2020 15:59:37 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 20.96.60698.9ED714E5; Mon, 10
        Feb 2020 15:59:37 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200210155937eucas1p2f7409e473b1074ce593e4b398d05b874~yFcoisahy2116121161eucas1p2d;
        Mon, 10 Feb 2020 15:59:37 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200210155937eusmtrp1860a7b783de8c22f2fb6b66e127031d4~yFcoiKl3V3144431444eusmtrp1F;
        Mon, 10 Feb 2020 15:59:37 +0000 (GMT)
X-AuditID: cbfec7f5-a29ff7000001ed1a-66-5e417de9aefe
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 7E.93.08375.8ED714E5; Mon, 10
        Feb 2020 15:59:36 +0000 (GMT)
Received: from [106.120.51.71] (unknown [106.120.51.71]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200210155936eusmtip2092405e2a2ed8c1666a8f81c50beb526~yFcoE_tXP1259512595eusmtip2R;
        Mon, 10 Feb 2020 15:59:36 +0000 (GMT)
Subject: Re: [PATCH 37/46] pata_pdc2027x: Replace PDPRINTK() with standard
 ata logging
To:     Hannes Reinecke <hare@suse.de>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-ide@vger.kernel.org,
        Hannes Reinecke <hare@suse.com>
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Message-ID: <ad08f914-7fe7-a347-9373-d4a5d3b93db6@samsung.com>
Date:   Mon, 10 Feb 2020 16:59:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20200204165547.115220-38-hare@suse.de>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprCKsWRmVeSWpSXmKPExsWy7djP87ovax3jDO7sELZYfbefzWLBm71s
        FnsWTWKyOLbjEZMDi8fls6Ue67dcZfHYfLra4/MmuQCWKC6blNSczLLUIn27BK6M5xeOMhec
        Dqx4//grawPjbocuRg4OCQETiSNzMrsYuTiEBFYwSpxb8ZEFwvnCKHFg5mIo5zOjxLtV7Uww
        HUc3SEPElzNKXJ/awwbhvGWUmL13OWMXIyeHsECExMnZS1hAbBEBJYmP7YfYQWxmgTiJpit3
        wWw2ASuJie2rwOp5BewkVr2fD2azCKhKbLzZDFYjCjTn04PDrBA1ghInZz4Bm8kJdMSnlitM
        EDPFJW49mQ9ly0tsfzuHGeQgCYFudonXG++ADZIQcJFY/HsmI4QtLPHq+BaouIzE6ck9LBAN
        6xgl/na8gOreziixfPI/Nogqa4k7536xgfzPLKApsX6XPkTYUeL1idtskGDhk7jxVhDiCD6J
        SdumM0OEeSU62oQgqtUkNizbwAaztmvnSuYJjEqzkLw2C8k7s5C8Mwth7wJGllWM4qmlxbnp
        qcXGeanlesWJucWleel6yfm5mxiBaeX0v+NfdzDu+5N0iFGAg1GJh/dCsGOcEGtiWXFl7iFG
        CQ5mJRFeS2mgEG9KYmVValF+fFFpTmrxIUZpDhYlcV7jRS9jhQTSE0tSs1NTC1KLYLJMHJxS
        DYxeEyfevnxK59Sdw4qbvb+8/+Yu2Hfo52zz529yG07wT9oaqcW14Zs8Q0mhUW+TzdH5jlkT
        H17PcQjf1sI6QX/F7TM3997dvqXQRFxObVGWytb7Rq+4T7hmrbh82eHzYoXYvMqLqbZr4g7+
        41i6aPuSycvYIqeGX/criEh1OVE/Y+LS+TIOSVHiSizFGYmGWsxFxYkAXyUNlicDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrKIsWRmVeSWpSXmKPExsVy+t/xe7ovah3jDB7stLFYfbefzWLBm71s
        FnsWTWKyOLbjEZMDi8fls6Ue67dcZfHYfLra4/MmuQCWKD2bovzSklSFjPziElulaEMLIz1D
        Sws9IxNLPUNj81grI1MlfTublNSczLLUIn27BL2M5xeOMhecDqx4//grawPjbocuRg4OCQET
        iaMbpLsYOTmEBJYySkzcwwkRlpE4vr4MJCwhICzx51oXWxcjF1DJa0aJlX1z2UESwgIREose
        fGQFsUUElCQ+th8CizMLxEn869vNBNGwgVHiy58bYAk2ASuJie2rGEFsXgE7iVXv54PZLAKq
        EhtvNoPViAINPbxjFlSNoMTJmU9YQGxOoDs/tVxhgligLvFn3iVmCFtc4taT+VBxeYntb+cw
        T2AUmoWkfRaSlllIWmYhaVnAyLKKUSS1tDg3PbfYUK84Mbe4NC9dLzk/dxMjMIq2Hfu5eQfj
        pY3BhxgFOBiVeHgrAh3jhFgTy4orcw8xSnAwK4nwWkoDhXhTEiurUovy44tKc1KLDzGaAj03
        kVlKNDkfGOF5JfGGpobmFpaG5sbmxmYWSuK8HQIHY4QE0hNLUrNTUwtSi2D6mDg4pRoYY258
        1bM3dd/97MIiCY8fF9T/Wh7QiNrjkbg27kK+umJjn9D1yvzON0f7JE9eDBG++2tXr0fZmuCX
        IuUvj994faU3rlZLf6LJmxciJqtv73m/asGBzp9lu/9vPz55XfLMqwo1P/l+3Hr3Ye/pCfun
        +n73Lgr27vMSeRQfeUXmhJxBmLCn8Z1rvkosxRmJhlrMRcWJAKr3rCS4AgAA
X-CMS-MailID: 20200210155937eucas1p2f7409e473b1074ce593e4b398d05b874
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200204165618eucas1p25edd54b6fddcb8b9371af6c13695963a
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200204165618eucas1p25edd54b6fddcb8b9371af6c13695963a
References: <20200204165547.115220-1-hare@suse.de>
        <CGME20200204165618eucas1p25edd54b6fddcb8b9371af6c13695963a@eucas1p2.samsung.com>
        <20200204165547.115220-38-hare@suse.de>
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org


On 2/4/20 5:55 PM, Hannes Reinecke wrote:
> From: Hannes Reinecke <hare@suse.com>
> 
> Use standard ata logging macros instead of the hand-crafted
> PDPRINTK and remove duplicate logging messages.
> 
> Signed-off-by: Hannes Reinecke <hare@suse.de>

It looks much better now, thank you for reworking it.

Could you please also fix some minor issues found by
checkpatch.pl script while at it:

WARNING: unnecessary whitespace before a quoted newline
#132: FILE: drivers/ata/pata_pdc2027x.c:300:
+       ata_port_dbg(ap, "Set pio regs... \n");

WARNING: unnecessary whitespace before a quoted newline
#143: FILE: drivers/ata/pata_pdc2027x.c:313:
+       ata_port_dbg(ap, "Set to pio mode[%u] \n", pio);

WARNING: unnecessary whitespace before a quoted newline
#152: FILE: drivers/ata/pata_pdc2027x.c:346:
+               ata_port_dbg(ap, "Set udma regs... \n");

WARNING: unnecessary whitespace before a quoted newline
#163: FILE: drivers/ata/pata_pdc2027x.c:355:
+               ata_port_dbg(ap, "Set to udma mode[%u] \n", udma_mode);

WARNING: unnecessary whitespace before a quoted newline
#171: FILE: drivers/ata/pata_pdc2027x.c:362:
+               ata_port_dbg(ap, "Set mdma regs... \n");

WARNING: unnecessary whitespace before a quoted newline
#182: FILE: drivers/ata/pata_pdc2027x.c:371:
+               ata_port_dbg(ap, "Set to mdma mode[%u] \n", mdma_mode);

?

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

> ---
>  drivers/ata/pata_pdc2027x.c | 81 ++++++++++++++++++++-------------------------
>  1 file changed, 36 insertions(+), 45 deletions(-)
> 
> diff --git a/drivers/ata/pata_pdc2027x.c b/drivers/ata/pata_pdc2027x.c
> index de834fbb6dfe..2c397c135ccd 100644
> --- a/drivers/ata/pata_pdc2027x.c
> +++ b/drivers/ata/pata_pdc2027x.c
> @@ -30,13 +30,6 @@
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
> @@ -214,11 +207,13 @@ static int pdc2027x_cable_detect(struct ata_port *ap)
>  	if (cgcr & (1 << 26))
>  		goto cbl40;
>  
> -	PDPRINTK("No cable or 80-conductor cable on port %d\n", ap->port_no);
> +	ata_port_dbg(ap, "No cable or 80-conductor cable on port %d\n",
> +		     ap->port_no);
>  
>  	return ATA_CBL_PATA80;
>  cbl40:
> -	printk(KERN_INFO DRV_NAME ": 40-conductor cable detected on port %d\n", ap->port_no);
> +	ata_port_info(ap, "40-conductor cable detected on port %d\n",
> +		      ap->port_no);
>  	return ATA_CBL_PATA40;
>  }
>  
> @@ -292,17 +287,17 @@ static void pdc2027x_set_piomode(struct ata_port *ap, struct ata_device *adev)
>  	unsigned int pio = adev->pio_mode - XFER_PIO_0;
>  	u32 ctcr0, ctcr1;
>  
> -	PDPRINTK("adev->pio_mode[%X]\n", adev->pio_mode);
> +	ata_port_dbg(ap, "adev->pio_mode[%X]\n", adev->pio_mode);
>  
>  	/* Sanity check */
>  	if (pio > 4) {
> -		printk(KERN_ERR DRV_NAME ": Unknown pio mode [%d] ignored\n", pio);
> +		ata_port_err(ap, "Unknown pio mode [%d] ignored\n", pio);
>  		return;
>  
>  	}
>  
>  	/* Set the PIO timing registers using value table for 133MHz */
> -	PDPRINTK("Set pio regs... \n");
> +	ata_port_dbg(ap, "Set pio regs... \n");
>  
>  	ctcr0 = ioread32(dev_mmio(ap, adev, PDC_CTCR0));
>  	ctcr0 &= 0xffff0000;
> @@ -315,9 +310,7 @@ static void pdc2027x_set_piomode(struct ata_port *ap, struct ata_device *adev)
>  	ctcr1 |= (pdc2027x_pio_timing_tbl[pio].value2 << 24);
>  	iowrite32(ctcr1, dev_mmio(ap, adev, PDC_CTCR1));
>  
> -	PDPRINTK("Set pio regs done\n");
> -
> -	PDPRINTK("Set to pio mode[%u] \n", pio);
> +	ata_port_dbg(ap, "Set to pio mode[%u] \n", pio);
>  }
>  
>  /**
> @@ -350,7 +343,7 @@ static void pdc2027x_set_dmamode(struct ata_port *ap, struct ata_device *adev)
>  			iowrite32(ctcr1 & ~(1 << 7), dev_mmio(ap, adev, PDC_CTCR1));
>  		}
>  
> -		PDPRINTK("Set udma regs... \n");
> +		ata_port_dbg(ap, "Set udma regs... \n");
>  
>  		ctcr1 = ioread32(dev_mmio(ap, adev, PDC_CTCR1));
>  		ctcr1 &= 0xff000000;
> @@ -359,16 +352,14 @@ static void pdc2027x_set_dmamode(struct ata_port *ap, struct ata_device *adev)
>  			(pdc2027x_udma_timing_tbl[udma_mode].value2 << 16);
>  		iowrite32(ctcr1, dev_mmio(ap, adev, PDC_CTCR1));
>  
> -		PDPRINTK("Set udma regs done\n");
> -
> -		PDPRINTK("Set to udma mode[%u] \n", udma_mode);
> +		ata_port_dbg(ap, "Set to udma mode[%u] \n", udma_mode);
>  
>  	} else  if ((dma_mode >= XFER_MW_DMA_0) &&
>  		   (dma_mode <= XFER_MW_DMA_2)) {
>  		/* Set the MDMA timing registers with value table for 133MHz */
>  		unsigned int mdma_mode = dma_mode & 0x07;
>  
> -		PDPRINTK("Set mdma regs... \n");
> +		ata_port_dbg(ap, "Set mdma regs... \n");
>  		ctcr0 = ioread32(dev_mmio(ap, adev, PDC_CTCR0));
>  
>  		ctcr0 &= 0x0000ffff;
> @@ -376,11 +367,10 @@ static void pdc2027x_set_dmamode(struct ata_port *ap, struct ata_device *adev)
>  			(pdc2027x_mdma_timing_tbl[mdma_mode].value1 << 24);
>  
>  		iowrite32(ctcr0, dev_mmio(ap, adev, PDC_CTCR0));
> -		PDPRINTK("Set mdma regs done\n");
>  
> -		PDPRINTK("Set to mdma mode[%u] \n", mdma_mode);
> +		ata_port_dbg(ap, "Set to mdma mode[%u] \n", mdma_mode);
>  	} else {
> -		printk(KERN_ERR DRV_NAME ": Unknown dma mode [%u] ignored\n", dma_mode);
> +		ata_port_err(ap, "Unknown dma mode [%u] ignored\n", dma_mode);
>  	}
>  }
>  
> @@ -414,7 +404,7 @@ static int pdc2027x_set_mode(struct ata_link *link, struct ata_device **r_failed
>  			ctcr1 |= (1 << 25);
>  			iowrite32(ctcr1, dev_mmio(ap, dev, PDC_CTCR1));
>  
> -			PDPRINTK("Turn on prefetch\n");
> +			ata_dev_dbg(dev, "Turn on prefetch\n");
>  		} else {
>  			pdc2027x_set_dmamode(ap, dev);
>  		}
> @@ -485,8 +475,10 @@ static long pdc_read_counter(struct ata_host *host)
>  
>  	counter = (bccrh << 15) | bccrl;
>  
> -	PDPRINTK("bccrh [%X] bccrl [%X]\n", bccrh,  bccrl);
> -	PDPRINTK("bccrhv[%X] bccrlv[%X]\n", bccrhv, bccrlv);
> +	dev_dbg(host->dev, "%s: bccrh [%X] bccrl [%X]\n",
> +		__func__, bccrh,  bccrl);
> +	dev_dbg(host->dev, "%s: bccrhv[%X] bccrlv[%X]\n",
> +		__func__, bccrhv, bccrlv);
>  
>  	/*
>  	 * The 30-bit decreasing counter are read by 2 pieces.
> @@ -495,7 +487,7 @@ static long pdc_read_counter(struct ata_host *host)
>  	 */
>  	if (retry && !(bccrh == bccrhv && bccrl >= bccrlv)) {
>  		retry--;
> -		PDPRINTK("rereading counter\n");
> +		dev_dbg(host->dev, "%s: rereading counter\n", __func__);
>  		goto retry;
>  	}
>  
> @@ -520,20 +512,21 @@ static void pdc_adjust_pll(struct ata_host *host, long pll_clock, unsigned int b
>  
>  	/* Sanity check */
>  	if (unlikely(pll_clock_khz < 5000L || pll_clock_khz > 70000L)) {
> -		printk(KERN_ERR DRV_NAME ": Invalid PLL input clock %ldkHz, give up!\n", pll_clock_khz);
> +		dev_err(host->dev,
> +			"Invalid PLL input clock %ldkHz, give up!\n",
> +			pll_clock_khz);
>  		return;
>  	}
>  
> -#ifdef PDC_DEBUG
> -	PDPRINTK("pout_required is %ld\n", pout_required);
> +	dev_dbg(host->dev, "%s: pout_required is %ld\n",
> +		__func__, pout_required);
>  
>  	/* Show the current clock value of PLL control register
>  	 * (maybe already configured by the firmware)
>  	 */
>  	pll_ctl = ioread16(mmio_base + PDC_PLL_CTL);
>  
> -	PDPRINTK("pll_ctl[%X]\n", pll_ctl);
> -#endif
> +	dev_dbg(host->dev, "%s: pll_ctl[%X]\n", __func__, pll_ctl);
>  
>  	/*
>  	 * Calculate the ratio of F, R and OD
> @@ -552,7 +545,7 @@ static void pdc_adjust_pll(struct ata_host *host, long pll_clock, unsigned int b
>  		R = 0x00;
>  	} else {
>  		/* Invalid ratio */
> -		printk(KERN_ERR DRV_NAME ": Invalid ratio %ld, give up!\n", ratio);
> +		dev_err(host->dev, "Invalid ratio %ld, give up!\n", ratio);
>  		return;
>  	}
>  
> @@ -560,15 +553,16 @@ static void pdc_adjust_pll(struct ata_host *host, long pll_clock, unsigned int b
>  
>  	if (unlikely(F < 0 || F > 127)) {
>  		/* Invalid F */
> -		printk(KERN_ERR DRV_NAME ": F[%d] invalid!\n", F);
> +		dev_err(host->dev, "F[%d] invalid!\n", F);
>  		return;
>  	}
>  
> -	PDPRINTK("F[%d] R[%d] ratio*1000[%ld]\n", F, R, ratio);
> +	dev_dbg(host->dev, "%s: F[%d] R[%d] ratio*1000[%ld]\n",
> +		__func__, F, R, ratio);
>  
>  	pll_ctl = (R << 8) | F;
>  
> -	PDPRINTK("Writing pll_ctl[%X]\n", pll_ctl);
> +	dev_dbg(host->dev, "%s: Writing pll_ctl[%X]\n", __func__, pll_ctl);
>  
>  	iowrite16(pll_ctl, mmio_base + PDC_PLL_CTL);
>  	ioread16(mmio_base + PDC_PLL_CTL); /* flush */
> @@ -576,15 +570,12 @@ static void pdc_adjust_pll(struct ata_host *host, long pll_clock, unsigned int b
>  	/* Wait the PLL circuit to be stable */
>  	msleep(30);
>  
> -#ifdef PDC_DEBUG
>  	/*
>  	 *  Show the current clock value of PLL control register
>  	 * (maybe configured by the firmware)
>  	 */
> -	pll_ctl = ioread16(mmio_base + PDC_PLL_CTL);
> -
> -	PDPRINTK("pll_ctl[%X]\n", pll_ctl);
> -#endif
> +	dev_dbg(host->dev, "%s: pll_ctl[%X]\n", __func__,
> +		ioread16(mmio_base + PDC_PLL_CTL));
>  
>  	return;
>  }
> @@ -605,7 +596,7 @@ static long pdc_detect_pll_input_clock(struct ata_host *host)
>  
>  	/* Start the test mode */
>  	scr = ioread32(mmio_base + PDC_SYS_CTL);
> -	PDPRINTK("scr[%X]\n", scr);
> +	dev_dbg(host->dev, "%s: scr[%X]\n", __func__, scr);
>  	iowrite32(scr | (0x01 << 14), mmio_base + PDC_SYS_CTL);
>  	ioread32(mmio_base + PDC_SYS_CTL); /* flush */
>  
> @@ -622,7 +613,7 @@ static long pdc_detect_pll_input_clock(struct ata_host *host)
>  
>  	/* Stop the test mode */
>  	scr = ioread32(mmio_base + PDC_SYS_CTL);
> -	PDPRINTK("scr[%X]\n", scr);
> +	dev_dbg(host->dev, "%s: scr[%X]\n", __func__, scr);
>  	iowrite32(scr & ~(0x01 << 14), mmio_base + PDC_SYS_CTL);
>  	ioread32(mmio_base + PDC_SYS_CTL); /* flush */
>  
> @@ -632,8 +623,8 @@ static long pdc_detect_pll_input_clock(struct ata_host *host)
>  	pll_clock = ((start_count - end_count) & 0x3fffffff) / 100 *
>  		(100000000 / usec_elapsed);
>  
> -	PDPRINTK("start[%ld] end[%ld] \n", start_count, end_count);
> -	PDPRINTK("PLL input clock[%ld]Hz\n", pll_clock);
> +	dev_dbg(host->dev, "%s: start[%ld] end[%ld] PLL input clock[%ld]HZ\n",
> +		__func__, start_count, end_count, pll_clock);
>  
>  	return pll_clock;
>  }
> 

