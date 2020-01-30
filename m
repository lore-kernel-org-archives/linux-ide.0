Return-Path: <SRS0=S1Gt=3T=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38E13C33C9E
	for <linux-ide@archiver.kernel.org>; Thu, 30 Jan 2020 10:49:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09116206D3
	for <linux-ide@archiver.kernel.org>; Thu, 30 Jan 2020 10:49:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="ttLlRKxS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726913AbgA3Kt2 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 30 Jan 2020 05:49:28 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:43103 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726873AbgA3Kt2 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 30 Jan 2020 05:49:28 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20200130104927euoutp02669f776654eea7a242d198bc71dc32b0~upHr_FMs43039230392euoutp02A
        for <linux-ide@vger.kernel.org>; Thu, 30 Jan 2020 10:49:27 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20200130104927euoutp02669f776654eea7a242d198bc71dc32b0~upHr_FMs43039230392euoutp02A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1580381367;
        bh=W3YILrl+iCdxOmRVIBOQ3DwjvYg/VM46eTmou+CaoVI=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=ttLlRKxSBn2GjjT/cUpDL0U2OCwhTWRvg85hRkmZTxSkhb8nwe+irMr+qbLNMhzLZ
         u2/dK0UDXkDJxo655ufAc5kWpi5LXIbphQABQKsHmWNcXjH+Ut/t04QfOG2QweS6Tf
         C/Z8nPBtO1rNBJ0gfIyDhX1JNU0Rk/shTcnEkANc=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200130104927eucas1p10275aa6fb16f2dcdf742a5ded993d53f~upHrvf3vB0646506465eucas1p1z;
        Thu, 30 Jan 2020 10:49:27 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 77.2E.60679.7B4B23E5; Thu, 30
        Jan 2020 10:49:27 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200130104926eucas1p203e21dd725dc3fe052a2a1cab8be2e15~upHrfvRau1338413384eucas1p2-;
        Thu, 30 Jan 2020 10:49:26 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200130104926eusmtrp2a3975a4c4a3bb29a325f2a5d6a26856a~upHrefz_12157621576eusmtrp23;
        Thu, 30 Jan 2020 10:49:26 +0000 (GMT)
X-AuditID: cbfec7f4-0cbff7000001ed07-12-5e32b4b7c8cd
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id F8.ED.07950.6B4B23E5; Thu, 30
        Jan 2020 10:49:26 +0000 (GMT)
