Return-Path: <SRS0=vLfT=36=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0768DC352A3
	for <linux-ide@archiver.kernel.org>; Mon, 10 Feb 2020 13:49:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD8DC20842
	for <linux-ide@archiver.kernel.org>; Mon, 10 Feb 2020 13:49:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="D0S7ZkIp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727855AbgBJNtm (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 10 Feb 2020 08:49:42 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:32965 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727795AbgBJNtm (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 10 Feb 2020 08:49:42 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20200210134940euoutp02f07714c76991024f9f685603788b7343~yDrLarKnH1019710197euoutp02K
        for <linux-ide@vger.kernel.org>; Mon, 10 Feb 2020 13:49:40 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20200210134940euoutp02f07714c76991024f9f685603788b7343~yDrLarKnH1019710197euoutp02K
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1581342580;
        bh=EprMlFeHmiZlvv+pBiQXR/DemVxXF4FHBlJwHvNhAcY=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=D0S7ZkIpHuV2P0eD0gR7XwLD/XHhDhbh/MLgLYLgBOC7RSMSCnmd3TDwZptl9i/NU
         jv887MhIQOa/sdSo0vzvIoCsLodAfilCJKLS381ke7XgbJAIIveAFpE0xOiB69U/k3
         QIxuMDMk5tsOX/tfmXIEax1qAT2JD/brXNoHPPpM=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200210134940eucas1p207f3a15e368097565ebcf2a6d20c58e4~yDrLWBMJu2015220152eucas1p23;
        Mon, 10 Feb 2020 13:49:40 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 8F.3A.60679.47F514E5; Mon, 10
        Feb 2020 13:49:40 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200210134939eucas1p14161fb44f6acc9c2a8e80fca9dc5eed0~yDrK2aXW21256912569eucas1p1t;
        Mon, 10 Feb 2020 13:49:39 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200210134939eusmtrp1b7a82055302049e73c0011a61fb93fbe~yDrK13QIn2065420654eusmtrp1G;
        Mon, 10 Feb 2020 13:49:39 +0000 (GMT)
X-AuditID: cbfec7f4-0cbff7000001ed07-be-5e415f7430f2
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 77.8C.07950.37F514E5; Mon, 10
        Feb 2020 13:49:39 +0000 (GMT)
