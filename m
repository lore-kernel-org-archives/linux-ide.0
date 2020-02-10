Return-Path: <SRS0=vLfT=36=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A301C352A3
	for <linux-ide@archiver.kernel.org>; Mon, 10 Feb 2020 16:49:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 477C120733
	for <linux-ide@archiver.kernel.org>; Mon, 10 Feb 2020 16:49:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="DAi+F61u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727606AbgBJQtP (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 10 Feb 2020 11:49:15 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:54737 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727431AbgBJQtP (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 10 Feb 2020 11:49:15 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20200210164913euoutp01844bcc79b4759f46d74dc60f01c245dd~yGH8_z7mq3237632376euoutp01g
        for <linux-ide@vger.kernel.org>; Mon, 10 Feb 2020 16:49:13 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20200210164913euoutp01844bcc79b4759f46d74dc60f01c245dd~yGH8_z7mq3237632376euoutp01g
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1581353353;
        bh=S3/YrM+bp5bU5GZaxlAtvXiWscKXYFW+DeWBmdnoKJk=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=DAi+F61u1aI6l/VoaPsPNzIAKS+judaglt3enzFraXiZEgmLmnmw7AIp6gjvRsNoz
         SKUgGRzqsmFALzl/Mo/V5KI0VZkpzWJDpsHLdCrzlFwiCBxLN3u0M5u4T4RZx5s4CW
         b/znh0oM3XyU87S7o/2/ungkRhz0rP6eeXn7eYis=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200210164913eucas1p22aa8380a828f48eed0f05b6f60ace434~yGH81Z3Vr1929519295eucas1p2F;
        Mon, 10 Feb 2020 16:49:13 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id AF.7C.60698.989814E5; Mon, 10
        Feb 2020 16:49:13 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200210164913eucas1p1a3d6a7aaeadd2c1534edb544d93b2fbf~yGH8R4fUx3266632666eucas1p1N;
        Mon, 10 Feb 2020 16:49:13 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200210164913eusmtrp12ee230a9a5e9cc9f3a30c6f4f2da544f~yGH8RO8pM2806628066eusmtrp1E;
        Mon, 10 Feb 2020 16:49:13 +0000 (GMT)
X-AuditID: cbfec7f5-a29ff7000001ed1a-d9-5e4189898f27
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 3B.29.08375.989814E5; Mon, 10
        Feb 2020 16:49:13 +0000 (GMT)
