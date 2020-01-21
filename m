Return-Path: <SRS0=H5qQ=3K=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA535C2D0DB
	for <linux-ide@archiver.kernel.org>; Tue, 21 Jan 2020 14:13:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45008217F4
	for <linux-ide@archiver.kernel.org>; Tue, 21 Jan 2020 14:13:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="XUOHNu0z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727059AbgAUONf (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 21 Jan 2020 09:13:35 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:43815 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729099AbgAUONe (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 21 Jan 2020 09:13:34 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20200121141332euoutp011f171842c43f280136fac4b75314c938~r7GTlHyqP2336323363euoutp01C
        for <linux-ide@vger.kernel.org>; Tue, 21 Jan 2020 14:13:32 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20200121141332euoutp011f171842c43f280136fac4b75314c938~r7GTlHyqP2336323363euoutp01C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1579616012;
        bh=+EvKtpTqmNbHn33i7Qi9qNYwtu6kDebAwLra/T7Ck7M=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=XUOHNu0zEMzqzLAMQ9vUof5LB0V3ZesHz3CZY7c/BI1/rXWkPZDyvcUnx8y87MWer
         R4voGZmOSmt5DhIWIVqHOnjMCBCh08fvf3fhPgx5O/2YT0pleh3S3Ix1MGjMBZCZ/f
         pIC5C9fKTkzpeX0LJo2fOAdUx4lC20gKRa7Uo/ZQ=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200121141332eucas1p11ab0748a80f4707be61c9ace0b5f74de~r7GTd6xXN0617606176eucas1p1l;
        Tue, 21 Jan 2020 14:13:32 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 0E.6A.60679.C07072E5; Tue, 21
        Jan 2020 14:13:32 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200121141332eucas1p2b8f726efe1de5e88dd9ea702a40af47e~r7GTM6clB1405414054eucas1p2e;
        Tue, 21 Jan 2020 14:13:32 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200121141331eusmtrp121b301c058dd1c3ee9cab7deba144b54~r7GTMUPXG3216032160eusmtrp10;
        Tue, 21 Jan 2020 14:13:31 +0000 (GMT)
X-AuditID: cbfec7f4-0e5ff7000001ed07-23-5e27070c81ca
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 6B.F2.08375.B07072E5; Tue, 21
        Jan 2020 14:13:31 +0000 (GMT)
