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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91D37C3F2D7
	for <linux-ide@archiver.kernel.org>; Mon,  2 Mar 2020 17:40:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C99024673
	for <linux-ide@archiver.kernel.org>; Mon,  2 Mar 2020 17:40:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="lFVVNM8/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727054AbgCBRkj (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 2 Mar 2020 12:40:39 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:47742 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727181AbgCBRkj (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 2 Mar 2020 12:40:39 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20200302174038euoutp020513a67ab5cd9a5086598e119589e414~4jX079kuC1704417044euoutp02u
        for <linux-ide@vger.kernel.org>; Mon,  2 Mar 2020 17:40:38 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20200302174038euoutp020513a67ab5cd9a5086598e119589e414~4jX079kuC1704417044euoutp02u
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1583170838;
        bh=/JeCnPTjvGhxQwVJV6kSOuVMWcUPsKEU/+QF+f8xHFo=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=lFVVNM8/31jjflo/Vvgy2grweFwLsKRYQQh4CvAQiCFDXBKtC52uF6LzZBl/hRYux
         5b5aOg9Yzg8Ir0EIE9mNvag4AytxxB6u6rl3jjx5hsPm8KKQFv9QEkcOQLVf5Du8PZ
         aMfzNeBmcLvjGTVKlyFM/+hdLbrHSlVTLNViztIY=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200302174037eucas1p28caca2b74d920340aedabcb28cc5a29a~4jX0qnEch1308213082eucas1p2F;
        Mon,  2 Mar 2020 17:40:37 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 7D.1F.60698.5154D5E5; Mon,  2
        Mar 2020 17:40:37 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200302174037eucas1p2b24ff4a199d72b761d93b2c8c01d0107~4jX0UUdGB1308213082eucas1p2E;
        Mon,  2 Mar 2020 17:40:37 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200302174037eusmtrp17d123b77cfe4b024a4b19af3c69af758~4jX0OaktB0964309643eusmtrp1S;
        Mon,  2 Mar 2020 17:40:37 +0000 (GMT)
X-AuditID: cbfec7f5-a29ff7000001ed1a-1c-5e5d4515b2fb
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 3C.FA.08375.5154D5E5; Mon,  2
        Mar 2020 17:40:37 +0000 (GMT)
