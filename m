Return-Path: <SRS0=vLfT=36=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C952C352A3
	for <linux-ide@archiver.kernel.org>; Mon, 10 Feb 2020 13:50:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 326962070A
	for <linux-ide@archiver.kernel.org>; Mon, 10 Feb 2020 13:50:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="lgIdMYBv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728020AbgBJNud (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 10 Feb 2020 08:50:33 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:33332 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727566AbgBJNud (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 10 Feb 2020 08:50:33 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20200210135032euoutp02a6764ffef3312c8671af72611dd0af7e~yDr7kVGeV1019510195euoutp02j
        for <linux-ide@vger.kernel.org>; Mon, 10 Feb 2020 13:50:32 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20200210135032euoutp02a6764ffef3312c8671af72611dd0af7e~yDr7kVGeV1019510195euoutp02j
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1581342632;
        bh=7jdzzGMnDcyE/wu0ago3TQAJCfQSTkAN+Ex59JLq7Lg=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=lgIdMYBvf1UifHa8ncpl/dED/u7GuxhmLaHcuvEzd+LGOJGvU03hfPoqeUAARh7FF
         iMKlrhcimoPBjiDzJfJJYzjeybjnrxoinNgbG/I0dEuSh0TiSt1SbFreyJn2MYdNHa
         De7FL8Kya8eovVK97MSN3L8V3kdZR05rxVRwT4NY=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200210135032eucas1p1c78a8dcc9f98f9f3403893c6d5ac1b83~yDr7d10820308903089eucas1p1T;
        Mon, 10 Feb 2020 13:50:32 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id BA.BE.61286.7AF514E5; Mon, 10
        Feb 2020 13:50:32 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200210135031eucas1p295860d0604fcd1b7006f815d49f86686~yDr7K5K5J2014320143eucas1p2m;
        Mon, 10 Feb 2020 13:50:31 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200210135031eusmtrp25037462c3a9aa09a6fd0fa5075447746~yDr7KZRXb3245632456eusmtrp2Z;
        Mon, 10 Feb 2020 13:50:31 +0000 (GMT)
X-AuditID: cbfec7f2-ef1ff7000001ef66-98-5e415fa7e6b2
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 42.BC.07950.7AF514E5; Mon, 10
        Feb 2020 13:50:31 +0000 (GMT)
