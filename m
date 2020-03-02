Return-Path: <SRS0=3I3m=4T=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1678C3F2CD
	for <linux-ide@archiver.kernel.org>; Mon,  2 Mar 2020 17:51:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2A652173E
	for <linux-ide@archiver.kernel.org>; Mon,  2 Mar 2020 17:51:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="k9thf7xz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727159AbgCBRvl (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 2 Mar 2020 12:51:41 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:49640 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727126AbgCBRvl (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 2 Mar 2020 12:51:41 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20200302175139euoutp0262222f62677be0291ffc372c6a3ac065~4jhcq57rG2348023480euoutp02Y
        for <linux-ide@vger.kernel.org>; Mon,  2 Mar 2020 17:51:39 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20200302175139euoutp0262222f62677be0291ffc372c6a3ac065~4jhcq57rG2348023480euoutp02Y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1583171499;
        bh=iEHsbW0VnVtU85aTi7+NRCGGtmTXpFlmrlNDk4PL6ec=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=k9thf7xzg7EdSi3UxXBIP00yCML4F0NY0YNDQd4jBD66iWfLSCYxOnVKL5/bXCzhr
         pEC4wsKFkPTOCw4zVLO0LypHVrpZ2Mo20WwAdbb3zCa+I2zdlE/UV718EWBWi5ijfe
         YmrOYoLhYSb0MFwcIK3AREIz9uPyixKanW2TzP+Y=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200302175138eucas1p200f01d86dfb11b364d373816921ae9f5~4jhccvAsd2640826408eucas1p2q;
        Mon,  2 Mar 2020 17:51:38 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 60.AC.60679.AA74D5E5; Mon,  2
        Mar 2020 17:51:38 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200302175138eucas1p20001ff8c435c7e3226e3d64c48336267~4jhb-L81V2096920969eucas1p2O;
        Mon,  2 Mar 2020 17:51:38 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200302175138eusmtrp293467f7055d7225529821b7daafc9ff1~4jhb_qfjS1569915699eusmtrp2G;
        Mon,  2 Mar 2020 17:51:38 +0000 (GMT)
X-AuditID: cbfec7f4-0cbff7000001ed07-d7-5e5d47aa6031
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 1B.1B.07950.AA74D5E5; Mon,  2
        Mar 2020 17:51:38 +0000 (GMT)
