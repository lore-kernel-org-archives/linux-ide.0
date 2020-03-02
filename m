Return-Path: <SRS0=3I3m=4T=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68A98C3F2CD
	for <linux-ide@archiver.kernel.org>; Mon,  2 Mar 2020 17:09:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3657B21775
	for <linux-ide@archiver.kernel.org>; Mon,  2 Mar 2020 17:09:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="rKL8KkQc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727032AbgCBRJx (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 2 Mar 2020 12:09:53 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:41602 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727459AbgCBRJx (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 2 Mar 2020 12:09:53 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20200302170951euoutp022e7f15bd042d5835f40ad98186dc12d5~4i886VcPH3133431334euoutp02e
        for <linux-ide@vger.kernel.org>; Mon,  2 Mar 2020 17:09:51 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20200302170951euoutp022e7f15bd042d5835f40ad98186dc12d5~4i886VcPH3133431334euoutp02e
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1583168991;
        bh=BbndpC4Javo9IaXaYO1oMPu3ZAoWtjf0VUz2rt3NqoY=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=rKL8KkQc7/2IU3BkBHzx4btb2JF9fKePdJ/rNG1RkdEZ/r18IoztOsHSnk6u3fKJE
         8LyLLRMvL0EDNSITEJz5auZ81d8QIgIROYABsCtIsITvuC7E46bM15BeCslWdF/y3b
         Jc8WCXw/KqvuUTHTAoX7i0sBhyXIJ6+gUrEE7/XY=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200302170951eucas1p20ed96dc9144d3f08ffa66d150677c7e5~4i88zMA4E2585125851eucas1p2g;
        Mon,  2 Mar 2020 17:09:51 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id F0.47.61286.EDD3D5E5; Mon,  2
        Mar 2020 17:09:51 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200302170950eucas1p22791bf8d9cb9d403154acdee136ead1c~4i88fNCGh2585125851eucas1p2d;
        Mon,  2 Mar 2020 17:09:50 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200302170950eusmtrp1796508385e6b701a900bd0c78158f26b~4i88enhIO2219622196eusmtrp18;
        Mon,  2 Mar 2020 17:09:50 +0000 (GMT)
X-AuditID: cbfec7f2-ef1ff7000001ef66-98-5e5d3dded5ae
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id DF.A8.07950.EDD3D5E5; Mon,  2
        Mar 2020 17:09:50 +0000 (GMT)
