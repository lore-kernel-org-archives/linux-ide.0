Return-Path: <SRS0=3I3m=4T=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EF72C3F2D1
	for <linux-ide@archiver.kernel.org>; Mon,  2 Mar 2020 18:22:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06DB9214DB
	for <linux-ide@archiver.kernel.org>; Mon,  2 Mar 2020 18:22:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="mnyzcgWS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727202AbgCBSWD (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 2 Mar 2020 13:22:03 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:53934 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726997AbgCBSWD (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 2 Mar 2020 13:22:03 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20200302182201euoutp0214bd78e246555a00971b11d5ab2e56fe~4j79-Mnwi0573405734euoutp02L
        for <linux-ide@vger.kernel.org>; Mon,  2 Mar 2020 18:22:01 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20200302182201euoutp0214bd78e246555a00971b11d5ab2e56fe~4j79-Mnwi0573405734euoutp02L
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1583173321;
        bh=ibEqbXcJzTrRyNs6yvQ+58n5UHeNNpH1OC9/d0YWqzw=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=mnyzcgWS11XHMIoHsmZ4ZVAtqtAxqpQxWvyDqwZb0RgLsLaw+g8t2/u8Ybxt7DKwa
         zN81oGeTSwmo8SBT2VA1xHhgPCAbgjIKtIF5vWxbn3q6EKZSe+RnOT4p691ScPiM8u
         9f6RGaDi/wGD2CSUH9HvjKXVb1H/mfRwrGPQrKqk=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200302182200eucas1p21ccc88a18225b99da935ab98dc1b8a02~4j79D0k2A1911819118eucas1p2H;
        Mon,  2 Mar 2020 18:22:00 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id F5.01.60698.8CE4D5E5; Mon,  2
        Mar 2020 18:22:00 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200302182159eucas1p1fb84ff0dd0e6eedd58670df403e9a04f~4j78TQfpL2269222692eucas1p1H;
        Mon,  2 Mar 2020 18:21:59 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200302182159eusmtrp14ae5cce49353bd242235681cbe9b048b~4j78St2jK0314803148eusmtrp1c;
        Mon,  2 Mar 2020 18:21:59 +0000 (GMT)
X-AuditID: cbfec7f5-a29ff7000001ed1a-53-5e5d4ec8aadf
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id C0.4C.07950.7CE4D5E5; Mon,  2
        Mar 2020 18:21:59 +0000 (GMT)
