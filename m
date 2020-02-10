Return-Path: <SRS0=vLfT=36=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6A8FC352A3
	for <linux-ide@archiver.kernel.org>; Mon, 10 Feb 2020 16:07:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65F9A2080C
	for <linux-ide@archiver.kernel.org>; Mon, 10 Feb 2020 16:07:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="AHFTF4TS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727732AbgBJQH5 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 10 Feb 2020 11:07:57 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:59462 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727120AbgBJQH5 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 10 Feb 2020 11:07:57 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20200210160755euoutp029c59363e2d3357f507934d640ee6c1e9~yFj4R2a5K0622306223euoutp02C
        for <linux-ide@vger.kernel.org>; Mon, 10 Feb 2020 16:07:55 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20200210160755euoutp029c59363e2d3357f507934d640ee6c1e9~yFj4R2a5K0622306223euoutp02C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1581350875;
        bh=OBIHpa77OLnYEWKfX3X3TbTLzdv0vXLoi+QyubVzNM4=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=AHFTF4TSiKLm09IudSo3uj5/RlUMmcMS9+uqFgsTAzvntg1bt/HiQ9k/Nwsk5T/Bg
         hY8BWOguHA7HXXuGmahkJVwRVCpQOzKb8612AlepSrjmlMxpT+gEfHD1hboONVi0YW
         Ugea+v0w7niCtdqgeTYypdu6nT7oKcA0yhlq9X30=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200210160754eucas1p19e05f1f8180ee679f8e5e61685cd0ba0~yFj331mk32683826838eucas1p1X;
        Mon, 10 Feb 2020 16:07:54 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 3E.E3.61286.ADF714E5; Mon, 10
        Feb 2020 16:07:54 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200210160754eucas1p22adaa79df0f0719295de45d4869ab34b~yFj3hmV-31798817988eucas1p2J;
        Mon, 10 Feb 2020 16:07:54 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200210160754eusmtrp24cf8cef62e7b95fff4e0465d7b8e2e60~yFj3hCd3F1035210352eusmtrp2C;
        Mon, 10 Feb 2020 16:07:54 +0000 (GMT)
X-AuditID: cbfec7f2-ef1ff7000001ef66-42-5e417fdab4a9
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 10.A0.07950.ADF714E5; Mon, 10
        Feb 2020 16:07:54 +0000 (GMT)
