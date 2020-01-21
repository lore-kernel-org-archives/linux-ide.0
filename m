Return-Path: <SRS0=H5qQ=3K=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B433C2D0CE
	for <linux-ide@archiver.kernel.org>; Tue, 21 Jan 2020 10:58:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD0A520882
	for <linux-ide@archiver.kernel.org>; Tue, 21 Jan 2020 10:58:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="RmbavHFS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728689AbgAUK6h (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 21 Jan 2020 05:58:37 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:49938 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727962AbgAUK6g (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 21 Jan 2020 05:58:36 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20200121105835euoutp024d18845c5222727b1701179985eece3b~r4cF4FcNs1508115081euoutp02N
        for <linux-ide@vger.kernel.org>; Tue, 21 Jan 2020 10:58:35 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20200121105835euoutp024d18845c5222727b1701179985eece3b~r4cF4FcNs1508115081euoutp02N
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1579604315;
        bh=CCXtL4ZaJCU0uf6vOaRECcOyWgMUoLBYKe30olA7sHg=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=RmbavHFSzSsSsEPiqqYhSzMP8Y1GKNdjuwyTS6THAnvxMm5Pvz752F2SO6NdTSSWJ
         u+tdvrgMaSAQkbNQayoedEsA6e/xYNDzJTzOFQfeWxJAkE/rPGoIBFpEH9/YiCuodN
         TdSl+80pcBRxOzKdRaFyullM6GGuomxgti4ogFe0=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200121105835eucas1p276d1c29c86d045d9e369e324ee511bb7~r4cFrWQiH2701927019eucas1p2s;
        Tue, 21 Jan 2020 10:58:35 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 95.9C.60679.B59D62E5; Tue, 21
        Jan 2020 10:58:35 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200121105834eucas1p262277e5d831ef8a054d9069aa7c5213e~r4cFY8qp_0767507675eucas1p2p;
        Tue, 21 Jan 2020 10:58:34 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200121105834eusmtrp219550d81668a6801927bb2b71958b528~r4cFYWWpn2884128841eusmtrp2P;
        Tue, 21 Jan 2020 10:58:34 +0000 (GMT)
X-AuditID: cbfec7f4-0e5ff7000001ed07-0f-5e26d95bbbbe
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id C3.97.08375.A59D62E5; Tue, 21
        Jan 2020 10:58:34 +0000 (GMT)
