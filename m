Return-Path: <SRS0=S1Gt=3T=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB484C33C9E
	for <linux-ide@archiver.kernel.org>; Thu, 30 Jan 2020 10:46:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2B05206D3
	for <linux-ide@archiver.kernel.org>; Thu, 30 Jan 2020 10:46:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="PJrGfrB/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726885AbgA3KqS (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 30 Jan 2020 05:46:18 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:49533 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726873AbgA3KqS (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 30 Jan 2020 05:46:18 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20200130104617euoutp014ca83c74547922dd12a8ff9f59aae7c6~upE6sAPFm2841428414euoutp01x
        for <linux-ide@vger.kernel.org>; Thu, 30 Jan 2020 10:46:17 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20200130104617euoutp014ca83c74547922dd12a8ff9f59aae7c6~upE6sAPFm2841428414euoutp01x
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1580381177;
        bh=Gb5n73ShlbJFYuYmZANamgHNUj2FMPNqHIf7zh8E+/g=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=PJrGfrB/F5H9iozvVStgvbsha2astFoC3HQIL/Yzd9DUrPKbxOHT0mz5Tx4yxUosP
         zhIXhwojwi/PL4g+6hJQBNTYBkhUWld2WxqQI3Bfrkzuv0QgXsmDk9sERtltsAJLur
         8sqVjuC9ssSD385vrs1EQkg0vNzVWiW0COHeyB7I=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200130104616eucas1p143636bca7b30f98b4420e5769c70928b~upE6dRdNE3168731687eucas1p1o;
        Thu, 30 Jan 2020 10:46:16 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 47.19.60698.8F3B23E5; Thu, 30
        Jan 2020 10:46:16 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200130104616eucas1p1b6876ff57fedcdb7fb04b49c2a05a1ea~upE6PsgZn0357503575eucas1p1T;
        Thu, 30 Jan 2020 10:46:16 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200130104616eusmtrp15f07fa430d6be69b03db1a3f17f5e6fb~upE6PHQdI0942409424eusmtrp1e;
        Thu, 30 Jan 2020 10:46:16 +0000 (GMT)
X-AuditID: cbfec7f5-a0fff7000001ed1a-83-5e32b3f82f9c
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id E5.3E.08375.8F3B23E5; Thu, 30
        Jan 2020 10:46:16 +0000 (GMT)
