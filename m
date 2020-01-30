Return-Path: <SRS0=S1Gt=3T=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B74BC33C9E
	for <linux-ide@archiver.kernel.org>; Thu, 30 Jan 2020 10:50:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C1C0206D3
	for <linux-ide@archiver.kernel.org>; Thu, 30 Jan 2020 10:50:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="LM6LmkEV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726893AbgA3Kuq (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 30 Jan 2020 05:50:46 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:43528 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726873AbgA3Kuq (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 30 Jan 2020 05:50:46 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20200130105045euoutp0274052f014c8e5f90d2858928de2e643c~upI0wrQdI3039230392euoutp02a
        for <linux-ide@vger.kernel.org>; Thu, 30 Jan 2020 10:50:45 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20200130105045euoutp0274052f014c8e5f90d2858928de2e643c~upI0wrQdI3039230392euoutp02a
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1580381445;
        bh=jfT5wlur9z17rAbL+Rf9spuiYdCd2IPpXd68XnWmwoQ=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=LM6LmkEV9ljFr6Y73WPLKrEhcKXMJidJLUi3NYjpARKLbn8LBRNOR7AUec7gnZo33
         zpRd8VB5OOa42LQ8jbLWhX+r80Fzwsz5sXDkPCfyT3qcxnQrs55jzeT2nNvy0MZuUh
         GTbQ3BMWx0vNcPv6BstaVO75PUD+9LftWM4daERY=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200130105045eucas1p2ea257611b613b6742274998b17d5010f~upI0oeNWj2037920379eucas1p2k;
        Thu, 30 Jan 2020 10:50:45 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 03.29.61286.505B23E5; Thu, 30
        Jan 2020 10:50:45 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200130105045eucas1p1a74b2b19135caa89b9cd29eaf19ead0c~upI0XUrSc1416714167eucas1p1i;
        Thu, 30 Jan 2020 10:50:45 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200130105045eusmtrp277e2c15cc55daab04555aba0607a063f~upI0WyrCy2240922409eusmtrp2W;
        Thu, 30 Jan 2020 10:50:45 +0000 (GMT)
X-AuditID: cbfec7f2-f0bff7000001ef66-1e-5e32b50555cf
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 81.1E.07950.405B23E5; Thu, 30
        Jan 2020 10:50:45 +0000 (GMT)
