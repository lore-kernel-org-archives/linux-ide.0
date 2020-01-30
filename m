Return-Path: <SRS0=S1Gt=3T=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B18A3C33C9E
	for <linux-ide@archiver.kernel.org>; Thu, 30 Jan 2020 11:55:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83B7E2082E
	for <linux-ide@archiver.kernel.org>; Thu, 30 Jan 2020 11:55:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="XyVlZJJl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727089AbgA3Lzo (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 30 Jan 2020 06:55:44 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:39238 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726873AbgA3Lzo (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 30 Jan 2020 06:55:44 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20200130115542euoutp02344c8e02409e856c9c2e29ff9f050ac6~uqBiGmCKn0960909609euoutp02V
        for <linux-ide@vger.kernel.org>; Thu, 30 Jan 2020 11:55:42 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20200130115542euoutp02344c8e02409e856c9c2e29ff9f050ac6~uqBiGmCKn0960909609euoutp02V
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1580385342;
        bh=k7RPOdxluhf8dYXgweZoro4XJjfdEueUhLXAF9DZdKA=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=XyVlZJJlOBlcowFUxQGAXb62Gz+qlKl5WuWbA0YkOSbRtKH+39Pj6sauFqREaNHBp
         VLHvD7mfnyMo6D8+uhBNTZ9Z9UkFhqI+II5PanVmbzYtV6L8+ID81oCf4uE2OniId+
         eGAY8bcojT9AeXTu5R1sG1QspDpkJDQ2XBsAV1hM=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200130115542eucas1p291756e93d1087c68f85d0038bc4e4616~uqBhuIqUc3156031560eucas1p2X;
        Thu, 30 Jan 2020 11:55:42 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 18.E2.61286.D34C23E5; Thu, 30
        Jan 2020 11:55:42 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200130115541eucas1p2134ea9aaae8a64ff359577435cdc75a3~uqBhVgyy03145231452eucas1p2h;
        Thu, 30 Jan 2020 11:55:41 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200130115541eusmtrp2df28cea8afcec48b129b521b77d8d818~uqBhU9v253084930849eusmtrp2B;
        Thu, 30 Jan 2020 11:55:41 +0000 (GMT)
X-AuditID: cbfec7f2-ef1ff7000001ef66-71-5e32c43d07b0
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 50.47.07950.D34C23E5; Thu, 30
        Jan 2020 11:55:41 +0000 (GMT)
