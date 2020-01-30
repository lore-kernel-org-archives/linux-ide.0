Return-Path: <SRS0=S1Gt=3T=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAC64C33C9E
	for <linux-ide@archiver.kernel.org>; Thu, 30 Jan 2020 11:25:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3BD7206D3
	for <linux-ide@archiver.kernel.org>; Thu, 30 Jan 2020 11:25:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="WHD/dzWc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727107AbgA3LZm (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 30 Jan 2020 06:25:42 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:36195 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726980AbgA3LZm (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 30 Jan 2020 06:25:42 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20200130112540euoutp01c81f68a1945366904dc4fe15399c63ef~upnTrVVe03000330003euoutp01F
        for <linux-ide@vger.kernel.org>; Thu, 30 Jan 2020 11:25:40 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20200130112540euoutp01c81f68a1945366904dc4fe15399c63ef~upnTrVVe03000330003euoutp01F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1580383540;
        bh=gdRc73FUU6HRMysdsB4agyEIH8BQXcWLXesA0pyNWAE=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=WHD/dzWckjrbO6Ttc+iAYQxk+NW3S/l4rpsAsk1ZGtWXSrj/M+LYt4ereMVE2dZ17
         8k0c3pQ5VRPB7jGe/bI476q5JGS3ohGSQni+kJarH0JXw7JG/Q30qhQtr8jtXEA4vP
         cCDfX9B/rdoBDVrrS64A8+KsnD9NErC7FMId/lzk=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200130112540eucas1p1b57cce9fb7c16d1c235d86da611fd107~upnTkf7ia1816418164eucas1p1V;
        Thu, 30 Jan 2020 11:25:40 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 14.8E.61286.43DB23E5; Thu, 30
        Jan 2020 11:25:40 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200130112539eucas1p177b4f0d9f7f3055a015af8671c25a857~upnTLjXZA2342023420eucas1p1V;
        Thu, 30 Jan 2020 11:25:39 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200130112539eusmtrp279493768f152c642c00a3832a8f14659~upnTFXnLb1174511745eusmtrp2Y;
        Thu, 30 Jan 2020 11:25:39 +0000 (GMT)
X-AuditID: cbfec7f2-ef1ff7000001ef66-01-5e32bd34c6a3
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id B9.33.07950.33DB23E5; Thu, 30
        Jan 2020 11:25:39 +0000 (GMT)