Received: from [106.120.51.71] (unknown [106.120.51.71]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200121141331eusmtip20fcad005a5f142bcfca5422f1b6488a1~r7GS1YKPM1574215742eusmtip2_;
        Tue, 21 Jan 2020 14:13:31 +0000 (GMT)
Subject: Re: [PATCH] ide: make drive->dn read only
To:     Dan Carpenter <dan.carpenter@oracle.com>,
        "David S. Miller" <davem@davemloft.net>
Cc:     linux-ide@vger.kernel.org, kernel-janitors@vger.kernel.org
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Message-ID: <beada2e3-29bd-2165-b6d7-d28a8c83060e@samsung.com>
Date:   Tue, 21 Jan 2020 15:13:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20200121125942.hkr3zg77i5gtgc7v@kili.mountain>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprIKsWRmVeSWpSXmKPExsWy7djP87o87OpxBtPnCVi8/jedxWLO+RYW
        i623pC2O7XjE5MDisWXlTSaPj09vsXh83iQXwBzFZZOSmpNZllqkb5fAlfH//1eWguUCFfv+
        fGVuYLzM28XIySEhYCLx/8Y21i5GLg4hgRWMElMOfGSHcL4wSsy7tYUNwvnMKHFt/wM2mJY9
        1z8yQySWM0o0L3vFCOG8ZZRYv38WM0iVsICRxO8lb1hBbBGBcIlZK5eCdTML2EnsufUKLM4m
        YCUxsX0VUDMHBy9Q/PdGa5Awi4CqxPr5l1lAbFGBCIlPDw6DlfMKCEqcnPkELM4pYCMx8/4c
        qJHiEreezGeCsOUltr+dA3achEA/u8TNTeuhrnaRuLpnGQuELSzx6vgWdghbRuL05B4WiIZ1
        jBJ/O15AdW9nlFg++R9Ut7XEnXO/2EAuZRbQlFi/Sx8i7Cjxte0+K0hYQoBP4sZbQYgj+CQm
        bZvODBHmlehoE4KoVpPYsGwDG8zarp0rmScwKs1C8tosJO/MQvLOLIS9CxhZVjGKp5YW56an
        FhvlpZbrFSfmFpfmpesl5+duYgQmlNP/jn/ZwbjrT9IhRgEORiUe3oynanFCrIllxZW5hxgl
        OJiVRHgXNKnGCfGmJFZWpRblxxeV5qQWH2KU5mBREuc1XvQyVkggPbEkNTs1tSC1CCbLxMEp
        1cAYy/9nz6zZXxpuZBppZdk8U9mdMjdksc2TxjeXWmZWBgrcWRFt9mSZ4OXFL89l3WR6WeY4
        idduok+jS+HOx8WZ03itnVbqJibMWr3Wbml31LoWvc7/T35F8Ggq7FWZyl93bt+BF7lXIpYv
        +/XF+ay10oc3jAdE5zF844tbefR8hfhRoZ2vroj9VWIpzkg01GIuKk4EAPf7wNgkAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrIIsWRmVeSWpSXmKPExsVy+t/xe7rc7OpxBsvnWVi8/jedxWLO+RYW
        i623pC2O7XjE5MDisWXlTSaPj09vsXh83iQXwBylZ1OUX1qSqpCRX1xiqxRtaGGkZ2hpoWdk
        YqlnaGwea2VkqqRvZ5OSmpNZllqkb5egl/H//1eWguUCFfv+fGVuYLzM28XIySEhYCKx5/pH
        5i5GLg4hgaWMEjNbP7F3MXIAJWQkjq8vg6gRlvhzrYsNouY1o0Tznm8sIAlhASOJ30vesILU
        iwiES+xcYQoSZhawk9hz6xUrRH0/o8SD5jYmkASbgJXExPZVjCD1vEBFvzdag4RZBFQl1s+/
        DDZSVCBC4vCOWYwgNq+AoMTJmU/A4pwCNhIz789hg5ivLvFn3iVmCFtc4taT+UwQtrzE9rdz
        mCcwCs1C0j4LScssJC2zkLQsYGRZxSiSWlqcm55bbKhXnJhbXJqXrpecn7uJERg924793LyD
        8dLG4EOMAhyMSjy8GU/V4oRYE8uKK3MPMUpwMCuJ8C5oUo0T4k1JrKxKLcqPLyrNSS0+xGgK
        9NxEZinR5HxgZOeVxBuaGppbWBqaG5sbm1koifN2CByMERJITyxJzU5NLUgtgulj4uCUamDM
        ULbcy/b4buXXyZ32+SEp918mHpPSW22s/fbI468c8dGRp17lHLDPEJ4pM/3lxu91HDdWTw07
        I2c6tUC/4Z343S3Fpb3Ka9fu8Vbc4b+usqLIRC5hS2L56aqFNm0RjZ+ims81bHu5THDaZIc5
        bJXNbxi35J858e79sWsbX4Yee3Qg8nBkwaX1SizFGYmGWsxFxYkAHHpO4LQCAAA=
X-CMS-MailID: 20200121141332eucas1p2b8f726efe1de5e88dd9ea702a40af47e
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200121130719eucas1p15e8bc52b9167b48a1eb7be191ef103f5
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200121130719eucas1p15e8bc52b9167b48a1eb7be191ef103f5
References: <CGME20200121130719eucas1p15e8bc52b9167b48a1eb7be191ef103f5@eucas1p1.samsung.com>
        <20200121125942.hkr3zg77i5gtgc7v@kili.mountain>
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org


On 1/21/20 2:06 PM, Dan Carpenter wrote:
> The IDE core always sets ->dn correctly so changing it is never
> required.
> 
> Setting it to a different value than assigned by IDE core is very likely
> to result in data corruption (due to wrong transfer timings being set on
> the controller etc.)
> 
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Thanks, it looks fine (though patch summary can be improved further i.e.:
"[PATCH] ide-proc: make "number" setting read-only").

Acked-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

I've also verified it (using ARAnyM emulator):

Tested-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

> ---
> 
>  include/linux/ide.h    | 4 ++++
>  drivers/ide/ide-proc.c | 2 +-
>  2 files changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/ide.h b/include/linux/ide.h
> index 06dae6438557..a254841bd315 100644
> --- a/include/linux/ide.h
> +++ b/include/linux/ide.h
> @@ -945,6 +945,10 @@ ide_devset_get(_name, _field); \
>  ide_devset_set(_name, _field); \
>  IDE_DEVSET(_name, DS_SYNC, get_##_name, set_##_name)
>  
> +#define ide_devset_ro_field(_name, _field) \
> +ide_devset_get(_name, _field); \
> +IDE_DEVSET(_name, 0, get_##_name, NULL)
> +
>  #define ide_devset_rw_flag(_name, _field) \
>  ide_devset_get_flag(_name, _field); \
>  ide_devset_set_flag(_name, _field); \
> diff --git a/drivers/ide/ide-proc.c b/drivers/ide/ide-proc.c
> index 11a801aa92d8..15c17f3781ee 100644
> --- a/drivers/ide/ide-proc.c
> +++ b/drivers/ide/ide-proc.c
> @@ -206,7 +206,7 @@ static int set_xfer_rate (ide_drive_t *drive, int arg)
>  ide_devset_rw(current_speed, xfer_rate);
>  ide_devset_rw_field(init_speed, init_speed);
>  ide_devset_rw_flag(nice1, IDE_DFLAG_NICE1);
> -ide_devset_rw_field(number, dn);
> +ide_devset_ro_field(number, dn);
>  
>  static const struct ide_proc_devset ide_generic_settings[] = {
>  	IDE_PROC_DEVSET(current_speed, 0, 70),
> 

