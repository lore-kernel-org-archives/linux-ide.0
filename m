Return-Path: <SRS0=3I3m=4T=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AABFFC3F2CD
	for <linux-ide@archiver.kernel.org>; Mon,  2 Mar 2020 18:26:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F31020842
	for <linux-ide@archiver.kernel.org>; Mon,  2 Mar 2020 18:26:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="pXRBiHNu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727309AbgCBS0s (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 2 Mar 2020 13:26:48 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:54588 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727126AbgCBS0r (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 2 Mar 2020 13:26:47 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20200302182646euoutp0243b190abb6672631e43b85ba10d3c0cb~4kAG5_nRf1030310303euoutp02b
        for <linux-ide@vger.kernel.org>; Mon,  2 Mar 2020 18:26:46 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20200302182646euoutp0243b190abb6672631e43b85ba10d3c0cb~4kAG5_nRf1030310303euoutp02b
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1583173606;
        bh=Rojl5eKYK9DCZ1bZPdyTyGHZ+FK3inSX4evR4cEMtX4=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=pXRBiHNutNpqvK4VRQFMK21Fmv3H81pfI3QxUnvHLvpY/gB9Y+k6FlbDkxY0IdX1Y
         3dCHpgHYynKTkyyFN+sdqjWG9D6dvWZZdcvn512hQKalBVMCERaLWlxRxqizs+BYQO
         X2VeGwnWcVXLB0bIeEx2+pK7JqD+ZKiz5p4I/sM0=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200302182645eucas1p25c9adacfff598ad62c8144f09f8bf4ec~4kAGswdau2908729087eucas1p2o;
        Mon,  2 Mar 2020 18:26:45 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 5E.21.60698.5EF4D5E5; Mon,  2
        Mar 2020 18:26:45 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200302182645eucas1p2a990c4a088d2893e29cec0058279829b~4kAGXhUxw1912619126eucas1p2G;
        Mon,  2 Mar 2020 18:26:45 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200302182645eusmtrp10b7a0eb206da2cc9f1f191d4240ff324~4kAGW_M5u0772907729eusmtrp1Y;
        Mon,  2 Mar 2020 18:26:45 +0000 (GMT)
X-AuditID: cbfec7f5-a0fff7000001ed1a-de-5e5d4fe5f82a
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 9F.CC.08375.5EF4D5E5; Mon,  2
        Mar 2020 18:26:45 +0000 (GMT)
