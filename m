Return-Path: <SRS0=vLfT=36=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE57AC352A3
	for <linux-ide@archiver.kernel.org>; Mon, 10 Feb 2020 15:21:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8547620715
	for <linux-ide@archiver.kernel.org>; Mon, 10 Feb 2020 15:21:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="TAK4OsLz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728779AbgBJPVd (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 10 Feb 2020 10:21:33 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:43643 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727636AbgBJPVd (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 10 Feb 2020 10:21:33 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20200210152131euoutp026ad33f975edacad5df534468c66c9f8d~yE7Xv2enk0932209322euoutp02G
        for <linux-ide@vger.kernel.org>; Mon, 10 Feb 2020 15:21:31 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20200210152131euoutp026ad33f975edacad5df534468c66c9f8d~yE7Xv2enk0932209322euoutp02G
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1581348091;
        bh=Jy0jFfs1gxqz55LME4i4nINiyJ/qES687UdtXvMKnbo=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=TAK4OsLzZwAXOM5L+juqWlkt5EmrV2m5RyqJjWbSvONXtRv/ewqHB0WpKw/mfr2Ia
         4UouYonSy+IBSQQ9tSeAKNUc+t6rAgzL8OlzsczG8Nx2+HWy+t8V07ClwLlwvO+CRx
         P0yfkeB0JLpMU+nfDwQ/XY/G/fcBSijsp+ir2b0I=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200210152131eucas1p1af3a6714c2abebca0fa7167ad19a7e64~yE7Xh1RwQ1261812618eucas1p1G;
        Mon, 10 Feb 2020 15:21:31 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id BB.31.60698.AF4714E5; Mon, 10
        Feb 2020 15:21:30 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200210152130eucas1p18c176aec092584bd19a17ac276c55e8a~yE7XFlMAl1874618746eucas1p1m;
        Mon, 10 Feb 2020 15:21:30 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200210152130eusmtrp236176370de6f1c257a8494c6845d09b4~yE7XFCrD31719017190eusmtrp2w;
        Mon, 10 Feb 2020 15:21:30 +0000 (GMT)
X-AuditID: cbfec7f5-a0fff7000001ed1a-32-5e4174fa4b85
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 65.CE.08375.AF4714E5; Mon, 10
        Feb 2020 15:21:30 +0000 (GMT)
