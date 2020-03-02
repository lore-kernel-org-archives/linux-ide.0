Return-Path: <SRS0=3I3m=4T=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D068C3F2D1
	for <linux-ide@archiver.kernel.org>; Mon,  2 Mar 2020 17:34:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E45C1222C4
	for <linux-ide@archiver.kernel.org>; Mon,  2 Mar 2020 17:34:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="j7iZkQne"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727154AbgCBReV (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 2 Mar 2020 12:34:21 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:46476 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727101AbgCBReV (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 2 Mar 2020 12:34:21 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20200302173419euoutp0209afc038e934cca6ce54fbb9082a3a33~4jST-a5Q_1415114151euoutp022
        for <linux-ide@vger.kernel.org>; Mon,  2 Mar 2020 17:34:19 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20200302173419euoutp0209afc038e934cca6ce54fbb9082a3a33~4jST-a5Q_1415114151euoutp022
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1583170459;
        bh=EM4P79Oj5oYKO+txT9xVuSTElfPu9BwCMy7dhTMboGI=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=j7iZkQneT7Qy+Nrpg5iFZtaPbLE9ChuHJ8+SR+8LtjJModc2wegMbK5xs8pwFmW14
         CeW84k69/3wxCtQEpd7tVnSqgzSpU8762/iinC6rBa939TMbTo91HrwQQCBX5PhBpg
         Lx3vYy7PjbmtAOdawSqLfSjpLBjNkSEJ6bqycB8c=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200302173418eucas1p257d1b39716f2fd38b3fa01026f7fd78c~4jST3qXEt0945009450eucas1p2d;
        Mon,  2 Mar 2020 17:34:18 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 38.AB.60679.A934D5E5; Mon,  2
        Mar 2020 17:34:18 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200302173418eucas1p1edaf987ba0cf4aae9c6209430afccb10~4jSThXgeT1719117191eucas1p1L;
        Mon,  2 Mar 2020 17:34:18 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200302173418eusmtrp153d479bcde451b0d3548d1d724535286~4jSTgxXhc0546105461eusmtrp1X;
        Mon,  2 Mar 2020 17:34:18 +0000 (GMT)
X-AuditID: cbfec7f4-0e5ff7000001ed07-bf-5e5d439a9786
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id C2.AA.08375.A934D5E5; Mon,  2
        Mar 2020 17:34:18 +0000 (GMT)
Received: from [106.120.51.71] (unknown [106.120.51.71]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200302173417eusmtip2f2aec8d6664fe416d84d2ee43856fafd~4jSSFLRWO2404024040eusmtip2l;
        Mon,  2 Mar 2020 17:34:16 +0000 (GMT)
Subject: Re: [PATCH 18/42] libata: drop DPRINTK calls for bus-master DMA
To:     Hannes Reinecke <hare@suse.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
        linux-ide@vger.kernel.org
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Message-ID: <a9d0ce8e-0d70-2e62-67bd-b1a9f8403278@samsung.com>
Date:   Mon, 2 Mar 2020 18:34:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20200213095412.23773-19-hare@suse.de>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprIKsWRmVeSWpSXmKPExsWy7djPc7qznGPjDBr2GlusvtvPZrFn0SQm
        i2M7HjFZ/Fp+lNGBxePy2VKPTas62Tw2n672+LxJLoAlissmJTUnsyy1SN8ugStjzf6VbAXf
        DSoaNgk2ML5U72Lk5JAQMJG42nOfCcQWEljBKHHpRVkXIxeQ/YVRou/SZGYI5zOjxO/Hd9hh
        Oha1/2SESCwH6jj5kw3Cecso0XnoHitIlbCAh8T8fUfAOkQElCQ+th8Cs5kFIiQ2blgLto9N
        wEpiYvsqRhCbV8BOYu3zTrAaFgEVidbZO1lAbFGg+k8PDrNC1AhKnJz5BCjOwcEpYCzxZVEZ
        xEhxiVtP5jNB2PIS29/OAbtaQqCfXWLfysmMIPUSAi4SK6bqQzwgLPHq+BaoZ2QkTk/uYYGo
        X8co8bfjBVTzdkaJ5ZP/sUFUWUvcOfeLDWQQs4CmxPpd+hAzHSU+TcuFMPkkbrwVhDiBT2LS
        tunMEGFeiY42IYgZahIblm1gg9natXMl8wRGpVlI/pqF5JlZSJ6ZhbB2ASPLKkbx1NLi3PTU
        YqO81HK94sTc4tK8dL3k/NxNjMCEcvrf8S87GHf9STrEKMDBqMTDG8AcGyfEmlhWXJl7iFGC
        g1lJhNeXMzpOiDclsbIqtSg/vqg0J7X4EKM0B4uSOK/xopexQgLpiSWp2ampBalFMFkmDk6p
        BsYFT5RKXheJyehJqOxOmSenr/ku6x/zp4vbptd9VVCMDcp0irC1ey564x9Tvf5fuaD63O4J
        52/PV5wnvPrcowuCv28wOnr+NbPxlY16cjXXUElvVUfgs/uZX9yiCsKOLj41fxfTnbtTKw5H
        XC9wUJbYlvCg8fyqi7NWG6kLWdzlUWZ/aPk6XVGJpTgj0VCLuag4EQBTDPNaJAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrKIsWRmVeSWpSXmKPExsVy+t/xe7qznGPjDD5NUbBYfbefzWLPoklM
        Fsd2PGKy+LX8KKMDi8fls6Uem1Z1snlsPl3t8XmTXABLlJ5NUX5pSapCRn5xia1StKGFkZ6h
        pYWekYmlnqGxeayVkamSvp1NSmpOZllqkb5dgl7Gmv0r2Qq+G1Q0bBJsYHyp3sXIySEhYCKx
        qP0nYxcjF4eQwFJGiYaX05m6GDmAEjISx9eXQdQIS/y51sUGUfOaUeJE6wMmkISwgIfE/H1H
        2EFsEQEliY/th8BsZoEIie5XZ6Aa1jFKNO1dBtbAJmAlMbF9FSOIzStgJ7H2eSdYA4uAikTr
        7J0sILYoUPPhHbOgagQlTs58wgJyEKeAscSXRWUQ89Ul/sy7xAxhi0vcejKfCcKWl9j+dg7z
        BEahWUi6ZyFpmYWkZRaSlgWMLKsYRVJLi3PTc4sN9YoTc4tL89L1kvNzNzECo2jbsZ+bdzBe
        2hh8iFGAg1GJhzeAOTZOiDWxrLgy9xCjBAezkgivL2d0nBBvSmJlVWpRfnxRaU5q8SFGU6Df
        JjJLiSbnAyM8ryTe0NTQ3MLS0NzY3NjMQkmct0PgYIyQQHpiSWp2ampBahFMHxMHp1QDY7zK
        qxWzzxzb/3Lb+/9lbs9PzjKqttM5vf+YzzNugb0STke/37UWDpNJfv314Z55bY+W7dKe+i0k
        xumjW2PV77UvDZasTTZzqH/+iHG/xOvZSUti5v4tVpgk9d7PqFDXcnrCK9bUQ6t7ZSuj7sop
        3O2OlI6Lf7PSb/tP0/TFTDVH2X1l1l3g/63EUpyRaKjFXFScCAAWiOSduAIAAA==
X-CMS-MailID: 20200302173418eucas1p1edaf987ba0cf4aae9c6209430afccb10
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200213095437eucas1p25c3da9b8a3daf00515d938e57de8da94
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200213095437eucas1p25c3da9b8a3daf00515d938e57de8da94
References: <20200213095412.23773-1-hare@suse.de>
        <CGME20200213095437eucas1p25c3da9b8a3daf00515d938e57de8da94@eucas1p2.samsung.com>
        <20200213095412.23773-19-hare@suse.de>
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org


On 2/13/20 10:53 AM, Hannes Reinecke wrote:
> Bus-master DMA is now logged with generic tracepoints, so we can
> drop the DPRINTK() calls here.

..drop DPRINTK(), VPRINTK() and dev_dbg() calls here.

Also please replace "DPRINTK" with "debugging" in the patch summary.

With the above fixes:

Reviewed-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

> Signed-off-by: Hannes Reinecke <hare@suse.de>
> ---
>  drivers/ata/libata-sff.c        | 18 +-----------------
>  drivers/ata/pata_octeon_cf.c    | 10 ++--------
>  drivers/ata/pata_pdc202xx_old.c |  2 --
>  drivers/ata/pata_sil680.c       |  1 -
>  drivers/ata/sata_dwc_460ex.c    | 18 ++++--------------
>  drivers/ata/sata_rcar.c         |  2 --
>  6 files changed, 7 insertions(+), 44 deletions(-)
> 
> diff --git a/drivers/ata/libata-sff.c b/drivers/ata/libata-sff.c
> index e2d1504f7562..1078b621d47b 100644
> --- a/drivers/ata/libata-sff.c
> +++ b/drivers/ata/libata-sff.c
> @@ -413,12 +413,6 @@ void ata_sff_tf_load(struct ata_port *ap, const struct ata_taskfile *tf)
>  		iowrite8(tf->hob_lbal, ioaddr->lbal_addr);
>  		iowrite8(tf->hob_lbam, ioaddr->lbam_addr);
>  		iowrite8(tf->hob_lbah, ioaddr->lbah_addr);
> -		VPRINTK("hob: feat 0x%X nsect 0x%X, lba 0x%X 0x%X 0x%X\n",
> -			tf->hob_feature,
> -			tf->hob_nsect,
> -			tf->hob_lbal,
> -			tf->hob_lbam,
> -			tf->hob_lbah);
>  	}
>  
>  	if (is_addr) {
> @@ -427,18 +421,10 @@ void ata_sff_tf_load(struct ata_port *ap, const struct ata_taskfile *tf)
>  		iowrite8(tf->lbal, ioaddr->lbal_addr);
>  		iowrite8(tf->lbam, ioaddr->lbam_addr);
>  		iowrite8(tf->lbah, ioaddr->lbah_addr);
> -		VPRINTK("feat 0x%X nsect 0x%X lba 0x%X 0x%X 0x%X\n",
> -			tf->feature,
> -			tf->nsect,
> -			tf->lbal,
> -			tf->lbam,
> -			tf->lbah);
>  	}
>  
> -	if (tf->flags & ATA_TFLAG_DEVICE) {
> +	if (tf->flags & ATA_TFLAG_DEVICE)
>  		iowrite8(tf->device, ioaddr->device_addr);
> -		VPRINTK("device 0x%X\n", tf->device);
> -	}
>  
>  	ata_wait_idle(ap);
>  }
> @@ -498,8 +484,6 @@ EXPORT_SYMBOL_GPL(ata_sff_tf_read);
>   */
>  void ata_sff_exec_command(struct ata_port *ap, const struct ata_taskfile *tf)
>  {
> -	DPRINTK("ata%u: cmd 0x%X\n", ap->print_id, tf->command);
> -
>  	iowrite8(tf->command, ap->ioaddr.command_addr);
>  	ata_sff_pause(ap);
>  }
> diff --git a/drivers/ata/pata_octeon_cf.c b/drivers/ata/pata_octeon_cf.c
> index 7c87168a1932..9b66552efbd2 100644
> --- a/drivers/ata/pata_octeon_cf.c
> +++ b/drivers/ata/pata_octeon_cf.c
> @@ -514,20 +514,14 @@ static void octeon_cf_exec_command16(struct ata_port *ap,
>  {
>  	/* The base of the registers is at ioaddr.data_addr. */
>  	void __iomem *base = ap->ioaddr.data_addr;
> -	u16 blob;
> +	u16 blob = 0;
>  
> -	if (tf->flags & ATA_TFLAG_DEVICE) {
> -		VPRINTK("device 0x%X\n", tf->device);
> +	if (tf->flags & ATA_TFLAG_DEVICE)
>  		blob = tf->device;
> -	} else {
> -		blob = 0;
> -	}
>  
> -	DPRINTK("ata%u: cmd 0x%X\n", ap->print_id, tf->command);
>  	blob |= (tf->command << 8);
>  	__raw_writew(blob, base + 6);
>  
> -
>  	ata_wait_idle(ap);
>  }
>  
> diff --git a/drivers/ata/pata_pdc202xx_old.c b/drivers/ata/pata_pdc202xx_old.c
> index 378ed9ea97e9..3778270e762f 100644
> --- a/drivers/ata/pata_pdc202xx_old.c
> +++ b/drivers/ata/pata_pdc202xx_old.c
> @@ -38,8 +38,6 @@ static int pdc2026x_cable_detect(struct ata_port *ap)
>  static void pdc202xx_exec_command(struct ata_port *ap,
>  				  const struct ata_taskfile *tf)
>  {
> -	DPRINTK("ata%u: cmd 0x%X\n", ap->print_id, tf->command);
> -
>  	iowrite8(tf->command, ap->ioaddr.command_addr);
>  	ndelay(400);
>  }
> diff --git a/drivers/ata/pata_sil680.c b/drivers/ata/pata_sil680.c
> index 7ab9aea3b630..42ea13dd4ace 100644
> --- a/drivers/ata/pata_sil680.c
> +++ b/drivers/ata/pata_sil680.c
> @@ -211,7 +211,6 @@ static void sil680_set_dmamode(struct ata_port *ap, struct ata_device *adev)
>  static void sil680_sff_exec_command(struct ata_port *ap,
>  				    const struct ata_taskfile *tf)
>  {
> -	DPRINTK("ata%u: cmd 0x%X\n", ap->print_id, tf->command);
>  	iowrite8(tf->command, ap->ioaddr.command_addr);
>  	ioread8(ap->ioaddr.bmdma_addr + ATA_DMA_CMD);
>  }
> diff --git a/drivers/ata/sata_dwc_460ex.c b/drivers/ata/sata_dwc_460ex.c
> index 9dcef6ac643b..ef07d4a03627 100644
> --- a/drivers/ata/sata_dwc_460ex.c
> +++ b/drivers/ata/sata_dwc_460ex.c
> @@ -970,9 +970,6 @@ static void sata_dwc_exec_command_by_tag(struct ata_port *ap,
>  {
>  	struct sata_dwc_device_port *hsdevp = HSDEVP_FROM_AP(ap);
>  
> -	dev_dbg(ap->dev, "%s cmd(0x%02x): %s tag=%d\n", __func__, tf->command,
> -		ata_get_cmd_descript(tf->command), tag);
> -
>  	hsdevp->cmd_issued[tag] = cmd_issued;
>  
>  	/*
> @@ -995,12 +992,9 @@ static void sata_dwc_bmdma_setup(struct ata_queued_cmd *qc)
>  {
>  	u8 tag = qc->hw_tag;
>  
> -	if (ata_is_ncq(qc->tf.protocol)) {
> -		dev_dbg(qc->ap->dev, "%s: ap->link.sactive=0x%08x tag=%d\n",
> -			__func__, qc->ap->link.sactive, tag);
> -	} else {
> +	if (!ata_is_ncq(qc->tf.protocol))
>  		tag = 0;
> -	}
> +
>  	sata_dwc_bmdma_setup_by_tag(qc, tag);
>  }
>  
> @@ -1057,13 +1051,9 @@ static void sata_dwc_bmdma_start(struct ata_queued_cmd *qc)
>  {
>  	u8 tag = qc->hw_tag;
>  
> -	if (ata_is_ncq(qc->tf.protocol)) {
> -		dev_dbg(qc->ap->dev, "%s: ap->link.sactive=0x%08x tag=%d\n",
> -			__func__, qc->ap->link.sactive, tag);
> -	} else {
> +	if (!ata_is_ncq(qc->tf.protocol))
>  		tag = 0;
> -	}
> -	dev_dbg(qc->ap->dev, "%s\n", __func__);
> +
>  	sata_dwc_bmdma_start_by_tag(qc, tag);
>  }
>  
> diff --git a/drivers/ata/sata_rcar.c b/drivers/ata/sata_rcar.c
> index 1b42be234761..0925a0564cc5 100644
> --- a/drivers/ata/sata_rcar.c
> +++ b/drivers/ata/sata_rcar.c
> @@ -436,8 +436,6 @@ static void sata_rcar_tf_read(struct ata_port *ap, struct ata_taskfile *tf)
>  static void sata_rcar_exec_command(struct ata_port *ap,
>  				   const struct ata_taskfile *tf)
>  {
> -	DPRINTK("ata%u: cmd 0x%X\n", ap->print_id, tf->command);
> -
>  	iowrite32(tf->command, ap->ioaddr.command_addr);
>  	ata_sff_pause(ap);
>  }
> 