Received: from [106.120.51.71] (unknown [106.120.51.71]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200210160753eusmtip2d94739459c11db6ea3a9e40e4a10fe71~yFj3LXqVX1567515675eusmtip2S;
        Mon, 10 Feb 2020 16:07:53 +0000 (GMT)
Subject: Re: [PATCH 38/46] sata_fsl: move DPRINTK to ata debugging
To:     Hannes Reinecke <hare@suse.de>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-ide@vger.kernel.org, Hannes Reinecke <hare@suse.com>
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Message-ID: <2e41aac2-ebd2-45a9-e0fb-cd2705add764@samsung.com>
Date:   Mon, 10 Feb 2020 17:07:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20200204165547.115220-39-hare@suse.de>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprCKsWRmVeSWpSXmKPExsWy7djPc7q36h3jDJ4sUrRYfbefzWLBm71s
        FnsWTWKyOLbjEZMDi8fls6Ue67dcZfHYfLra4/MmuQCWKC6blNSczLLUIn27BK6M5f1n2Qo6
        4ypm75jP2MA417uLkZNDQsBEYuu+n8xdjFwcQgIrGCU2TN/ODuF8YZSY+6QFyvnMKLFv4URG
        mJau2bNYIBLLGSWeHj7JCuG8ZZT4NXcGWJWwgJPE1WdH2UBsEQEHiae3GlhAbGYBO4mLV1vZ
        QWw2ASuJie2rgOo5OHiB4rN2poKEWQRUJXpuTQIrFxWIkPj04DAriM0rIChxcuYTsDgn0BH/
        vp9lhxgpLnHryXwmCFteYvvbOcwQh/azS2zv9oCwXSTWrexlg7CFJV4d38IOYctI/N8J0ssF
        ZK9jlPjb8YIZwtnOKLF88j+oDmuJO+d+sYEcyiygKbF+lz5E2FHi9IO/YPdLCPBJ3HgrCHED
        n8SkbdOZIcK8Eh1tQhDVahIblm1gg1nbtXMl8wRGpVlIPpuF5JtZSL6ZhbB3ASPLKkbx1NLi
        3PTUYsO81HK94sTc4tK8dL3k/NxNjMC0cvrf8U87GL9eSjrEKMDBqMTDWxHoGCfEmlhWXJl7
        iFGCg1lJhNdSGijEm5JYWZValB9fVJqTWnyIUZqDRUmc13jRy1ghgfTEktTs1NSC1CKYLBMH
        p1QD40xDq45/d9a0vHw5+7qzVVrS/e2t0us/+DYu5Pi1ZH6r/cqNnAF3tmU8Zp9zT1CiheV9
        tsi3yyu/3co48Ts5TuWo1SOhHq8nK14eVWLz1m9xUDrIvmbWz9jDDf+YrcsPlJ1cF3N85WXt
        Ls+LTQesjybvrFjh0R6zz3jqx7NbP1x5rlPFF2n6j1GJpTgj0VCLuag4EQD7BH8IJwMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrGIsWRmVeSWpSXmKPExsVy+t/xe7q36h3jDJ4f47RYfbefzWLBm71s
        FnsWTWKyOLbjEZMDi8fls6Ue67dcZfHYfLra4/MmuQCWKD2bovzSklSFjPziElulaEMLIz1D
        Sws9IxNLPUNj81grI1MlfTublNSczLLUIn27BL2M5f1n2Qo64ypm75jP2MA417uLkZNDQsBE
        omv2LJYuRi4OIYGljBK7Zl5l72LkAErISBxfXwZRIyzx51oXG0TNa0aJzskbGUESwgJOElef
        HWUDsUUEHCSe3mpgAbGZBewkLl5tZYdo2MAo8eBgK1iCTcBKYmL7KkaQBbxARbN2poKEWQRU
        JXpuTQIrERWIkDi8YxbYfF4BQYmTM5+AxTmBDv33/Sw7xHx1iT/zLjFD2OISt57MZ4Kw5SW2
        v53DPIFRaBaS9llIWmYhaZmFpGUBI8sqRpHU0uLc9NxiI73ixNzi0rx0veT83E2MwDjaduzn
        lh2MXe+CDzEKcDAq8fBeCHaME2JNLCuuzD3EKMHBrCTCaykNFOJNSaysSi3Kjy8qzUktPsRo
        CvTcRGYp0eR8YIznlcQbmhqaW1gamhubG5tZKInzdggcjBESSE8sSc1OTS1ILYLpY+LglGpg
        3HpI56P8t6Krzj+WmVn+uCw77Sz37x6r9isn2Rpu2vWlcOpma4XkJt5h9XL7H1Px8bxi3jTp
        UuOZT5YxMTk8DV8rsMXcQWdryNkJUiFHMzbNS+B8LKQY3vWCZ27pnjvHdT7siOl6GLpMpq/s
        ++2L3LufPJM+zlC5v3jZ1CibheY2Kvo+Hm8/KLEUZyQaajEXFScCAMgwIm+5AgAA
X-CMS-MailID: 20200210160754eucas1p22adaa79df0f0719295de45d4869ab34b
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200204165618eucas1p21ecabd73d9b80e138394af0ce6670826
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200204165618eucas1p21ecabd73d9b80e138394af0ce6670826
References: <20200204165547.115220-1-hare@suse.de>
        <CGME20200204165618eucas1p21ecabd73d9b80e138394af0ce6670826@eucas1p2.samsung.com>
        <20200204165547.115220-39-hare@suse.de>
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org


On 2/4/20 5:55 PM, Hannes Reinecke wrote:
> From: Hannes Reinecke <hare@suse.com>
> 
> Replace all DPRINTK calls with the standard logging functions.
> 
> Signed-off-by: Hannes Reinecke <hare@suse.de>
> ---
>  drivers/ata/sata_fsl.c | 84 ++++++++++++++++++++++++++------------------------
>  1 file changed, 43 insertions(+), 41 deletions(-)
> 
> diff --git a/drivers/ata/sata_fsl.c b/drivers/ata/sata_fsl.c
> index 5d48e1d223fa..57c8c4a1558d 100644
> --- a/drivers/ata/sata_fsl.c
> +++ b/drivers/ata/sata_fsl.c
> @@ -311,10 +311,12 @@ static void fsl_sata_set_irq_coalescing(struct ata_host *host,
>  	intr_coalescing_ticks = ticks;
>  	spin_unlock_irqrestore(&host->lock, flags);
>  
> -	DPRINTK("interrupt coalescing, count = 0x%x, ticks = %x\n",
> -			intr_coalescing_count, intr_coalescing_ticks);
> -	DPRINTK("ICC register status: (hcr base: 0x%x) = 0x%x\n",
> -			hcr_base, ioread32(hcr_base + ICC));
> +	dev_dbg(host->dev,
> +		"%s: interrupt coalescing, count = 0x%x, ticks = %x\n",
> +		__func__, intr_coalescing_count, intr_coalescing_ticks);
> +	dev_dbg(host->dev,
> +		"%s: ICC register status: (hcr base: 0x%x) = 0x%x\n",
> +		__func__, hcr_base, ioread32(hcr_base + ICC));
>  }
>  
>  static ssize_t fsl_sata_intr_coalescing_show(struct device *dev,
> @@ -385,18 +387,19 @@ static ssize_t fsl_sata_rx_watermark_store(struct device *dev,
>  	return strlen(buf);
>  }
>  
> -static inline unsigned int sata_fsl_tag(unsigned int tag,
> +static inline unsigned int sata_fsl_tag(struct ata_port *ap,
> +					unsigned int tag,
>  					void __iomem *hcr_base)
>  {
>  	/* We let libATA core do actual (queue) tag allocation */
>  
>  	if (unlikely(tag >= SATA_FSL_QUEUE_DEPTH)) {
> -		DPRINTK("tag %d invalid : out of range\n", tag);
> +		ata_port_dbg(ap, "tag %d invalid : out of range\n", tag);
>  		return 0;
>  	}
>  
>  	if (unlikely((ioread32(hcr_base + CQ)) & (1 << tag))) {
> -		DPRINTK("tag %d invalid : in use!!\n", tag);
> +		ata_port_dbg(ap, "tag %d invalid : in use!!\n", tag);
>  		return 0;
>  	}
>  
> @@ -508,7 +511,7 @@ static enum ata_completion_errors sata_fsl_qc_prep(struct ata_queued_cmd *qc)
>  	struct sata_fsl_port_priv *pp = ap->private_data;
>  	struct sata_fsl_host_priv *host_priv = ap->host->private_data;
>  	void __iomem *hcr_base = host_priv->hcr_base;
> -	unsigned int tag = sata_fsl_tag(qc->hw_tag, hcr_base);
> +	unsigned int tag = sata_fsl_tag(ap, qc->hw_tag, hcr_base);
>  	struct command_desc *cd;
>  	u32 desc_info = CMD_DESC_RES | CMD_DESC_SNOOP_ENABLE;
>  	u32 num_prde = 0;
> @@ -557,7 +560,7 @@ static unsigned int sata_fsl_qc_issue(struct ata_queued_cmd *qc)
>  	struct ata_port *ap = qc->ap;
>  	struct sata_fsl_host_priv *host_priv = ap->host->private_data;
>  	void __iomem *hcr_base = host_priv->hcr_base;
> -	unsigned int tag = sata_fsl_tag(qc->hw_tag, hcr_base);
> +	unsigned int tag = sata_fsl_tag(ap, qc->hw_tag, hcr_base);
>  
>  	VPRINTK("xx_qc_issue called,CQ=0x%x,CA=0x%x,CE=0x%x,CC=0x%x\n",
>  		ioread32(CQ + hcr_base),
> @@ -586,7 +589,7 @@ static bool sata_fsl_qc_fill_rtf(struct ata_queued_cmd *qc)
>  	struct sata_fsl_port_priv *pp = qc->ap->private_data;
>  	struct sata_fsl_host_priv *host_priv = qc->ap->host->private_data;
>  	void __iomem *hcr_base = host_priv->hcr_base;
> -	unsigned int tag = sata_fsl_tag(qc->hw_tag, hcr_base);
> +	unsigned int tag = sata_fsl_tag(qc->ap, qc->hw_tag, hcr_base);
>  	struct command_desc *cd;
>  
>  	cd = pp->cmdentry + tag;
> @@ -850,9 +853,10 @@ static int sata_fsl_hardreset(struct ata_link *link, unsigned int *class,
>  			goto try_offline_again;
>  	}
>  
> -	DPRINTK("hardreset, controller off-lined\n");
> -	VPRINTK("HStatus = 0x%x\n", ioread32(hcr_base + HSTATUS));
> -	VPRINTK("HControl = 0x%x\n", ioread32(hcr_base + HCONTROL));

The above two are not DPRINTKs, please update patch description
accordingly.

> +	ata_port_dbg(ap, "hardreset, controller off-lined\n"

letfover '\n'?

> +		     "HStatus = 0x%x HControl = 0x%x\n",
> +		     ioread32(hcr_base + HSTATUS),
> +		     ioread32(hcr_base + HCONTROL));
>  
>  	/*
>  	 * PHY reset should remain asserted for atleast 1ms
> @@ -880,9 +884,10 @@ static int sata_fsl_hardreset(struct ata_link *link, unsigned int *class,
>  		goto err;
>  	}
>  
> -	DPRINTK("hardreset, controller off-lined & on-lined\n");
> -	VPRINTK("HStatus = 0x%x\n", ioread32(hcr_base + HSTATUS));
> -	VPRINTK("HControl = 0x%x\n", ioread32(hcr_base + HCONTROL));

The above two are not DPRINTKs, please update patch description
accordingly.

> +	ata_port_dbg(ap, "controller off-lined & on-lined\n"

letfover '\n'?

> +		     "HStatus = 0x%x HControl = 0x%x\n",
> +		     ioread32(hcr_base + HSTATUS),
> +		     ioread32(hcr_base + HCONTROL));
>  
>  	/*
>  	 * First, wait for the PHYRDY change to occur before waiting for
> @@ -962,7 +967,7 @@ static int sata_fsl_softreset(struct ata_link *link, unsigned int *class,
>  	tf.ctl |= ATA_SRST;	/* setup SRST bit in taskfile control reg */
>  	ata_tf_to_fis(&tf, pmp, 0, cfis);
>  
> -	DPRINTK("Dumping cfis : 0x%x, 0x%x, 0x%x, 0x%x\n",
> +	ata_port_dbg(ap, "Dumping cfis : 0x%x, 0x%x, 0x%x, 0x%x\n",
>  		cfis[0], cfis[1], cfis[2], cfis[3]);
>  
>  	/*
> @@ -970,7 +975,7 @@ static int sata_fsl_softreset(struct ata_link *link, unsigned int *class,
>  	 * other commands are active on the controller/device
>  	 */
>  
> -	DPRINTK("@Softreset, CQ = 0x%x, CA = 0x%x, CC = 0x%x\n",
> +	ata_port_dbg(ap, "CQ = 0x%x, CA = 0x%x, CC = 0x%x\n",
>  		ioread32(CQ + hcr_base),
>  		ioread32(CA + hcr_base), ioread32(CC + hcr_base));
>  
> @@ -983,15 +988,16 @@ static int sata_fsl_softreset(struct ata_link *link, unsigned int *class,
>  	if (temp & 0x1) {
>  		ata_port_warn(ap, "ATA_SRST issue failed\n");
>  
> -		DPRINTK("Softreset@5000,CQ=0x%x,CA=0x%x,CC=0x%x\n",
> +		ata_port_dbg(ap, "Softreset@5000,CQ=0x%x,CA=0x%x,CC=0x%x\n",
>  			ioread32(CQ + hcr_base),
>  			ioread32(CA + hcr_base), ioread32(CC + hcr_base));
>  
>  		sata_fsl_scr_read(&ap->link, SCR_ERROR, &Serror);
>  
> -		DPRINTK("HStatus = 0x%x\n", ioread32(hcr_base + HSTATUS));
> -		DPRINTK("HControl = 0x%x\n", ioread32(hcr_base + HCONTROL));
> -		DPRINTK("Serror = 0x%x\n", Serror);
> +		ata_port_dbg(ap, "HStatus = 0x%x HControl = 0x%x Serror = 0x%x\n",
> +			     ioread32(hcr_base + HSTATUS),
> +			     ioread32(hcr_base + HCONTROL),
> +			     Serror);
>  		goto err;
>  	}
>  
> @@ -1049,7 +1055,7 @@ static int sata_fsl_softreset(struct ata_link *link, unsigned int *class,
>  static void sata_fsl_error_handler(struct ata_port *ap)
>  {
>  
> -	DPRINTK("in xx_error_handler\n");
> +	ata_port_dbg(ap, "ENTER\n");
>  	sata_pmp_error_handler(ap);
>  
>  }
> @@ -1092,7 +1098,7 @@ static void sata_fsl_error_intr(struct ata_port *ap)
>  	if (unlikely(SError & 0xFFFF0000))
>  		sata_fsl_scr_write(&ap->link, SCR_ERROR, SError);
>  
> -	DPRINTK("error_intr,hStat=0x%x,CE=0x%x,DE =0x%x,SErr=0x%x\n",
> +	ata_port_dbg(ap, "hStat=0x%x,CE=0x%x,DE =0x%x,SErr=0x%x\n",
>  		hstatus, cereg, ioread32(hcr_base + DE), SError);
>  
>  	/* handle fatal errors */
> @@ -1109,7 +1115,7 @@ static void sata_fsl_error_intr(struct ata_port *ap)
>  
>  	/* Handle PHYRDY change notification */
>  	if (hstatus & INT_ON_PHYRDY_CHG) {
> -		DPRINTK("SATA FSL: PHYRDY change indication\n");
> +		ata_port_dbg(ap, "PHYRDY change indication\n");
>  
>  		/* Setup a soft-reset EH action */
>  		ata_ehi_hotplugged(ehi);
> @@ -1130,7 +1136,7 @@ static void sata_fsl_error_intr(struct ata_port *ap)
>  		 */
>  		abort = 1;
>  
> -		DPRINTK("single device error, CE=0x%x, DE=0x%x\n",
> +		ata_port_dbg(ap, "single device error, CE=0x%x, DE=0x%x\n",
>  			ioread32(hcr_base + CE), ioread32(hcr_base + DE));
>  
>  		/* find out the offending link and qc */
> @@ -1235,12 +1241,12 @@ static void sata_fsl_host_intr(struct ata_port *ap)
>  	}
>  
>  	if (unlikely(SError & 0xFFFF0000)) {
> -		DPRINTK("serror @host_intr : 0x%x\n", SError);
> +		ata_port_dbg(ap, "serror @host_intr : 0x%x\n", SError);
>  		sata_fsl_error_intr(ap);
>  	}
>  
>  	if (unlikely(hstatus & status_mask)) {
> -		DPRINTK("error interrupt!!\n");
> +		ata_port_dbg(ap, "error interrupt!!\n");
>  		sata_fsl_error_intr(ap);
>  		return;
>  	}
> @@ -1258,15 +1264,13 @@ static void sata_fsl_host_intr(struct ata_port *ap)
>  		/* clear CC bit, this will also complete the interrupt */
>  		iowrite32(done_mask, hcr_base + CC);
>  
> -		DPRINTK("Status of all queues :\n");
> -		DPRINTK("done_mask/CC = 0x%x, CA = 0x%x, CE=0x%x\n",
> +		ata_port_dbg(ap, "Status of all queues: done_mask/CC = 0x%x, CA = 0x%x, CE=0x%x\n",
>  			done_mask, ioread32(hcr_base + CA),
>  			ioread32(hcr_base + CE));
>  
>  		for (i = 0; i < SATA_FSL_QUEUE_DEPTH; i++) {
>  			if (done_mask & (1 << i))
> -				DPRINTK
> -				    ("completing ncq cmd,tag=%d,CC=0x%x,CA=0x%x\n",
> +				ata_port_dbg(ap, "completing ncq cmd,tag=%d,CC=0x%x,CA=0x%x\n",
>  				     i, ioread32(hcr_base + CC),
>  				     ioread32(hcr_base + CA));
>  		}
> @@ -1277,7 +1281,7 @@ static void sata_fsl_host_intr(struct ata_port *ap)
>  		iowrite32(1, hcr_base + CC);
>  		qc = ata_qc_from_tag(ap, ATA_TAG_INTERNAL);
>  
> -		DPRINTK("completing non-ncq cmd, CC=0x%x\n",
> +		ata_port_dbg(ap, "completing non-ncq cmd, CC=0x%x\n",
>  			 ioread32(hcr_base + CC));
>  
>  		if (qc) {
> @@ -1285,7 +1289,7 @@ static void sata_fsl_host_intr(struct ata_port *ap)
>  		}
>  	} else {
>  		/* Spurious Interrupt!! */
> -		DPRINTK("spurious interrupt!!, CC = 0x%x\n",
> +		ata_port_dbg(ap, "spurious interrupt!!, CC = 0x%x\n",
>  			ioread32(hcr_base + CC));
>  		iowrite32(done_mask, hcr_base + CC);
>  		return;
> @@ -1305,7 +1309,7 @@ static irqreturn_t sata_fsl_interrupt(int irq, void *dev_instance)
>  	interrupt_enables = ioread32(hcr_base + HSTATUS);
>  	interrupt_enables &= 0x3F;
>  
> -	DPRINTK("interrupt status 0x%x\n", interrupt_enables);
> +	ata_port_dbg(ap, "interrupt status 0x%x\n", interrupt_enables);
>  
>  	if (!interrupt_enables)
>  		return IRQ_NONE;
> @@ -1359,7 +1363,7 @@ static int sata_fsl_init_controller(struct ata_host *host)
>  	iowrite32((temp & ~0x3F), hcr_base + HCONTROL);
>  
>  	/* Disable interrupt coalescing control(icc), for the moment */
> -	DPRINTK("icc = 0x%x\n", ioread32(hcr_base + ICC));
> +	ata_port_dbg(ap, "icc = 0x%x\n", ioread32(hcr_base + ICC));
>  	iowrite32(0x01000000, hcr_base + ICC);
>  
>  	/* clear error registers, SError is cleared by libATA  */
> @@ -1378,8 +1382,8 @@ static int sata_fsl_init_controller(struct ata_host *host)
>  	 * callback, that should also initiate the OOB, COMINIT sequence
>  	 */
>  
> -	DPRINTK("HStatus = 0x%x\n", ioread32(hcr_base + HSTATUS));
> -	DPRINTK("HControl = 0x%x\n", ioread32(hcr_base + HCONTROL));
> +	ata_port_dbg(ap, "HStatus = 0x%x HControl = 0x%x\n",
> +		     ioread32(hcr_base + HSTATUS), ioread32(hcr_base + HCONTROL));

checkpatch.pl script complains about this line:

WARNING: line over 80 characters
#329: FILE: drivers/ata/sata_fsl.c:1386:
+                    ioread32(hcr_base + HSTATUS), ioread32(hcr_base + HCONTROL));

>  
>  	return 0;
>  }
> @@ -1458,9 +1462,7 @@ static int sata_fsl_probe(struct platform_device *ofdev)
>  		iowrite32(temp | TRANSCFG_RX_WATER_MARK, csr_base + TRANSCFG);
>  	}
>  
> -	DPRINTK("@reset i/o = 0x%x\n", ioread32(csr_base + TRANSCFG));
> -	DPRINTK("sizeof(cmd_desc) = %d\n", sizeof(struct command_desc));
> -	DPRINTK("sizeof(#define cmd_desc) = %d\n", SATA_FSL_CMD_DESC_SIZE);

The above two DPRINTKs are deleted, please update patch description
accordingly.

> +	ata_port_dbg(ap, "@reset i/o = 0x%x\n", ioread32(csr_base + TRANSCFG));
>  
>  	host_priv = kzalloc(sizeof(struct sata_fsl_host_priv), GFP_KERNEL);
>  	if (!host_priv)
> 

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