Received: from [106.120.51.71] (unknown [106.120.51.71]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200130115541eusmtip2ba9853b64c4d04d9c194f9a79ed05a22~uqBg5VrqP1780917809eusmtip2b;
        Thu, 30 Jan 2020 11:55:41 +0000 (GMT)
Subject: Re: [PATCH 20/24] pata_pdc202xx_old: move DPRINTK to ata debugging
To:     Hannes Reinecke <hare@suse.de>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-ide@vger.kernel.org,
        Hannes Reinecke <hare@suse.com>
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Message-ID: <bba1e0c7-d5db-86b3-3ded-efb0c91208f6@samsung.com>
Date:   Thu, 30 Jan 2020 12:55:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20181213104716.31930-32-hare@suse.de>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprMKsWRmVeSWpSXmKPExsWy7djP87p2R4ziDDb2M1msvtvPZrHgzV42
        iz2LJjFZHNvxiMmBxePy2VKP9VuusnhsPl3t8XmTXABLFJdNSmpOZllqkb5dAlfG51MPmAu+
        s1fMOfyFpYHxMlsXIyeHhICJxOlnDxm7GLk4hARWMEr8PLmWBSQhJPCFUeLUBz8I+zOjxJ/N
        STANzfN6WCEaljNKrFnYxQLhvGWUmNn2nAmkSljAW2L3/DZGEFtEQEniY/shdhCbWSBOounK
        XTCbTcBKYmL7KrAaXgE7iVuPl7KC2CwCqhIvjqwFO09UIELi04PDrBA1ghInZz4Bu45TwFji
        xL3ZLBAzxSVuPZnPBGHLS2x/O4cZ5CAJgX52iZY5nUAOB5DjIrFgmhTEB8ISr45vYYewZST+
        7wTpBalfxyjxt+MFVPN2Ronlk/9BA8la4s65X2wgg5gFNCXW79KHCDtKbHv8khFiPp/EjbeC
        EDfwSUzaNh1qLa9ER5sQRLWaxIZlG9hg1nbtXMk8gVFpFpLPZiH5ZhaSb2Yh7F3AyLKKUTy1
        tDg3PbXYMC+1XK84Mbe4NC9dLzk/dxMjMKmc/nf80w7Gr5eSDjEKcDAq8fBqbDCKE2JNLCuu
        zD3EKMHBrCTCK+pqGCfEm5JYWZValB9fVJqTWnyIUZqDRUmc13jRy1ghgfTEktTs1NSC1CKY
        LBMHp1QDY3ara+sbvuVM2pK9DqVGfRw351hND5qhe7ir4CyjJeuht09+VvCHfGQr0p5ZKnng
        UOn5y0zveN++mMx41Ym9yHjLs1aFcOvAydnqq5035ca+UQwy0Lm6aa/ZAw71oKrXfzcvkFwS
        +0fuiZ3o3JpXGzsF+zdqqZ+py7Tq3DL7+geF5lSV/9ZFSizFGYmGWsxFxYkANs/TyiYDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrOIsWRmVeSWpSXmKPExsVy+t/xe7q2R4ziDB4c0rJYfbefzWLBm71s
        FnsWTWKyOLbjEZMDi8fls6Ue67dcZfHYfLra4/MmuQCWKD2bovzSklSFjPziElulaEMLIz1D
        Sws9IxNLPUNj81grI1MlfTublNSczLLUIn27BL2Mz6ceMBd8Z6+Yc/gLSwPjZbYuRk4OCQET
        ieZ5PaxdjFwcQgJLGSU6X64EcjiAEjISx9eXQdQIS/y51sUGUfOaUaJh3lFGkISwgLfE7vlt
        YLaIgJLEx/ZD7CA2s0CcxL++3UwQDesYJY7dXgKWYBOwkpjYvgqsgVfATuLW46WsIDaLgKrE
        iyNrwS4SFYiQOLxjFlSNoMTJmU9YQGxOAWOJE/dms0AsUJf4M+8SM4QtLnHryXwmCFteYvvb
        OcwTGIVmIWmfhaRlFpKWWUhaFjCyrGIUSS0tzk3PLTbSK07MLS7NS9dLzs/dxAiMpG3Hfm7Z
        wdj1LvgQowAHoxIPr8YGozgh1sSy4srcQ4wSHMxKIryiroZxQrwpiZVVqUX58UWlOanFhxhN
        gZ6byCwlmpwPjPK8knhDU0NzC0tDc2NzYzMLJXHeDoGDMUIC6YklqdmpqQWpRTB9TBycUg2M
        EyS6u/pWJn2ZdoS9fELTyRb2y06cfQIp05rfaSfYvmV4rztp9sYDiZlCn/5pPpKsC/uzLVPR
        iaVEJiKzh8WkO1R3kWQ862wL1nde3w48Vd2wIrNgXtX6LarTlod/THUo2mjX9kJs0Rq12QaL
        P2qLzvlkfzdg5r0PRzPP3D/B45z/KpC/apG9EktxRqKhFnNRcSIAmgqImboCAAA=
X-CMS-MailID: 20200130115541eucas1p2134ea9aaae8a64ff359577435cdc75a3
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20181213104753epcas1p338a6423f03225a101ef438786f3932b0
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20181213104753epcas1p338a6423f03225a101ef438786f3932b0
References: <20181213104716.31930-1-hare@suse.de>
        <CGME20181213104753epcas1p338a6423f03225a101ef438786f3932b0@epcas1p3.samsung.com>
        <20181213104716.31930-32-hare@suse.de>
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org


On 12/13/18 11:47 AM, Hannes Reinecke wrote:
> Replace all DPRINTK calls with the ata_XXX_dbg functions.

Please preserve __func__ printing in the conversion.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

> Signed-off-by: Hannes Reinecke <hare@suse.com>
> ---
>  drivers/ata/pata_pdc202xx_old.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/ata/pata_pdc202xx_old.c b/drivers/ata/pata_pdc202xx_old.c
> index 9001991d2830..6d52b1bb1b9e 100644
> --- a/drivers/ata/pata_pdc202xx_old.c
> +++ b/drivers/ata/pata_pdc202xx_old.c
> @@ -37,7 +37,7 @@ static int pdc2026x_cable_detect(struct ata_port *ap)
>  static void pdc202xx_exec_command(struct ata_port *ap,
>  				  const struct ata_taskfile *tf)
>  {
> -	DPRINTK("ata%u: cmd 0x%X\n", ap->print_id, tf->command);
> +	ata_port_dbg(ap, "ata%u: cmd 0x%X\n", ap->print_id, tf->command);
>  
>  	iowrite8(tf->command, ap->ioaddr.command_addr);
>  	ndelay(400);
