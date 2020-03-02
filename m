Return-Path: <SRS0=3I3m=4T=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05206C3F2CD
	for <linux-ide@archiver.kernel.org>; Mon,  2 Mar 2020 17:24:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFF35222C4
	for <linux-ide@archiver.kernel.org>; Mon,  2 Mar 2020 17:24:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="qaM9fseN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726980AbgCBRYq (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 2 Mar 2020 12:24:46 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:53038 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726451AbgCBRYp (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 2 Mar 2020 12:24:45 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20200302172444euoutp01972d4c9e2c031d8cac2859966d86253a~4jJ809L4A2768727687euoutp01_
        for <linux-ide@vger.kernel.org>; Mon,  2 Mar 2020 17:24:44 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20200302172444euoutp01972d4c9e2c031d8cac2859966d86253a~4jJ809L4A2768727687euoutp01_
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1583169884;
        bh=Vh7/bjWiQoGmoE28ykl4Pu3TQJiPWNB2YUekRjrSJ1M=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=qaM9fseNYQBbMfhMia9A9U1B8Q+P2nwJECMSW+dTCsBE3s/e4KLeKeX0r+7FunvXg
         J9xny0E80z8O9+OPQkgjDNoeH490F3XnEhxP8WZJCAX64rz0VAzjRh8l0k1I3/JdHY
         vG5nd2laQIec/y3pEfAYgncsYL1jaIg5ZANV9IHY=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200302172444eucas1p2163819287f1f0ad1aa921b37478af61c~4jJ8pv6ld2534625346eucas1p2h;
        Mon,  2 Mar 2020 17:24:44 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 4F.0B.60679.C514D5E5; Mon,  2
        Mar 2020 17:24:44 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200302172443eucas1p1e231bd1910ea5c232a779f734d898fa2~4jJ8Dc8fr0742307423eucas1p1u;
        Mon,  2 Mar 2020 17:24:43 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200302172443eusmtrp256778e1550b9a1a1154ba8dc54cba544~4jJ8C7KlJ3058230582eusmtrp2V;
        Mon,  2 Mar 2020 17:24:43 +0000 (GMT)
X-AuditID: cbfec7f4-0e5ff7000001ed07-71-5e5d415cf9a1
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 69.A9.07950.B514D5E5; Mon,  2
        Mar 2020 17:24:43 +0000 (GMT)
