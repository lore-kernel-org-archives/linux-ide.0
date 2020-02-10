Return-Path: <SRS0=vLfT=36=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B0D7C352A3
	for <linux-ide@archiver.kernel.org>; Mon, 10 Feb 2020 13:46:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18D2C2070A
	for <linux-ide@archiver.kernel.org>; Mon, 10 Feb 2020 13:46:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="nkCmb+Ti"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727742AbgBJNqp (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 10 Feb 2020 08:46:45 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:59995 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727632AbgBJNqp (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 10 Feb 2020 08:46:45 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20200210134643euoutp0241c080574cd59dd5f69f50bac4571f94~yDomxFj-V0841408414euoutp02J
        for <linux-ide@vger.kernel.org>; Mon, 10 Feb 2020 13:46:43 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20200210134643euoutp0241c080574cd59dd5f69f50bac4571f94~yDomxFj-V0841408414euoutp02J
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1581342403;
        bh=CGL4MlxF32i9jLjYTtUYtOfGTHztoG+Ydk5mBNDjRzQ=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=nkCmb+TiEppmiTZg22U41FJYQ3j3sihqkfZZ4MiSCbq6anF4xb1otYv74S74LWBrn
         ki30Amc/JlQDgKA8aCuEFmerbGHwsaEnfsyHqIFQJN2dkR56+7IjYbFUQeGGFg2jHB
         esN//gAGCEtmUzKxlEHilyWqQU9yjAQRIZkecGkQ=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200210134643eucas1p2c7290f163c26236d961d62bc04450422~yDommkOpZ3047630476eucas1p2c;
        Mon, 10 Feb 2020 13:46:43 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 4C.B9.60679.3CE514E5; Mon, 10
        Feb 2020 13:46:43 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200210134643eucas1p210ddf5e93df04da9ab6ee9ab760c71e1~yDomHV9z73048030480eucas1p2M;
        Mon, 10 Feb 2020 13:46:43 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200210134642eusmtrp26e01e51fadbb4b5f30cd73c5b37c0069~yDomGz86N2977729777eusmtrp28;
        Mon, 10 Feb 2020 13:46:42 +0000 (GMT)
X-AuditID: cbfec7f4-0e5ff7000001ed07-34-5e415ec39acf
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id D2.1C.07950.2CE514E5; Mon, 10
        Feb 2020 13:46:42 +0000 (GMT)
Received: from [106.120.51.71] (unknown [106.120.51.71]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200210134642eusmtip101c11320878f2c904aaa5f4ff88132bd~yDol3Irbx0269402694eusmtip1M;
        Mon, 10 Feb 2020 13:46:42 +0000 (GMT)
Subject: Re: [PATCH 18/46] libahci: drop DPRINTK() calls in reset
To:     Hannes Reinecke <hare@suse.de>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-ide@vger.kernel.org
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Message-ID: <201308e3-101e-82d4-6183-6b1b0fa55ea7@samsung.com>
Date:   Mon, 10 Feb 2020 14:46:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20200204165547.115220-19-hare@suse.de>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupileLIzCtJLcpLzFFi42LZduzned3DcY5xBmuXSlisvtvPZrFn0SQm
        i2M7HjE5MHtcPlvqsfl0tcfnTXIBzFFcNimpOZllqUX6dglcGW8mnGArWClY8eXfb6YGxke8
        XYycHBICJhInv8xi7WLk4hASWMEocb3pIzuE84VR4vvOv8wgVUICnxkl1hxghuk40XacCSK+
        nFFiyXYHiIa3jBJLu3aygySEBRwldrz7ywZiiwgoSXxsPwQWZxawlpi9eD1YM5uAlcTE9lWM
        IDavgJ3Ei7a1YAtYBFQlLl3uAesVFYiQ+PTgMCtEjaDEyZlPWEBsTqAjui5/ZYSYKS5x68l8
        JghbXmL72znMIAdJCDSzS7RN+McGcbWLxLz+l4wQtrDEq+Nb2CFsGYn/O0GaQRrWMUr87XgB
        1b2dUWL5ZJhua4k7534B2RxAKzQl1u/Shwg7SvxsfMAKEpYQ4JO48VYQ4gg+iUnbpjNDhHkl
        OtqEIKrVJDYs28AGs7Zr50rmCYxKs5C8NgvJO7OQvDMLYe8CRpZVjOKppcW56anFRnmp5XrF
        ibnFpXnpesn5uZsYgSnk9L/jX3Yw7vqTdIhRgINRiYe3ItAxTog1say4MvcQowQHs5IIr6U0
        UIg3JbGyKrUoP76oNCe1+BCjNAeLkjiv8aKXsUIC6YklqdmpqQWpRTBZJg5OqQbGSTfyG0pf
        p9zZnNxecobBT9rlRGFIt/ws8Ubn2ITrl113bmpe/qHPafFjlzuTFm6r3i+7LmfdV9nT82wm
        lXA+eXN3cvfnkgbDa1fbLYSv9G0z3SfgOzF2m+ScxHu2/b7czqEze1M8jKPd/hYeTXHKyVv1
        QUkzSuLQO1bV4p83qlbvVQrwXuauxFKckWioxVxUnAgA+HzRAR0DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprLIsWRmVeSWpSXmKPExsVy+t/xu7qH4hzjDF58NLdYfbefzWLPoklM
        Fsd2PGJyYPa4fLbUY/Ppao/Pm+QCmKP0bIryS0tSFTLyi0tslaINLYz0DC0t9IxMLPUMjc1j
        rYxMlfTtbFJSczLLUov07RL0Mt5MOMFWsFKw4su/30wNjI94uxg5OSQETCROtB1n6mLk4hAS
        WMoosaNnJ1sXIwdQQkbi+PoyiBphiT/Xutggal4zSpyYsZwVJCEs4Cix491fNhBbREBJ4mP7
        IXYQm1nAWmL24vVQQzcwSpx9eBGsiE3ASmJi+ypGEJtXwE7iRdtaZhCbRUBV4tLlHrAaUYEI
        icM7ZkHVCEqcnPmEBcTmBLq06/JXRogF6hJ/5l1ihrDFJW49mc8EYctLbH87h3kCo9AsJO2z
        kLTMQtIyC0nLAkaWVYwiqaXFuem5xUZ6xYm5xaV56XrJ+bmbGIFRs+3Yzy07GLveBR9iFOBg
        VOLhvRDsGCfEmlhWXJl7iFGCg1lJhNdSGijEm5JYWZValB9fVJqTWnyI0RTouYnMUqLJ+cCI
        ziuJNzQ1NLewNDQ3Njc2s1AS5+0QOBgjJJCeWJKanZpakFoE08fEwSnVwKi8/ebEHx+3/tSa
        ui+NZ/JRpxQuN4WDGjo7fvPMvbpOs/7qJMc7rDPrlygvvcVhwOpXPkNR4s47tdPfWHUEVF5s
        SdaT9z3evMklILF+9UWxAsvybhHdTRKmDzfUHjizpmyPA3+57PTb1sslLXKOyG1edP7ipaT3
        XM5VCVrb169JK7+zWWmvo4MSS3FGoqEWc1FxIgCIj1IJsAIAAA==
X-CMS-MailID: 20200210134643eucas1p210ddf5e93df04da9ab6ee9ab760c71e1
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200204165614eucas1p2e5d852483c0728f1d0a5a3063db03c88
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200204165614eucas1p2e5d852483c0728f1d0a5a3063db03c88
References: <20200204165547.115220-1-hare@suse.de>
        <CGME20200204165614eucas1p2e5d852483c0728f1d0a5a3063db03c88@eucas1p2.samsung.com>
        <20200204165547.115220-19-hare@suse.de>
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org


On 2/4/20 5:55 PM, Hannes Reinecke wrote:
> Reset is now logged with tracepoints, so the DPRINTK() calls can
> be dropped.
> 
> Signed-off-by: Hannes Reinecke <hare@suse.de>

Reviewed-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

> ---
>  drivers/ata/libahci.c | 10 ----------
>  1 file changed, 10 deletions(-)
> 
> diff --git a/drivers/ata/libahci.c b/drivers/ata/libahci.c
> index c1bc973ecc16..1c6d98fab3a3 100644
> --- a/drivers/ata/libahci.c
> +++ b/drivers/ata/libahci.c
> @@ -1391,8 +1391,6 @@ int ahci_do_softreset(struct ata_link *link, unsigned int *class,
>  	bool fbs_disabled = false;
>  	int rc;
>  
> -	DPRINTK("ENTER\n");
> -
>  	/* prepare for SRST (AHCI-1.1 10.4.1) */
>  	rc = ahci_kick_engine(ap);
>  	if (rc && rc != -EOPNOTSUPP)
> @@ -1452,7 +1450,6 @@ int ahci_do_softreset(struct ata_link *link, unsigned int *class,
>  	if (fbs_disabled)
>  		ahci_enable_fbs(ap);
>  
> -	DPRINTK("EXIT, class=%u\n", *class);
>  	return 0;
>  
>   fail:
> @@ -1474,8 +1471,6 @@ static int ahci_softreset(struct ata_link *link, unsigned int *class,
>  {
>  	int pmp = sata_srst_pmp(link);
>  
> -	DPRINTK("ENTER\n");
> -
>  	return ahci_do_softreset(link, class, pmp, deadline, ahci_check_ready);
>  }
>  EXPORT_SYMBOL_GPL(ahci_do_softreset);
> @@ -1505,8 +1500,6 @@ static int ahci_pmp_retry_softreset(struct ata_link *link, unsigned int *class,
>  	int rc;
>  	u32 irq_sts;
>  
> -	DPRINTK("ENTER\n");
> -
>  	rc = ahci_do_softreset(link, class, pmp, deadline,
>  			       ahci_bad_pmp_check_ready);
>  
> @@ -1540,8 +1533,6 @@ int ahci_do_hardreset(struct ata_link *link, unsigned int *class,
>  	struct ata_taskfile tf;
>  	int rc;
>  
> -	DPRINTK("ENTER\n");
> -
>  	hpriv->stop_engine(ap);
>  
>  	/* clear D2H reception area to properly wait for D2H FIS */
> @@ -1557,7 +1548,6 @@ int ahci_do_hardreset(struct ata_link *link, unsigned int *class,
>  	if (*online)
>  		*class = ahci_dev_classify(ap);
>  
> -	DPRINTK("EXIT, rc=%d, class=%u\n", rc, *class);
>  	return rc;
>  }
>  EXPORT_SYMBOL_GPL(ahci_do_hardreset);
> 
