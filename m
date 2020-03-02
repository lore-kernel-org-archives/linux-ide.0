Return-Path: <SRS0=3I3m=4T=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EA7DC3F2CD
	for <linux-ide@archiver.kernel.org>; Mon,  2 Mar 2020 18:29:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02A2A2467E
	for <linux-ide@archiver.kernel.org>; Mon,  2 Mar 2020 18:29:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="B7iXUe3+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727504AbgCBS3M (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 2 Mar 2020 13:29:12 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:35142 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727485AbgCBS3M (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 2 Mar 2020 13:29:12 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20200302182910euoutp0131b1e5602403d37fb7191fa3c1c6acd0~4kCNy_AvI0792307923euoutp01B
        for <linux-ide@vger.kernel.org>; Mon,  2 Mar 2020 18:29:10 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20200302182910euoutp0131b1e5602403d37fb7191fa3c1c6acd0~4kCNy_AvI0792307923euoutp01B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1583173750;
        bh=mNfDsr8htwKo43Xg8OIQpHmzW259hS51mPyyglSMYAw=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=B7iXUe3+rIHND3P8oRV0Rb7xY8SFv+EWM+tE115DdBSlM1fs+F/rlqj5+Z3VT/zjs
         qE/tVDK260Ztd4XSicn0lwnqUB7ZxYjc8Fftvdn6nxIjpmk2qKV1VEsCAjjCVeB72K
         e6sDQp5rJAbyphP6nfYLaWhs9n+2HgM2zHR07SjI=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200302182910eucas1p2a07d76193607812a6fe65d90497e3c81~4kCNciCSD0634706347eucas1p27;
        Mon,  2 Mar 2020 18:29:10 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id EF.31.60698.6705D5E5; Mon,  2
        Mar 2020 18:29:10 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200302182909eucas1p18e6583efda4ced605d1e94baf422f280~4kCM1NMya1926119261eucas1p1B;
        Mon,  2 Mar 2020 18:29:09 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200302182909eusmtrp207a5b4d19d5cdebdd3b52723ce7107e2~4kCMuwcGh0722007220eusmtrp2G;
        Mon,  2 Mar 2020 18:29:09 +0000 (GMT)
X-AuditID: cbfec7f5-a0fff7000001ed1a-aa-5e5d507684e4
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id AA.7C.07950.5705D5E5; Mon,  2
        Mar 2020 18:29:09 +0000 (GMT)