Received: from [106.120.51.71] (unknown [106.120.51.71]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200130104616eusmtip1d27b5c869d5ea5d4d8daafc5439b1f31~upE57DO7_1192711927eusmtip15;
        Thu, 30 Jan 2020 10:46:16 +0000 (GMT)
Subject: Re: [PATCH 02/24] sata_nv: move DPRINTK to ata debugging
To:     Hannes Reinecke <hare@suse.de>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-ide@vger.kernel.org,
        Hannes Reinecke <hare@suse.com>
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Message-ID: <9e9442f4-a8b1-71ac-dabc-a91496f3af78@samsung.com>
Date:   Thu, 30 Jan 2020 11:46:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20181213104716.31930-13-hare@suse.de>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprKKsWRmVeSWpSXmKPExsWy7djP87o/NhvFGXQ2GVisvtvPZrHgzV42
        iz2LJjFZHNvxiMmBxePy2VKP9VuusnhsPl3t8XmTXABLFJdNSmpOZllqkb5dAlfGs3X72AoO
        yFVsb37G1MC4QKKLkZNDQsBEYsPdu2xdjFwcQgIrGCXatzcwgiSEBL4wSlzb6AuR+Mwo0d/8
        khGm4/utVywQieWMEudnbIJy3jJKLPn7khWkSljAUWLy4YvMILaIgJLEx/ZD7CA2s0CcRNOV
        u2A2m4CVxMT2VWBTeQXsJCZ2zAWrZxFQlXj9cRsTiC0qECHx6cFhVogaQYmTM5+wgNicAsYS
        nWf+Qs0Ul7j1ZD4ThC0vsf3tHGaQgyQEJrNL/Fx8GepsF4nZN18zQdjCEq+Ob2GHsGUkTk/u
        YYFoWMco8bfjBVT3dkaJ5ZP/sUFUWUvcOfcLyOYAWqEpsX6XPkTYUWJ23yxWkLCEAJ/EjbeC
        EEfwSUzaNp0ZIswr0dEmBFGtJrFh2QY2mLVdO1cyT2BUmoXktVlI3pmF5J1ZCHsXMLKsYhRP
        LS3OTU8tNs5LLdcrTswtLs1L10vOz93ECEwsp/8d/7qDcd+fpEOMAhyMSjy8GhuM4oRYE8uK
        K3MPMUpwMCuJ8Iq6GsYJ8aYkVlalFuXHF5XmpBYfYpTmYFES5zVe9DJWSCA9sSQ1OzW1ILUI
        JsvEwSnVwLg8Kkjg20kXc4XnfYlTt29Yr1tbdlBnoXj+8gTVgrmmU4oqVHfVcOv3f+PnzWxX
        W+DszSbruXvew4hXOjdnfLe7/Eh/9ZG2f29XrHQ1FV/0edEx+5gWpeSWHhOTjsmW81eyJJ6U
        F7Jbfe+KQdod30BnltXl5YcnPbng4ztRzK5SdGpV9SfhNiWW4oxEQy3mouJEANHijs4oAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrGIsWRmVeSWpSXmKPExsVy+t/xu7o/NhvFGTT+lbdYfbefzWLBm71s
        FnsWTWKyOLbjEZMDi8fls6Ue67dcZfHYfLra4/MmuQCWKD2bovzSklSFjPziElulaEMLIz1D
        Sws9IxNLPUNj81grI1MlfTublNSczLLUIn27BL2MZ+v2sRUckKvY3vyMqYFxgUQXIyeHhICJ
        xPdbr1i6GLk4hASWMkq0LT3K1sXIAZSQkTi+vgyiRljiz7UuNoia14wSH360M4MkhAUcJSYf
        vghmiwgoSXxsP8QOYjMLxEn869vNBGILCaxjlPj5zgTEZhOwkpjYvooRxOYVsJOY2DEXrJdF
        QFXi9cdtYPWiAhESh3fMgqoRlDg58wkLiM0pYCzReeYv1Hx1iT/zLjFD2OISt57MZ4Kw5SW2
        v53DPIFRaBaS9llIWmYhaZmFpGUBI8sqRpHU0uLc9NxiQ73ixNzi0rx0veT83E2MwDjaduzn
        5h2MlzYGH2IU4GBU4uHV2GAUJ8SaWFZcmXuIUYKDWUmEV9TVME6INyWxsiq1KD++qDQntfgQ
        oynQcxOZpUST84ExnlcSb2hqaG5haWhubG5sZqEkztshcDBGSCA9sSQ1OzW1ILUIpo+Jg1Oq
        gTEibVHarerLnILbRFZmcIr4rPoyK343c8hpccUrF15pzAz7N1mWd5ryZoudlTce7fV03tGx
        +n52wg3NrvgcH961a5tY9u19p53569azL9J6EzYsy3ofaeW430Ln4tKgzTWMtR51db3tmx5O
        7pBgYVh3fKHIilU/99+5zZK2Z7e2Td051gTL3l1KLMUZiYZazEXFiQAdCEKVuQIAAA==
X-CMS-MailID: 20200130104616eucas1p1b6876ff57fedcdb7fb04b49c2a05a1ea
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20181213104751epcas1p46f3208764bdb8b6a0c03ff234cbe61bf
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20181213104751epcas1p46f3208764bdb8b6a0c03ff234cbe61bf
References: <20181213104716.31930-1-hare@suse.de>
        <CGME20181213104751epcas1p46f3208764bdb8b6a0c03ff234cbe61bf@epcas1p4.samsung.com>
        <20181213104716.31930-13-hare@suse.de>
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org


On 12/13/18 11:46 AM, Hannes Reinecke wrote:
> Replace all DPRINTK calls with the ata_XXX_dbg functions.
> 
> Signed-off-by: Hannes Reinecke <hare@suse.com>
> ---
>  drivers/ata/sata_nv.c | 22 ++++++++++------------
>  1 file changed, 10 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/ata/sata_nv.c b/drivers/ata/sata_nv.c
> index 72c9b922a77b..aa2611d638ea 100644
> --- a/drivers/ata/sata_nv.c
> +++ b/drivers/ata/sata_nv.c
> @@ -1451,7 +1451,7 @@ static unsigned int nv_adma_qc_issue(struct ata_queued_cmd *qc)
>  
>  	writew(qc->hw_tag, mmio + NV_ADMA_APPEND);
>  
> -	DPRINTK("Issued tag %u\n", qc->hw_tag);
> +	ata_dev_dbg(qc->dev, "Issued tag %u\n", qc->hw_tag);

Please preserve __func__ printing in the conversion.
 
>  	return 0;
>  }
> @@ -2029,8 +2029,6 @@ static unsigned int nv_swncq_issue_atacmd(struct ata_port *ap,
>  	if (qc == NULL)
>  		return 0;
>  
> -	DPRINTK("Enter\n");
> -

Please either keep it or document the removal in the patch description.

>  	writel((1 << qc->hw_tag), pp->sactive_block);
>  	pp->last_issue_tag = qc->hw_tag;
>  	pp->dhfis_bits &= ~(1 << qc->hw_tag);
> @@ -2040,7 +2038,7 @@ static unsigned int nv_swncq_issue_atacmd(struct ata_port *ap,
>  	ap->ops->sff_tf_load(ap, &qc->tf);	 /* load tf registers */
>  	ap->ops->sff_exec_command(ap, &qc->tf);
>  
> -	DPRINTK("Issued tag %u\n", qc->hw_tag);
> +	ata_dev_dbg(qc->dev, "Issued tag %u\n", qc->hw_tag);

Please preserve __func__ printing in the conversion.
 
>  	return 0;
>  }
> @@ -2053,7 +2051,7 @@ static unsigned int nv_swncq_qc_issue(struct ata_queued_cmd *qc)
>  	if (qc->tf.protocol != ATA_PROT_NCQ)
>  		return ata_bmdma_qc_issue(qc);
>  
> -	DPRINTK("Enter\n");
> +	ata_dev_dbg(qc->dev, "Enter\n");

ditto
 
>  	if (!pp->qc_active)
>  		nv_swncq_issue_atacmd(ap, qc);
> @@ -2121,7 +2119,7 @@ static int nv_swncq_sdbfis(struct ata_port *ap)
>  	ata_qc_complete_multiple(ap, ap->qc_active ^ done_mask);
>  
>  	if (!ap->qc_active) {
> -		DPRINTK("over\n");
> +		ata_port_dbg(ap, "over\n");

ditto

>  		nv_swncq_pp_reinit(ap);
>  		return 0;
>  	}
> @@ -2136,10 +2134,10 @@ static int nv_swncq_sdbfis(struct ata_port *ap)
>  		 */
>  		lack_dhfis = 1;
>  
> -	DPRINTK("id 0x%x QC: qc_active 0x%x,"
> +	ata_port_dbg(ap, "QC: qc_active 0x%llx,"

ditto

>  		"SWNCQ:qc_active 0x%X defer_bits %X "
>  		"dhfis 0x%X dmafis 0x%X last_issue_tag %x\n",
> -		ap->print_id, ap->qc_active, pp->qc_active,
> +		ap->qc_active, pp->qc_active,
>  		pp->defer_queue.defer_bits, pp->dhfis_bits,
>  		pp->dmafis_bits, pp->last_issue_tag);
>  
> @@ -2181,7 +2179,7 @@ static void nv_swncq_dmafis(struct ata_port *ap)
>  	__ata_bmdma_stop(ap);
>  	tag = nv_swncq_tag(ap);
>  
> -	DPRINTK("dma setup tag 0x%x\n", tag);
> +	ata_port_dbg(ap, "dma setup tag 0x%x\n", tag);

ditto

>  	qc = ata_qc_from_tag(ap, tag);
>  
>  	if (unlikely(!qc))
> @@ -2249,9 +2247,9 @@ static void nv_swncq_host_interrupt(struct ata_port *ap, u16 fis)
>  
>  	if (fis & NV_SWNCQ_IRQ_SDBFIS) {
>  		pp->ncq_flags |= ncq_saw_sdb;
> -		DPRINTK("id 0x%x SWNCQ: qc_active 0x%X "
> +		ata_port_dbg(ap, "SWNCQ: qc_active 0x%X "

ditto

>  			"dhfis 0x%X dmafis 0x%X sactive 0x%X\n",
> -			ap->print_id, pp->qc_active, pp->dhfis_bits,
> +			pp->qc_active, pp->dhfis_bits,
>  			pp->dmafis_bits, readl(pp->sactive_block));
>  		if (nv_swncq_sdbfis(ap) < 0)
>  			goto irq_error;
> @@ -2277,7 +2275,7 @@ static void nv_swncq_host_interrupt(struct ata_port *ap, u16 fis)
>  				goto irq_exit;
>  
>  			if (pp->defer_queue.defer_bits) {
> -				DPRINTK("send next command\n");
> +				ata_port_dbg(ap, "send next command\n");

ditto

>  				qc = nv_swncq_qc_from_dq(ap);
>  				nv_swncq_issue_atacmd(ap, qc);
>  			}
> 

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
