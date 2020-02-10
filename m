Return-Path: <SRS0=vLfT=36=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC8A2C352A3
	for <linux-ide@archiver.kernel.org>; Mon, 10 Feb 2020 13:46:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1D182070A
	for <linux-ide@archiver.kernel.org>; Mon, 10 Feb 2020 13:46:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="LMEhWltA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727655AbgBJNqG (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 10 Feb 2020 08:46:06 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:42381 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727417AbgBJNqG (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 10 Feb 2020 08:46:06 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20200210134604euoutp01ced1b94ca0d56d2a913d430a72713c25~yDoCqBJ_K0697806978euoutp01f
        for <linux-ide@vger.kernel.org>; Mon, 10 Feb 2020 13:46:04 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20200210134604euoutp01ced1b94ca0d56d2a913d430a72713c25~yDoCqBJ_K0697806978euoutp01f
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1581342364;
        bh=bb2gjtBwfSKpGm94wNzsfW77Eqr/OMVD9yPRKUlBshA=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=LMEhWltA0Nr3PQ8AvD9aVY42I5PrcYpvgrD2jKFCqGZXiFK6jgt4OR0APbWRxTVMQ
         DgMSQE2OGYmkXt4yUybkTFQ2QuOiyvCcTCjso3k5Q+9TaLXOnifKn8dAfZi6LTTOec
         F7EzXcOuT3ogSr1OIVph2MheRXhbNriX+98rT3yU=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200210134604eucas1p1fbc9cc0fdd8937920d543e7bccbfc032~yDoCjSDQv3099330993eucas1p1b;
        Mon, 10 Feb 2020 13:46:04 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 5E.FD.61286.C9E514E5; Mon, 10
        Feb 2020 13:46:04 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200210134604eucas1p118d16312fda48cd23fa5567a04ad8cb1~yDoB9xAC80056900569eucas1p1Q;
        Mon, 10 Feb 2020 13:46:04 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200210134604eusmtrp1447076afd9d4269a3ff6eaa2f5cf31d1~yDoB9KMDj1866318663eusmtrp1f;
        Mon, 10 Feb 2020 13:46:04 +0000 (GMT)
X-AuditID: cbfec7f2-f0bff7000001ef66-e5-5e415e9c5f7d
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id B8.BF.08375.C9E514E5; Mon, 10
        Feb 2020 13:46:04 +0000 (GMT)
