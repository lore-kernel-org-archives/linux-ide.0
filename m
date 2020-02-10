Return-Path: <SRS0=vLfT=36=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0F5BC352A3
	for <linux-ide@archiver.kernel.org>; Mon, 10 Feb 2020 16:48:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD6C520733
	for <linux-ide@archiver.kernel.org>; Mon, 10 Feb 2020 16:48:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="YAmqBkOw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727849AbgBJQsX (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 10 Feb 2020 11:48:23 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:43623 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727653AbgBJQsX (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 10 Feb 2020 11:48:23 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20200210164821euoutp020828723bee5d9cee4dc1b3d1cf59b47f~yGHMgBkFc3024030240euoutp02g
        for <linux-ide@vger.kernel.org>; Mon, 10 Feb 2020 16:48:21 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20200210164821euoutp020828723bee5d9cee4dc1b3d1cf59b47f~yGHMgBkFc3024030240euoutp02g
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1581353301;
        bh=WqZNaQhUvdsZGqgKI5UwGgV5ozy24wUEYOpepffoIQE=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=YAmqBkOw7Ner2K+vbedCjWvLrmXdKO8PbIS+bjsfERpclsw2esIGZDr/Kn5lOYRpr
         mDZC49YKdOylHIFGGUzI+ZBQnIMLccLJRzf5saNWAWx/7cwgRGcfiLst6Qyt/f5Ja7
         tn5xWPq7tH74CUSn58q83pgLqWqaYKlj2b8oiVfI=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200210164821eucas1p2ba57db4861c4cf61944aa2d71b9d8336~yGHMawU4h3100131001eucas1p2l;
        Mon, 10 Feb 2020 16:48:21 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id E8.78.61286.559814E5; Mon, 10
        Feb 2020 16:48:21 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200210164821eucas1p189c8a63ab93478c5e017a84296dea021~yGHL-1tp10754107541eucas1p1Q;
        Mon, 10 Feb 2020 16:48:21 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200210164821eusmtrp21f822c17696c454aa68f1e127b167506~yGHL-PzdQ3224832248eusmtrp2L;
        Mon, 10 Feb 2020 16:48:21 +0000 (GMT)
X-AuditID: cbfec7f2-ef1ff7000001ef66-3e-5e41895578e6
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id A3.19.08375.559814E5; Mon, 10
        Feb 2020 16:48:21 +0000 (GMT)