Received: from [106.120.51.71] (unknown [106.120.51.71]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200121105834eusmtip2b87fdc273175b7e00c510474fb766d42~r4cFHN7Jw2149421494eusmtip2I;
        Tue, 21 Jan 2020 10:58:34 +0000 (GMT)
Subject: Re: [PATCH -next] ata: pata_macio: fix comparing pointer to 0
To:     Chen Zhou <chenzhou10@huawei.com>
Cc:     axboe@kernel.dk, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Message-ID: <ce9dbc1d-0f48-da24-af56-74a93f964e3a@samsung.com>
Date:   Tue, 21 Jan 2020 11:58:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20200121012827.1036-1-chenzhou10@huawei.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprAKsWRmVeSWpSXmKPExsWy7djP87rRN9XiDPoeMVusvtvPZnGh/SWr
        xbEdj5gsLu+aw+bA4tFy5C2rx+WzpR6fN8kFMEdx2aSk5mSWpRbp2yVwZcxb3cNW8IO9omfN
        S/YGxi1sXYycHBICJhIr/m5j7mLk4hASWMEosXLSOxYI5wujxLOuG+wQzmdGie51newwLVMm
        L4NKLGeU2P/+KpTzllGi4ecMJpAqYQE3iR13GplBbBEBVYklfxaCdTML+EicmN/NCGKzCVhJ
        TGxfBWbzCthJrHjQAlTDwcECVL96Bh9IWFQgQuLTg8OsECWCEidnPmEBKeEEan293wdiorjE
        rSfzmSBseYntb+eAvSMh0M4usXxFDzPE0S4SvXPaoR4Qlnh1fAuULSPxfydIM0jDOkaJvx0v
        oLq3M0osn/wPGkrWEnfO/WID2cwsoCmxfpc+RNhR4nBjB9hBEgJ8EjfeCkIcwScxadt0Zogw
        r0RHmxBEtZrEhmUb2GDWdu1cyTyBUWkWks9mIXlnFpJ3ZiHsXcDIsopRPLW0ODc9tdgoL7Vc
        rzgxt7g0L10vOT93EyMwnZz+d/zLDsZdf5IOMQpwMCrx8L6YrBonxJpYVlyZe4hRgoNZSYR3
        QRNQiDclsbIqtSg/vqg0J7X4EKM0B4uSOK/xopexQgLpiSWp2ampBalFMFkmDk6pBkYJRtFD
        UgdPsouyvTE+YBo7e/qliRz1Bvz3/3VWsks9nbd2miL7OWEzxYAKozpe/oRTlXM0F8v/nBxu
        IVL+72T5n8jKOJ0qydBO7St969KCtl/MubmhQFpMRnKD/y5+zczlkle5V95bemNLWuv3RX8T
        /EOVu3nntq4/5MOodv8wW8QxbjP3hUosxRmJhlrMRcWJAFuNXWEjAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrIIsWRmVeSWpSXmKPExsVy+t/xe7pRN9XiDF4d1rdYfbefzeJC+0tW
        i2M7HjFZXN41h82BxaPlyFtWj8tnSz0+b5ILYI7SsynKLy1JVcjILy6xVYo2tDDSM7S00DMy
        sdQzNDaPtTIyVdK3s0lJzcksSy3St0vQy5i3uoet4Ad7Rc+al+wNjFvYuhg5OSQETCSmTF7G
        3sXIxSEksJRR4saN1cxdjBxACRmJ4+vLIGqEJf5c62KDqHnNKLHweBMrSEJYwE1ix51GZhBb
        REBVYsmfhewgNrOAj8SJ+d2MEA29jBLtzyczgiTYBKwkJravArN5BewkVjxoYQdZxgLUvHoG
        H0hYVCBC4vCOWVAlghInZz5hASnhBGp9vd8HYry6xJ95l5ghbHGJW0/mM0HY8hLb385hnsAo
        NAtJ9ywkLbOQtMxC0rKAkWUVo0hqaXFuem6xoV5xYm5xaV66XnJ+7iZGYPRsO/Zz8w7GSxuD
        DzEKcDAq8fA6TFONE2JNLCuuzD3EKMHBrCTCu6AJKMSbklhZlVqUH19UmpNafIjRFOi1icxS
        osn5wMjOK4k3NDU0t7A0NDc2NzazUBLn7RA4GCMkkJ5YkpqdmlqQWgTTx8TBKdXAWBEvuJDp
        7K6c2VdcH3IWnp3G5y/L1yObEj55XfiNhtJ3DhMLN1iy7fn72vHv0juGxv9OXfiivZHXb4HA
        0T3bD6xuyznoJOcpfG1XSeZRlpO1b092bFvtuzqkvC9w0pTd+RVRPCvEfeUevLc4FHZX+caF
        CY1qR9jiHe4suxCa8iBUbsbLyqtSb5VYijMSDbWYi4oTAcq9++i0AgAA
X-CMS-MailID: 20200121105834eucas1p262277e5d831ef8a054d9069aa7c5213e
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200121013332eucas1p223fe0dd6da9ac002f3d5dd152d4ea7a8
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200121013332eucas1p223fe0dd6da9ac002f3d5dd152d4ea7a8
References: <CGME20200121013332eucas1p223fe0dd6da9ac002f3d5dd152d4ea7a8@eucas1p2.samsung.com>
        <20200121012827.1036-1-chenzhou10@huawei.com>
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org


On 1/21/20 2:28 AM, Chen Zhou wrote:
> Fixes coccicheck warning:
> 
> ./drivers/ata/pata_macio.c:982:31-32:
> 	WARNING comparing pointer to 0, suggest !E
> 
> Compare pointer-typed values to NULL rather than 0.
> 
> Signed-off-by: Chen Zhou <chenzhou10@huawei.com>

Acked-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

> ---
>  drivers/ata/pata_macio.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/ata/pata_macio.c b/drivers/ata/pata_macio.c
> index 1bfd015..e47a282 100644
> --- a/drivers/ata/pata_macio.c
> +++ b/drivers/ata/pata_macio.c
> @@ -979,7 +979,7 @@ static void pata_macio_invariants(struct pata_macio_priv *priv)
>  	priv->aapl_bus_id =  bidp ? *bidp : 0;
>  
>  	/* Fixup missing Apple bus ID in case of media-bay */
> -	if (priv->mediabay && bidp == 0)
> +	if (priv->mediabay && !bidp)
>  		priv->aapl_bus_id = 1;
>  }
>  

