Return-Path: <SRS0=vLfT=36=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E77AC352A5
	for <linux-ide@archiver.kernel.org>; Mon, 10 Feb 2020 13:42:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D53CC20715
	for <linux-ide@archiver.kernel.org>; Mon, 10 Feb 2020 13:42:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="F1yjH30e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727507AbgBJNmt (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 10 Feb 2020 08:42:49 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:41001 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727369AbgBJNmt (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 10 Feb 2020 08:42:49 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20200210134246euoutp017ebee2e4d350b994612eeaa0b1c9e497~yDlJqlOD30390503905euoutp01q
        for <linux-ide@vger.kernel.org>; Mon, 10 Feb 2020 13:42:46 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20200210134246euoutp017ebee2e4d350b994612eeaa0b1c9e497~yDlJqlOD30390503905euoutp01q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1581342166;
        bh=oiEW9MOU3SV/WN64OtfPUBHSAPhYj+8M2tgo2jhMDvc=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=F1yjH30eq4WyPWdhfkse0unxWac+icFfQlIFEK9iyD1PuE4mGMcQrp2MxjXKB0qGj
         IXpZZ5nTWzBhXmtQ+ddXNQnOAp9bZKRlmE7ZvOBQyH7MxLkOmSJssri0cYc42UODcq
         K54pnd42cv5ahNgVsqQu2uHnwpHAY+zmRNoRjPW0=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200210134246eucas1p28b7951fb9a23da8513d29bc8704189e7~yDlJjwuew1568715687eucas1p2b;
        Mon, 10 Feb 2020 13:42:46 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 0B.09.60679.6DD514E5; Mon, 10
        Feb 2020 13:42:46 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200210134245eucas1p2680a6956c45e818db8b64f6597095a32~yDlJWIyDI1571015710eucas1p2Q;
        Mon, 10 Feb 2020 13:42:45 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200210134245eusmtrp16103caddbca7cc06da1f8c263b85bcd3~yDlJVnEI01677816778eusmtrp1H;
        Mon, 10 Feb 2020 13:42:45 +0000 (GMT)
X-AuditID: cbfec7f4-0cbff7000001ed07-0d-5e415dd64fcc
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id A6.2F.08375.5DD514E5; Mon, 10
        Feb 2020 13:42:45 +0000 (GMT)