Received: from [106.120.51.71] (unknown [106.120.51.71]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200210135031eusmtip1c74b220bec20868f42adbd08783cdb2d~yDr6vMHAC0742107421eusmtip19;
        Mon, 10 Feb 2020 13:50:31 +0000 (GMT)
Subject: Re: [PATCH 22/46] libata-core: drop DPRINTK() calls in reset
To:     Hannes Reinecke <hare@suse.de>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-ide@vger.kernel.org
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Message-ID: <82036327-4421-d41e-3234-be85f5b31449@samsung.com>
Date:   Mon, 10 Feb 2020 14:50:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20200204165547.115220-23-hare@suse.de>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupileLIzCtJLcpLzFFi42LZduzned0V8Y5xBrNOMlmsvtvPZrFn0SQm
        i2M7HjE5MHtcPlvqsfl0tcfnTXIBzFFcNimpOZllqUX6dglcGT//P2cvuMddsWjOFqYGxiWc
        XYycHBICJhInZ8xmArGFBFYwSvxdwgdhf2GUaNoi28XIBWR/ZpTonjWXGabhyYFuZojEckaJ
        h+9fsEE4bxklJi6fB1YlLOAq8WrNUzYQW0RASeJj+yF2EJtZwFpi9uL1YOvYBKwkJravYgSx
        eQXsJFZPaGQBsVkEVCV6vpwCqxEViJD49OAwK0SNoMTJmU/AajiBrrj+fwozxExxiVtP5jNB
        2PIS29/OAbtOQuA/m8SHrv9MEGe7SOxtfc8IYQtLvDq+hR3ClpH4vxOkGaRhHdD/HS+gurcz
        Siyf/I8Nospa4s65X0A2B9AKTYn1u/Qhwo4Sbx8sBAtLCPBJ3HgrCHEEn8SkbdOZIcK8Eh1t
        QhDVahIblm1gg1nbtXMl8wRGpVlIXpuF5J1ZSN6ZhbB3ASPLKkbx1NLi3PTUYsO81HK94sTc
        4tK8dL3k/NxNjMAUcvrf8U87GL9eSjrEKMDBqMTDWxHoGCfEmlhWXJl7iFGCg1lJhNdSGijE
        m5JYWZValB9fVJqTWnyIUZqDRUmc13jRy1ghgfTEktTs1NSC1CKYLBMHp1QDY+X+2/vMV/bV
        hJ3Mjl7K22jwmbf434wa0aXbjdKv1vY7s/32OqYwcedea9mDMX4Kl3im2H4u3CAml7b6Qnzz
        fDe7c0n+9zwuuP5f48278u/RHx4WsUquEvvlGC/ozrFLy9pS4FWq2m/ynvHDegb7Q5Pe3Sx8
        cExQ1jer2fqCeoObdFuWqdxhJZbijERDLeai4kQAu6r46B0DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprLIsWRmVeSWpSXmKPExsVy+t/xu7rL4x3jDO7u0LJYfbefzWLPoklM
        Fsd2PGJyYPa4fLbUY/Ppao/Pm+QCmKP0bIryS0tSFTLyi0tslaINLYz0DC0t9IxMLPUMjc1j
        rYxMlfTtbFJSczLLUov07RL0Mn7+f85ecI+7YtGcLUwNjEs4uxg5OSQETCSeHOhm7mLk4hAS
        WMoose1SL2sXIwdQQkbi+PoyiBphiT/Xutggal4zSrQeXs8OkhAWcJV4teYpG4gtIqAk8bH9
        EFicWcBaYvbi9UwQDRsYJZo2TgYrYhOwkpjYvooRxOYVsJNYPaGRBcRmEVCV6PlyignEFhWI
        kDi8YxZUjaDEyZlPwGo4gS69/n8KM8QCdYk/8y5B2eISt57MZ4Kw5SW2v53DPIFRaBaS9llI
        WmYhaZmFpGUBI8sqRpHU0uLc9NxiI73ixNzi0rx0veT83E2MwKjZduznlh2MXe+CDzEKcDAq
        8fBeCHaME2JNLCuuzD3EKMHBrCTCaykNFOJNSaysSi3Kjy8qzUktPsRoCvTcRGYp0eR8YETn
        lcQbmhqaW1gamhubG5tZKInzdggcjBESSE8sSc1OTS1ILYLpY+LglGpgPLzovnG//92vKbX/
        AuVXXVGsmH6kYlokz4TspDrWR9sfp53r0etznTR/uanio3s7xTxkODTXndmWeDFxzYWFz7KW
        m01Y18gtIXba6oHc9N3tcbVGwoei2zub9mmsuVlu9M7BZu3Hmuc/VGaw7HDOLCh4mp/dEeMz
        85lN9bsts8Sl/M/wXUgtVWIpzkg01GIuKk4EAPa/kRuwAgAA
X-CMS-MailID: 20200210135031eucas1p295860d0604fcd1b7006f815d49f86686
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200204165614eucas1p289f1f755f2f83419fd92f932ca4166cd
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200204165614eucas1p289f1f755f2f83419fd92f932ca4166cd
References: <20200204165547.115220-1-hare@suse.de>
        <CGME20200204165614eucas1p289f1f755f2f83419fd92f932ca4166cd@eucas1p2.samsung.com>
        <20200204165547.115220-23-hare@suse.de>
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
>  drivers/ata/libata-core.c | 7 -------
>  1 file changed, 7 deletions(-)
> 
> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
> index 8a18047f9bcb..297aa8172d4e 100644
> --- a/drivers/ata/libata-core.c
> +++ b/drivers/ata/libata-core.c
> @@ -4070,8 +4070,6 @@ int sata_link_hardreset(struct ata_link *link, const unsigned long *timing,
>  	u32 scontrol;
>  	int rc;
>  
> -	DPRINTK("ENTER\n");
> -
>  	if (online)
>  		*online = false;
>  
> @@ -4147,7 +4145,6 @@ int sata_link_hardreset(struct ata_link *link, const unsigned long *timing,
>  			*online = false;
>  		ata_link_err(link, "COMRESET failed (errno=%d)\n", rc);
>  	}
> -	DPRINTK("EXIT, rc=%d\n", rc);
>  	return rc;
>  }
>  
> @@ -4193,16 +4190,12 @@ void ata_std_postreset(struct ata_link *link, unsigned int *classes)
>  {
>  	u32 serror;
>  
> -	DPRINTK("ENTER\n");
> -
>  	/* reset complete, clear SError */
>  	if (!sata_scr_read(link, SCR_ERROR, &serror))
>  		sata_scr_write(link, SCR_ERROR, serror);
>  
>  	/* print link status */
>  	sata_print_link_status(link);
> -
> -	DPRINTK("EXIT\n");
>  }
>  
>  /**
> 