Received: from [106.120.51.71] (unknown [106.120.51.71]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200210152130eusmtip249a8740273c8ed8513b005a497ee6079~yE7WzkahT2360123601eusmtip2Q;
        Mon, 10 Feb 2020 15:21:30 +0000 (GMT)
Subject: Re: [PATCH 24/46] libata: tracepoints for bus-master DMA
To:     Hannes Reinecke <hare@suse.de>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-ide@vger.kernel.org
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Message-ID: <8bf629d0-8e56-8b2c-f170-8d701972a4db@samsung.com>
Date:   Mon, 10 Feb 2020 16:21:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20200204165547.115220-25-hare@suse.de>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupileLIzCtJLcpLzFFi42LZduzned1fJY5xBi2NVhar7/azWexZNInJ
        4tiOR0wOzB6Xz5Z6bD5d7fF5k1wAcxSXTUpqTmZZapG+XQJXxvH7cQUbgyre/OpnbmBsc+pi
        5OSQEDCR2PDzOWsXIxeHkMAKRon/O04xQjhfGCUmNR1mh3A+M0osbN3E1sXIAdZypb8OIr6c
        UWLZ+f9QRW8ZJR7NPccEMldYwFFi1cKTzCC2iICSxMf2Q+wgNrOAtcTsxevBatgErCQmtq9i
        BLF5Bewkvt3cD1bDIqAqsX9NPxuILSoQIfHpwWFWiBpBiZMzn7CA2JxAR3TNbmKEmCkucevJ
        fCYIW15i+9s5zCAHSQj8Z5O49fIEO8SjLhKPfxxnhrCFJV4d3wIVl5H4vxOkGaRhHaPE344X
        UN3bGSWWT/7HBlFlLXHn3C+w/5kFNCXW79KHCDtKTHp9kR0SLHwSN94KQhzBJzFp23RmiDCv
        REebEES1msSGZRvYYNZ27VzJPIFRaRaS12YheWcWkndmIexdwMiyilE8tbQ4Nz212DgvtVyv
        ODG3uDQvXS85P3cTIzCFnP53/OsOxn1/kg4xCnAwKvHwXgh2jBNiTSwrrsw9xCjBwawkwmsp
        DRTiTUmsrEotyo8vKs1JLT7EKM3BoiTOa7zoZayQQHpiSWp2ampBahFMlomDU6qB8eh+7bnb
        lx68KqvVHv1In6mvxP5F6HORewvq3dJLH3XcsRATSHF17fqd+Fsz46f8wjuLUmeeCc2J1jv2
        O23iVDfFVtn73E+1p0ZF+urIXZT8YNTT5Hhl7Wa/iQxRKycuuPp3m9idzg12LpdnZBwxucM/
        a15yXuP5m/VsdroWHz+lSz5xbn5vqcRSnJFoqMVcVJwIAL9Q3HcdAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprNIsWRmVeSWpSXmKPExsVy+t/xe7q/ShzjDLbslbNYfbefzWLPoklM
        Fsd2PGJyYPa4fLbUY/Ppao/Pm+QCmKP0bIryS0tSFTLyi0tslaINLYz0DC0t9IxMLPUMjc1j
        rYxMlfTtbFJSczLLUov07RL0Mo7fjyvYGFTx5lc/cwNjm1MXIweHhICJxJX+ui5GLg4hgaWM
        EivffWSDiMtIHF9f1sXICWQKS/y51sUGUfOaUeL5n2lsIAlhAUeJVQtPMoPYIgJKEh/bD7GD
        2MwC1hKzF69ngmjYwCix6tovVpAEm4CVxMT2VYwgNq+AncS3m/vBGlgEVCX2r+kHGyoqECFx
        eMcsqBpBiZMzn7CA2JxAh3bNbmKEWKAu8WfeJWYIW1zi1pP5TBC2vMT2t3OYJzAKzULSPgtJ
        yywkLbOQtCxgZFnFKJJaWpybnltsqFecmFtcmpeul5yfu4kRGDHbjv3cvIPx0sbgQ4wCHIxK
        PLwVgY5xQqyJZcWVuYcYJTiYlUR4LaWBQrwpiZVVqUX58UWlOanFhxhNgZ6byCwlmpwPjOa8
        knhDU0NzC0tDc2NzYzMLJXHeDoGDMUIC6YklqdmpqQWpRTB9TBycUg2M1n+bOi9+2Xr2p/1X
        dqMTTw7rFDFWbrPqZs8vunPBfYHLoarLidvNzL7XWS1YffjL3U2XPqTdj11fc9zP50bMn0Ou
        v34YRedofLj3W5TvhfPBaoW20zl6Bpwa/7g2udZvX7XrtfeVg0bVs9u2nbWx0Uky7bWya3Oz
        Pjf3844PZ06on/+6cbL2KiWW4oxEQy3mouJEAGiz0+muAgAA
X-CMS-MailID: 20200210152130eucas1p18c176aec092584bd19a17ac276c55e8a
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200204165616eucas1p13cb874125f45a8d6fef797de7cf1f5b1
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200204165616eucas1p13cb874125f45a8d6fef797de7cf1f5b1
References: <20200204165547.115220-1-hare@suse.de>
        <CGME20200204165616eucas1p13cb874125f45a8d6fef797de7cf1f5b1@eucas1p1.samsung.com>
        <20200204165547.115220-25-hare@suse.de>
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org


On 2/4/20 5:55 PM, Hannes Reinecke wrote:
> Add tracepoints for bus-master DMA and taskfile related functions.
> That allows us to drop the relevant DPRINTK() calls.

The patch drops VPRINTK() calls, not DPRINTK() ones.

Also please move the removal to a separate (post-)patch
(like it has been done for reset tracepoints).

> Signed-off-by: Hannes Reinecke <hare@suse.de>
> ---
>  drivers/ata/libata-sff.c      | 41 +++++++++---------
>  include/trace/events/libata.h | 97 +++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 116 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/ata/libata-sff.c b/drivers/ata/libata-sff.c
> index f1799291b4a6..a5e6be6955ae 100644
> --- a/drivers/ata/libata-sff.c
> +++ b/drivers/ata/libata-sff.c
> @@ -22,7 +22,7 @@
>  #include <linux/module.h>
>  #include <linux/libata.h>
>  #include <linux/highmem.h>
> -
> +#include <trace/events/libata.h>
>  #include "libata.h"
>  
>  static struct workqueue_struct *ata_sff_wq;
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
> @@ -509,6 +493,7 @@ EXPORT_SYMBOL_GPL(ata_sff_exec_command);
>   *	ata_tf_to_host - issue ATA taskfile to host controller
>   *	@ap: port to which command is being issued
>   *	@tf: ATA taskfile register set
> + *	@tag: tag of the associated command
>   *
>   *	Issues ATA taskfile register set to ATA host controller,
>   *	with proper synchronization with interrupt handler and
> @@ -518,9 +503,12 @@ EXPORT_SYMBOL_GPL(ata_sff_exec_command);
>   *	spin_lock_irqsave(host lock)
>   */
>  static inline void ata_tf_to_host(struct ata_port *ap,
> -				  const struct ata_taskfile *tf)
> +				  const struct ata_taskfile *tf,
> +				  unsigned int tag)
>  {
> +	trace_ata_tf_load(ap, tf);
>  	ap->ops->sff_tf_load(ap, tf);
> +	trace_ata_exec_command(ap, tf, tag);
>  	ap->ops->sff_exec_command(ap, tf);
>  }
>  
> @@ -753,6 +741,7 @@ static void atapi_send_cdb(struct ata_port *ap, struct ata_queued_cmd *qc)
>  	case ATAPI_PROT_DMA:
>  		ap->hsm_task_state = HSM_ST_LAST;
>  		/* initiate bmdma */
> +		trace_ata_bmdma_start(ap, &qc->tf, qc->tag);
>  		ap->ops->bmdma_start(qc);
>  		break;
>  #endif /* CONFIG_ATA_BMDMA */
> @@ -1361,7 +1350,7 @@ unsigned int ata_sff_qc_issue(struct ata_queued_cmd *qc)
>  		if (qc->tf.flags & ATA_TFLAG_POLLING)
>  			ata_qc_set_polling(qc);
>  
> -		ata_tf_to_host(ap, &qc->tf);
> +		ata_tf_to_host(ap, &qc->tf, qc->tag);