Received: from [106.120.51.71] (unknown [106.120.51.71]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200302182909eusmtip1387af1c879303d26f8c4b7736e8dd365~4kCMVKMbT0580505805eusmtip1b;
        Mon,  2 Mar 2020 18:29:09 +0000 (GMT)
Subject: Re: [PATCH 11/42] libata: sanitize ATA_HORKAGE_DUMP_ID
To:     Hannes Reinecke <hare@suse.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
        linux-ide@vger.kernel.org
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Message-ID: <e7cefa2c-554c-838f-d449-0ff8418ffcb7@samsung.com>
Date:   Mon, 2 Mar 2020 19:29:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20200213095412.23773-12-hare@suse.de>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprCKsWRmVeSWpSXmKPExsWy7djP87plAbFxBs/Py1usvtvPZrFn0SQm
        i2M7HjFZ/Fp+lNGBxePy2VKPTas62Tw2n672+LxJLoAlissmJTUnsyy1SN8ugSvj5Me17AXH
        uSouXG1gbGA8wdHFyMkhIWAicer9BdYuRi4OIYEVjBLz1t1jhHC+MEoc3XQCyvnMKHH42gpm
        mJZ/8+cxQSSWM0rMn3WZHcJ5yyixZckLNpAqYQF7ieObrzGB2CICShIf2w+xg9jMAhESGzes
        BYuzCVhJTGxfxQhi8wrYSZy50QpWwyKgItHVMgksLgpU/+nBYVaIGkGJkzOfsHQxcnBwChhL
        fH8rADFSXOLWk/lMELa8xPa3c6AO7WeX2PvUF8J2kbhwbAcLhC0s8er4FnYIW0bi/875YM9I
        CKxjlPjb8YIZwtnOKLF88j82iCpriTvnfrGBLGYW0JRYv0sfIuwo8XT9U7CwhACfxI23ghA3
        8ElM2jadGSLMK9HRJgRRrSaxYdkGNpi1XTtXMk9gVJqF5LFZSL6ZheSbWQh7FzCyrGIUTy0t
        zk1PLTbOSy3XK07MLS7NS9dLzs/dxAhMK6f/Hf+6g3Hfn6RDjAIcjEo8vAHMsXFCrIllxZW5
        hxglOJiVRHh9OaPjhHhTEiurUovy44tKc1KLDzFKc7AoifMaL3oZKySQnliSmp2aWpBaBJNl
        4uCUAqabGtkj3NncSqfbTy2e+rO5roRzpa1lyfpJiQ5v/NcsYGV82lSixnWLyazjTkC7pdYm
        ZxafC9P4hL+r5Zwzfnbt65zFjUIL//9IPyZuxHFEyX3Hnm+SunOYhG7tVLpafbtjtuS3w86b
        FXiWTt/4s3ix1ITFJ9y2hk7YFPl9h3p6qE7Nf/mIX1+UWIozEg21mIuKEwFAd5MzJwMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrGIsWRmVeSWpSXmKPExsVy+t/xu7qlAbFxBguna1usvtvPZrFn0SQm
        i2M7HjFZ/Fp+lNGBxePy2VKPTas62Tw2n672+LxJLoAlSs+mKL+0JFUhI7+4xFYp2tDCSM/Q
        0kLPyMRSz9DYPNbKyFRJ384mJTUnsyy1SN8uQS/j5Me17AXHuSouXG1gbGA8wdHFyMkhIWAi
        8W/+PKYuRi4OIYGljBKbJ58BcjiAEjISx9eXQdQIS/y51sUGUfOaUaJpzwlmkISwgL3E8c3X
        mEBsEQEliY/th9hBbGaBCInuV2egGtYxSvxp38QCkmATsJKY2L6KEcTmFbCTOHOjFayBRUBF
        oqtlElhcFKj58I5ZUDWCEidnPmEBOYhTwFji+1sBiPnqEn/mXWKGsMUlbj2ZzwRhy0tsfzuH
        eQKj0Cwk3bOQtMxC0jILScsCRpZVjCKppcW56bnFRnrFibnFpXnpesn5uZsYgXG07djPLTsY
        u94FH2IU4GBU4uH9wRAbJ8SaWFZcmXuIUYKDWUmE15czOk6INyWxsiq1KD++qDQntfgQoynQ
        bxOZpUST84ExnlcSb2hqaG5haWhubG5sZqEkztshcDBGSCA9sSQ1OzW1ILUIpo+Jg1OqgXHO
        1N0nl/J092ks81i6OXjP7uxin2WBTeIXrb/f/XjiKIvjlt///mq/eHCL85WOrC/T81VKc9sk
        RAI0lt6uXbrLYurOtgMlJYLfV3N2fBezVww8rLdb6lyunzlL41PdPxO7C4W/f5Q0S9jnttfq
        DXfXymDn5Fmfr+7tiPp16Zv35Kef5QIs/pgpsRRnJBpqMRcVJwIAOwBcV7kCAAA=
X-CMS-MailID: 20200302182909eucas1p18e6583efda4ced605d1e94baf422f280
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200213095434eucas1p1cc0d0985170f83430c8a614e2b71956e
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200213095434eucas1p1cc0d0985170f83430c8a614e2b71956e
References: <20200213095412.23773-1-hare@suse.de>
        <CGME20200213095434eucas1p1cc0d0985170f83430c8a614e2b71956e@eucas1p1.samsung.com>
        <20200213095412.23773-12-hare@suse.de>
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org


On 2/13/20 10:53 AM, Hannes Reinecke wrote:
> As ata_dev_dbg() is now using dynamic debugging ATA_HORKAGE_DUMP_ID
> will now print out the raw IDENTIFY data without a header unless
> explicitly enable via dyndebug.
> So move the logging level up to INFO and have the header printed
> always.
> 
> Signed-off-by: Hannes Reinecke <hare@suse.de>

Reviewed-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

> ---
>  drivers/ata/libata-core.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
> index 1987886140b6..40e327e49905 100644
> --- a/drivers/ata/libata-core.c
> +++ b/drivers/ata/libata-core.c
> @@ -1944,10 +1944,10 @@ int ata_dev_read_id(struct ata_device *dev, unsigned int *p_class,
>  	}
>  
>  	if (dev->horkage & ATA_HORKAGE_DUMP_ID) {
> -		ata_dev_dbg(dev, "dumping IDENTIFY data, "
> +		ata_dev_info(dev, "dumping IDENTIFY data, "
>  			    "class=%d may_fallback=%d tried_spinup=%d\n",
>  			    class, may_fallback, tried_spinup);
> -		print_hex_dump(KERN_DEBUG, "", DUMP_PREFIX_OFFSET,
> +		print_hex_dump(KERN_INFO, "", DUMP_PREFIX_OFFSET,
>  			       16, 2, id, ATA_ID_WORDS * sizeof(*id), true);
>  	}
>  
> 