Received: from [106.120.51.71] (unknown [106.120.51.71]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200302172443eusmtip286dea52335b31733b481699b13c64f4d~4jJ7i2jIb0774007740eusmtip2d;
        Mon,  2 Mar 2020 17:24:43 +0000 (GMT)
Subject: Re: [PATCH 17/42] libata: tracepoints for bus-master DMA
To:     Hannes Reinecke <hare@suse.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
        linux-ide@vger.kernel.org
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Message-ID: <47837f23-6727-bb49-5eb0-1b739bd373c5@samsung.com>
Date:   Mon, 2 Mar 2020 18:24:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20200213095412.23773-18-hare@suse.de>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprGKsWRmVeSWpSXmKPExsWy7djPc7oxjrFxBsfusFusvtvPZrFn0SQm
        i2M7HjFZ/Fp+lNGBxePy2VKPTas62Tw2n672+LxJLoAlissmJTUnsyy1SN8ugSvj/exmpoJF
        3hUrzpxgbmB8ZdPFyMkhIWAisXv1F8YuRi4OIYEVjBIrl09hgnC+MEp8PfYGyvnMKPHw7Bxm
        mJb3/cfZIBLLGSWmzrsG1f+WUeJV8z92kCphAUeJD5OmMILYIgJKEh/bD4HFmQUiJDZuWMsE
        YrMJWElMbF8FVsMrYCcxv+ci2AYWARWJBUe2gNmiQPWfHhxmhagRlDg58wkLiM0pYCzRN+Eu
        G8RMcYlbT+YzQdjyEtvfglzKBXRpN7tE7/MjrBBnu0jc/ngUyhaWeHV8CzuELSPxf+d8JoiG
        dYwSfzteQHVvZ5RYPvkfG0SVtcSdc7+AbA6gFZoS63fpQ4QdJR49esAEEpYQ4JO48VYQ4gg+
        iUnbpjNDhHklOtqEIKrVJDYs28AGs7Zr50rmCYxKs5C8NgvJO7OQvDMLYe8CRpZVjOKppcW5
        6anFRnmp5XrFibnFpXnpesn5uZsYganl9L/jX3Yw7vqTdIhRgINRiYc3gDk2Tog1say4MvcQ
        owQHs5IIry9ndJwQb0piZVVqUX58UWlOavEhRmkOFiVxXuNFL2OFBNITS1KzU1MLUotgskwc
        nFINjEnFd3aI80c/uyu30FrpgXz2kpWV6cbaqTev9749PXnjjv8mDKs4lgnIdlYdzs8tWCbu
        8fDrt/RTGnLCWyre5On71e/oWvKnyHrl0q0mD9oii2xvX5A3LvI+8lq24lmcDKf/8hfH4rPX
        Stxi734yuXDej613ZteaTtmyRfntieqfPQfcqiuXnFJiKc5INNRiLipOBAC7o7lxKQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrOIsWRmVeSWpSXmKPExsVy+t/xe7rRjrFxBpOWKFqsvtvPZrFn0SQm
        i2M7HjFZ/Fp+lNGBxePy2VKPTas62Tw2n672+LxJLoAlSs+mKL+0JFUhI7+4xFYp2tDCSM/Q
        0kLPyMRSz9DYPNbKyFRJ384mJTUnsyy1SN8uQS/j/exmpoJF3hUrzpxgbmB8ZdPFyMkhIWAi
        8b7/OFsXIxeHkMBSRonDl1uZuhg5gBIyEsfXl0HUCEv8udYFVfOaUWLFvX/MIAlhAUeJD5Om
        MILYIgJKEh/bD7GD2MwCERLdr85ANaxjlDi4YhEbSIJNwEpiYvsqsAZeATuJ+T0XwQaxCKhI
        LDiyBcwWBWo+vGMWVI2gxMmZT1hAbE4BY4m+CXfZIBaoS/yZd4kZwhaXuPVkPhOELS+x/e0c
        5gmMQrOQtM9C0jILScssJC0LGFlWMYqklhbnpucWG+kVJ+YWl+al6yXn525iBEbStmM/t+xg
        7HoXfIhRgINRiYf3B0NsnBBrYllxZe4hRgkOZiURXl/O6Dgh3pTEyqrUovz4otKc1OJDjKZA
        z01klhJNzgdGeV5JvKGpobmFpaG5sbmxmYWSOG+HwMEYIYH0xJLU7NTUgtQimD4mDk6pBkZW
        hXmy9qxKibXRm1v32m44lJe++Elrbk5MvfFup+bHl+P+6Vv/fOJRYRZ7abFuzM7Z00Suf536
        4GioQv1E3dbeq4u4l5qcEWw/wbRri0KtjqJfxcKivWEtVvHNb7b1zfqge0cnLDH+cbPbbMPt
        1p8aLlQEc0yqeK2dbi5Q9tD50a5rZoZJd5RYijMSDbWYi4oTASo/ZlG6AgAA
X-CMS-MailID: 20200302172443eucas1p1e231bd1910ea5c232a779f734d898fa2
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200213095437eucas1p106742c3b4f5dcc56b7a3a4e01971fa89
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200213095437eucas1p106742c3b4f5dcc56b7a3a4e01971fa89
References: <20200213095412.23773-1-hare@suse.de>
        <CGME20200213095437eucas1p106742c3b4f5dcc56b7a3a4e01971fa89@eucas1p1.samsung.com>
        <20200213095412.23773-18-hare@suse.de>
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org


On 2/13/20 10:53 AM, Hannes Reinecke wrote:
> Add tracepoints for bus-master DMA and taskfile related functions.
> That allows us to drop the relevant DPRINTK() calls.

..DPRINTK() & VPRINTK() calls.

Also please see comments below (from v1 review).

> Signed-off-by: Hannes Reinecke <hare@suse.de>
> ---
>  drivers/ata/libata-core.c     |  5 +++
>  drivers/ata/libata-sff.c      | 23 +++++++---
>  include/trace/events/libata.h | 97 +++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 120 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
> index 329cc587eeab..695974d0c634 100644
> --- a/drivers/ata/libata-core.c
> +++ b/drivers/ata/libata-core.c
> @@ -7383,3 +7383,8 @@ EXPORT_SYMBOL_GPL(ata_cable_ignore);
>  EXPORT_SYMBOL_GPL(ata_cable_sata);
>  EXPORT_SYMBOL_GPL(ata_host_get);
>  EXPORT_SYMBOL_GPL(ata_host_put);
> +
> +EXPORT_TRACEPOINT_SYMBOL_GPL(ata_tf_load);
> +EXPORT_TRACEPOINT_SYMBOL_GPL(ata_exec_command);
> +EXPORT_TRACEPOINT_SYMBOL_GPL(ata_bmdma_setup);
> +EXPORT_TRACEPOINT_SYMBOL_GPL(ata_bmdma_start);
> diff --git a/drivers/ata/libata-sff.c b/drivers/ata/libata-sff.c
> index 25c10f3eef83..e2d1504f7562 100644
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
> @@ -509,6 +509,7 @@ EXPORT_SYMBOL_GPL(ata_sff_exec_command);
>   *	ata_tf_to_host - issue ATA taskfile to host controller
>   *	@ap: port to which command is being issued
>   *	@tf: ATA taskfile register set
> + *	@tag: tag of the associated command
>   *
>   *	Issues ATA taskfile register set to ATA host controller,
>   *	with proper synchronization with interrupt handler and
> @@ -518,9 +519,12 @@ EXPORT_SYMBOL_GPL(ata_sff_exec_command);
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
> @@ -753,6 +757,7 @@ static void atapi_send_cdb(struct ata_port *ap, struct ata_queued_cmd *qc)
>  	case ATAPI_PROT_DMA:
>  		ap->hsm_task_state = HSM_ST_LAST;
>  		/* initiate bmdma */
> +		trace_ata_bmdma_start(ap, &qc->tf, qc->tag);
>  		ap->ops->bmdma_start(qc);
>  		break;
>  #endif /* CONFIG_ATA_BMDMA */
> @@ -1361,7 +1366,7 @@ unsigned int ata_sff_qc_issue(struct ata_queued_cmd *qc)
>  		if (qc->tf.flags & ATA_TFLAG_POLLING)
>  			ata_qc_set_polling(qc);
>  
> -		ata_tf_to_host(ap, &qc->tf);
> +		ata_tf_to_host(ap, &qc->tf, qc->tag);
>  		ap->hsm_task_state = HSM_ST_LAST;
>  
>  		if (qc->tf.flags & ATA_TFLAG_POLLING)
> @@ -1373,7 +1378,7 @@ unsigned int ata_sff_qc_issue(struct ata_queued_cmd *qc)
>  		if (qc->tf.flags & ATA_TFLAG_POLLING)
>  			ata_qc_set_polling(qc);
>  
> -		ata_tf_to_host(ap, &qc->tf);
> +		ata_tf_to_host(ap, &qc->tf, qc->tag);
>  
>  		if (qc->tf.flags & ATA_TFLAG_WRITE) {
>  			/* PIO data out protocol */
> @@ -1403,7 +1408,7 @@ unsigned int ata_sff_qc_issue(struct ata_queued_cmd *qc)
>  		if (qc->tf.flags & ATA_TFLAG_POLLING)
>  			ata_qc_set_polling(qc);
>  
> -		ata_tf_to_host(ap, &qc->tf);
> +		ata_tf_to_host(ap, &qc->tf, qc->tag);
>  
>  		ap->hsm_task_state = HSM_ST_FIRST;
>  
> @@ -2735,8 +2740,11 @@ unsigned int ata_bmdma_qc_issue(struct ata_queued_cmd *qc)
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
> @@ -2744,7 +2752,9 @@ unsigned int ata_bmdma_qc_issue(struct ata_queued_cmd *qc)
>  	case ATAPI_PROT_DMA:
>  		WARN_ON_ONCE(qc->tf.flags & ATA_TFLAG_POLLING);
>  
> +		trace_ata_tf_load(ap, &qc->tf);
>  		ap->ops->sff_tf_load(ap, &qc->tf);  /* load tf registers */
> +		trace_ata_bmdma_setup(ap, &qc->tf, qc->tag);
>  		ap->ops->bmdma_setup(qc);	    /* set up bmdma */
>  		ap->hsm_task_state = HSM_ST_FIRST;
>  
> @@ -2792,6 +2802,7 @@ unsigned int ata_bmdma_port_intr(struct ata_port *ap, struct ata_queued_cmd *qc)
>  			return ata_sff_idle_irq(ap);
>  
>  		/* before we do anything else, clear DMA-Start bit */
> +		trace_ata_bmdma_stop(ap, &qc->tf, qc->tag);
>  		ap->ops->bmdma_stop(qc);
>  		bmdma_stopped = true;
>  
> @@ -2871,6 +2882,7 @@ void ata_bmdma_error_handler(struct ata_port *ap)
>  			thaw = true;
>  		}
>  
> +		trace_ata_bmdma_stop(ap, &qc->tf, qc->tag);
>  		ap->ops->bmdma_stop(qc);
>  
>  		/* if we're gonna thaw, make sure IRQ is clear */
> @@ -2904,6 +2916,7 @@ void ata_bmdma_post_internal_cmd(struct ata_queued_cmd *qc)
>  
>  	if (ata_is_dma(qc->tf.protocol)) {
>  		spin_lock_irqsave(ap->lock, flags);
> +		trace_ata_bmdma_stop(ap, &qc->tf, qc->tag);
>  		ap->ops->bmdma_stop(qc);
>  		spin_unlock_irqrestore(ap->lock, flags);
>  	}
> diff --git a/include/trace/events/libata.h b/include/trace/events/libata.h
> index ec2a350d1aca..f2cd6daa6b2d 100644
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
> +		__field( unsigned char,	proto	)
> +		__field( unsigned long,	flags	)
> +	),

'flags' field doesn't seem to be used?

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
> +		__field( unsigned char,	proto	)
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
> +		  __entry->tag)

Please keep both new events consistent regarding 'proto' and
'cmd' fields printing (add "proto=%s" in this event or rework
printing in ata_tf_load one).

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

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
> 
