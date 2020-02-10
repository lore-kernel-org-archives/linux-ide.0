Return-Path: <SRS0=vLfT=36=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E258C352A3
	for <linux-ide@archiver.kernel.org>; Mon, 10 Feb 2020 13:25:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E5E820733
	for <linux-ide@archiver.kernel.org>; Mon, 10 Feb 2020 13:25:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="ezwLwocw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729539AbgBJNZx (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 10 Feb 2020 08:25:53 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:33689 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728012AbgBJNZw (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 10 Feb 2020 08:25:52 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20200210132551euoutp01614f0194fc239c71acfee2316c2070ac~yDWYg8LLR2025620256euoutp01Y
        for <linux-ide@vger.kernel.org>; Mon, 10 Feb 2020 13:25:51 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20200210132551euoutp01614f0194fc239c71acfee2316c2070ac~yDWYg8LLR2025620256euoutp01Y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1581341151;
        bh=i4FdHcSz/wNx9hqo+RtKnV6gHGj9ldmwQ6TU12WKJhc=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=ezwLwocwfqRdsXWQaaFLq6gQC8nkqrY4P/H85G84qF0nP8sVdq+WBiS8dvSC1xOqT
         UonNFsEFUZD2PD+YSHdcwAAEHHWUqPUSZZzQbBW3E5enJcGT63kZRJqh6TGHQKNlL0
         jiKOIE5pHzkMcERkganT4ctOYR8Q7cLlytscxLeY=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200210132551eucas1p26bf5e509a0bd10f4f92408c6f378eeb1~yDWYS_67A0519705197eucas1p2c;
        Mon, 10 Feb 2020 13:25:51 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 52.16.60679.FD9514E5; Mon, 10
        Feb 2020 13:25:51 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200210132550eucas1p133c217adbb80dd20a838ec1693c0f6ca~yDWYCggPt0126101261eucas1p1s;
        Mon, 10 Feb 2020 13:25:50 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200210132550eusmtrp1583c037ecb987f49144ff948bfcabc35~yDWYB9oCG0678706787eusmtrp1i;
        Mon, 10 Feb 2020 13:25:50 +0000 (GMT)
X-AuditID: cbfec7f4-0cbff7000001ed07-a9-5e4159df14d3
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 9A.7C.08375.ED9514E5; Mon, 10
        Feb 2020 13:25:50 +0000 (GMT)