Received: from [106.120.51.71] (unknown [106.120.51.71]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200210134244eusmtip113f9ea0a4fd2bff38c1f1a93ee966d07~yDlIJW5aW0370503705eusmtip1i;
        Mon, 10 Feb 2020 13:42:44 +0000 (GMT)
Subject: Re: [PATCH 14/46] libata: add reset tracepoints
To:     Hannes Reinecke <hare@suse.de>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-ide@vger.kernel.org
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Message-ID: <a9df9616-03c7-48bb-026a-e99cbef5ad44@samsung.com>
Date:   Mon, 10 Feb 2020 14:42:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20200204165547.115220-15-hare@suse.de>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupileLIzCtJLcpLzFFi42LZduznOd1rsY5xBqdmcVmsvtvPZrFn0SQm
        i2M7HjE5MHtcPlvqsfl0tcfnTXIBzFFcNimpOZllqUX6dglcGc2nGlgKNjlW/Hg1l72BcYNJ
        FyMnh4SAicT8YyvZuxi5OIQEVjBKrPlwCMr5wijR96iTFcL5zCix7tQEdpiWfztusEEkljNK
        9Nz+wgSSEBJ4yyjR+YsVxBYWsJDYtvM0WIOIgJLEx/ZDYDazgLXE7MXrwerZBKwkJravYuxi
        5ODgFbCTmLpIDSTMIqAq8fTeQUYQW1QgQuLTg8NgI3kFBCVOznzCAmJzAt3w+vZhRoiR4hK3
        nsxngrDlJba/ncMMcpuEQDO7xKafP5ggjnaRuPB5PQuELSzx6vgWqGdkJE5P7mGBaFjHKPG3
        4wVU93ZGieWT/7FBVFlL3Dn3iw3kUmYBTYn1u/Qhwo4ST08/YwIJSwjwSdx4KwhxBJ/EpG3T
        mSHCvBIdbUIQ1WoSG5ZtYINZ27VzJfMERqVZSF6bheSdWUjemYWwdwEjyypG8dTS4tz01GKj
        vNRyveLE3OLSvHS95PzcTYzAFHL63/EvOxh3/Uk6xCjAwajEw1sR6BgnxJpYVlyZe4hRgoNZ
        SYTXUhooxJuSWFmVWpQfX1Sak1p8iFGag0VJnNd40ctYIYH0xJLU7NTUgtQimCwTB6dUA+P2
        EIdX6ie3ZBkxv4s5+Gjd4lP6iaKd5dMPbXj/5usy1yDOo4x9+xSZ1f5xfPZ7Mt9hpZaTiebh
        8ljHrvZndfPPXdpytPyFpNUBY769cevTnj99/O7H1pKfGazidvMu5DeZPQ9Sufvyz6Ngr0Vb
        5haVFLNI1306827iXJ8z3eIup7YvCDxxumqlEktxRqKhFnNRcSIAVtTApB0DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprDIsWRmVeSWpSXmKPExsVy+t/xu7pXYx3jDOa8MrFYfbefzWLPoklM
        Fsd2PGJyYPa4fLbUY/Ppao/Pm+QCmKP0bIryS0tSFTLyi0tslaINLYz0DC0t9IxMLPUMjc1j
        rYxMlfTtbFJSczLLUov07RL0MppPNbAUbHKs+PFqLnsD4waTLkZODgkBE4l/O26wdTFycQgJ
        LGWUuLjxPXMXIwdQQkbi+PoyiBphiT/XuqBqXjNKtGx4xgiSEBawkNi28zQ7iC0ioCTxsf0Q
        mM0sYC0xe/F6JoiGDYwSf7ZvAkuwCVhJTGxfxQiygFfATmLqIjWQMIuAqsTTewfBZooKREgc
        3jELzOYVEJQ4OfMJC4jNCXTo69uHGSHmq0v8mXeJGcIWl7j1ZD4ThC0vsf3tHOYJjEKzkLTP
        QtIyC0nLLCQtCxhZVjGKpJYW56bnFhvqFSfmFpfmpesl5+duYgTGzLZjPzfvYLy0MfgQowAH
        oxIPb0WgY5wQa2JZcWXuIUYJDmYlEV5LaaAQb0piZVVqUX58UWlOavEhRlOg5yYyS4km5wPj
        Oa8k3tDU0NzC0tDc2NzYzEJJnLdD4GCMkEB6YklqdmpqQWoRTB8TB6dUA2NRUNhRxdXHtYxF
        MixnLF7iqlNk13/tO798+4t8r4fXGLYUmExrS59s67ea4+TRRfvuKv8sWj7R7ZXBWibPF3dC
        Va4sazLkbGNuc9j5an1slvZUXq4qTq5oSRXtauumg/uuzlJkWzpzctcyBbNtTd+b7C//UNIu
        WLJoMpdi9xeXf/FRqYcPJCmxFGckGmoxFxUnAgC6Se18rwIAAA==
X-CMS-MailID: 20200210134245eucas1p2680a6956c45e818db8b64f6597095a32
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200204165612eucas1p27b387db5137925e140ad53712a5af2d9
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200204165612eucas1p27b387db5137925e140ad53712a5af2d9
References: <20200204165547.115220-1-hare@suse.de>
        <CGME20200204165612eucas1p27b387db5137925e140ad53712a5af2d9@eucas1p2.samsung.com>
        <20200204165547.115220-15-hare@suse.de>
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org


On 2/4/20 5:55 PM, Hannes Reinecke wrote:
> To follow the flow of control we should be using tracepoints, as
> they will tie in with the actual I/O flow and deliver a better
> overview about what it happening.
> This patch adds tracepoints for hard and soft reset and adds
> them in the libata-eh control flow.
> 
> Signed-off-by: Hannes Reinecke <hare@suse.de>

checkpatch.pl complains about CodingStyle issues:

WARNING: line over 80 characters
#164: FILE: include/trace/events/libata.h:350:
+       TP_PROTO(struct ata_link *link, unsigned int *class, unsigned long deadline),

ERROR: space prohibited after that open parenthesis '('
#169: FILE: include/trace/events/libata.h:355:
+               __field( unsigned int,  ata_port )

ERROR: space prohibited before that close parenthesis ')'
#169: FILE: include/trace/events/libata.h:355:
+               __field( unsigned int,  ata_port )

ERROR: space prohibited after that open parenthesis '('
#170: FILE: include/trace/events/libata.h:356:
+               __array( unsigned int,  class, 2)

ERROR: space prohibited after that open parenthesis '('
#171: FILE: include/trace/events/libata.h:357:
+               __field( unsigned long, deadline)

WARNING: line over 80 characters
#187: FILE: include/trace/events/libata.h:373:
+            TP_PROTO(struct ata_link *link, unsigned int *class, unsigned long deadline),

WARNING: line over 80 characters
#191: FILE: include/trace/events/libata.h:377:
+            TP_PROTO(struct ata_link *link, unsigned int *class, unsigned long deadline),

WARNING: line over 80 characters
#195: FILE: include/trace/events/libata.h:381:
+            TP_PROTO(struct ata_link *link, unsigned int *class, unsigned long deadline),

ERROR: space prohibited after that open parenthesis '('
#205: FILE: include/trace/events/libata.h:391:
+               __field( unsigned int,  ata_port )

ERROR: space prohibited before that close parenthesis ')'
#205: FILE: include/trace/events/libata.h:391:
+               __field( unsigned int,  ata_port )

ERROR: space prohibited after that open parenthesis '('
#206: FILE: include/trace/events/libata.h:392:
+               __array( unsigned int,  class, 2)

ERROR: space prohibited after that open parenthesis '('
#207: FILE: include/trace/events/libata.h:393:
+               __field( int,           rc)

Otherwise the patch looks fine.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

> ---
>  drivers/ata/libata-eh.c       | 16 +++++++-
>  include/trace/events/libata.h | 88 +++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 102 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
> index 3bfd9da58473..253dcf903c1b 100644
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
> diff --git a/include/trace/events/libata.h b/include/trace/events/libata.h
> index ab69434e2329..e9fb4d44eeac 100644
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
> @@ -329,6 +345,78 @@ TRACE_EVENT(ata_eh_link_autopsy_qc,
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
> +		__array( unsigned int,	class, 2)
> +		__field( unsigned long,	deadline)
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
> +		__array( unsigned int,	class, 2)
> +		__field( int,		rc)
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
>  #endif /*  _TRACE_LIBATA_H */
>  
>  /* This part must be outside protection */
> 
