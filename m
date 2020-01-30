Return-Path: <SRS0=S1Gt=3T=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B114C33C9E
	for <linux-ide@archiver.kernel.org>; Thu, 30 Jan 2020 11:56:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B66F2083E
	for <linux-ide@archiver.kernel.org>; Thu, 30 Jan 2020 11:56:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="a3w3eb8f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726873AbgA3L45 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 30 Jan 2020 06:56:57 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:39670 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727161AbgA3L45 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 30 Jan 2020 06:56:57 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20200130115656euoutp022dbee0f7a7d0fc91fbb84654a5965fb5~uqCnAvPaD0971009710euoutp02-
        for <linux-ide@vger.kernel.org>; Thu, 30 Jan 2020 11:56:56 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20200130115656euoutp022dbee0f7a7d0fc91fbb84654a5965fb5~uqCnAvPaD0971009710euoutp02-
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1580385416;
        bh=UQlZlpxnZnCen9+L4Vvn4fBEB4yk3oJgp3Hm0czj5Zk=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=a3w3eb8fgS5O5xqFhlOtFduTtrpl68UHc1OSrqUgD2RN1eqqFCDvW0kvlvV80qgsh
         jrY7ZL4NCt+YHTli0sOpBPmh3A7+Q0ZOJAmu468RVam31cOrBl4WNeoMfoJnfKqNth
         GxJbVzgC9TuV7wd3EsSKWduVgyNThnFbFh638Dq4=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200130115656eucas1p1e6fc4c404b2c194c57297e0d3f02f89e~uqCmzn-Z82969129691eucas1p1o;
        Thu, 30 Jan 2020 11:56:56 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 0C.C8.60679.884C23E5; Thu, 30
        Jan 2020 11:56:56 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200130115656eucas1p1b60418f3327a8204396ac00b29462337~uqCmmlMPd2000120001eucas1p1H;
        Thu, 30 Jan 2020 11:56:56 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200130115656eusmtrp28aceccccac19dac98e9459ed3a1a18e1~uqCmmCxoz3146231462eusmtrp2k;
        Thu, 30 Jan 2020 11:56:56 +0000 (GMT)
X-AuditID: cbfec7f4-0cbff7000001ed07-4c-5e32c488639a
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id B1.67.07950.784C23E5; Thu, 30
        Jan 2020 11:56:56 +0000 (GMT)