Received: from [106.120.51.71] (unknown [106.120.51.71]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200302174036eusmtip25f3486ef00d33d753e1d1c12933d8877~4jXz8cumX2312623126eusmtip2-;
        Mon,  2 Mar 2020 17:40:36 +0000 (GMT)
Subject: Re: [PATCH 20/42] pata_arasan_cf: use generic tracepoints
To:     Hannes Reinecke <hare@suse.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
        linux-ide@vger.kernel.org
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Message-ID: <433689b2-889d-1bd8-19bd-1edef33d7fbd@samsung.com>
Date:   Mon, 2 Mar 2020 18:40:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20200213095412.23773-21-hare@suse.de>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprMKsWRmVeSWpSXmKPExsWy7djP87qirrFxBqfvalisvtvPZrFn0SQm
        i2M7HjFZ/Fp+lNGBxePy2VKPTas62Tw2n672+LxJLoAlissmJTUnsyy1SN8ugSvjZvc59oIJ
        XBV/vr9ga2Bcz9HFyMkhIWAiMW/SbOYuRi4OIYEVjBLfj35kg3C+MErsaToK5XxmlNj9/hcz
        TMudt7NYIBLLGSX+b//LDuG8ZZT4fKGBtYuRg0NYwEmi530pSIOIgJLEx/ZD7CA2s0CExMYN
        a5lAbDYBK4mJ7asYQcp5BewkfrVqg4RZBFQkjvxZzwpiiwKVf3pwGMzmFRCUODnzCQtIOaeA
        scSTGxEQE8Ulbj2ZzwRhy0tsfzsH7BsJgX52iUetZ1kgbnaROLJtJzuELSzx6vgWKFtG4vTk
        HhaIhnWMEn87XkB1b2eUWD75HxtElbXEnXO/2EA2MwtoSqzfpQ8RdpTo3HyUCSQsIcAnceOt
        IMQRfBKTtk1nhgjzSnS0CUFUq0lsWLaBDWZt186VzBMYlWYh+WwWkndmIXlnFsLeBYwsqxjF
        U0uLc9NTi43zUsv1ihNzi0vz0vWS83M3MQKTyul/x7/uYNz3J+kQowAHoxIPbwBzbJwQa2JZ
        cWXuIUYJDmYlEV5fzug4Id6UxMqq1KL8+KLSnNTiQ4zSHCxK4rzGi17GCgmkJ5akZqemFqQW
        wWSZODilGhiP8T++bM/FMpEtTmr14cvrVG/X9e3ynHnBSUg5UvF0y3yrjS6mJ7bNymGYr1ym
        2fJu54d4mcUqdZvfnPTc9rmb+abp7QffYmyfzvG/syP6/mqZg1nL/ky1mDBh5ZG6wrDcTaXX
        GE1+G3lOWPrQx9frW1Opy9arU/4JaKms6I0/n8trx1p6fF+WEktxRqKhFnNRcSIAekUQTCYD
        AAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrMIsWRmVeSWpSXmKPExsVy+t/xe7qirrFxBl8ncVusvtvPZrFn0SQm
        i2M7HjFZ/Fp+lNGBxePy2VKPTas62Tw2n672+LxJLoAlSs+mKL+0JFUhI7+4xFYp2tDCSM/Q
        0kLPyMRSz9DYPNbKyFRJ384mJTUnsyy1SN8uQS/jZvc59oIJXBV/vr9ga2Bcz9HFyMkhIWAi
        ceftLBYQW0hgKaPEjm6FLkYOoLiMxPH1ZRAlwhJ/rnWxdTFyAZW8ZpS4OfcRI0iNsICTRM/7
        UpAaEQEliY/th9hBbGaBCInuV2eg6tcxSsxo+Ak2n03ASmJi+yqwXl4BO4lfrdogYRYBFYkj
        f9azgtiiQL2Hd8xiBLF5BQQlTs58wgJSzilgLPHkRgTEeHWJP/MuMUPY4hK3nsxngrDlJba/
        ncM8gVFoFpLuWUhaZiFpmYWkZQEjyypGkdTS4tz03GJDveLE3OLSvHS95PzcTYzACNp27Ofm
        HYyXNgYfYhTgYFTi4Q1gjo0TYk0sK67MPcQowcGsJMLryxkdJ8SbklhZlVqUH19UmpNafIjR
        FOi3icxSosn5wOjOK4k3NDU0t7A0NDc2NzazUBLn7RA4GCMkkJ5YkpqdmlqQWgTTx8TBKdXA
        GM/C93rPk9elX6ofzTKqWv7cIe/m1Ba2G0nvOEsKHtv/Vgj2fKr7+kyW7bmOp3I8p4R/GORe
        vPpZLIm7w+bBjg77OYKvnR4c6ZW0epWne7vz/W9Wb97M5c8rjzH6zjzSfjdH5eJ7O0WtT1GW
        DYsXNvvH7VjZ7HFpT9DUpscTjnTtC3q902TWTiWW4oxEQy3mouJEADWk+A62AgAA
X-CMS-MailID: 20200302174037eucas1p2b24ff4a199d72b761d93b2c8c01d0107
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200213095437eucas1p11c28a5642a52650e1c570593999339d2
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200213095437eucas1p11c28a5642a52650e1c570593999339d2
References: <20200213095412.23773-1-hare@suse.de>
        <CGME20200213095437eucas1p11c28a5642a52650e1c570593999339d2@eucas1p1.samsung.com>
        <20200213095412.23773-21-hare@suse.de>
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org


On 2/13/20 10:53 AM, Hannes Reinecke wrote:
> For completeness add generic tracepoints for bus-master DMA.
> 
> Signed-off-by: Hannes Reinecke <hare@suse.de>

Reviewed-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

> ---
>  drivers/ata/pata_arasan_cf.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/ata/pata_arasan_cf.c b/drivers/ata/pata_arasan_cf.c
> index e9cf31f38450..f066c47f8d6e 100644
> --- a/drivers/ata/pata_arasan_cf.c
> +++ b/drivers/ata/pata_arasan_cf.c
> @@ -39,6 +39,7 @@
>  #include <linux/spinlock.h>
>  #include <linux/types.h>
>  #include <linux/workqueue.h>
> +#include <trace/events/libata.h>
>  
>  #define DRIVER_NAME	"arasan_cf"
>  #define TIMEOUT		msecs_to_jiffies(3000)
> @@ -703,9 +704,11 @@ static unsigned int arasan_cf_qc_issue(struct ata_queued_cmd *qc)
>  	case ATA_PROT_DMA:
>  		WARN_ON_ONCE(qc->tf.flags & ATA_TFLAG_POLLING);
>  
> +		trace_ata_tf_load(ap, &qc->tf);
>  		ap->ops->sff_tf_load(ap, &qc->tf);
>  		acdev->dma_status = 0;
>  		acdev->qc = qc;
> +		trace_ata_bmdma_start(ap, &qc->tf, qc->tag)
>  		arasan_cf_dma_start(acdev);
>  		ap->hsm_task_state = HSM_ST_LAST;
>  		break;
> 