Received: from [106.120.51.71] (unknown [106.120.51.71]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200210164820eusmtip27b21e1ff13bb25d5ffce4949e73fe81c~yGHLX91QR0548505485eusmtip2b;
        Mon, 10 Feb 2020 16:48:20 +0000 (GMT)
Subject: Re: [PATCH 41/46] libata-core: move DPRINTK to ata debugging
To:     Hannes Reinecke <hare@suse.de>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-ide@vger.kernel.org,
        Hannes Reinecke <hare@suse.com>
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Message-ID: <0d6c2b4c-9e34-2e95-02a3-37a763a2ea54@samsung.com>
Date:   Mon, 10 Feb 2020 17:48:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20200204165547.115220-42-hare@suse.de>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprGKsWRmVeSWpSXmKPExsWy7djPc7qhnY5xBv0HtC1W3+1ns1jwZi+b
        xZ5Fk5gsju14xOTA4nH5bKnH+i1XWTw2n672+LxJLoAlissmJTUnsyy1SN8ugStj89pv7AUP
        5SrWT/vJ2MD4VKKLkZNDQsBE4vmk9exdjFwcQgIrGCU6Lv5nhHC+MEpMOfmVGcL5zChx6sYT
        FpiWrqeNUInljBJfPr2Gct4ySrz/080IUiUs4CrxYdMHdhBbREBJ4mP7ITCbWSBOounKXTCb
        TcBKYmL7KrB6XgE7iTdfD7CB2CwCqhItPW3MILaoQITEpweHWSFqBCVOzoS4ghPoirutm6Fm
        ikvcejKfCcKWl9j+dg7YQRIC/ewSk650MEGc7SLRc2MxlC0s8er4FnYIW0bi/06QZpCGdYwS
        fzteQHVvZ5RYPvkfG0SVtcSdc7+AbA6gFZoS63fpQ4QdJT72vGQHCUsI8EnceCsIcQSfxKRt
        05khwrwSHW1CENVqEhuWbWCDWdu1cyXzBEalWUhem4XknVlI3pmFsHcBI8sqRvHU0uLc9NRi
        w7zUcr3ixNzi0rx0veT83E2MwNRy+t/xTzsYv15KOsQowMGoxMNbEegYJ8SaWFZcmXuIUYKD
        WUmE11IaKMSbklhZlVqUH19UmpNafIhRmoNFSZzXeNHLWCGB9MSS1OzU1ILUIpgsEwenVAPj
        jofBj/nfTd715dzRfsUbmz433UzzVV+1T3HDKfP9N+qDFrx4WeRgIDM3d5oNs6TiOQMjvry+
        FpZ93IvnJN1heXCW++xGPe1jp2Y7VHZqnZ9bNv/xrT3LY71OVZjGeIl8uReja3JgpUn01Kty
        Li2JIv+MjzHsU6m3MVWr5yz+9Zdj89+n7X2HlFiKMxINtZiLihMBq/phgSkDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrOIsWRmVeSWpSXmKPExsVy+t/xe7qhnY5xBideCVisvtvPZrHgzV42
        iz2LJjFZHNvxiMmBxePy2VKP9VuusnhsPl3t8XmTXABLlJ5NUX5pSapCRn5xia1StKGFkZ6h
        pYWekYmlnqGxeayVkamSvp1NSmpOZllqkb5dgl7G5rXf2AseylWsn/aTsYHxqUQXIyeHhICJ
        RNfTRuYuRi4OIYGljBIHd19j6mLkAErISBxfXwZRIyzx51oXG0TNa0aJT9d+MoIkhAVcJT5s
        +sAOYosIKEl8bD8EZjMLxEn869vNBNGwgVFiyt67rCAJNgEriYntq8CaeQXsJN58PcAGYrMI
        qEq09LQxg9iiAhESh3fMgqoRlDg58wkLiM0JdOnd1s1QC9Ql/sy7xAxhi0vcejKfCcKWl9j+
        dg7zBEahWUjaZyFpmYWkZRaSlgWMLKsYRVJLi3PTc4sN9YoTc4tL89L1kvNzNzECI2nbsZ+b
        dzBe2hh8iFGAg1GJh7ci0DFOiDWxrLgy9xCjBAezkgivpTRQiDclsbIqtSg/vqg0J7X4EKMp
        0HMTmaVEk/OBUZ5XEm9oamhuYWlobmxubGahJM7bIXAwRkggPbEkNTs1tSC1CKaPiYNTqoGx
        PeGznoqvx7lGldv6mldmdvlL34mq3X7ipNPyvO51e/cvS2FMUpwy67XPE59PzXfNa80lXm04
        uoEpXFvkd8SlyVxfn+Qv91GYUXJlXiijqOLmjtagBdP3Jkx9ePSE4b1gnoYFWS9WKSybc3Vu
        sWda8A+T4Anzdjj9OZvnuVLrZe+tFT84DViVlFiKMxINtZiLihMBalNQZboCAAA=
X-CMS-MailID: 20200210164821eucas1p189c8a63ab93478c5e017a84296dea021
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200204171351eucas1p2e8fb856d0f38d0eb8a16ae2a2f442344
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200204171351eucas1p2e8fb856d0f38d0eb8a16ae2a2f442344
References: <20200204165547.115220-1-hare@suse.de>
        <CGME20200204171351eucas1p2e8fb856d0f38d0eb8a16ae2a2f442344@eucas1p2.samsung.com>
        <20200204165547.115220-42-hare@suse.de>
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org


On 2/4/20 5:55 PM, Hannes Reinecke wrote:
> From: Hannes Reinecke <hare@suse.com>
> 
> Replace all DPRINTK calls with the ata_XXX_dbg functions.
> 
> Signed-off-by: Hannes Reinecke <hare@suse.de>

Reviewed-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

> ---
>  drivers/ata/libata-core.c | 20 +++++++++++---------
>  1 file changed, 11 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
> index 297aa8172d4e..73f89026b2a2 100644
> --- a/drivers/ata/libata-core.c
> +++ b/drivers/ata/libata-core.c
> @@ -2060,7 +2060,7 @@ unsigned int ata_read_log_page(struct ata_device *dev, u8 log,
>  	unsigned int err_mask;
>  	bool dma = false;
>  
> -	DPRINTK("read log page - log 0x%x, page 0x%x\n", log, page);
> +	ata_dev_dbg(dev, "read log page - log 0x%x, page 0x%x\n", log, page);
>  
>  	/*
>  	 * Return error without actually issuing the command on controllers
> @@ -2096,7 +2096,7 @@ unsigned int ata_read_log_page(struct ata_device *dev, u8 log,
>  		goto retry;
>  	}
>  
> -	DPRINTK("EXIT, err_mask=%x\n", err_mask);
> +	ata_dev_dbg(dev, "EXIT, err_mask=%x\n", err_mask);
>  	return err_mask;
>  }
>  
> @@ -3560,7 +3560,7 @@ static int ata_dev_set_mode(struct ata_device *dev)
>  			dev_err_whine = " (device error ignored)";
>  	}
>  
> -	DPRINTK("xfer_shift=%u, xfer_mode=0x%x\n",
> +	ata_dev_dbg(dev, "xfer_shift=%u, xfer_mode=0x%x\n",
>  		dev->xfer_shift, (int)dev->xfer_mode);
>  
>  	if (!(ehc->i.flags & ATA_EHI_QUIET) ||
> @@ -4814,7 +4814,7 @@ static unsigned int ata_dev_set_xfermode(struct ata_device *dev)
>  	unsigned int err_mask;
>  
>  	/* set up set-features taskfile */
> -	DPRINTK("set features - xfer mode\n");
> +	ata_dev_dbg(dev, "set features - xfer mode\n");
>  
>  	/* Some controllers and ATAPI devices show flaky interrupt
>  	 * behavior after setting xfer mode.  Use polling instead.
> @@ -4836,7 +4836,7 @@ static unsigned int ata_dev_set_xfermode(struct ata_device *dev)
>  	/* On some disks, this command causes spin-up, so we need longer timeout */
>  	err_mask = ata_exec_internal(dev, &tf, NULL, DMA_NONE, NULL, 0, 15000);
>  
> -	DPRINTK("EXIT, err_mask=%x\n", err_mask);
> +	ata_dev_dbg(dev, "EXIT, err_mask=%x\n", err_mask);
>  	return err_mask;
>  }
>  
> @@ -4862,7 +4862,8 @@ unsigned int ata_dev_set_feature(struct ata_device *dev, u8 enable, u8 feature)
>  	unsigned long timeout = 0;
>  
>  	/* set up set-features taskfile */
> -	DPRINTK("set features - SATA features\n");
> +	ata_dev_dbg(dev, "set features - SATA features enable %u feature %u\n",
> +		    enable, feature);
>  
>  	ata_tf_init(dev, &tf);
>  	tf.command = ATA_CMD_SET_FEATURES;
> @@ -4876,7 +4877,7 @@ unsigned int ata_dev_set_feature(struct ata_device *dev, u8 enable, u8 feature)
>  			  ata_probe_timeout * 1000 : SETFEATURES_SPINUP_TIMEOUT;
>  	err_mask = ata_exec_internal(dev, &tf, NULL, DMA_NONE, NULL, 0, timeout);
>  
> -	DPRINTK("EXIT, err_mask=%x\n", err_mask);
> +	ata_dev_dbg(dev, "EXIT, err_mask=%x\n", err_mask);
>  	return err_mask;
>  }
>  EXPORT_SYMBOL_GPL(ata_dev_set_feature);
> @@ -4904,7 +4905,8 @@ static unsigned int ata_dev_init_params(struct ata_device *dev,
>  		return AC_ERR_INVALID;
>  
>  	/* set up init dev params taskfile */
> -	DPRINTK("init dev params \n");
> +	ata_dev_dbg(dev, "init dev params heads %u sectors %u\n",
> +		    heads, sectors);
>  
>  	ata_tf_init(dev, &tf);
>  	tf.command = ATA_CMD_INIT_DEV_PARAMS;
> @@ -4920,7 +4922,7 @@ static unsigned int ata_dev_init_params(struct ata_device *dev,
>  	if (err_mask == AC_ERR_DEV && (tf.feature & ATA_ABORTED))
>  		err_mask = 0;
>  
> -	DPRINTK("EXIT, err_mask=%x\n", err_mask);
> +	ata_dev_dbg(dev, "EXIT, err_mask=%x\n", err_mask);
>  	return err_mask;
>  }
>  