Wouldn't it be easier to simply pass 'qc' to ata_tf_to_host()?

>  		ap->hsm_task_state = HSM_ST_LAST;
>  
>  		if (qc->tf.flags & ATA_TFLAG_POLLING)
> @@ -1373,7 +1362,7 @@ unsigned int ata_sff_qc_issue(struct ata_queued_cmd *qc)
>  		if (qc->tf.flags & ATA_TFLAG_POLLING)
>  			ata_qc_set_polling(qc);
>  
> -		ata_tf_to_host(ap, &qc->tf);
> +		ata_tf_to_host(ap, &qc->tf, qc->tag);
>  
>  		if (qc->tf.flags & ATA_TFLAG_WRITE) {
>  			/* PIO data out protocol */
> @@ -1403,7 +1392,7 @@ unsigned int ata_sff_qc_issue(struct ata_queued_cmd *qc)
>  		if (qc->tf.flags & ATA_TFLAG_POLLING)
>  			ata_qc_set_polling(qc);
>  
> -		ata_tf_to_host(ap, &qc->tf);
> +		ata_tf_to_host(ap, &qc->tf, qc->tag);
>  
>  		ap->hsm_task_state = HSM_ST_FIRST;
>  
> @@ -2737,8 +2726,11 @@ unsigned int ata_bmdma_qc_issue(struct ata_queued_cmd *qc)
>  	case ATA_PROT_DMA:
>  		WARN_ON_ONCE(qc->tf.flags & ATA_TFLAG_POLLING);
>  
> +		trace_ata_tf_load(ap, &qc->tf);
>  		ap->ops->sff_tf_load(ap, &qc->tf);  /* load tf registers */
> +		trace_ata_bmdma_setup(ap, &qc->tf, qc->tag);
>  		ap->ops->bmdma_setup(qc);	    /* set up bmdma */
> +		trace_ata_bmdma_start(ap, &qc->tf, qc->tag);
>  		ap->ops->bmdma_start(qc);	    /* initiate bmdma */
>  		ap->hsm_task_state = HSM_ST_LAST;
>  		break;
> @@ -2746,7 +2738,9 @@ unsigned int ata_bmdma_qc_issue(struct ata_queued_cmd *qc)
>  	case ATAPI_PROT_DMA:
>  		WARN_ON_ONCE(qc->tf.flags & ATA_TFLAG_POLLING);
>  
> +		trace_ata_tf_load(ap, &qc->tf);
>  		ap->ops->sff_tf_load(ap, &qc->tf);  /* load tf registers */
> +		trace_ata_bmdma_setup(ap, &qc->tf, qc->tag);
>  		ap->ops->bmdma_setup(qc);	    /* set up bmdma */
>  		ap->hsm_task_state = HSM_ST_FIRST;
>  
> @@ -2794,6 +2788,7 @@ unsigned int ata_bmdma_port_intr(struct ata_port *ap, struct ata_queued_cmd *qc)
>  			return ata_sff_idle_irq(ap);
>  
>  		/* before we do anything else, clear DMA-Start bit */
> +		trace_ata_bmdma_stop(ap, &qc->tf, qc->tag);
>  		ap->ops->bmdma_stop(qc);
>  		bmdma_stopped = true;
>  
> @@ -2873,6 +2868,7 @@ void ata_bmdma_error_handler(struct ata_port *ap)
>  			thaw = true;
>  		}
>  
> +		trace_ata_bmdma_stop(ap, &qc->tf, qc->tag);
>  		ap->ops->bmdma_stop(qc);
>  
>  		/* if we're gonna thaw, make sure IRQ is clear */
> @@ -2906,6 +2902,7 @@ void ata_bmdma_post_internal_cmd(struct ata_queued_cmd *qc)
>  
>  	if (ata_is_dma(qc->tf.protocol)) {
>  		spin_lock_irqsave(ap->lock, flags);
> +		trace_ata_bmdma_stop(ap, &qc->tf, qc->tag);
>  		ap->ops->bmdma_stop(qc);
>  		spin_unlock_irqrestore(ap->lock, flags);
>  	}
> diff --git a/include/trace/events/libata.h b/include/trace/events/libata.h
> index e9fb4d44eeac..476acf823928 100644
> --- a/include/trace/events/libata.h
> +++ b/include/trace/events/libata.h
> @@ -291,6 +291,103 @@ DEFINE_EVENT(ata_qc_complete_template, ata_qc_complete_done,
>  	     TP_PROTO(struct ata_queued_cmd *qc),
>  	     TP_ARGS(qc));
>  
> +TRACE_EVENT(ata_tf_load,
> +
> +	TP_PROTO(struct ata_port *ap, const struct ata_taskfile *tf),
> +
> +	TP_ARGS(ap, tf),
> +
> +	TP_STRUCT__entry(
> +		__field( unsigned int,	ata_port )
> +		__field( unsigned char,	cmd	)
> +		__field( unsigned char,	dev	)
> +		__field( unsigned char,	lbal	)
> +		__field( unsigned char,	lbam	)
> +		__field( unsigned char,	lbah	)
> +		__field( unsigned char,	nsect	)
> +		__field( unsigned char,	feature	)
> +		__field( unsigned char,	hob_lbal )
> +		__field( unsigned char,	hob_lbam )
> +		__field( unsigned char,	hob_lbah )
> +		__field( unsigned char,	hob_nsect )
> +		__field( unsigned char,	hob_feature )
> +		__field( unsigned char,	proto )
> +		__field( unsigned long,	flags )

'flags' field doesn't seem to be used?

> +	),
> +
> +	TP_fast_assign(
> +		__entry->ata_port	= ap->print_id;
> +		__entry->proto		= tf->protocol;
> +		__entry->cmd		= tf->command;
> +		__entry->dev		= tf->device;
> +		__entry->lbal		= tf->lbal;
> +		__entry->lbam		= tf->lbam;
> +		__entry->lbah		= tf->lbah;
> +		__entry->hob_lbal	= tf->hob_lbal;
> +		__entry->hob_lbam	= tf->hob_lbam;
> +		__entry->hob_lbah	= tf->hob_lbah;
> +		__entry->feature	= tf->feature;
> +		__entry->hob_feature	= tf->hob_feature;
> +		__entry->nsect		= tf->nsect;
> +		__entry->hob_nsect	= tf->hob_nsect;
> +	),
> +
> +	TP_printk("ata_port=%u proto=%s cmd=%s%s " \
> +		  " tf=(%02x/%02x:%02x:%02x:%02x:%02x/%02x:%02x:%02x:%02x:%02x/%02x)",
> +		  __entry->ata_port,
> +		  show_protocol_name(__entry->proto),
> +		  show_opcode_name(__entry->cmd),
> +		  __parse_subcmd(__entry->cmd, __entry->feature, __entry->hob_nsect),
> +		  __entry->cmd, __entry->feature, __entry->nsect,
> +		  __entry->lbal, __entry->lbam, __entry->lbah,
> +		  __entry->hob_feature, __entry->hob_nsect,
> +		  __entry->hob_lbal, __entry->hob_lbam, __entry->hob_lbah,
> +		  __entry->dev)
> +);
> +
> +DECLARE_EVENT_CLASS(ata_exec_command_template,
> +
> +	TP_PROTO(struct ata_port *ap, const struct ata_taskfile *tf, unsigned int tag),
> +
> +	TP_ARGS(ap, tf, tag),
> +
> +	TP_STRUCT__entry(
> +		__field( unsigned int,	ata_port )
> +		__field( unsigned int,	tag	)
> +		__field( unsigned char,	cmd	)
> +		__field( unsigned char,	proto )
> +	),
> +
> +	TP_fast_assign(
> +		__entry->ata_port	= ap->print_id;
> +		__entry->tag		= tag;
> +		__entry->proto		= tf->protocol;
> +		__entry->cmd		= tf->command;
> +	),
> +
> +	TP_printk("ata_port=%u cmd=%s%s tag=%d",
> +		  __entry->ata_port,
> +		  show_protocol_name(__entry->proto),
> +		  show_opcode_name(__entry->cmd),

Please keep both new events consistent regarding 'proto' and
'cmd' fields printing (add "proto=%s" in this event or rework
printing in ata_tf_load one).

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

> +		  __entry->tag)
> +);
> +
> +DEFINE_EVENT(ata_exec_command_template, ata_exec_command,
> +	     TP_PROTO(struct ata_port *ap, const struct ata_taskfile *tf, unsigned int tag),
> +	     TP_ARGS(ap, tf, tag));
> +
> +DEFINE_EVENT(ata_exec_command_template, ata_bmdma_setup,
> +	     TP_PROTO(struct ata_port *ap, const struct ata_taskfile *tf, unsigned int tag),
> +	     TP_ARGS(ap, tf, tag));
> +
> +DEFINE_EVENT(ata_exec_command_template, ata_bmdma_start,
> +	     TP_PROTO(struct ata_port *ap, const struct ata_taskfile *tf, unsigned int tag),
> +	     TP_ARGS(ap, tf, tag));
> +
> +DEFINE_EVENT(ata_exec_command_template, ata_bmdma_stop,
> +	     TP_PROTO(struct ata_port *ap, const struct ata_taskfile *tf, unsigned int tag),
> +	     TP_ARGS(ap, tf, tag));
> +
>  TRACE_EVENT(ata_eh_link_autopsy,
>  
>  	TP_PROTO(struct ata_device *dev, unsigned int eh_action, unsigned int eh_err_mask),