Received: from [106.120.51.71] (unknown [106.120.51.71]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200130112539eusmtip1217143c6654a2a35feede4461cf693c2~upnSwPxep0558605586eusmtip1Q;
        Thu, 30 Jan 2020 11:25:39 +0000 (GMT)
Subject: Re: [PATCH 16/24] sata_fsl: move DPRINTK to ata debugging
To:     Hannes Reinecke <hare@suse.de>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-ide@vger.kernel.org,
        Hannes Reinecke <hare@suse.com>
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Message-ID: <7cd6f059-e74c-21d6-7c71-681ade35ebf0@samsung.com>
Date:   Thu, 30 Jan 2020 12:25:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20181213104716.31930-28-hare@suse.de>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprKKsWRmVeSWpSXmKPExsWy7djPc7ome43iDDbf47ZYfbefzWLBm71s
        FnsWTWKyOLbjEZMDi8fls6Ue67dcZfHYfLra4/MmuQCWKC6blNSczLLUIn27BK6M5pY+xoKT
        CRV7Xi9la2Cc6dvFyMEhIWAicWVLShcjF4eQwApGicWrH7NDOF8YJWa/72KCcD4zSuyaNA8o
        wwnW8evkN1aIxHJGie7Zs6Ba3jJKPNp6kgmkSljASWLqtBOMILaIgJLEx/ZDYN3MAnESTVfu
        gtlsAlYSE9tXgdXwCthJPGy9xAJiswioSlxfcJYZxBYViJD49OAwK0SNoMTJmU/AajgFjCXW
        /trDDDFTXOLWk/lMELa8xPa3c5hBDpIQ6GeX6G75CHW2i8SV7zOZIWxhiVfHt0DFZST+75zP
        BNGwjlHib8cLqO7tjBLLJ/9jg6iylrhz7hcbKMiYBTQl1u/Shwg7SvTsnMUICUk+iRtvBSGO
        4JOYtG06M0SYV6KjTQiiWk1iw7INbDBru3auZJ7AqDQLyWuzkLwzC8k7sxD2LmBkWcUonlpa
        nJueWmyYl1quV5yYW1yal66XnJ+7iRGYWE7/O/5pB+PXS0mHGAU4GJV4eDU2GMUJsSaWFVfm
        HmKU4GBWEuEVdTWME+JNSaysSi3Kjy8qzUktPsQozcGiJM5rvOhlrJBAemJJanZqakFqEUyW
        iYNTqoFxwaw9moK7Wx4w6pv+l335rON5HYtbt7fZnPtL3Db9VPji/e/CzYp89Y1bWQ5c7okp
        utNkEX/MInd22LV99TWHbXsjQ40Y6mYkZLdG6fx0y+NIu/5wlqXdArWlWzbWqnGVm+6Jry+6
        LxJZfGT74rWMPqy/nZ4UcD4Ijy+fcEV453uzc7Ui91iVWIozEg21mIuKEwEERHHXKAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrOIsWRmVeSWpSXmKPExsVy+t/xu7rGe43iDOZ1a1msvtvPZrHgzV42
        iz2LJjFZHNvxiMmBxePy2VKP9VuusnhsPl3t8XmTXABLlJ5NUX5pSapCRn5xia1StKGFkZ6h
        pYWekYmlnqGxeayVkamSvp1NSmpOZllqkb5dgl5Gc0sfY8HJhIo9r5eyNTDO9O1i5OSQEDCR
        +HXyG2sXIxeHkMBSRonf56YCORxACRmJ4+vLIGqEJf5c62KDqHnNKLH8Xg8bSEJYwEli6rQT
        jCC2iICSxMf2Q+wgNrNAnMS/vt1MEA3rGCWu7L3OApJgE7CSmNi+CqyBV8BO4mHrJbA4i4Cq
        xPUFZ5lBbFGBCInDO2ZB1QhKnJz5BKyGU8BYYu2vPcwQC9Ql/sy7BGWLS9x6Mp8JwpaX2P52
        DvMERqFZSNpnIWmZhaRlFpKWBYwsqxhFUkuLc9Nzi430ihNzi0vz0vWS83M3MQIjaduxn1t2
        MHa9Cz7EKMDBqMTDq7HBKE6INbGsuDL3EKMEB7OSCK+oq2GcEG9KYmVValF+fFFpTmrxIUZT
        oOcmMkuJJucDozyvJN7Q1NDcwtLQ3Njc2MxCSZy3Q+BgjJBAemJJanZqakFqEUwfEwenVAPj
        pfDtrKxa5ybPCDpfq6b66lUb58pDgrGfZp3k2/1Jmo+h7MZn0V3TEs/uOflrP7OeTdOGzRsa
        1+86+fnfvRy5G/oSzku6ewOn6Z67+OVaR0YZ954wttPxnyYt1Tlzu8jnnEQtU5Bp4ur7/rsE
        pjLH2yxQLbb6EtlU9iz4V97CbQENv1kFP7spKbEUZyQaajEXFScCAJR6RFW6AgAA
X-CMS-MailID: 20200130112539eucas1p177b4f0d9f7f3055a015af8671c25a857
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20181213104740epcas3p498f1b4f489320a9c04f74c072643e988
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20181213104740epcas3p498f1b4f489320a9c04f74c072643e988
References: <20181213104716.31930-1-hare@suse.de>
        <CGME20181213104740epcas3p498f1b4f489320a9c04f74c072643e988@epcas3p4.samsung.com>
        <20181213104716.31930-28-hare@suse.de>
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org


On 12/13/18 11:47 AM, Hannes Reinecke wrote:
> Replace all DPRINTK calls with the ata_XXX_dbg functions.

Please preserve __func__ printing in the conversion.

> Signed-off-by: Hannes Reinecke <hare@suse.com>
> ---
>  drivers/ata/sata_fsl.c | 85 +++++++++++++++++++++++++++-----------------------
>  1 file changed, 46 insertions(+), 39 deletions(-)
> 
> diff --git a/drivers/ata/sata_fsl.c b/drivers/ata/sata_fsl.c
> index 4dc528bf8e85..8bb129c87a3f 100644
> --- a/drivers/ata/sata_fsl.c
> +++ b/drivers/ata/sata_fsl.c
> @@ -316,9 +316,9 @@ static void fsl_sata_set_irq_coalescing(struct ata_host *host,
>  	intr_coalescing_ticks = ticks;
>  	spin_unlock_irqrestore(&host->lock, flags);
>  
> -	DPRINTK("interrupt coalescing, count = 0x%x, ticks = %x\n",
> +	dev_dbg(host->dev, "interrupt coalescing, count = 0x%x, ticks = %x\n",
>  			intr_coalescing_count, intr_coalescing_ticks);
> -	DPRINTK("ICC register status: (hcr base: 0x%x) = 0x%x\n",
> +	dev_dbg(host->dev, "ICC register status: (hcr base: 0x%x) = 0x%x\n",
>  			hcr_base, ioread32(hcr_base + ICC));
>  }
>  
> @@ -390,18 +390,18 @@ static ssize_t fsl_sata_rx_watermark_store(struct device *dev,
>  	return strlen(buf);
>  }
>  
> -static inline unsigned int sata_fsl_tag(unsigned int tag,
> +static inline unsigned int sata_fsl_tag(struct ata_dev *dev, unsigned int tag,
>  					void __iomem *hcr_base)
>  {
>  	/* We let libATA core do actual (queue) tag allocation */
>  
>  	if (unlikely(tag >= SATA_FSL_QUEUE_DEPTH)) {
> -		DPRINTK("tag %d invalid : out of range\n", tag);
> +		ata_dev_dbg(dev, "tag %d invalid : out of range\n", tag);
>  		return 0;
>  	}
>  
>  	if (unlikely((ioread32(hcr_base + CQ)) & (1 << tag))) {
> -		DPRINTK("tag %d invalid : in use!!\n", tag);
> +		ata_dev_dbg(dev, "tag %d invalid : in use!!\n", tag);
>  		return 0;
>  	}
>  
> @@ -513,7 +513,7 @@ static void sata_fsl_qc_prep(struct ata_queued_cmd *qc)
>  	struct sata_fsl_port_priv *pp = ap->private_data;
>  	struct sata_fsl_host_priv *host_priv = ap->host->private_data;
>  	void __iomem *hcr_base = host_priv->hcr_base;
> -	unsigned int tag = sata_fsl_tag(qc->hw_tag, hcr_base);
> +	unsigned int tag = sata_fsl_tag(qc->dev, qc->hw_tag, hcr_base);
>  	struct command_desc *cd;
>  	u32 desc_info = CMD_DESC_RES | CMD_DESC_SNOOP_ENABLE;
>  	u32 num_prde = 0;
> @@ -828,7 +828,7 @@ static int sata_fsl_hardreset(struct ata_link *link, unsigned int *class,
>  	int i = 0;
>  	unsigned long start_jiffies;
>  
> -	DPRINTK("in xx_hardreset\n");
> +	ata_port_dbg(ap, "in xx_hardreset\n");
>  
>  try_offline_again:
>  	/*
> @@ -855,7 +855,7 @@ static int sata_fsl_hardreset(struct ata_link *link, unsigned int *class,
>  			goto try_offline_again;
>  	}
>  
> -	DPRINTK("hardreset, controller off-lined\n");
> +	ata_port_dbg(port, "hardreset, controller off-lined\n");
>  	VPRINTK("HStatus = 0x%x\n", ioread32(hcr_base + HSTATUS));
>  	VPRINTK("HControl = 0x%x\n", ioread32(hcr_base + HCONTROL));
>  
> @@ -885,7 +885,7 @@ static int sata_fsl_hardreset(struct ata_link *link, unsigned int *class,
>  		goto err;
>  	}
>  
> -	DPRINTK("hardreset, controller off-lined & on-lined\n");
> +	ata_port_dbg(ap, "hardreset, controller off-lined & on-lined\n");
>  	VPRINTK("HStatus = 0x%x\n", ioread32(hcr_base + HSTATUS));
>  	VPRINTK("HControl = 0x%x\n", ioread32(hcr_base + HCONTROL));
>  
> @@ -944,10 +944,10 @@ static int sata_fsl_softreset(struct ata_link *link, unsigned int *class,
>  	u8 *cfis;
>  	u32 Serror;
>  
> -	DPRINTK("in xx_softreset\n");
> +	ata_link_dbg(link, "in xx_softreset\n");
>  
>  	if (ata_link_offline(link)) {
> -		DPRINTK("PHY reports no device\n");
> +		ata_link_dbg(link, "PHY reports no device\n");
>  		*class = ATA_DEV_NONE;
>  		return 0;
>  	}
> @@ -960,7 +960,7 @@ static int sata_fsl_softreset(struct ata_link *link, unsigned int *class,
>  	 * reached here, we can send a command to the target device
>  	 */
>  
> -	DPRINTK("Sending SRST/device reset\n");
> +	ata_link_dbg(link, "Sending SRST/device reset\n");
>  
>  	ata_tf_init(link->device, &tf);
>  	cfis = (u8 *) &pp->cmdentry->cfis;
> @@ -972,7 +972,7 @@ static int sata_fsl_softreset(struct ata_link *link, unsigned int *class,
>  	tf.ctl |= ATA_SRST;	/* setup SRST bit in taskfile control reg */
>  	ata_tf_to_fis(&tf, pmp, 0, cfis);
>  
> -	DPRINTK("Dumping cfis : 0x%x, 0x%x, 0x%x, 0x%x\n",
> +	ata_port_dbg(ap, "Dumping cfis : 0x%x, 0x%x, 0x%x, 0x%x\n",
>  		cfis[0], cfis[1], cfis[2], cfis[3]);
>  
>  	/*
> @@ -980,7 +980,7 @@ static int sata_fsl_softreset(struct ata_link *link, unsigned int *class,
>  	 * other commands are active on the controller/device
>  	 */
>  
> -	DPRINTK("@Softreset, CQ = 0x%x, CA = 0x%x, CC = 0x%x\n",
> +	ata_port_dbg(ap, "@Softreset, CQ = 0x%x, CA = 0x%x, CC = 0x%x\n",
>  		ioread32(CQ + hcr_base),
>  		ioread32(CA + hcr_base), ioread32(CC + hcr_base));
>  
> @@ -993,15 +993,17 @@ static int sata_fsl_softreset(struct ata_link *link, unsigned int *class,
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
> +		ata_port_dbg(ap, "HStatus = 0x%x\n",
> +			     ioread32(hcr_base + HSTATUS));
> +		ata_port_dbg(ap, "HControl = 0x%x\n",
> +			     ioread32(hcr_base + HCONTROL));
> +		ata_port_dbg(ap, "Serror = 0x%x\n", Serror);
>  		goto err;
>  	}
>  
> @@ -1033,12 +1035,14 @@ static int sata_fsl_softreset(struct ata_link *link, unsigned int *class,
>  	 */
>  	iowrite32(0x01, CC + hcr_base);	/* We know it will be cmd#0 always */
>  
> -	DPRINTK("SATA FSL : Now checking device signature\n");
> +	ata_link_dbg(link, "SATA FSL : Now checking device signature\n");
>  
>  	*class = ATA_DEV_NONE;
>  
>  	/* Verify if SStatus indicates device presence */
>  	if (ata_link_online(link)) {
> +		char desc[16];
> +

What do we need it for?

>  		/*
>  		 * if we are here, device presence has been detected,
>  		 * 1st D2H FIS would have been received, but sfis in
> @@ -1048,7 +1052,7 @@ static int sata_fsl_softreset(struct ata_link *link, unsigned int *class,
>  
>  		*class = sata_fsl_dev_classify(ap);
>  
> -		DPRINTK("class = %d\n", *class);
> +		ata_link_dbg(link, "class = %d\n", *class);
>  		VPRINTK("ccreg = 0x%x\n", ioread32(hcr_base + CC));
>  		VPRINTK("cereg = 0x%x\n", ioread32(hcr_base + CE));
>  	}
> @@ -1062,7 +1066,7 @@ static int sata_fsl_softreset(struct ata_link *link, unsigned int *class,
>  static void sata_fsl_error_handler(struct ata_port *ap)
>  {
>  
> -	DPRINTK("in xx_error_handler\n");
> +	ata_port_dbg(ap, "in xx_error_handler\n");
>  	sata_pmp_error_handler(ap);
>  
>  }
> @@ -1105,7 +1109,7 @@ static void sata_fsl_error_intr(struct ata_port *ap)
>  	if (unlikely(SError & 0xFFFF0000))
>  		sata_fsl_scr_write(&ap->link, SCR_ERROR, SError);
>  
> -	DPRINTK("error_intr,hStat=0x%x,CE=0x%x,DE =0x%x,SErr=0x%x\n",
> +	ata_port_dbg(ap, "error_intr,hStat=0x%x,CE=0x%x,DE =0x%x,SErr=0x%x\n",
>  		hstatus, cereg, ioread32(hcr_base + DE), SError);
>  
>  	/* handle fatal errors */
> @@ -1122,7 +1126,7 @@ static void sata_fsl_error_intr(struct ata_port *ap)
>  
>  	/* Handle PHYRDY change notification */
>  	if (hstatus & INT_ON_PHYRDY_CHG) {
> -		DPRINTK("SATA FSL: PHYRDY change indication\n");
> +		ata_port_dbg(ap, "SATA FSL: PHYRDY change indication\n");
>  
>  		/* Setup a soft-reset EH action */
>  		ata_ehi_hotplugged(ehi);
> @@ -1143,7 +1147,7 @@ static void sata_fsl_error_intr(struct ata_port *ap)
>  		 */
>  		abort = 1;
>  
> -		DPRINTK("single device error, CE=0x%x, DE=0x%x\n",
> +		ata_port_dbg(ap, "single device error, CE=0x%x, DE=0x%x\n",
>  			ioread32(hcr_base + CE), ioread32(hcr_base + DE));
>  
>  		/* find out the offending link and qc */
> @@ -1248,12 +1252,12 @@ static void sata_fsl_host_intr(struct ata_port *ap)
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
> @@ -1271,15 +1275,15 @@ static void sata_fsl_host_intr(struct ata_port *ap)
>  		/* clear CC bit, this will also complete the interrupt */
>  		iowrite32(done_mask, hcr_base + CC);
>  
> -		DPRINTK("Status of all queues :\n");
> -		DPRINTK("done_mask/CC = 0x%x, CA = 0x%x, CE=0x%x\n",
> +		ata_port_dbg(ap, "Status of all queues :\n");
> +		ata_port_dbg(ap, "done_mask/CC = 0x%x, CA = 0x%x, CE=0x%x\n",
>  			done_mask, ioread32(hcr_base + CA),
>  			ioread32(hcr_base + CE));
>  
>  		for (i = 0; i < SATA_FSL_QUEUE_DEPTH; i++) {
>  			if (done_mask & (1 << i))
> -				DPRINTK
> -				    ("completing ncq cmd,tag=%d,CC=0x%x,CA=0x%x\n",
> +				ata_port_dbg(ap,
> +				     "completing ncq cmd,tag=%d,CC=0x%x,CA=0x%x\n",
>  				     i, ioread32(hcr_base + CC),
>  				     ioread32(hcr_base + CA));
>  		}
> @@ -1290,7 +1294,7 @@ static void sata_fsl_host_intr(struct ata_port *ap)
>  		iowrite32(1, hcr_base + CC);
>  		qc = ata_qc_from_tag(ap, ATA_TAG_INTERNAL);
>  
> -		DPRINTK("completing non-ncq cmd, CC=0x%x\n",
> +		ata_port_dbg(ap, "completing non-ncq cmd, CC=0x%x\n",
>  			 ioread32(hcr_base + CC));
>  
>  		if (qc) {
> @@ -1298,7 +1302,7 @@ static void sata_fsl_host_intr(struct ata_port *ap)
>  		}
>  	} else {
>  		/* Spurious Interrupt!! */
> -		DPRINTK("spurious interrupt!!, CC = 0x%x\n",
> +		ap_port_dbg(ap, "spurious interrupt!!, CC = 0x%x\n",
>  			ioread32(hcr_base + CC));
>  		iowrite32(done_mask, hcr_base + CC);
>  		return;
> @@ -1318,7 +1322,7 @@ static irqreturn_t sata_fsl_interrupt(int irq, void *dev_instance)
>  	interrupt_enables = ioread32(hcr_base + HSTATUS);
>  	interrupt_enables &= 0x3F;
>  
> -	DPRINTK("interrupt status 0x%x\n", interrupt_enables);
> +	dev_dbg(host->dev, "interrupt status 0x%x\n", interrupt_enables);
>  
>  	if (!interrupt_enables)
>  		return IRQ_NONE;
> @@ -1372,7 +1376,7 @@ static int sata_fsl_init_controller(struct ata_host *host)
>  	iowrite32((temp & ~0x3F), hcr_base + HCONTROL);
>  
>  	/* Disable interrupt coalescing control(icc), for the moment */
> -	DPRINTK("icc = 0x%x\n", ioread32(hcr_base + ICC));
> +	dev_dbg(host->dev, "icc = 0x%x\n", ioread32(hcr_base + ICC));
>  	iowrite32(0x01000000, hcr_base + ICC);
>  
>  	/* clear error registers, SError is cleared by libATA  */
> @@ -1391,8 +1395,8 @@ static int sata_fsl_init_controller(struct ata_host *host)
>  	 * callback, that should also initiate the OOB, COMINIT sequence
>  	 */
>  
> -	DPRINTK("HStatus = 0x%x\n", ioread32(hcr_base + HSTATUS));
> -	DPRINTK("HControl = 0x%x\n", ioread32(hcr_base + HCONTROL));
> +	dev_dbg(host->dev, "HStatus = 0x%x\n", ioread32(hcr_base + HSTATUS));
> +	dev_dbg(host->dev, "HControl = 0x%x\n", ioread32(hcr_base + HCONTROL));
>  
>  	return 0;
>  }
> @@ -1471,9 +1475,12 @@ static int sata_fsl_probe(struct platform_device *ofdev)
>  		iowrite32(temp | TRANSCFG_RX_WATER_MARK, csr_base + TRANSCFG);
>  	}
>  
> -	DPRINTK("@reset i/o = 0x%x\n", ioread32(csr_base + TRANSCFG));
> -	DPRINTK("sizeof(cmd_desc) = %d\n", sizeof(struct command_desc));
> -	DPRINTK("sizeof(#define cmd_desc) = %d\n", SATA_FSL_CMD_DESC_SIZE);
> +	dev_dbg(&ofdev->dev,
> +		"@reset i/o = 0x%x\n", ioread32(csr_base + TRANSCFG));
> +	dev_dbg(&ofdev->dev,
> +		"sizeof(cmd_desc) = %d\n", sizeof(struct command_desc));
> +	dev_dbg(&ofdev->dev,
> +		"sizeof(#define cmd_desc) = %d\n", SATA_FSL_CMD_DESC_SIZE);
>  
>  	host_priv = kzalloc(sizeof(struct sata_fsl_host_priv), GFP_KERNEL);
>  	if (!host_priv)

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