Received: from [106.120.51.71] (unknown [106.120.51.71]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200210134603eusmtip23e0b93c66729e67981f193690b888a64~yDoBvaQcr3129231292eusmtip2k;
        Mon, 10 Feb 2020 13:46:03 +0000 (GMT)
Subject: Re: [PATCH 17/46] pata_octeon_cf: drop DPRINTK() calls in reset
To:     Hannes Reinecke <hare@suse.de>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-ide@vger.kernel.org
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Message-ID: <4299bc4c-50a1-7fbe-92d1-083f709b8ba6@samsung.com>
Date:   Mon, 10 Feb 2020 14:46:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20200204165547.115220-18-hare@suse.de>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupmleLIzCtJLcpLzFFi42LZduzned05cY5xBhtmqVmsvtvPZrFn0SQm
        i2M7HjE5MHtcPlvqsfl0tcfnTXIBzFFcNimpOZllqUX6dglcGdPvLGAreMRZ0Xq5ibmBsZGj
        i5GTQ0LARGJz+xU2EFtIYAWjxO5bxV2MXED2F0aJmQvOs0I4nxkltl47wAbTcWfNEiaIxHJG
        ic2bz7NBOG8ZJa7sfswKUiUs4CHxc8cUZhBbREBJ4mP7IXYQm1nAWmL24vVMIDabgJXExPZV
        jCA2r4CdxKzVjWA1LAKqEpsXzAOLiwpESHx6cJgVokZQ4uTMJywgNifQFe8XX2WCmCkucevJ
        fChbXmL72znMIAdJCDSzS6xa2swKcbaLxMt/u1ggbGGJV8e3sEPYMhKnJ/ewQDSsY5T42/EC
        qns7o8Tyyf+gnraWuHPuF5DNAbRCU2L9Ln2IsKPE6YZ3jCBhCQE+iRtvBSGO4JOYtG06M0SY
        V6KjTQiiWk1iw7INbDBru3auZJ7AqDQLyWuzkLwzC8k7sxD2LmBkWcUonlpanJueWmyYl1qu
        V5yYW1yal66XnJ+7iRGYRE7/O/5pB+PXS0mHGAU4GJV4eCsCHeOEWBPLiitzDzFKcDArifBa
        SgOFeFMSK6tSi/Lji0pzUosPMUpzsCiJ8xovehkrJJCeWJKanZpakFoEk2Xi4JRqYOy+/N71
        x+fDVXE//rjPsLz35UC45MxgDatv0y48PK3Zr7M5N3ZCOV+d+yehw31WOmcki14/+3SARYWN
        UUrtjf3vtraTyqsTtr+cf9aoomPFyYbEj6efWLT2Wrbe6El+vOVw+Kz6W12mKfMrWLvXFemn
        H0nJrp6/8NX+e3eXr9E/FJNTbf/t8DslluKMREMt5qLiRACVtOSpHgMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprDIsWRmVeSWpSXmKPExsVy+t/xe7pz4hzjDF4u4rBYfbefzWLPoklM
        Fsd2PGJyYPa4fLbUY/Ppao/Pm+QCmKP0bIryS0tSFTLyi0tslaINLYz0DC0t9IxMLPUMjc1j
        rYxMlfTtbFJSczLLUov07RL0MqbfWcBW8IizovVyE3MDYyNHFyMnh4SAicSdNUuYuhi5OIQE
        ljJK7Oldw9jFyAGUkJE4vr4MokZY4s+1LjaImteMEq1dj1lBEsICHhI/d0xhBrFFBJQkPrYf
        YgexmQWsJWYvXs8EYgsJbGCU+PuNE8RmE7CSmNi+ihHE5hWwk5i1uhGsnkVAVWLzgnlgcVGB
        CInDO2ZB1QhKnJz5hAXE5gQ69P3iq0wQ89Ul/sy7xAxhi0vcejIfKi4vsf3tHOYJjEKzkLTP
        QtIyC0nLLCQtCxhZVjGKpJYW56bnFhvqFSfmFpfmpesl5+duYgTGzLZjPzfvYLy0MfgQowAH
        oxIPb0WgY5wQa2JZcWXuIUYJDmYlEV5LaaAQb0piZVVqUX58UWlOavEhRlOg5yYyS4km5wPj
        Oa8k3tDU0NzC0tDc2NzYzEJJnLdD4GCMkEB6YklqdmpqQWoRTB8TB6dUA2Ps1bN/bFp0LDm+
        Khhe2iI+1e5E5JZztWdP7pn4JLms5pcK6z6e9ctLZhUJNvgkfMm/+dTFzuxI+CeX7ytfHMww
        +3zuzJxWe+NXy17tb7f341wpKLjmQo/Hydvbq37/uzNXWOLEhfkv5ggkts89G2X10aArObXm
        gLnpfNfF07gksu6nvXpesqROiaU4I9FQi7moOBEAh5/qiq8CAAA=
X-CMS-MailID: 20200210134604eucas1p118d16312fda48cd23fa5567a04ad8cb1
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200204165615eucas1p189dc18c2faea6b0ea041784bdcd8d512
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200204165615eucas1p189dc18c2faea6b0ea041784bdcd8d512
References: <20200204165547.115220-1-hare@suse.de>
        <CGME20200204165615eucas1p189dc18c2faea6b0ea041784bdcd8d512@eucas1p1.samsung.com>
        <20200204165547.115220-18-hare@suse.de>
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
>  drivers/ata/pata_octeon_cf.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/ata/pata_octeon_cf.c b/drivers/ata/pata_octeon_cf.c
> index d3d851b014a3..f5cd89173028 100644
> --- a/drivers/ata/pata_octeon_cf.c
> +++ b/drivers/ata/pata_octeon_cf.c
> @@ -440,7 +440,6 @@ static int octeon_cf_softreset16(struct ata_link *link, unsigned int *classes,
>  	int rc;
>  	u8 err;
>  
> -	DPRINTK("about to softreset\n");
>  	__raw_writew(ap->ctl, base + 0xe);
>  	udelay(20);
>  	__raw_writew(ap->ctl | ATA_SRST, base + 0xe);
> @@ -455,7 +454,6 @@ static int octeon_cf_softreset16(struct ata_link *link, unsigned int *classes,
>  
>  	/* determine by signature whether we have ATA or ATAPI devices */
>  	classes[0] = ata_sff_dev_classify(&link->device[0], 1, &err);
> -	DPRINTK("EXIT, classes[0]=%u [1]=%u\n", classes[0], classes[1]);
>  	return 0;
>  }
>  