Received: from [106.120.51.71] (unknown [106.120.51.71]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200130104926eusmtip1fb58c6ffa4f0b6d4f6a57434ef2c90c4~upHrMlUSB1451114511eusmtip1j;
        Thu, 30 Jan 2020 10:49:26 +0000 (GMT)
Subject: Re: [PATCH 07/24] pdc_adma: move DPRINTK to ata debugging
To:     Hannes Reinecke <hare@suse.de>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-ide@vger.kernel.org,
        Hannes Reinecke <hare@suse.com>
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Message-ID: <f1a25a6d-110c-8d2c-7b49-d83fdc67aa0f@samsung.com>
Date:   Thu, 30 Jan 2020 11:49:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20181213104716.31930-19-hare@suse.de>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprCKsWRmVeSWpSXmKPExsWy7djP87rbtxjFGaz5zW6x+m4/m8WCN3vZ
        LPYsmsRkcWzHIyYHFo/LZ0s91m+5yuKx+XS1x+dNcgEsUVw2Kak5mWWpRfp2CVwZK87MYSqY
        wlExeeFW9gbG82xdjJwcEgImEs+nrGDuYuTiEBJYwSixoHMnG4TzhVHi4vTzLBDOZ0aJWZs+
        MMK0nH7YBJVYzigxf8srRgjnLaNE7+sTQP3sHMICThJzpUHqRQSUJD62H2IHsZkF4iSartwF
        s9kErCQmtq8Cm8krYCfRfmkbWJxFQFVi8b2vYLaoQITEpweHWSFqBCVOznzCAmJzChhLnLjQ
        AzVTXOLWk/lMELa8xPa3c8DekRDoZ5fYemsmC8TRLhInHt6H+llY4tXxLewQtozE/50gzSAN
        6xgl/na8gOreziixfPI/qA5riTvnfgHZHEArNCXW79KHCDtKbNn+gBUkLCHAJ3HjrSDEEXwS
        k7ZNZ4YI80p0tAlBVKtJbFi2gQ1mbdfOlcwTGJVmIXltFpJ3ZiF5ZxbC3gWMLKsYxVNLi3PT
        U4uN8lLL9YoTc4tL89L1kvNzNzEC08rpf8e/7GDc9SfpEKMAB6MSD6/GBqM4IdbEsuLK3EOM
        EhzMSiK8oq6GcUK8KYmVValF+fFFpTmpxYcYpTlYlMR5jRe9jBUSSE8sSc1OTS1ILYLJMnFw
        SjUwrt6XEN/i/q4yTf/CemWrtywy2v43/c9298Z/jX1hPvVwzqIJsdeNlJXD+cP+Xa/95SfD
        36BvrL/J+eHReZYHt7TxN51V3XxhmWrNPW/uX2X6e489n2y7ovXAmsYUnbyn0ekVoltbsqSP
        OU879pB/g5Z7iVtwYcgZI9nSFXxJqcaXFr6TnJavxFKckWioxVxUnAgAPtfRjycDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrKIsWRmVeSWpSXmKPExsVy+t/xu7rbthjFGWzYaWix+m4/m8WCN3vZ
        LPYsmsRkcWzHIyYHFo/LZ0s91m+5yuKx+XS1x+dNcgEsUXo2RfmlJakKGfnFJbZK0YYWRnqG
        lhZ6RiaWeobG5rFWRqZK+nY2Kak5mWWpRfp2CXoZK87MYSqYwlExeeFW9gbG82xdjJwcEgIm
        EqcfNrF0MXJxCAksZZS4fGQ1excjB1BCRuL4+jKIGmGJP9e62CBqXjNKXFraAuSwcwgLOEnM
        lQYpERFQkvjYfogdxGYWiJP417ebCaJ8HaPE39eXWUESbAJWEhPbVzGC2LwCdhLtl7aBNbAI
        qEosvvcVzBYViJA4vGMWVI2gxMmZT1hAbE4BY4kTF3qgFqhL/Jl3iRnCFpe49WQ+E4QtL7H9
        7RzmCYxCs5C0z0LSMgtJyywkLQsYWVYxiqSWFuem5xYb6RUn5haX5qXrJefnbmIERtG2Yz+3
        7GDsehd8iFGAg1GJh1djg1GcEGtiWXFl7iFGCQ5mJRFeUVfDOCHelMTKqtSi/Pii0pzU4kOM
        pkDPTWSWEk3OB0Z4Xkm8oamhuYWlobmxubGZhZI4b4fAwRghgfTEktTs1NSC1CKYPiYOTqkG
        xlU2dwMZeNmefnz6YH2q77y1H/gF1pf3nG88NpPD8sDbp4JTXzRoN5uGG1xs8LEKmfrldW2p
        hcaOZ5f+fRFhtGt7cKh5ufv2HK/9PszTGy1yLzc77jkj+6mP073JWefDv2U1EqUKNd15CaYi
        /VabuU30D8np80yZ2zbF5UPVNq+XLzIyvorxKbEUZyQaajEXFScCADidSmS4AgAA
X-CMS-MailID: 20200130104926eucas1p203e21dd725dc3fe052a2a1cab8be2e15
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20181213104738epcas2p471da9b8d359cec2dbb81dd9cdee37a15
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20181213104738epcas2p471da9b8d359cec2dbb81dd9cdee37a15
References: <20181213104716.31930-1-hare@suse.de>
        <CGME20181213104738epcas2p471da9b8d359cec2dbb81dd9cdee37a15@epcas2p4.samsung.com>
        <20181213104716.31930-19-hare@suse.de>
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org


On 12/13/18 11:46 AM, Hannes Reinecke wrote:
> Replace all DPRINTK calls with the ata_XXX_dbg functions.
> 
> Signed-off-by: Hannes Reinecke <hare@suse.com>
> ---
>  drivers/ata/pdc_adma.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/ata/pdc_adma.c b/drivers/ata/pdc_adma.c
> index f1e873a37465..ee9c26ef78c0 100644
> --- a/drivers/ata/pdc_adma.c
> +++ b/drivers/ata/pdc_adma.c
> @@ -490,8 +490,8 @@ static inline unsigned int adma_intr_mmio(struct ata_host *host)
>  			u8 status = ata_sff_check_status(ap);
>  			if ((status & ATA_BUSY))
>  				continue;
> -			DPRINTK("ata%u: protocol %d (dev_stat 0x%X)\n",
> -				ap->print_id, qc->tf.protocol, status);
> +			ata_port_dbg(ap, "protocol %d (dev_stat 0x%X)\n",
> +				qc->tf.protocol, status);

Please preserve __func__ printing in the conversion.

>  			/* complete taskfile transaction */
>  			pp->state = adma_state_idle;

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