Received: from [106.120.51.71] (unknown [106.120.51.71]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200130115655eusmtip232964ef0ffdf5149d0d1abc24cede466~uqCmMQweB1780917809eusmtip21;
        Thu, 30 Jan 2020 11:56:55 +0000 (GMT)
Subject: Re: [PATCH 21/24] libata: remove DPRINTK() macro
To:     Hannes Reinecke <hare@suse.de>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-ide@vger.kernel.org,
        Hannes Reinecke <hare@suse.com>
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Message-ID: <81b5b0c6-1aee-6dd1-456d-52759e3c6d6c@samsung.com>
Date:   Thu, 30 Jan 2020 12:56:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20181213104716.31930-33-hare@suse.de>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprMKsWRmVeSWpSXmKPExsWy7djP87odR4ziDK72CVmsvtvPZrHgzV42
        iz2LJjFZHNvxiMmBxePy2VKP9VuusnhsPl3t8XmTXABLFJdNSmpOZllqkb5dAlfG/APiBb/Z
        K9Z8+sTewHiQrYuRk0NCwERi09k2IJuLQ0hgBaPE1Q1nwBJCAl8YJQ5/4oRIfGaUaOy+Cdcx
        99BUVojEckaJ291LodrfMkrce3SBHaRKWMBS4t2Fo2C2iICSxMf2Q2A2s0CcRNOVu2A2m4CV
        xMT2VYwgNq+AncSGteuZQWwWAVWJLf+3gm0TFYiQ+PTgMCtEjaDEyZlPWEBsTgFjiTdbdjJC
        zBSXuPVkPhOELS+x/e0cZpCDJAT62SX6T4IM5QByXCTm3bOG+EBY4tXxLewQtozE/50gvSD1
        6xgl/na8gGreziixfPI/qJ+tJe6c+8UGMohZQFNi/S59iLCjxImdV1gg5vNJ3HgrCHEDn8Sk
        bdOh1vJKdLQJQVSrSWxYtoENZm3XzpXMExiVZiH5bBaSb2Yh+WYWwt4FjCyrGMVTS4tz01OL
        jfJSy/WKE3OLS/PS9ZLzczcxApPK6X/Hv+xg3PUn6RCjAAejEg+vxgajOCHWxLLiytxDjBIc
        zEoivKKuhnFCvCmJlVWpRfnxRaU5qcWHGKU5WJTEeY0XvYwVEkhPLEnNTk0tSC2CyTJxcEo1
        MBaIbNGtTm5TzPdx/Tube37kuZPuLjl6vIcC526YWOx+7mHw5Q1+c599dqqRW3uuSoCzt0jn
        ubOMouKk4GW7k8qe/XE48sh19zdb8/X9f+LPbPygU7y99fflXaZSvh+aTzrmujPEJlkeWNFf
        dVopq+6w9pUQ7QstJ5m+srTdf/WWh5X1ovfWF0osxRmJhlrMRcWJADujtxEmAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrGIsWRmVeSWpSXmKPExsVy+t/xe7odR4ziDJYvZbRYfbefzWLBm71s
        FnsWTWKyOLbjEZMDi8fls6Ue67dcZfHYfLra4/MmuQCWKD2bovzSklSFjPziElulaEMLIz1D
        Sws9IxNLPUNj81grI1MlfTublNSczLLUIn27BL2M+QfEC36zV6z59Im9gfEgWxcjJ4eEgInE
        3ENTWbsYuTiEBJYySvSd3wzkcAAlZCSOry+DqBGW+HOtiw2i5jWjxLOW+8wgCWEBS4l3F46y
        g9giAkoSH9sPgdnMAnES//p2M0E0rGOUOP51JlgDm4CVxMT2VYwgNq+AncSGtevB4iwCqhJb
        /m8Fu0hUIELi8I5ZUDWCEidnPmEBsTkFjCXebNnJCLFAXeLPvEvMELa4xK0n85kgbHmJ7W/n
        ME9gFJqFpH0WkpZZSFpmIWlZwMiyilEktbQ4Nz232EivODG3uDQvXS85P3cTIzCOth37uWUH
        Y9e74EOMAhyMSjy8GhuM4oRYE8uKK3MPMUpwMCuJ8Iq6GsYJ8aYkVlalFuXHF5XmpBYfYjQF
        em4is5Rocj4wxvNK4g1NDc0tLA3Njc2NzSyUxHk7BA7GCAmkJ5akZqemFqQWwfQxcXBKNTB2
        RJjt1ii7OVs704yt+az8V0abpNQu5qLw47lb/uq1nfAxFYn9m2uUJ515/L/rw4dsrLeN7s8U
        SeA6cP9dTa5pd2H/1Rqp674KTXqyjItOxonX/9jx3OvWtfVauxVDfp1zaHHelvtDY/1rm9e3
        rMpOFr07e2nKiW0MSzW7QyckG22vsZxXuk6JpTgj0VCLuag4EQDViYNXuQIAAA==
X-CMS-MailID: 20200130115656eucas1p1b60418f3327a8204396ac00b29462337
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20181213104745epcas2p285b2e3d67650cbeee8298e30124ab9a4
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20181213104745epcas2p285b2e3d67650cbeee8298e30124ab9a4
References: <20181213104716.31930-1-hare@suse.de>
        <CGME20181213104745epcas2p285b2e3d67650cbeee8298e30124ab9a4@epcas2p2.samsung.com>
        <20181213104716.31930-33-hare@suse.de>
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org


On 12/13/18 11:47 AM, Hannes Reinecke wrote:
> No users left, remove it.
> 
> Signed-off-by: Hannes Reinecke <hare@suse.com>

Reviewed-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

> ---
>  include/linux/libata.h | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/include/linux/libata.h b/include/linux/libata.h
> index 808a96a8cb1d..cf62f3bdf4ef 100644
> --- a/include/linux/libata.h
> +++ b/include/linux/libata.h
> @@ -62,14 +62,12 @@
>  
>  /* note: prints function name for you */
>  #ifdef ATA_DEBUG
> -#define DPRINTK(fmt, args...) printk(KERN_ERR "%s: " fmt, __func__, ## args)
>  #ifdef ATA_VERBOSE_DEBUG
>  #define VPRINTK(fmt, args...) printk(KERN_ERR "%s: " fmt, __func__, ## args)
>  #else
>  #define VPRINTK(fmt, args...)
>  #endif	/* ATA_VERBOSE_DEBUG */
>  #else
> -#define DPRINTK(fmt, args...)
>  #define VPRINTK(fmt, args...)
>  #endif	/* ATA_DEBUG */