Received: from [106.120.51.71] (unknown [106.120.51.71]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200130105044eusmtip141c338c99f540d99bd71043a83ec698b~upI0BhTL-0840208402eusmtip17;
        Thu, 30 Jan 2020 10:50:44 +0000 (GMT)
Subject: Re: [PATCH 09/24] ahci_qorig: move DPRINTK to ata debugging
To:     Hannes Reinecke <hare@suse.de>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-ide@vger.kernel.org,
        Hannes Reinecke <hare@suse.com>
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Message-ID: <732abe13-65cd-296a-7599-be5c986da9bb@samsung.com>
Date:   Thu, 30 Jan 2020 11:50:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20181213104716.31930-21-hare@suse.de>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprIKsWRmVeSWpSXmKPExsWy7djPc7qsW43iDDZclLBYfbefzWLBm71s
        FnsWTWKyOLbjEZMDi8fls6Ue67dcZfHYfLra4/MmuQCWKC6blNSczLLUIn27BK6Mpua6ggWc
        Fec/HmBrYDzB3sXIySEhYCJx+tgeli5GLg4hgRWMErsPTGWHcL4wSnTPmssK4XxmlNi0/TFT
        FyMHWMvxKTUQ8eWMEl03/jFDOG+BnE0XWEDmCgu4SDy6fJcVxBYRUJL42H4IbB+zQJxE05W7
        YDabgJXExPZVjCA2r4CdxLS1e8BsFgFViePzN7KB2KICERKfHhxmhagRlDg58wkLyBGcAsYS
        B5Z4QYwUl7j1ZD4ThC0vsf3tHGaI1/rZJc50Q9kuEttOtLJA2MISr45vgXpfRuL/TpBeLiB7
        HaPE344XzBDOdkaJ5ZP/sUFUWUvcOfeLDWQxs4CmxPpd+pCAcJS4s5APwuSTuPFWEOIEPolJ
        26YzQ4R5JTrahCBmqElsWLaBDWZr186VzBMYlWYh+WsWkmdmIXlmFsLaBYwsqxjFU0uLc9NT
        iw3zUsv1ihNzi0vz0vWS83M3MQITyul/xz/tYPx6KekQowAHoxIPr8YGozgh1sSy4srcQ4wS
        HMxKIryiroZxQrwpiZVVqUX58UWlOanFhxilOViUxHmNF72MFRJITyxJzU5NLUgtgskycXBK
        NTDuSdpyePMSudUKi6SXmXBp/Yt8Kcxq/4PLftkMfrc3SUtZVjLPCU3/28BqyL/83R+WAMW+
        baYOy86kvV95d6qk2j6JKQp/rI2vqBsl80RttxIps3d5dlamJHn+sT83jvL2e3Ktv145U4Mv
        Qyb3RKx6vxffpo1V3/dJtSXmS+QpGHjk3Drv9UqJpTgj0VCLuag4EQA2TPLXJAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrCIsWRmVeSWpSXmKPExsVy+t/xu7qsW43iDC7tYbJYfbefzWLBm71s
        FnsWTWKyOLbjEZMDi8fls6Ue67dcZfHYfLra4/MmuQCWKD2bovzSklSFjPziElulaEMLIz1D
        Sws9IxNLPUNj81grI1MlfTublNSczLLUIn27BL2Mpua6ggWcFec/HmBrYDzB3sXIwSEhYCJx
        fEpNFyMXh5DAUkaJ3Z3rWCDiMhLH15d1MXICmcISf651sUHUvGaU+Lh6PTNIQljAReLR5bus
        ILaIgJLEx/ZD7CA2s0CcxL++3UwQDesYJeZvmsIEkmATsJKY2L6KEcTmFbCTmLZ2D5jNIqAq
        cXz+RjYQW1QgQuLwjllQNYISJ2c+ATuIU8BY4sASL4j56hJ/5l1ihrDFJW49mc8EYctLbH87
        h3kCo9AsJN2zkLTMQtIyC0nLAkaWVYwiqaXFuem5xUZ6xYm5xaV56XrJ+bmbGIExtO3Yzy07
        GLveBR9iFOBgVOLh1dhgFCfEmlhWXJl7iFGCg1lJhFfU1TBOiDclsbIqtSg/vqg0J7X4EKMp
        0G8TmaVEk/OB8Z1XEm9oamhuYWlobmxubGahJM7bIXAwRkggPbEkNTs1tSC1CKaPiYNTqoFR
        6efFpJKSaqGDhhbrTXfbTfqSEnuxUu77QxflySWNs70FrDxk/rQ3NMtUeBY0pDwsXZXCt9e7
        8rLt7i1pGyZb1Xg8j2Sday/aIqdjzPz3h3SHHMu1kID7e5Wj1yumG/x3sFzJP+G6vqnYtwvS
        X17L1PfHPN9bdtTgrJniUoU5ToXHHszIOqHEUpyRaKjFXFScCABUEEP+twIAAA==
X-CMS-MailID: 20200130105045eucas1p1a74b2b19135caa89b9cd29eaf19ead0c
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20181213104817epcas1p1bd74393040fb4b5da0b4aa2f401d1934
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20181213104817epcas1p1bd74393040fb4b5da0b4aa2f401d1934
References: <20181213104716.31930-1-hare@suse.de>
        <CGME20181213104817epcas1p1bd74393040fb4b5da0b4aa2f401d1934@epcas1p1.samsung.com>
        <20181213104716.31930-21-hare@suse.de>
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org


On 12/13/18 11:47 AM, Hannes Reinecke wrote:
> Replace all DPRINTK calls with the ata_XXX_dbg functions.
> 
> Signed-off-by: Hannes Reinecke <hare@suse.com>
> ---
>  drivers/ata/ahci_qoriq.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/ata/ahci_qoriq.c b/drivers/ata/ahci_qoriq.c
> index ce59253ec158..b5136c28aa91 100644
> --- a/drivers/ata/ahci_qoriq.c
> +++ b/drivers/ata/ahci_qoriq.c
> @@ -94,7 +94,7 @@ static int ahci_qoriq_hardreset(struct ata_link *link, unsigned int *class,
>  	int rc;
>  	bool ls1021a_workaround = (qoriq_priv->type == AHCI_LS1021A);
>  
> -	DPRINTK("ENTER\n");
> +	ata_link_dbg(link, "ENTER\n");

Please preserve __func__ printing in the conversion.

>  	hpriv->stop_engine(ap);
>  
> @@ -138,7 +138,7 @@ static int ahci_qoriq_hardreset(struct ata_link *link, unsigned int *class,
>  	if (online)
>  		*class = ahci_dev_classify(ap);
>  
> -	DPRINTK("EXIT, rc=%d, class=%u\n", rc, *class);
> +	ata_link_dbg(link, "EXIT, rc=%d, class=%u\n", rc, *class);

ditto

>  	return rc;
>  }

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