Received: from [106.120.51.71] (unknown [106.120.51.71]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200302170950eusmtip17dde2a4768073e1f6b1ea7aaf1a704a3~4i87_agcG0763607636eusmtip1K;
        Mon,  2 Mar 2020 17:09:50 +0000 (GMT)
Subject: Re: [PATCH 15/42] libata: add reset tracepoints
To:     Hannes Reinecke <hare@suse.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
        linux-ide@vger.kernel.org
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Message-ID: <ca7c3510-0fef-9783-6523-307c50a2cff5@samsung.com>
Date:   Mon, 2 Mar 2020 18:09:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20200213095412.23773-16-hare@suse.de>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprMKsWRmVeSWpSXmKPExsWy7djP87r3bWPjDG60MFqsvtvPZrFn0SQm
        i2M7HjFZ/Fp+lNGBxePy2VKPTas62Tw2n672+LxJLoAlissmJTUnsyy1SN8ugSvjx533TAXn
        zSvm3NnG3sD4VKeLkZNDQsBEYvrvdrYuRi4OIYEVjBLLLi1hh3C+MErMWvGSGcL5zCix7uQD
        JpiWXd/WQlUtZ5To/XIAqv8to8Se/acYQaqEBSwktu96yA5iiwgoSXxsPwRmMwtESGzcsBZs
        EpuAlcTE9lVg9bwCdhJvFq5n6WLk4GARUJH4/EgKJCwKVP7pwWFWiBJBiZMzn7CA2JwCxhJz
        ts5mgRgpLnHryXwmCFteYvvbOWBXSwhMZpfYs2sLM8hMCQEXiU3roH4Wlnh1fAs7hC0jcXpy
        DwtE/TpGib8dL6CatzNKLJ/8jw2iylrizrlfbCCDmAU0Jdbv0oeY6Shx4aMFhMknceOtIMQJ
        fBKTtk2H2sor0dEmBDFDTWLDsg1sMFu7dq5knsCoNAvJY7OQPDMLyTOzENYuYGRZxSieWlqc
        m55abJiXWq5XnJhbXJqXrpecn7uJEZhUTv87/mkH49dLSYcYBTgYlXh4A5hj44RYE8uKK3MP
        MUpwMCuJ8PpyRscJ8aYkVlalFuXHF5XmpBYfYpTmYFES5zVe9DJWSCA9sSQ1OzW1ILUIJsvE
        wSnVwLg05JZPSMn3kqiM/hnLnDY0Brdt7pvDf/apXeUlYaW8VN43Uza/YfDbp5Pm+EL2apY9
        Q4DkrgvnHk87Gl6xL2NTyfP1q9d9qfggYrL8/CRv8YB/Ja72ZfOPzAqY2JJrP+Xptv1Ja4Tt
        Zk0LUz+laKLLfO5BRrXExl09v7v87U7zTNiXp/ORf54SS3FGoqEWc1FxIgDYalMuJgMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrKIsWRmVeSWpSXmKPExsVy+t/xu7r3bGPjDJ51aFisvtvPZrFn0SQm
        i2M7HjFZ/Fp+lNGBxePy2VKPTas62Tw2n672+LxJLoAlSs+mKL+0JFUhI7+4xFYp2tDCSM/Q
        0kLPyMRSz9DYPNbKyFRJ384mJTUnsyy1SN8uQS/jx533TAXnzSvm3NnG3sD4VKeLkZNDQsBE
        Yte3texdjFwcQgJLGSWOzuxl62LkAErISBxfXwZRIyzx51oXG4gtJPCaUeLHKVMQW1jAQmL7
        rofsILaIgJLEx/ZDYDazQIRE96szbBAz1zFK7FlxA6yZTcBKYmL7KkYQm1fATuLNwvUsILtY
        BFQkPj+SAgmLAvUe3jELqkRQ4uTMJywgNqeAscScrbNZIOarS/yZd4kZwhaXuPVkPhOELS+x
        /e0c5gmMQrOQtM9C0jILScssJC0LGFlWMYqklhbnpucWG+kVJ+YWl+al6yXn525iBEbRtmM/
        t+xg7HoXfIhRgINRiYf3B0NsnBBrYllxZe4hRgkOZiURXl/O6Dgh3pTEyqrUovz4otKc1OJD
        jKZAv01klhJNzgdGeF5JvKGpobmFpaG5sbmxmYWSOG+HwMEYIYH0xJLU7NTUgtQimD4mDk6p
        BsZydvtTLy1EjPvibPU+xObOZl2mzNVyNcrzU9GCh+q/3r1gfu/l/illi2rwvaWqNUpXJgbO
        Zgnl+DYp2dlkquW58PvqZ18+PdWzzin9uQh3kJNTbO3L/7zXOG8oXd+xZWOgyUr5tyfCSvd+
        3858TUA590Zlwtrm1dseSF66+5kz3z0kkJVvToUSS3FGoqEWc1FxIgDQ4rj9uAIAAA==
X-CMS-MailID: 20200302170950eucas1p22791bf8d9cb9d403154acdee136ead1c
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200213095437eucas1p24ba8aec2f3324878490eca28a6e1c3d1
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200213095437eucas1p24ba8aec2f3324878490eca28a6e1c3d1
References: <20200213095412.23773-1-hare@suse.de>
        <CGME20200213095437eucas1p24ba8aec2f3324878490eca28a6e1c3d1@eucas1p2.samsung.com>
        <20200213095412.23773-16-hare@suse.de>
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org


On 2/13/20 10:53 AM, Hannes Reinecke wrote:
> To follow the flow of control we should be using tracepoints, as
> they will tie in with the actual I/O flow and deliver a better
> overview about what it happening.
> This patch adds tracepoints for hard reset, soft reset, and postreset
> and adds them in the libata-eh control flow.
> 
> Signed-off-by: Hannes Reinecke <hare@suse.de>

Reviewed-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

> ---
>  drivers/ata/libata-eh.c       | 21 ++++++++--
>  include/trace/events/libata.h | 96 +++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 114 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
> index 3bfd9da58473..ef3576eb5874 100644
> --- a/drivers/ata/libata-eh.c
> +++ b/drivers/ata/libata-eh.c
> @@ -2787,12 +2787,19 @@ int ata_eh_reset(struct ata_link *link, int classify,
>  
>  		/* mark that this EH session started with reset */
>  		ehc->last_reset = jiffies;
> -		if (reset == hardreset)
> +		if (reset == hardreset) {
>  			ehc->i.flags |= ATA_EHI_DID_HARDRESET;
> -		else
> +			trace_ata_link_hardreset_begin(link, classes, deadline);
> +		} else {
>  			ehc->i.flags |= ATA_EHI_DID_SOFTRESET;
> +			trace_ata_link_softreset_begin(link, classes, deadline);
> +		}
>  
>  		rc = ata_do_reset(link, reset, classes, deadline, true);
> +		if (reset == hardreset)
> +			trace_ata_link_hardreset_end(link, classes, rc);
> +		else
> +			trace_ata_link_softreset_end(link, classes, rc);
>  		if (rc && rc != -EAGAIN) {
>  			failed_link = link;
>  			goto fail;
> @@ -2806,8 +2813,11 @@ int ata_eh_reset(struct ata_link *link, int classify,
>  				ata_link_info(slave, "hard resetting link\n");
>  
>  			ata_eh_about_to_do(slave, NULL, ATA_EH_RESET);
> +			trace_ata_slave_hardreset_begin(slave, classes,
> +							deadline);
>  			tmp = ata_do_reset(slave, reset, classes, deadline,
>  					   false);
> +			trace_ata_slave_hardreset_end(slave, classes, tmp);
>  			switch (tmp) {
>  			case -EAGAIN:
>  				rc = -EAGAIN;
> @@ -2834,7 +2844,9 @@ int ata_eh_reset(struct ata_link *link, int classify,
>  			}
>  
>  			ata_eh_about_to_do(link, NULL, ATA_EH_RESET);
> +			trace_ata_link_softreset_begin(link, classes, deadline);
>  			rc = ata_do_reset(link, reset, classes, deadline, true);
> +			trace_ata_link_softreset_end(link, classes, rc);
>  			if (rc) {
>  				failed_link = link;
>  				goto fail;
> @@ -2888,8 +2900,11 @@ int ata_eh_reset(struct ata_link *link, int classify,
>  	 */
>  	if (postreset) {
>  		postreset(link, classes);
> -		if (slave)
> +		trace_ata_link_postreset(link, classes, rc);
> +		if (slave) {
>  			postreset(slave, classes);
> +			trace_ata_slave_postreset(slave, classes, rc);
> +		}
>  	}
>  
>  	/*
> diff --git a/include/trace/events/libata.h b/include/trace/events/libata.h
> index ab69434e2329..ec2a350d1aca 100644
> --- a/include/trace/events/libata.h
> +++ b/include/trace/events/libata.h
> @@ -132,6 +132,22 @@
>  		ata_protocol_name(ATAPI_PROT_PIO),	\
>  		ata_protocol_name(ATAPI_PROT_DMA))
>  
> +#define ata_class_name(class)	{ class, #class }
> +#define show_class_name(val)				\
> +	__print_symbolic(val,				\
> +		ata_class_name(ATA_DEV_UNKNOWN),	\
> +		ata_class_name(ATA_DEV_ATA),		\
> +		ata_class_name(ATA_DEV_ATA_UNSUP),	\
> +		ata_class_name(ATA_DEV_ATAPI),		\
> +		ata_class_name(ATA_DEV_ATAPI_UNSUP),	\
> +		ata_class_name(ATA_DEV_PMP),		\
> +		ata_class_name(ATA_DEV_PMP_UNSUP),	\
> +		ata_class_name(ATA_DEV_SEMB),		\
> +		ata_class_name(ATA_DEV_SEMB_UNSUP),	\
> +		ata_class_name(ATA_DEV_ZAC),		\
> +		ata_class_name(ATA_DEV_ZAC_UNSUP),	\
> +		ata_class_name(ATA_DEV_NONE))
> +
>  const char *libata_trace_parse_status(struct trace_seq*, unsigned char);
>  #define __parse_status(s) libata_trace_parse_status(p, s)
>  
> @@ -329,6 +345,86 @@ TRACE_EVENT(ata_eh_link_autopsy_qc,
>  		  __parse_eh_err_mask(__entry->eh_err_mask))
>  );
>  
> +DECLARE_EVENT_CLASS(ata_link_reset_begin_template,
> +
> +	TP_PROTO(struct ata_link *link, unsigned int *class, unsigned long deadline),
> +
> +	TP_ARGS(link, class, deadline),
> +
> +	TP_STRUCT__entry(
> +		__field( unsigned int,	ata_port )
> +		__array( unsigned int,	class, 2 )
> +		__field( unsigned long,	deadline )
> +	),
> +
> +	TP_fast_assign(
> +		__entry->ata_port	= link->ap->print_id;
> +		memcpy(__entry->class, class, 2);
> +		__entry->deadline	= deadline;
> +	),
> +
> +	TP_printk("ata_port=%u deadline=%lu classes=[%s,%s]",
> +		  __entry->ata_port, __entry->deadline,
> +		  show_class_name(__entry->class[0]),
> +		  show_class_name(__entry->class[1]))
> +);
> +
> +DEFINE_EVENT(ata_link_reset_begin_template, ata_link_hardreset_begin,
> +	     TP_PROTO(struct ata_link *link, unsigned int *class, unsigned long deadline),
> +	     TP_ARGS(link, class, deadline));
> +
> +DEFINE_EVENT(ata_link_reset_begin_template, ata_slave_hardreset_begin,
> +	     TP_PROTO(struct ata_link *link, unsigned int *class, unsigned long deadline),
> +	     TP_ARGS(link, class, deadline));
> +
> +DEFINE_EVENT(ata_link_reset_begin_template, ata_link_softreset_begin,
> +	     TP_PROTO(struct ata_link *link, unsigned int *class, unsigned long deadline),
> +	     TP_ARGS(link, class, deadline));
> +
> +DECLARE_EVENT_CLASS(ata_link_reset_end_template,
> +
> +	TP_PROTO(struct ata_link *link, unsigned int *class, int rc),
> +
> +	TP_ARGS(link, class, rc),
> +
> +	TP_STRUCT__entry(
> +		__field( unsigned int,	ata_port )
> +		__array( unsigned int,	class, 2 )
> +		__field( int,		rc	)
> +	),
> +
> +	TP_fast_assign(
> +		__entry->ata_port	= link->ap->print_id;
> +		memcpy(__entry->class, class, 2);
> +		__entry->rc		= rc;
> +	),
> +
> +	TP_printk("ata_port=%u rc=%d class=[%s,%s]",
> +		  __entry->ata_port, __entry->rc,
> +		  show_class_name(__entry->class[0]),
> +		  show_class_name(__entry->class[1]))
> +);
> +
> +DEFINE_EVENT(ata_link_reset_end_template, ata_link_hardreset_end,
> +	     TP_PROTO(struct ata_link *link, unsigned int *class, int rc),
> +	     TP_ARGS(link, class, rc));
> +
> +DEFINE_EVENT(ata_link_reset_end_template, ata_slave_hardreset_end,
> +	     TP_PROTO(struct ata_link *link, unsigned int *class, int rc),
> +	     TP_ARGS(link, class, rc));
> +
> +DEFINE_EVENT(ata_link_reset_end_template, ata_link_softreset_end,
> +	     TP_PROTO(struct ata_link *link, unsigned int *class, int rc),
> +	     TP_ARGS(link, class, rc));
> +
> +DEFINE_EVENT(ata_link_reset_end_template, ata_link_postreset,
> +	     TP_PROTO(struct ata_link *link, unsigned int *class, int rc),
> +	     TP_ARGS(link, class, rc));
> +
> +DEFINE_EVENT(ata_link_reset_end_template, ata_slave_postreset,
> +	     TP_PROTO(struct ata_link *link, unsigned int *class, int rc),
> +	     TP_ARGS(link, class, rc));
> +
>  #endif /*  _TRACE_LIBATA_H */
>  
>  /* This part must be outside protection */
> 