Received: from [106.120.51.71] (unknown [106.120.51.71]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200210164912eusmtip14f500ee5eb1158e1d3f2cd379cdb9be7~yGH7v67Gb0950009500eusmtip1n;
        Mon, 10 Feb 2020 16:49:12 +0000 (GMT)
Subject: Re: [PATCH 43/46] libata: kill ATA_MSG_INFO
To:     Hannes Reinecke <hare@suse.de>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-ide@vger.kernel.org,
        Hannes Reinecke <hare@suse.com>
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Message-ID: <96cabd9e-580a-6624-9611-e850d94a70d4@samsung.com>
Date:   Mon, 10 Feb 2020 17:49:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20200204165547.115220-44-hare@suse.de>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprCKsWRmVeSWpSXmKPExsWy7djP87qdnY5xBm+261msvtvPZrHgzV42
        iz2LJjFZHNvxiMmBxePy2VKP9VuusnhsPl3t8XmTXABLFJdNSmpOZllqkb5dAlfG1vnL2AqW
        ClZsnbyItYFxAl8XIyeHhICJxOpFN1hAbCGBFYwSy7c7dzFyAdlfGCUaH65ihHA+M0oc3naL
        GabjZM9EVojEckaJG93b2SGct4wSG148ZAepEgaqunBwL1iHiICSxMf2Q2BxZoE4iaYrd8Fs
        NgEriYntICs4OXgF7CR+z5nNBGKzCKhKHJ28AiwuKhAh8enBYVaIGkGJkzOfgN3KCTR/24Tr
        bBAzxSVuPZnPBGHLS2x/O4cZ5CAJgX52iX+X+4ASHECOi8SBzfoQHwhLvDq+hR3ClpE4PbmH
        BaJ+HaPE344XUM3bgYEx+R8bRJW1xJ1zv9hABjELaEqs3wU1yFFi1QmQQSDz+SRuvBWEuIFP
        YtK26cwQYV6JjjYhiGo1iQ3LNrDBrO3auZJ5AqPSLCSfzULyzSwk38xC2LuAkWUVo3hqaXFu
        emqxcV5quV5xYm5xaV66XnJ+7iZGYFo5/e/41x2M+/4kHWIU4GBU4uG9EOwYJ8SaWFZcmXuI
        UYKDWUmE11IaKMSbklhZlVqUH19UmpNafIhRmoNFSZzXeNHLWCGB9MSS1OzU1ILUIpgsEwen
        VANjoejizk6B9we1exMX3IzcfU1X5kHo9ZotcRcjXRb3lL6cZuYwJd/55HUv8Yh/3z78eR7x
        0yrJUlhK7Oj2HX+sHyX9vfLBScCDd8lLtS2C17rtTVpeuU5IMAr407N6i8hma6mEH6uVfMof
        L6260XTuza9F6vZ3t5d0ndU4d3Na7aZ/ytWLr8WcU2Ipzkg01GIuKk4EAILcg7wnAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrKIsWRmVeSWpSXmKPExsVy+t/xu7qdnY5xBqeWclqsvtvPZrHgzV42
        iz2LJjFZHNvxiMmBxePy2VKP9VuusnhsPl3t8XmTXABLlJ5NUX5pSapCRn5xia1StKGFkZ6h
        pYWekYmlnqGxeayVkamSvp1NSmpOZllqkb5dgl7G1vnL2AqWClZsnbyItYFxAl8XIyeHhICJ
        xMmeiawgtpDAUkaJc1syuxg5gOIyEsfXl0GUCEv8udbFBlHymlFiwVdpEFsYqPXCwb3MILaI
        gJLEx/ZD7CA2s0CcxL++3UxdjFxA9RsYJTbs6WYESbAJWElMbF8FZvMK2En8njObCcRmEVCV
        ODp5BVhcVCBC4vCOWVA1ghInZz5hAbE5gZZtm3CdDWKBusSfeZeYIWxxiVtP5jNB2PIS29/O
        YZ7AKDQLSfssJC2zkLTMQtKygJFlFaNIamlxbnpusaFecWJucWleul5yfu4mRmAUbTv2c/MO
        xksbgw8xCnAwKvHwVgQ6xgmxJpYVV+YeYpTgYFYS4bWUBgrxpiRWVqUW5ccXleakFh9iNAV6
        biKzlGhyPjDC80riDU0NzS0sDc2NzY3NLJTEeTsEDsYICaQnlqRmp6YWpBbB9DFxcEo1MC4U
        VGLLLtJ/v/ryg6MbyoUUlhaL+sUe2pcp83Fby+Z2boY5E1zkF7le/vf8HnfXYreJQm0ss9y9
        pDveMRp3eMZmLf2kJVvBV7OgSX6het3W2ENVs7W3Tsxe9OCj/gaGw5/eiDbbPFV9tFaT8XmZ
        +q7VGwO2nnj8croNw3QdCbl1Wy82vo+ue6bEUpyRaKjFXFScCACR/txzuAIAAA==
X-CMS-MailID: 20200210164913eucas1p1a3d6a7aaeadd2c1534edb544d93b2fbf
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200204165617eucas1p2aa3bc89df7c61c85933d06f761cd8ab0
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200204165617eucas1p2aa3bc89df7c61c85933d06f761cd8ab0
References: <20200204165547.115220-1-hare@suse.de>
        <CGME20200204165617eucas1p2aa3bc89df7c61c85933d06f761cd8ab0@eucas1p2.samsung.com>
        <20200204165547.115220-44-hare@suse.de>
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org


On 2/4/20 5:55 PM, Hannes Reinecke wrote:
> From: Hannes Reinecke <hare@suse.com>
> 
> Just a single user, which should be converted to ata_dev_dbg() anyway.
> 
> Signed-off-by: Hannes Reinecke <hare@suse.de>

Reviewed-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

> ---
>  drivers/ata/libata-core.c | 6 +++---
>  include/linux/libata.h    | 2 --
>  2 files changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
> index 73f89026b2a2..a81e7006e73f 100644
> --- a/drivers/ata/libata-core.c
> +++ b/drivers/ata/libata-core.c
> @@ -2454,8 +2454,8 @@ int ata_dev_configure(struct ata_device *dev)
>  	char modelbuf[ATA_ID_PROD_LEN+1];
>  	int rc;
>  
> -	if (!ata_dev_enabled(dev) && ata_msg_info(ap)) {
> -		ata_dev_info(dev, "%s: ENTER/EXIT -- nodev\n", __func__);
> +	if (!ata_dev_enabled(dev)) {
> +		ata_dev_dbg(dev, "ENTER/EXIT -- nodev\n");
>  		return 0;
>  	}
>  
> @@ -6036,7 +6036,7 @@ struct ata_port *ata_port_alloc(struct ata_host *host)
>  	/* turn on all debugging levels */
>  	ap->msg_enable = 0x00FF;
>  #elif defined(ATA_DEBUG)
> -	ap->msg_enable = ATA_MSG_DRV | ATA_MSG_INFO | ATA_MSG_CTL | ATA_MSG_WARN | ATA_MSG_ERR;
> +	ap->msg_enable = ATA_MSG_DRV | ATA_MSG_CTL | ATA_MSG_WARN | ATA_MSG_ERR;
>  #else
>  	ap->msg_enable = ATA_MSG_DRV | ATA_MSG_ERR | ATA_MSG_WARN;
>  #endif
> diff --git a/include/linux/libata.h b/include/linux/libata.h
> index e2578d87d931..cab7aa3f0ed0 100644
> --- a/include/linux/libata.h
> +++ b/include/linux/libata.h
> @@ -70,7 +70,6 @@
>  
>  enum {
>  	ATA_MSG_DRV	= 0x0001,
> -	ATA_MSG_INFO	= 0x0002,
>  	ATA_MSG_PROBE	= 0x0004,
>  	ATA_MSG_WARN	= 0x0008,
>  	ATA_MSG_MALLOC	= 0x0010,
> @@ -80,7 +79,6 @@ enum {
>  };
>  
>  #define ata_msg_drv(p)    ((p)->msg_enable & ATA_MSG_DRV)
> -#define ata_msg_info(p)   ((p)->msg_enable & ATA_MSG_INFO)
>  #define ata_msg_probe(p)  ((p)->msg_enable & ATA_MSG_PROBE)
>  #define ata_msg_warn(p)   ((p)->msg_enable & ATA_MSG_WARN)
>  #define ata_msg_malloc(p) ((p)->msg_enable & ATA_MSG_MALLOC)
> 
