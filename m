Return-Path: <SRS0=vLfT=36=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 632AEC352A3
	for <linux-ide@archiver.kernel.org>; Mon, 10 Feb 2020 16:50:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35C5120733
	for <linux-ide@archiver.kernel.org>; Mon, 10 Feb 2020 16:50:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="RGLFzFpR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727530AbgBJQub (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 10 Feb 2020 11:50:31 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:44131 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727003AbgBJQua (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 10 Feb 2020 11:50:30 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20200210165029euoutp02b96ff32938e1848cb20e541bdced5a8c~yGJDZqgnR3151231512euoutp02M
        for <linux-ide@vger.kernel.org>; Mon, 10 Feb 2020 16:50:29 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20200210165029euoutp02b96ff32938e1848cb20e541bdced5a8c~yGJDZqgnR3151231512euoutp02M
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1581353429;
        bh=IRHmfqzebPKNA8k3U+05QtTXvLIzXpMS0bfIeYXryms=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=RGLFzFpRvlboZscEvS60RjBJyp3Z/sN0luvcOOcTE9IR8ulvDBGbBdTZsxfbcY/GI
         HNPq/K41cF8K0xU6p9KJjnXyuGt1VqeTmK+2BvT6eDRdEXBTixhMqS1mF4Rx3/p/tA
         G3K93B8NaPgwxKqmuZ+0g2b8bXvcdwh7FXwU0zmg=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200210165029eucas1p22af70af52b5fa60577c53b07a8588d57~yGJDTZOEY0729807298eucas1p2V;
        Mon, 10 Feb 2020 16:50:29 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 8C.9C.60698.5D9814E5; Mon, 10
        Feb 2020 16:50:29 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200210165028eucas1p2023f3fd8fad917cfd90933ebffb1ed0c~yGJC2ByL52125321253eucas1p2W;
        Mon, 10 Feb 2020 16:50:28 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200210165028eusmtrp2c605f7a732190e284cc15a610cf89562~yGJC1c8Jn0051100511eusmtrp2u;
        Mon, 10 Feb 2020 16:50:28 +0000 (GMT)
X-AuditID: cbfec7f5-a29ff7000001ed1a-87-5e4189d53af8
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 87.55.07950.4D9814E5; Mon, 10
        Feb 2020 16:50:28 +0000 (GMT)