Received: from [106.120.51.71] (unknown [106.120.51.71]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200302175138eusmtip24be744dc0ec95a3d9631342b0ce110db~4jhbsCfB_2919529195eusmtip27;
        Mon,  2 Mar 2020 17:51:38 +0000 (GMT)
Subject: Re: [PATCH 22/42] sata_nv: use generic tracepoints
To:     Hannes Reinecke <hare@suse.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
        linux-ide@vger.kernel.org
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Message-ID: <341f40d3-7388-89a5-33c0-1cff55f6d4fd@samsung.com>
Date:   Mon, 2 Mar 2020 18:51:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20200213095412.23773-23-hare@suse.de>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprMKsWRmVeSWpSXmKPExsWy7djP87qr3GPjDPZdNbFYfbefzWLPoklM
        Fsd2PGKy+LX8KKMDi8fls6Uem1Z1snlsPl3t8XmTXABLFJdNSmpOZllqkb5dAlfG7e7FzAX/
        +Su2dqxgbWB8w9PFyMEhIWAi8WhORRcjJ4eQwApGiZ43Sl2MXED2F0aJ2ad/skE4nxklDs/c
        xghSBdIw49VLVojEckaJrp9HoKreMkrc3PgBrEpYwFri3LMmNhBbREBJ4mP7IXYQm1kgQmLj
        hrVMIDabgJXExPZVjCBn8ArYSZy8aA0SZhFQkTi0ZD7YGFGg8k8PDrOC2LwCghInZz5hAbE5
        BYwlLnRdZoIYKS5x68l8KFteYvvbOcwg90gI9LNL9P6azAxxtYvE/kPzWSBsYYlXx7ewQ9gy
        Ev93gjSDNKxjlPjb8QKqezujxPLJ/9ggqqwl7pz7xQZyKbOApsT6XfoQYUeJ+93HWSDhyCdx
        460gxBF8EpO2TWeGCPNKdLQJQVSrSWxYtoENZm3XzpXMExiVZiF5bRaSd2YheWcWwt4FjCyr
        GMVTS4tz01OLjfJSy/WKE3OLS/PS9ZLzczcxApPK6X/Hv+xg3PUn6RCjAAejEg9vAHNsnBBr
        YllxZe4hRgkOZiURXl/O6Dgh3pTEyqrUovz4otKc1OJDjNIcLErivMaLXsYKCaQnlqRmp6YW
        pBbBZJk4OKUaGGeVT1tYtvTpv2PFvY5NF7vszxicsw7m+t5yv/y1hNYxpWnFvEaVOZt3zJ16
        99LERa2yc7g+17clVCUxCK5sPcir6PzaIaHfYduM9xKlqQa5TPILYkLNlykI/O76uHdWeXD/
        l2PbF1lFTei8MU1hklnUFZZt/zpPxZs6Cknw5Pd8Tr1wZ9rh2UosxRmJhlrMRcWJAMAqLPwm
        AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrGIsWRmVeSWpSXmKPExsVy+t/xe7qr3GPjDKavFLNYfbefzWLPoklM
        Fsd2PGKy+LX8KKMDi8fls6Uem1Z1snlsPl3t8XmTXABLlJ5NUX5pSapCRn5xia1StKGFkZ6h
        pYWekYmlnqGxeayVkamSvp1NSmpOZllqkb5dgl7G7e7FzAX/+Su2dqxgbWB8w9PFyMkhIWAi
        MePVS9YuRi4OIYGljBL/H/1g62LkAErISBxfXwZRIyzx51oXG0TNa0aJNavbWEASwgLWEuee
        NbGB2CICShIf2w+xg9jMAhES3a/OQDWsY5T43nyQESTBJmAlMbF9FSPIAl4BO4mTF61BwiwC
        KhKHlswHKxEF6j28YxaYzSsgKHFy5hOwXZwCxhIXui4zQcxXl/gz7xIzhC0ucevJfKi4vMT2
        t3OYJzAKzULSPgtJyywkLbOQtCxgZFnFKJJaWpybnltspFecmFtcmpeul5yfu4kRGEfbjv3c
        soOx613wIUYBDkYlHt4fDLFxQqyJZcWVuYcYJTiYlUR4fTmj44R4UxIrq1KL8uOLSnNSiw8x
        mgI9N5FZSjQ5HxjjeSXxhqaG5haWhubG5sZmFkrivB0CB2OEBNITS1KzU1MLUotg+pg4OKUa
        GE8/7lY/ImMhGqI+96a0t6nWV4fzSSGVSq6n3+1271/Ys4vdjTX99NHzv6vPVJ1ZOKEhpT3A
        xtRs1gYfX0bW3x/LNv5kjdPtz/ApO/bi3izNKwqm313F7VocZuy7cOnN1o8NvPvYuA2uMdTs
        0X6zZJZua//Cg2fPcgsun7LFm3FVcTCz37YgESWW4oxEQy3mouJEADty1KO5AgAA
X-CMS-MailID: 20200302175138eucas1p20001ff8c435c7e3226e3d64c48336267
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200213095440eucas1p272a76fbb6e1c56529d98a8e99f85e5a2
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200213095440eucas1p272a76fbb6e1c56529d98a8e99f85e5a2
References: <20200213095412.23773-1-hare@suse.de>
        <CGME20200213095440eucas1p272a76fbb6e1c56529d98a8e99f85e5a2@eucas1p2.samsung.com>
        <20200213095412.23773-23-hare@suse.de>
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org


On 2/13/20 10:53 AM, Hannes Reinecke wrote:
> Remove logging messages covered by generic tracepoints and add
> generic tracepoints for internal calls.
> 
> Signed-off-by: Hannes Reinecke <hare@suse.de>

Reviewed-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

> ---
>  drivers/ata/sata_nv.c | 11 +++--------
>  1 file changed, 3 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/ata/sata_nv.c b/drivers/ata/sata_nv.c
> index 8639f66706a3..f7dd32679c8e 100644
> --- a/drivers/ata/sata_nv.c
> +++ b/drivers/ata/sata_nv.c
> @@ -31,6 +31,7 @@
>  #include <scsi/scsi_host.h>
>  #include <scsi/scsi_device.h>
>  #include <linux/libata.h>
> +#include <trace/events/libata.h>
>  
>  #define DRV_NAME			"sata_nv"
>  #define DRV_VERSION			"3.5"
> @@ -1428,8 +1429,6 @@ static unsigned int nv_adma_qc_issue(struct ata_queued_cmd *qc)
>  
>  	writew(qc->hw_tag, mmio + NV_ADMA_APPEND);
>  
> -	DPRINTK("Issued tag %u\n", qc->hw_tag);
> -
>  	return 0;
>  }
>  
> @@ -2007,19 +2006,17 @@ static unsigned int nv_swncq_issue_atacmd(struct ata_port *ap,
>  	if (qc == NULL)
>  		return 0;
>  
> -	DPRINTK("Enter\n");
> -
>  	writel((1 << qc->hw_tag), pp->sactive_block);
>  	pp->last_issue_tag = qc->hw_tag;
>  	pp->dhfis_bits &= ~(1 << qc->hw_tag);
>  	pp->dmafis_bits &= ~(1 << qc->hw_tag);
>  	pp->qc_active |= (0x1 << qc->hw_tag);
>  
> +	trace_ata_tf_load(ap, &qc->tf);
>  	ap->ops->sff_tf_load(ap, &qc->tf);	 /* load tf registers */
> +	trace_ata_exec_command(ap, &qc->tf, qc->hw_tag);
>  	ap->ops->sff_exec_command(ap, &qc->tf);
>  
> -	DPRINTK("Issued tag %u\n", qc->hw_tag);
> -
>  	return 0;
>  }
>  
> @@ -2031,8 +2028,6 @@ static unsigned int nv_swncq_qc_issue(struct ata_queued_cmd *qc)
>  	if (qc->tf.protocol != ATA_PROT_NCQ)
>  		return ata_bmdma_qc_issue(qc);
>  
> -	DPRINTK("Enter\n");
> -
>  	if (!pp->qc_active)
>  		nv_swncq_issue_atacmd(ap, qc);
>  	else
> 