Received: from [106.120.51.71] (unknown [106.120.51.71]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200210134939eusmtip1a35e04aa814f61d847efb204900dbfa3~yDrKm6gxt0755607556eusmtip1p;
        Mon, 10 Feb 2020 13:49:39 +0000 (GMT)
Subject: Re: [PATCH 21/46] sata_fsl: drop DPRINTK() calls in reset
To:     Hannes Reinecke <hare@suse.de>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-ide@vger.kernel.org
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Message-ID: <a16422df-7fba-84cf-3ce8-d0c64d23bbe9@samsung.com>
Date:   Mon, 10 Feb 2020 14:49:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20200204165547.115220-22-hare@suse.de>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupkleLIzCtJLcpLzFFi42LZduznOd2SeMc4gytrJSxW3+1ns9izaBKT
        xbEdj5gcmD0uny312Hy62uPzJrkA5igum5TUnMyy1CJ9uwSujLO77zAWnBGsWHpQqoHxO28X
        IyeHhICJxOMLr1i6GLk4hARWMErc3/WJDSQhJPCFUeL2bm6IxGdGiQUf/rPCdGzr28sMkVjO
        KNG+ZwEjhPOWUaLr9GtGkCphASeJt50Qo0QElCQ+th9iB7GZBawlZi9ezwRiswlYSUxsXwVW
        zytgJ7Hq9mywehYBVYlrK1eB1YsKREh8enCYFaJGUOLkzCdAt3JwcAJdsX+5A8RIcYlbT+Yz
        QdjyEtvfzgE7TkKgmV3ifdN2ZoirXST+X/vFAmELS7w6voUdwpaROD25hwWiYR2jxN+OF1Dd
        2xkllk/+xwZRZS1x59wvNpDNzAKaEut36UOEHSW2LAb5ngPI5pO48VYQ4gg+iUnbpjNDhHkl
        OtqEIKrVJDYs28AGs7Zr50rmCYxKs5B8NgvJO7OQvDMLYe8CRpZVjOKppcW56anFRnmp5XrF
        ibnFpXnpesn5uZsYgQnk9L/jX3Yw7vqTdIhRgINRiYe3ItAxTog1say4MvcQowQHs5IIr6U0
        UIg3JbGyKrUoP76oNCe1+BCjNAeLkjiv8aKXsUIC6YklqdmpqQWpRTBZJg5OYKrh9XNUDU+W
        u513aDafc2DL+9q4jEPXpCPydqfu/ehbNOn5kwUMzYYrM1+6hv3keat64G/h3Zc/MlJnuIsp
        nAqZPmNOnd+lvVWnsg9pWpv/kLLclV9e9zP/eyDLGWF38wYR3cnvM3W/XL718bb5dKNog0sT
        96fFupdJzb9z2SFJcFVmo2nCdWElluKMREMt5qLiRACgeCTlHAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprFIsWRmVeSWpSXmKPExsVy+t/xu7rF8Y5xBhM/G1usvtvPZrFn0SQm
        i2M7HjE5MHtcPlvqsfl0tcfnTXIBzFF6NkX5pSWpChn5xSW2StGGFkZ6hpYWekYmlnqGxuax
        VkamSvp2NimpOZllqUX6dgl6GWd332EsOCNYsfSgVAPjd94uRk4OCQETiW19e5m7GLk4hASW
        Mkoc+vWRvYuRAyghI3F8fRlEjbDEn2tdbCC2kMBrRonOzzkgtrCAk8Tbzk9gcREBJYmP7YfY
        QWxmAWuJ2YvXM0HM3MAo8aVxETNIgk3ASmJi+ypGEJtXwE5i1e3ZYM0sAqoS11auAmsWFYiQ
        OLxjFlSNoMTJmU9YQO7hBDp0/3IHiPnqEn/mXWKGsMUlbj2ZzwRhy0tsfzuHeQKj0Cwk3bOQ
        tMxC0jILScsCRpZVjCKppcW56bnFRnrFibnFpXnpesn5uZsYgfGy7djPLTsYu94FH2IU4GBU
        4uG9EOwYJ8SaWFZcmXuIUYKDWUmE11IaKMSbklhZlVqUH19UmpNafIjRFOi3icxSosn5wFjO
        K4k3NDU0t7A0NDc2NzazUBLn7RA4GCMkkJ5YkpqdmlqQWgTTx8TBCYyi7O33cqeceRL0Q27z
        +Wsyezv/flxUL8Elxr2bL372Ec4/t8M9nkdwSTzf/GRN7q1i72/vjvxeoWs0aX73rluH9ogX
        uj9NnFH+/cvtvTZnF07V83Zc6KxfsZRvQ6jlwr3cKwsvHr8fZHJR8vMLAYvP/BMalj2vfxZs
        1qRUMHnJ2aqNK6sd5CqLHiqxFGckGmoxFxUnAgAqTEa9rQIAAA==
X-CMS-MailID: 20200210134939eucas1p14161fb44f6acc9c2a8e80fca9dc5eed0
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200204165615eucas1p2d812bbd3542379394afc18c902cbb842
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200204165615eucas1p2d812bbd3542379394afc18c902cbb842
References: <20200204165547.115220-1-hare@suse.de>
        <CGME20200204165615eucas1p2d812bbd3542379394afc18c902cbb842@eucas1p2.samsung.com>
        <20200204165547.115220-22-hare@suse.de>
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org


On 2/4/20 5:55 PM, Hannes Reinecke wrote:
> Reset is now logged with tracepoints, so the DPRINTK() calls can
> be dropped, and some calls can be dropped as they don't provide
> additional value.
> 
> Signed-off-by: Hannes Reinecke <hare@suse.de>

Reviewed-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

> ---
>  drivers/ata/sata_fsl.c | 10 ----------
>  1 file changed, 10 deletions(-)
> 
> diff --git a/drivers/ata/sata_fsl.c b/drivers/ata/sata_fsl.c
> index 0864c4fafa39..5d48e1d223fa 100644
> --- a/drivers/ata/sata_fsl.c
> +++ b/drivers/ata/sata_fsl.c
> @@ -825,8 +825,6 @@ static int sata_fsl_hardreset(struct ata_link *link, unsigned int *class,
>  	int i = 0;
>  	unsigned long start_jiffies;
>  
> -	DPRINTK("in xx_hardreset\n");
> -
>  try_offline_again:
>  	/*
>  	 * Force host controller to go off-line, aborting current operations
> @@ -941,10 +939,7 @@ static int sata_fsl_softreset(struct ata_link *link, unsigned int *class,
>  	u8 *cfis;
>  	u32 Serror;
>  
> -	DPRINTK("in xx_softreset\n");
> -
>  	if (ata_link_offline(link)) {
> -		DPRINTK("PHY reports no device\n");
>  		*class = ATA_DEV_NONE;
>  		return 0;
>  	}
> @@ -957,8 +952,6 @@ static int sata_fsl_softreset(struct ata_link *link, unsigned int *class,
>  	 * reached here, we can send a command to the target device
>  	 */
>  
> -	DPRINTK("Sending SRST/device reset\n");
> -
>  	ata_tf_init(link->device, &tf);
>  	cfis = (u8 *) &pp->cmdentry->cfis;
>  
> @@ -1030,8 +1023,6 @@ static int sata_fsl_softreset(struct ata_link *link, unsigned int *class,
>  	 */
>  	iowrite32(0x01, CC + hcr_base);	/* We know it will be cmd#0 always */
>  
> -	DPRINTK("SATA FSL : Now checking device signature\n");
> -
>  	*class = ATA_DEV_NONE;
>  
>  	/* Verify if SStatus indicates device presence */
> @@ -1045,7 +1036,6 @@ static int sata_fsl_softreset(struct ata_link *link, unsigned int *class,
>  
>  		*class = sata_fsl_dev_classify(ap);
>  
> -		DPRINTK("class = %d\n", *class);
>  		VPRINTK("ccreg = 0x%x\n", ioread32(hcr_base + CC));
>  		VPRINTK("cereg = 0x%x\n", ioread32(hcr_base + CE));
>  	}
> 