Received: from [106.120.51.71] (unknown [106.120.51.71]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200302182645eusmtip2f150df53edaa8741b73eb4121f0501d7~4kAF91UKm0786207862eusmtip23;
        Mon,  2 Mar 2020 18:26:45 +0000 (GMT)
Subject: Re: [PATCH 36/42] sata_fsl: move DPRINTK to ata debugging
To:     Hannes Reinecke <hare@suse.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
        linux-ide@vger.kernel.org
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Message-ID: <22d2f47b-1cd0-e3ac-2b9a-4459c3a99e83@samsung.com>
Date:   Mon, 2 Mar 2020 19:26:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20200213095412.23773-37-hare@suse.de>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprGKsWRmVeSWpSXmKPExsWy7djPc7pP/WPjDM7d1LNYfbefzWLPoklM
        Fsd2PGKy+LX8KKMDi8fls6Uem1Z1snlsPl3t8XmTXABLFJdNSmpOZllqkb5dAlfGzisP2Ao+
        RFe87LjO1sC42rOLkZNDQsBE4m7nZdYuRi4OIYEVjBK/139ngnC+MEp86v7OCOF8ZpRYtP0d
        K0zL7ZZmqKrljBInTm2EqnrLKLF6fQ8LSJWwgJPE6oNv2EFsEQEliY/th8BsZoEIiY0b1jKB
        2GwCVhIT21cxgti8AnYSU9/1gMVZBFQkLqx8xgZiiwLVf3pwmBWiRlDi5MwnYPM5BYwlvrx+
        zwwxU1zi1pP5TBC2vMT2t3OYQQ6SEOhnl5g2o58J4mwXiclvfjBD2MISr45vYYewZSROTwY5
        GqRhHaPE344XUN3bGSWWT/7HBlFlLXHn3C8gmwNohabE+l36EGFHiTUfWphBwhICfBI33gpC
        HMEnMWnbdKgwr0RHmxBEtZrEhmUb2GDWdu1cyTyBUWkWktdmIXlnFpJ3ZiHsXcDIsopRPLW0
        ODc9tdg4L7Vcrzgxt7g0L10vOT93EyMwtZz+d/zrDsZ9f5IOMQpwMCrx8AYwx8YJsSaWFVfm
        HmKU4GBWEuH15YyOE+JNSaysSi3Kjy8qzUktPsQozcGiJM5rvOhlrJBAemJJanZqakFqEUyW
        iYNTqoGx9cyHnUYp2+ZKOOe7n98+tV5CVzvsU6nUo1CruoPTGLz2P4kzjnTrOO9a8iui5f1v
        hb92RgFJNi+3TuIqyU4rUlh8+5Wh/8VeixIxg91zrLg4N3quXblSf4mNp9u0R3PXM/DXGbV7
        yC9omFEa4zNJr5Xjx0Lu7XITp71OOsdeHFW97aGyygslluKMREMt5qLiRACoZufKKQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrOIsWRmVeSWpSXmKPExsVy+t/xe7pP/WPjDFbtlLJYfbefzWLPoklM
        Fsd2PGKy+LX8KKMDi8fls6Uem1Z1snlsPl3t8XmTXABLlJ5NUX5pSapCRn5xia1StKGFkZ6h
        pYWekYmlnqGxeayVkamSvp1NSmpOZllqkb5dgl7GzisP2Ao+RFe87LjO1sC42rOLkZNDQsBE
        4nZLM1MXIxeHkMBSRonp7y8CORxACRmJ4+vLIGqEJf5c62KDqHnNKHF69g1mkISwgJPE6oNv
        2EFsEQEliY/th8BsZoEIie5XZ6Aa1jFK9G2cwgqSYBOwkpjYvooRxOYVsJOY+q6HCcRmEVCR
        uLDyGRuILQrUfHjHLKgaQYmTM5+wgNicAsYSX16/Z4ZYoC7xZ94lKFtc4taT+UwQtrzE9rdz
        mCcwCs1C0j4LScssJC2zkLQsYGRZxSiSWlqcm55bbKhXnJhbXJqXrpecn7uJERhJ24793LyD
        8dLG4EOMAhyMSjy8AcyxcUKsiWXFlbmHGCU4mJVEeH05o+OEeFMSK6tSi/Lji0pzUosPMZoC
        PTeRWUo0OR8Y5Xkl8YamhuYWlobmxubGZhZK4rwdAgdjhATSE0tSs1NTC1KLYPqYODilGhg7
        K3mWraw6PO9Hp1HThwki+TJ1bOYfpZqPu3+u96lnb7+ktvSJrvelpXtzX+y/ey+my9ypPfr2
        X7n18z2XXVOyePNAf9+Ot6Wtzvs9OnjKblxjKbmZvaP72ef1/n+Ve67t3Hf6qdiaszbXW/ZX
        Kvw+/3FVKF/aLZ5ej0g2i7cnr8+68P+91j53JZbijERDLeai4kQAcm9IV7oCAAA=
X-CMS-MailID: 20200302182645eucas1p2a990c4a088d2893e29cec0058279829b
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200213095440eucas1p118b8b5a5dce9fcac9dc88b886218e188
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200213095440eucas1p118b8b5a5dce9fcac9dc88b886218e188
References: <20200213095412.23773-1-hare@suse.de>
        <CGME20200213095440eucas1p118b8b5a5dce9fcac9dc88b886218e188@eucas1p1.samsung.com>
        <20200213095412.23773-37-hare@suse.de>
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org


On 2/13/20 10:54 AM, Hannes Reinecke wrote:
> Replace all DPRINTK calls with the standard logging functions.
> 
> Signed-off-by: Hannes Reinecke <hare@suse.de>
> ---
>  drivers/ata/sata_fsl.c | 90 ++++++++++++++++++++++++++------------------------
>  1 file changed, 46 insertions(+), 44 deletions(-)
> 
> diff --git a/drivers/ata/sata_fsl.c b/drivers/ata/sata_fsl.c
> index 5d48e1d223fa..51627da79ffc 100644
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
> @@ -850,7 +853,7 @@ static int sata_fsl_hardreset(struct ata_link *link, unsigned int *class,
>  			goto try_offline_again;
>  	}
>  
> -	DPRINTK("hardreset, controller off-lined\n");
> +	ata_port_dbg(ap, "hardreset, controller off-lined\n");
>  	VPRINTK("HStatus = 0x%x\n", ioread32(hcr_base + HSTATUS));
>  	VPRINTK("HControl = 0x%x\n", ioread32(hcr_base + HCONTROL));
>  
> @@ -880,7 +883,7 @@ static int sata_fsl_hardreset(struct ata_link *link, unsigned int *class,
>  		goto err;
>  	}
>  
> -	DPRINTK("hardreset, controller off-lined & on-lined\n");
> +	ata_port_dbg(ap, "controller off-lined & on-lined\n");
>  	VPRINTK("HStatus = 0x%x\n", ioread32(hcr_base + HSTATUS));
>  	VPRINTK("HControl = 0x%x\n", ioread32(hcr_base + HCONTROL));
>  
> @@ -962,7 +965,7 @@ static int sata_fsl_softreset(struct ata_link *link, unsigned int *class,
>  	tf.ctl |= ATA_SRST;	/* setup SRST bit in taskfile control reg */
>  	ata_tf_to_fis(&tf, pmp, 0, cfis);
>  
> -	DPRINTK("Dumping cfis : 0x%x, 0x%x, 0x%x, 0x%x\n",
> +	ata_port_dbg(ap, "Dumping cfis : 0x%x, 0x%x, 0x%x, 0x%x\n",
>  		cfis[0], cfis[1], cfis[2], cfis[3]);
>  
>  	/*
> @@ -970,7 +973,7 @@ static int sata_fsl_softreset(struct ata_link *link, unsigned int *class,
>  	 * other commands are active on the controller/device
>  	 */
>  
> -	DPRINTK("@Softreset, CQ = 0x%x, CA = 0x%x, CC = 0x%x\n",
> +	ata_port_dbg(ap, "CQ = 0x%x, CA = 0x%x, CC = 0x%x\n",
>  		ioread32(CQ + hcr_base),
>  		ioread32(CA + hcr_base), ioread32(CC + hcr_base));
>  
> @@ -983,15 +986,17 @@ static int sata_fsl_softreset(struct ata_link *link, unsigned int *class,
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
> +		ata_port_dbg(ap,
> +			     "HStatus = 0x%x HControl = 0x%x Serror = 0x%x\n",
> +			     ioread32(hcr_base + HSTATUS),
> +			     ioread32(hcr_base + HCONTROL),
> +			     Serror);
>  		goto err;
>  	}
>  
> @@ -1049,7 +1054,7 @@ static int sata_fsl_softreset(struct ata_link *link, unsigned int *class,
>  static void sata_fsl_error_handler(struct ata_port *ap)
>  {
>  
> -	DPRINTK("in xx_error_handler\n");
> +	ata_port_dbg(ap, "ENTER\n");
>  	sata_pmp_error_handler(ap);
>  
>  }
> @@ -1092,7 +1097,7 @@ static void sata_fsl_error_intr(struct ata_port *ap)
>  	if (unlikely(SError & 0xFFFF0000))
>  		sata_fsl_scr_write(&ap->link, SCR_ERROR, SError);
>  
> -	DPRINTK("error_intr,hStat=0x%x,CE=0x%x,DE =0x%x,SErr=0x%x\n",
> +	ata_port_dbg(ap, "hStat=0x%x,CE=0x%x,DE =0x%x,SErr=0x%x\n",
>  		hstatus, cereg, ioread32(hcr_base + DE), SError);
>  
>  	/* handle fatal errors */
> @@ -1109,7 +1114,7 @@ static void sata_fsl_error_intr(struct ata_port *ap)
>  
>  	/* Handle PHYRDY change notification */
>  	if (hstatus & INT_ON_PHYRDY_CHG) {
> -		DPRINTK("SATA FSL: PHYRDY change indication\n");
> +		ata_port_dbg(ap, "PHYRDY change indication\n");
>  
>  		/* Setup a soft-reset EH action */
>  		ata_ehi_hotplugged(ehi);
> @@ -1130,7 +1135,7 @@ static void sata_fsl_error_intr(struct ata_port *ap)
>  		 */
>  		abort = 1;
>  
> -		DPRINTK("single device error, CE=0x%x, DE=0x%x\n",
> +		ata_port_dbg(ap, "single device error, CE=0x%x, DE=0x%x\n",
>  			ioread32(hcr_base + CE), ioread32(hcr_base + DE));
>  
>  		/* find out the offending link and qc */
> @@ -1235,12 +1240,12 @@ static void sata_fsl_host_intr(struct ata_port *ap)
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
> @@ -1258,17 +1263,15 @@ static void sata_fsl_host_intr(struct ata_port *ap)
>  		/* clear CC bit, this will also complete the interrupt */
>  		iowrite32(done_mask, hcr_base + CC);
>  
> -		DPRINTK("Status of all queues :\n");
> -		DPRINTK("done_mask/CC = 0x%x, CA = 0x%x, CE=0x%x\n",
> -			done_mask, ioread32(hcr_base + CA),
> -			ioread32(hcr_base + CE));
> +		ata_port_dbg(ap, "Status of all queues: done_mask/CC = 0x%x, CA = 0x%x, CE=0x%x\n",
> +			     done_mask, ioread32(hcr_base + CA),
> +			     ioread32(hcr_base + CE));
>  
>  		for (i = 0; i < SATA_FSL_QUEUE_DEPTH; i++) {
>  			if (done_mask & (1 << i))
> -				DPRINTK
> -				    ("completing ncq cmd,tag=%d,CC=0x%x,CA=0x%x\n",
> -				     i, ioread32(hcr_base + CC),
> -				     ioread32(hcr_base + CA));
> +				ata_port_dbg(ap, "completing ncq cmd,tag=%d,CC=0x%x,CA=0x%x\n",
> +					     i, ioread32(hcr_base + CC),
> +					     ioread32(hcr_base + CA));
>  		}
>  		ata_qc_complete_multiple(ap, ata_qc_get_active(ap) ^ done_mask);
>  		return;
> @@ -1277,16 +1280,16 @@ static void sata_fsl_host_intr(struct ata_port *ap)
>  		iowrite32(1, hcr_base + CC);
>  		qc = ata_qc_from_tag(ap, ATA_TAG_INTERNAL);
>  
> -		DPRINTK("completing non-ncq cmd, CC=0x%x\n",
> -			 ioread32(hcr_base + CC));
> +		ata_port_dbg(ap, "completing non-ncq cmd, CC=0x%x\n",
> +			     ioread32(hcr_base + CC));
>  
>  		if (qc) {
>  			ata_qc_complete(qc);
>  		}
>  	} else {
>  		/* Spurious Interrupt!! */
> -		DPRINTK("spurious interrupt!!, CC = 0x%x\n",
> -			ioread32(hcr_base + CC));
> +		ata_port_dbg(ap, "spurious interrupt!!, CC = 0x%x\n",
> +			     ioread32(hcr_base + CC));
>  		iowrite32(done_mask, hcr_base + CC);
>  		return;
>  	}
> @@ -1305,7 +1308,7 @@ static irqreturn_t sata_fsl_interrupt(int irq, void *dev_instance)
>  	interrupt_enables = ioread32(hcr_base + HSTATUS);
>  	interrupt_enables &= 0x3F;
>  
> -	DPRINTK("interrupt status 0x%x\n", interrupt_enables);
> +	ata_port_dbg(ap, "interrupt status 0x%x\n", interrupt_enables);
>  
>  	if (!interrupt_enables)
>  		return IRQ_NONE;
> @@ -1359,14 +1362,14 @@ static int sata_fsl_init_controller(struct ata_host *host)
>  	iowrite32((temp & ~0x3F), hcr_base + HCONTROL);
>  
>  	/* Disable interrupt coalescing control(icc), for the moment */
> -	DPRINTK("icc = 0x%x\n", ioread32(hcr_base + ICC));
> +	ata_port_dbg(ap, "icc = 0x%x\n", ioread32(hcr_base + ICC));
>  	iowrite32(0x01000000, hcr_base + ICC);
>  
>  	/* clear error registers, SError is cleared by libATA  */
>  	iowrite32(0x00000FFFF, hcr_base + CE);
>  	iowrite32(0x00000FFFF, hcr_base + DE);
>  
> - 	/*
> +x	/*

This needs to be removed.

Otherwise the patch looks fine:

Reviewed-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

>  	 * reset the number of command complete bits which will cause the
>  	 * interrupt to be signaled
>  	 */
> @@ -1378,8 +1381,9 @@ static int sata_fsl_init_controller(struct ata_host *host)
>  	 * callback, that should also initiate the OOB, COMINIT sequence
>  	 */
>  
> -	DPRINTK("HStatus = 0x%x\n", ioread32(hcr_base + HSTATUS));
> -	DPRINTK("HControl = 0x%x\n", ioread32(hcr_base + HCONTROL));
> +	ata_port_dbg(ap, "HStatus = 0x%x HControl = 0x%x\n",
> +		     ioread32(hcr_base + HSTATUS),
> +		     ioread32(hcr_base + HCONTROL));
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
> +	ata_port_dbg(ap, "@reset i/o = 0x%x\n", ioread32(csr_base + TRANSCFG));
>  
>  	host_priv = kzalloc(sizeof(struct sata_fsl_host_priv), GFP_KERNEL);
>  	if (!host_priv)
> 