Received: from [106.120.51.71] (unknown [106.120.51.71]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200210165028eusmtip25ee3553f5521b0b6cf4a83b3d6476e8b~yGJCStXlT0812608126eusmtip2d;
        Mon, 10 Feb 2020 16:50:28 +0000 (GMT)
Subject: Re: [PATCH 45/46] libata: remove references to ATA_DEBUG
To:     Hannes Reinecke <hare@suse.de>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-ide@vger.kernel.org
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Message-ID: <e897abaa-4d67-5c37-1775-bb1d2b034c95@samsung.com>
Date:   Mon, 10 Feb 2020 17:50:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20200204165547.115220-46-hare@suse.de>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupileLIzCtJLcpLzFFi42LZduzned2rnY5xBs93iFisvtvPZrFn0SQm
        i2M7HjE5MHtcPlvqsfl0tcfnTXIBzFFcNimpOZllqUX6dglcGdd6wwv6+Ss+btrN1sA4m6eL
        kZNDQsBE4vi1p4xdjFwcQgIrGCWW/LrEBOF8YZT4umIuVOYzo8S6rd+Zuxg5wFrW39SBiC9n
        lGj+upcdwnnLKHG87yILyFxhAUeJY+emgNkiAkoSH9sPsYPYzALWErMXr2cCsdkErCQmtq9i
        BLF5Bewk/rzZzQxiswioSmx79wfMFhWIkPj04DArRI2gxMmZT8BmcgId8fr2dBaImeISt57M
        Z4Kw5SW2v53DDHKQhMB/Nol5i16yQjzqIvHobQ87hC0s8er4FihbRuL/zvlMEA3rGCX+dryA
        6t7OKLF88j82iCpriTvnfrGB/M8soCmxfpc+RNhRYv+2q4yQYOGTuPFWEOIIPolJ26ZDQ4tX
        oqNNCKJaTWLDsg1sMGu7dq5knsCoNAvJa7OQvDMLyTuzEPYuYGRZxSieWlqcm55abJyXWq5X
        nJhbXJqXrpecn7uJEZhCTv87/nUH474/SYcYBTgYlXh4LwQ7xgmxJpYVV+YeYpTgYFYS4bWU
        BgrxpiRWVqUW5ccXleakFh9ilOZgURLnNV70MlZIID2xJDU7NbUgtQgmy8TBKdXAmP7r6Mbq
        f9mbJ1068E9LTKKA91rHYZfGOXsXLNxtdOzi+ROVObdWC9nu/fqlSaQ+5Uh7K2N9iO+XrVkl
        rq7HVmtu/Xnc/vSG8ndWxgd1Drkb5onwu38o1W7pE/m0Jcpo14yK29oSFzMPv507zb42dr5z
        YMdtlYaX3lFb5025szYi2Lz+36dkKSWW4oxEQy3mouJEAO5iZvMdAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprNIsWRmVeSWpSXmKPExsVy+t/xe7pXOh3jDA60mVisvtvPZrFn0SQm
        i2M7HjE5MHtcPlvqsfl0tcfnTXIBzFF6NkX5pSWpChn5xSW2StGGFkZ6hpYWekYmlnqGxuax
        VkamSvp2NimpOZllqUX6dgl6Gdd6wwv6+Ss+btrN1sA4m6eLkYNDQsBEYv1NnS5GLg4hgaWM
        EnfeTGOHiMtIHF9f1sXICWQKS/y51sUGUfOaUWL+u+mMIAlhAUeJY+emsIDYIgJKEh/bD7GD
        2MwC1hKzF69ngmjYwCjx7NtiJpAEm4CVxMT2VWDNvAJ2En/e7GYGsVkEVCW2vfsDZosKREgc
        3jELqkZQ4uTMJ2ALOIEOfX17OgvEAnWJP/MuMUPY4hK3nsxngrDlJba/ncM8gVFoFpL2WUha
        ZiFpmYWkZQEjyypGkdTS4tz03GIjveLE3OLSvHS95PzcTYzAiNl27OeWHYxd74IPMQpwMCrx
        8F4IdowTYk0sK67MPcQowcGsJMJrKQ0U4k1JrKxKLcqPLyrNSS0+xGgK9NxEZinR5HxgNOeV
        xBuaGppbWBqaG5sbm1koifN2CByMERJITyxJzU5NLUgtgulj4uCUamD0ihBT0e/K1j00ew6T
        u8/BS7ee+uVMS34vuPKQXJhv7uFDArIzw/+wWBiKaaVfjDj8zJulTaOD33vF4+mWl+yee+fa
        zFr6d73GnM21O2ey8jW9Xa33r2GjUY3UxxOxkmcL57YvEFL7xjxNes+cjVxTTEriavN4rm+b
        Kut04mRi+6HJk/gud3MrsRRnJBpqMRcVJwIARG+W7q4CAAA=
X-CMS-MailID: 20200210165028eucas1p2023f3fd8fad917cfd90933ebffb1ed0c
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200204165617eucas1p264b8a6c0b9ff47ac5c64ee5f1c242039
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200204165617eucas1p264b8a6c0b9ff47ac5c64ee5f1c242039
References: <20200204165547.115220-1-hare@suse.de>
        <CGME20200204165617eucas1p264b8a6c0b9ff47ac5c64ee5f1c242039@eucas1p2.samsung.com>
        <20200204165547.115220-46-hare@suse.de>
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org


On 2/4/20 5:55 PM, Hannes Reinecke wrote:
> All instances are gone.
> 
> Signed-off-by: Hannes Reinecke <hare@suse.de>

Reviewed-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

> ---
>  drivers/ata/libata-core.c | 2 --
>  include/linux/libata.h    | 5 -----
>  2 files changed, 7 deletions(-)
> 
> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
> index 0f1682a55b54..9c05177e09c2 100644
> --- a/drivers/ata/libata-core.c
> +++ b/drivers/ata/libata-core.c
> @@ -6034,8 +6034,6 @@ struct ata_port *ata_port_alloc(struct ata_host *host)
>  #if defined(ATA_VERBOSE_DEBUG)
>  	/* turn on all debugging levels */
>  	ap->msg_enable = 0x00FF;
> -#elif defined(ATA_DEBUG)
> -	ap->msg_enable = ATA_MSG_DRV | ATA_MSG_WARN | ATA_MSG_ERR;
>  #else
>  	ap->msg_enable = ATA_MSG_DRV | ATA_MSG_ERR | ATA_MSG_WARN;
>  #endif
> diff --git a/include/linux/libata.h b/include/linux/libata.h
> index 1012aed05187..06d6a3e18e18 100644
> --- a/include/linux/libata.h
> +++ b/include/linux/libata.h
> @@ -38,22 +38,17 @@
>   * compile-time options: to be removed as soon as all the drivers are
>   * converted to the new debugging mechanism
>   */
> -#undef ATA_DEBUG		/* debugging output */
>  #undef ATA_VERBOSE_DEBUG	/* yet more debugging output */
>  #undef ATA_IRQ_TRAP		/* define to ack screaming irqs */
>  #undef ATA_NDEBUG		/* define to disable quick runtime checks */
>  
>  
>  /* note: prints function name for you */
> -#ifdef ATA_DEBUG
>  #ifdef ATA_VERBOSE_DEBUG
>  #define VPRINTK(fmt, args...) printk(KERN_ERR "%s: " fmt, __func__, ## args)
>  #else
>  #define VPRINTK(fmt, args...)
>  #endif	/* ATA_VERBOSE_DEBUG */
> -#else
> -#define VPRINTK(fmt, args...)
> -#endif	/* ATA_DEBUG */
>  
>  #define ata_print_version_once(dev, version)			\
>  ({								\
> 