Received: from [106.120.51.71] (unknown [106.120.51.71]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200210132550eusmtip1329d56e478a283e3ef76c6d9c8d9a825~yDWXi2O1Y2592725927eusmtip1W;
        Mon, 10 Feb 2020 13:25:50 +0000 (GMT)
Subject: Re: [PATCH 11/46] sata_nv: move DPRINTK to ata debugging
To:     Hannes Reinecke <hare@suse.de>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-ide@vger.kernel.org,
        Hannes Reinecke <hare@suse.com>
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Message-ID: <249ba478-6f55-9236-1f5a-86f771080220@samsung.com>
Date:   Mon, 10 Feb 2020 14:25:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20200204165547.115220-12-hare@suse.de>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprKKsWRmVeSWpSXmKPExsWy7djP87r3Ix3jDNae57JYfbefzWLBm71s
        FnsWTWKyOLbjEZMDi8fls6Ue67dcZfHYfLra4/MmuQCWKC6blNSczLLUIn27BK6MR1/2sxX8
        UajoO/2TtYFxnVQXIyeHhICJxKvZt5m6GLk4hARWMEqcePyQFcL5wiixc+t3qMxnRokDey8w
        wbT8mn+IESKxnFHi4ZEDzBDOW0aJo7fPgVUJCzhK/O/oZgSxRQSUJD62H2IHsZkF4iSartwF
        s9kErCQmtq8Cq+EVsJM4+OcTmM0ioCpx5uJ1NhBbVCBC4tODw6wQNYISJ2c+YQGxOYGu6OpZ
        yQQxU1zi1pP5ULa8xPa3c8AOkhDoZ5d4s/IJI8TZLhLHW/cyQ9jCEq+Ob2GHsGUkTk/uYYFo
        WMco8bfjBVT3dkaJ5ZP/sUFUWUvcOfcLyOYAWqEpsX6XPogpAfTl9F5vCJNP4sZbQYgb+CQm
        bZvODBHmlehoE4KYoSaxYdkGNpitXTtXMk9gVJqF5LNZSL6ZheSbWQhrFzCyrGIUTy0tzk1P
        LTbKSy3XK07MLS7NS9dLzs/dxAhMLKf/Hf+yg3HXn6RDjAIcjEo8vBWBjnFCrIllxZW5hxgl
        OJiVRHgtpYFCvCmJlVWpRfnxRaU5qcWHGKU5WJTEeY0XvYwVEkhPLEnNTk0tSC2CyTJxcEo1
        MIr/XTd5fb7Cgdkps4wcZ/ZkHLsRoqm8tOuyQ4jJg+SgiXIMk+77cXoUek3w6W/Rke7fofC9
        YeWytTvYJGV9esQNNH8IXDe1Xfr541uLzYprZMs3LumJ+7/93423+d/WxeUdmWctPqMooE+O
        18XRW3Vd5NctpqUtAll5rzUmfmBZ62F0TCF1ohJLcUaioRZzUXEiADjXOBMoAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrGIsWRmVeSWpSXmKPExsVy+t/xu7r3Ih3jDO51G1msvtvPZrHgzV42
        iz2LJjFZHNvxiMmBxePy2VKP9VuusnhsPl3t8XmTXABLlJ5NUX5pSapCRn5xia1StKGFkZ6h
        pYWekYmlnqGxeayVkamSvp1NSmpOZllqkb5dgl7Goy/72Qr+KFT0nf7J2sC4TqqLkZNDQsBE
        4tf8Q4xdjFwcQgJLGSVuXrjP0sXIAZSQkTi+vgyiRljiz7UuNhBbSOA1o8T+IxYgtrCAo8T/
        jm5GEFtEQEniY/shdhCbWSBO4l/fbiaImRsYJQ7/fsYKkmATsJKY2L4KrIFXwE7i4J9PYDaL
        gKrEmYvXwRaICkRIHN4xC6pGUOLkzCcsIDYn0KFdPSuZIBaoS/yZd4kZwhaXuPVkPlRcXmL7
        2znMExiFZiFpn4WkZRaSlllIWhYwsqxiFEktLc5Nzy021CtOzC0uzUvXS87P3cQIjKNtx35u
        3sF4aWPwIUYBDkYlHt6KQMc4IdbEsuLK3EOMEhzMSiK8ltJAId6UxMqq1KL8+KLSnNTiQ4ym
        QM9NZJYSTc4HxnheSbyhqaG5haWhubG5sZmFkjhvh8DBGCGB9MSS1OzU1ILUIpg+Jg5OqQbG
        4MneT0XWXZG77CF7RI37ZamV49qqyZcbLvNe/u5S1CyfLsrspvrZSl72fXHfKRdfdzsFtUm6
        GZeY61maV+q+zb+7dOMi87oN3LLWlyq4XaPDVX45dDhIL34SGnw17nWk6eKvHiWsB3pnHP8U
        HHGF1ed1fcbH6dsz9uczbmdcbLOucU32mmVKLMUZiYZazEXFiQCRip32uQIAAA==
X-CMS-MailID: 20200210132550eucas1p133c217adbb80dd20a838ec1693c0f6ca
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200204165612eucas1p1f0f3866f82e8ac7fe7573ecc3ad03094
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200204165612eucas1p1f0f3866f82e8ac7fe7573ecc3ad03094
References: <20200204165547.115220-1-hare@suse.de>
        <CGME20200204165612eucas1p1f0f3866f82e8ac7fe7573ecc3ad03094@eucas1p1.samsung.com>
        <20200204165547.115220-12-hare@suse.de>
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org


On 2/4/20 5:55 PM, Hannes Reinecke wrote:
> From: Hannes Reinecke <hare@suse.com>
> 
> Replace all DPRINTK calls with the ata_XXX_dbg functions.
> 
> Signed-off-by: Hannes Reinecke <hare@suse.de>
> ---
>  drivers/ata/sata_nv.c | 24 ++++++++++++------------
>  1 file changed, 12 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/ata/sata_nv.c b/drivers/ata/sata_nv.c
> index 8639f66706a3..0cbddad7cd12 100644
> --- a/drivers/ata/sata_nv.c
> +++ b/drivers/ata/sata_nv.c
> @@ -1394,7 +1394,7 @@ static unsigned int nv_adma_qc_issue(struct ata_queued_cmd *qc)
>  	void __iomem *mmio = pp->ctl_block;
>  	int curr_ncq = (qc->tf.protocol == ATA_PROT_NCQ);
>  
> -	VPRINTK("ENTER\n");
> +	ata_dev_dbg(qc->dev, "ENTER\n");

This is VPRINTK() instance so it should be either left
alone or documented in the patch description.

Otherwise the patch looks fine.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

>  	/* We can't handle result taskfile with NCQ commands, since
>  	   retrieving the taskfile switches us out of ADMA mode and would abort
> @@ -1428,7 +1428,7 @@ static unsigned int nv_adma_qc_issue(struct ata_queued_cmd *qc)
>  
>  	writew(qc->hw_tag, mmio + NV_ADMA_APPEND);
>  
> -	DPRINTK("Issued tag %u\n", qc->hw_tag);
> +	ata_dev_dbg(qc->dev, "Issued tag %u\n", qc->hw_tag);
>  
>  	return 0;
>  }
> @@ -2007,7 +2007,7 @@ static unsigned int nv_swncq_issue_atacmd(struct ata_port *ap,
>  	if (qc == NULL)
>  		return 0;
>  
> -	DPRINTK("Enter\n");
> +	ata_port_dbg(ap, "Enter\n");
>  
>  	writel((1 << qc->hw_tag), pp->sactive_block);
>  	pp->last_issue_tag = qc->hw_tag;
> @@ -2018,7 +2018,7 @@ static unsigned int nv_swncq_issue_atacmd(struct ata_port *ap,
>  	ap->ops->sff_tf_load(ap, &qc->tf);	 /* load tf registers */
>  	ap->ops->sff_exec_command(ap, &qc->tf);
>  
> -	DPRINTK("Issued tag %u\n", qc->hw_tag);
> +	ata_port_dbg(ap, "Issued tag %u\n", qc->hw_tag);
>  
>  	return 0;
>  }
> @@ -2031,7 +2031,7 @@ static unsigned int nv_swncq_qc_issue(struct ata_queued_cmd *qc)
>  	if (qc->tf.protocol != ATA_PROT_NCQ)
>  		return ata_bmdma_qc_issue(qc);
>  
> -	DPRINTK("Enter\n");
> +	ata_port_dbg(ap, "Enter\n");
>  
>  	if (!pp->qc_active)
>  		nv_swncq_issue_atacmd(ap, qc);
> @@ -2099,7 +2099,7 @@ static int nv_swncq_sdbfis(struct ata_port *ap)
>  	ata_qc_complete_multiple(ap, ap->qc_active ^ done_mask);
>  
>  	if (!ap->qc_active) {
> -		DPRINTK("over\n");
> +		ata_port_dbg(ap, "over\n");
>  		nv_swncq_pp_reinit(ap);
>  		return 0;
>  	}
> @@ -2114,10 +2114,10 @@ static int nv_swncq_sdbfis(struct ata_port *ap)
>  		 */
>  		lack_dhfis = 1;
>  
> -	DPRINTK("id 0x%x QC: qc_active 0x%x,"
> +	ata_port_dbg(ap, "QC: qc_active 0x%llx,"
>  		"SWNCQ:qc_active 0x%X defer_bits %X "
>  		"dhfis 0x%X dmafis 0x%X last_issue_tag %x\n",
> -		ap->print_id, ap->qc_active, pp->qc_active,
> +		ap->qc_active, pp->qc_active,
>  		pp->defer_queue.defer_bits, pp->dhfis_bits,
>  		pp->dmafis_bits, pp->last_issue_tag);
>  
> @@ -2159,7 +2159,7 @@ static void nv_swncq_dmafis(struct ata_port *ap)
>  	__ata_bmdma_stop(ap);
>  	tag = nv_swncq_tag(ap);
>  
> -	DPRINTK("dma setup tag 0x%x\n", tag);
> +	ata_port_dbg(ap, "dma setup tag 0x%x\n", tag);
>  	qc = ata_qc_from_tag(ap, tag);
>  
>  	if (unlikely(!qc))
> @@ -2227,9 +2227,9 @@ static void nv_swncq_host_interrupt(struct ata_port *ap, u16 fis)
>  
>  	if (fis & NV_SWNCQ_IRQ_SDBFIS) {
>  		pp->ncq_flags |= ncq_saw_sdb;
> -		DPRINTK("id 0x%x SWNCQ: qc_active 0x%X "
> +		ata_port_dbg(ap, "SWNCQ: qc_active 0x%X "
>  			"dhfis 0x%X dmafis 0x%X sactive 0x%X\n",
> -			ap->print_id, pp->qc_active, pp->dhfis_bits,
> +			pp->qc_active, pp->dhfis_bits,
>  			pp->dmafis_bits, readl(pp->sactive_block));
>  		if (nv_swncq_sdbfis(ap) < 0)
>  			goto irq_error;
> @@ -2255,7 +2255,7 @@ static void nv_swncq_host_interrupt(struct ata_port *ap, u16 fis)
>  				goto irq_exit;
>  
>  			if (pp->defer_queue.defer_bits) {
> -				DPRINTK("send next command\n");
> +				ata_port_dbg(ap, "send next command\n");
>  				qc = nv_swncq_qc_from_dq(ap);
>  				nv_swncq_issue_atacmd(ap, qc);
>  			}
> 