Received: from [106.120.51.71] (unknown [106.120.51.71]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200302182159eusmtip1e79aa71099aab28a46700e902dff722a~4j77zh9gV1780217802eusmtip19;
        Mon,  2 Mar 2020 18:21:59 +0000 (GMT)
Subject: Re: [PATCH 34/42] pata_pdc2027x: Replace PDPRINTK() with standard
 ata logging
To:     Hannes Reinecke <hare@suse.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
        linux-ide@vger.kernel.org
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Message-ID: <6ef72b96-e00b-1e9f-4e8e-7c96c4f10a2f@samsung.com>
Date:   Mon, 2 Mar 2020 19:21:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20200213095412.23773-35-hare@suse.de>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprCKsWRmVeSWpSXmKPExsWy7djPc7on/GLjDO6dVrJYfbefzWLPoklM
        Fsd2PGKy+LX8KKMDi8fls6Uem1Z1snlsPl3t8XmTXABLFJdNSmpOZllqkb5dAlfGspb3TAV3
        PSo2rZrE2sB42LKLkZNDQsBEYtuWQ+xdjFwcQgIrGCWmbVsO5XxhlPjRsJkRpEpI4DOjxN5/
        2TAdPzb9YYEoWs4osaFhPhuE85ZRYsX6J+wgVcICERLH+r6xgtgiAkoSH9sPgcWZgeIbN6xl
        ArHZBKwkJravAtvAK2An8fDBBjYQm0VARWLjtCXMILYoUP2nB4dZIWoEJU7OfMICYnMKGEv0
        nNnKBjFTXOLWk/lMELa8xPa3c5ghLu1nl+iakAZhu0i8/NjGAmELS7w6voUdwpaROD25B+wb
        CYF1jBJ/O14wQzjbGSWWT/7HBlFlLXHn3C8gmwNog6bE+l36EGFHib0f/oOFJQT4JG68FYS4
        gU9i0rbpzBBhXomONiGIajWJDcs2sMGs7dq5knkCo9IsJJ/NQvLNLCTfzELYu4CRZRWjeGpp
        cW56arFxXmq5XnFibnFpXrpecn7uJkZgWjn97/jXHYz7/iQdYhTgYFTi4Q1gjo0TYk0sK67M
        PcQowcGsJMLryxkdJ8SbklhZlVqUH19UmpNafIhRmoNFSZzXeNHLWCGB9MSS1OzU1ILUIpgs
        EwenVAOj601JJo6/Rq9+nZjO3Pfgp9OFfBXmoumRXQw28q+Yj3w5yth8o+Pb53XrU77FnI1N
        kljbqvpoVihH8o0a6ZgFel8e5Oq8eW9V+fKKllL3Lpn+KB2ZnIpjF2dP3fvSe7/hcr0Hy3La
        NuirfNooo9BxZe+hzm+mLNK3GjelLnCL2/b9u9yUU2cklFiKMxINtZiLihMBXM46TCcDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrOIsWRmVeSWpSXmKPExsVy+t/xu7rH/WLjDE61GVisvtvPZrFn0SQm
        i2M7HjFZ/Fp+lNGBxePy2VKPTas62Tw2n672+LxJLoAlSs+mKL+0JFUhI7+4xFYp2tDCSM/Q
        0kLPyMRSz9DYPNbKyFRJ384mJTUnsyy1SN8uQS9jWct7poK7HhWbVk1ibWA8bNnFyMkhIWAi
        8WPTH5YuRi4OIYGljBKHH01k6mLkAErISBxfXwZRIyzx51oXG0TNa0aJCfMmM4IkhAUiJO40
        zAezRQSUJD62H2IHsZmB4t2vzkA1rGOU+PX7FViCTcBKYmL7KrAGXgE7iYcPNrCB2CwCKhIb
        py1hBrFFgZoP75gFVSMocXLmExYQm1PAWKLnzFY2iAXqEn/mXWKGsMUlbj2ZzwRhy0tsfzuH
        eQKj0Cwk7bOQtMxC0jILScsCRpZVjCKppcW56bnFRnrFibnFpXnpesn5uZsYgZG07djPLTsY
        u94FH2IU4GBU4uH9wRAbJ8SaWFZcmXuIUYKDWUmE15czOk6INyWxsiq1KD++qDQntfgQoynQ
        cxOZpUST84FRnlcSb2hqaG5haWhubG5sZqEkztshcDBGSCA9sSQ1OzW1ILUIpo+Jg1OqgTEs
        +p+kgd0KwYXcoTY3Xx0xLE7QPrXBdH77vuhOdoHShPe+zX47r2ttir64vUiQ/b6BVoJk6VGW
        Ox7rXP/f372zL0FvT5E4v/G3bae0XioaJxS/UX338NGLL5fW2Wf4yZsmrF6a2y2/xuxGekqw
        cw2L3PbbF+6X8R5mP3D2+LSGVdvvlbLIfVJiKc5INNRiLipOBADqZOGtugIAAA==
X-CMS-MailID: 20200302182159eucas1p1fb84ff0dd0e6eedd58670df403e9a04f
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200213101347eucas1p125db1db47a43a818fb963b2ee0ea6daa
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200213101347eucas1p125db1db47a43a818fb963b2ee0ea6daa
References: <20200213095412.23773-1-hare@suse.de>
        <CGME20200213101347eucas1p125db1db47a43a818fb963b2ee0ea6daa@eucas1p1.samsung.com>
        <20200213095412.23773-35-hare@suse.de>
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org


On 2/13/20 10:54 AM, Hannes Reinecke wrote:
> Use standard ata logging macros instead of the hand-crafted
> PDPRINTK and remove duplicate logging messages.
> 
> Signed-off-by: Hannes Reinecke <hare@suse.de>

Reviewed-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

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
> index de834fbb6dfe..bf0ccc901179 100644
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
> +	ata_port_dbg(ap, "Set pio regs...\n");
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
> +	ata_port_dbg(ap, "Set to pio mode[%u]\n", pio);
>  }
>  
>  /**
> @@ -350,7 +343,7 @@ static void pdc2027x_set_dmamode(struct ata_port *ap, struct ata_device *adev)
>  			iowrite32(ctcr1 & ~(1 << 7), dev_mmio(ap, adev, PDC_CTCR1));
>  		}
>  
> -		PDPRINTK("Set udma regs... \n");
> +		ata_port_dbg(ap, "Set udma regs...\n");
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
> +		ata_port_dbg(ap, "Set to udma mode[%u]\n", udma_mode);
>  
>  	} else  if ((dma_mode >= XFER_MW_DMA_0) &&
>  		   (dma_mode <= XFER_MW_DMA_2)) {
>  		/* Set the MDMA timing registers with value table for 133MHz */
>  		unsigned int mdma_mode = dma_mode & 0x07;
>  
> -		PDPRINTK("Set mdma regs... \n");
> +		ata_port_dbg(ap, "Set mdma regs...\n");
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
> +		ata_port_dbg(ap, "Set to mdma mode[%u]\n", mdma_mode);
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
