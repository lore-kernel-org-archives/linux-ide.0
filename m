Return-Path: <SRS0=vLfT=36=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0DFAC352A3
	for <linux-ide@archiver.kernel.org>; Mon, 10 Feb 2020 15:32:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50D6820715
	for <linux-ide@archiver.kernel.org>; Mon, 10 Feb 2020 15:32:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="fE9u+XFJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727725AbgBJPc1 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 10 Feb 2020 10:32:27 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:47443 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727690AbgBJPc1 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 10 Feb 2020 10:32:27 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20200210153225euoutp02931d24ed5c342543feba1483ce735a2f~yFE40i8SF1428814288euoutp02c
        for <linux-ide@vger.kernel.org>; Mon, 10 Feb 2020 15:32:25 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20200210153225euoutp02931d24ed5c342543feba1483ce735a2f~yFE40i8SF1428814288euoutp02c
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1581348745;
        bh=1szmsPHqmmMuEVLDBYmAHWGSxk6zgqhjoPei5PaIBfg=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=fE9u+XFJkUrx1rApISG32aC/tKFUuSwQDE+RWAnO0YoTUGbi+ufNQsZXh/a5uCy8o
         g1qJruJZ0qbCH9dCyIYNw0Ygx8JEGT1RrouM3+PJEa4ECh/u14YU8AIz/eUKl+AzYb
         40zj4ECVIezSWTN/8ESovpADXoMNscVlaR0jXap0=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200210153225eucas1p2e17d4d9846c360e77a4fc4f20387b806~yFE4q5nHi2897428974eucas1p2H;
        Mon, 10 Feb 2020 15:32:25 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 9E.0F.61286.887714E5; Mon, 10
        Feb 2020 15:32:25 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200210153224eucas1p1281d24b09ec5825a145e5364c5a89005~yFE4DIPFR2072720727eucas1p1n;
        Mon, 10 Feb 2020 15:32:24 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200210153224eusmtrp1872fa0d381665b7c3086a193bbe73c3c~yFE4ChPVH1608316083eusmtrp1Y;
        Mon, 10 Feb 2020 15:32:24 +0000 (GMT)
X-AuditID: cbfec7f2-f0bff7000001ef66-a0-5e41778860bf
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id EA.30.08375.887714E5; Mon, 10
        Feb 2020 15:32:24 +0000 (GMT)
Received: from [106.120.51.71] (unknown [106.120.51.71]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200210153222eusmtip2cce3eb724cc370e1df76f05726df4224~yFE2n8bgJ2858828588eusmtip2W;
        Mon, 10 Feb 2020 15:32:22 +0000 (GMT)
Subject: Re: [PATCH 25/46] libata-sff: add tracepoints for HSM state machine
To:     Hannes Reinecke <hare@suse.de>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-ide@vger.kernel.org,
        Hannes Reinecke <hare@suse.com>
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Message-ID: <5b3ab485-15dc-f58f-a26b-b774a9c6b239@samsung.com>
Date:   Mon, 10 Feb 2020 16:32:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20200204165547.115220-26-hare@suse.de>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprEKsWRmVeSWpSXmKPExsWy7djP87qd5Y5xBi9mM1msvtvPZrHgzV42
        iz2LJjFZHNvxiMmBxePy2VKP9VuusnhsPl3t8XmTXABLFJdNSmpOZllqkb5dAlfGkSXb2As6
        CysubmpkbWC8F9XFyMEhIWAisXJhfhcjF4eQwApGiUcXGpggnC+MEmc3vmTtYuQEcj4zSjT3
        y4LYIA1LF15ggogvZ5T4e8gAouEto8T3N7dYQBLCAj4SM1bMZQSxRQSUJD62H2IHsZkF4iSa
        rtwFs9kErCQmtq8Cq+EVsJN4+/0HWJxFQFVi2+M1YLaoQITEpweHWSFqBCVOznwCNp8T6IiD
        n84yQswUl7j1ZD4ThC0vsf3tHGaIQ/vZJQ7cZoewXSQu7/wEZQtLvDq+BcqWkTg9uYcF5AEJ
        gXVAz3S8YIZwtjNKLJ/8jw2iylrizrlfbKDwYhbQlFi/Sx8i7Cjx7tZEFkgw8knceCsIcQOf
        xKRt05khwrwSHW1CENVqEhuWbWCDWdu1cyXzBEalWUg+m4Xkm1lIvpmFsHcBI8sqRvHU0uLc
        9NRiw7zUcr3ixNzi0rx0veT83E2MwJRy+t/xTzsYv15KOsQowMGoxMNbEegYJ8SaWFZcmXuI
        UYKDWUmE11IaKMSbklhZlVqUH19UmpNafIhRmoNFSZzXeNHLWCGB9MSS1OzU1ILUIpgsEwen
        VAMj/9fO2hcuu2+aXpbOawkSKd1pmrDlN8/RpZ7/5WVCN+ybfIXbJ7066rB83dPzB/htz6xt
        +PJbrfnHDYbd6k3uRxy4JwldS9fpM3k0YYbS/8de6Rbmn2dzPtLc0HBdaqNq+fe3a97PrBdg
        e23c9WBNwZ3ZBts0khqt4ytnlDUIGRz02PFfzviAEktxRqKhFnNRcSIAF8tkOyUDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrOIsWRmVeSWpSXmKPExsVy+t/xe7od5Y5xBhNXiFmsvtvPZrHgzV42
        iz2LJjFZHNvxiMmBxePy2VKP9VuusnhsPl3t8XmTXABLlJ5NUX5pSapCRn5xia1StKGFkZ6h
        pYWekYmlnqGxeayVkamSvp1NSmpOZllqkb5dgl7GkSXb2As6CysubmpkbWC8F9XFyMkhIWAi
        sXThBaYuRi4OIYGljBL/5/5n72LkAErISBxfXwZRIyzx51oXG0TNa0aJDV19LCAJYQEfiRkr
        5jKC2CICShIf2w+xg9jMAnES//p2Qw3dwChx4MIqZpAEm4CVxMT2VWANvAJ2Em+//wBrYBFQ
        ldj2eA2YLSoQIXF4xyyoGkGJkzOfgC3jBLr04KezjBAL1CX+zLvEDGGLS9x6Mp8JwpaX2P52
        DvMERqFZSNpnIWmZhaRlFpKWBYwsqxhFUkuLc9Nziw31ihNzi0vz0vWS83M3MQIjaduxn5t3
        MF7aGHyIUYCDUYmHtyLQMU6INbGsuDL3EKMEB7OSCK+lNFCINyWxsiq1KD++qDQntfgQoynQ
        cxOZpUST84FRnlcSb2hqaG5haWhubG5sZqEkztshcDBGSCA9sSQ1OzW1ILUIpo+Jg1OqgdEg
        Ytafku53N0X+HtlySXz/lr9HUrm/ch7+fn1H9YsZFfMcf/fbxR68KpTmM/2YmM37k4Eblzlv
        dDi/YH1Uraz1P7n7nIvcgoNj91vpxW9JX/dE8Xsr67up78M3W9tGajxzVHD8KXRPYME1v7qU
        22eOGs3qX82jt2w9V9PKlJAvPxcvXv+2dSuXEktxRqKhFnNRcSIARaaTJ7oCAAA=
X-CMS-MailID: 20200210153224eucas1p1281d24b09ec5825a145e5364c5a89005
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200204165616eucas1p215700b148bba8293d0c3d18c83989dd3
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200204165616eucas1p215700b148bba8293d0c3d18c83989dd3
References: <20200204165547.115220-1-hare@suse.de>
        <CGME20200204165616eucas1p215700b148bba8293d0c3d18c83989dd3@eucas1p2.samsung.com>
        <20200204165547.115220-26-hare@suse.de>
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org


On 2/4/20 5:55 PM, Hannes Reinecke wrote:
> Add tracepoints for the HSM state machine and remove DPRINTK() calls.

Please move the removal to a separate (post-)patch
(like it has been done for reset tracepoints).

Also there is a lot of complaints from checkpatch.pl script
regarding CodingStyle:

WARNING: please, no spaces at the start of a line
#180: FILE: include/trace/events/libata.h:153:
+    __print_symbolic(val,^I^I^I^I\$

WARNING: function definition argument 'struct trace_seq *' should also have an identifier name
#194: FILE: include/trace/events/libata.h:172:
+const char *libata_trace_parse_tf_flags(struct trace_seq *, unsigned int);

WARNING: function definition argument 'unsigned int' should also have an identifier name
#194: FILE: include/trace/events/libata.h:172:
+const char *libata_trace_parse_tf_flags(struct trace_seq *, unsigned int);

ERROR: space prohibited after that open parenthesis '('
#211: FILE: include/trace/events/libata.h:536:
+               __field( unsigned int,  ata_port )

ERROR: space prohibited before that close parenthesis ')'
#211: FILE: include/trace/events/libata.h:536:
+               __field( unsigned int,  ata_port )

ERROR: space prohibited after that open parenthesis '('
#212: FILE: include/trace/events/libata.h:537:
+               __field( unsigned int,  ata_dev )

ERROR: space prohibited before that close parenthesis ')'
#212: FILE: include/trace/events/libata.h:537:
+               __field( unsigned int,  ata_dev )

ERROR: space prohibited after that open parenthesis '('
#213: FILE: include/trace/events/libata.h:538:
+               __field( unsigned int,  tag     )

ERROR: space prohibited before that close parenthesis ')'
#213: FILE: include/trace/events/libata.h:538:
+               __field( unsigned int,  tag     )

ERROR: space prohibited after that open parenthesis '('
#214: FILE: include/trace/events/libata.h:539:
+               __field( unsigned int,  qc_flags )

ERROR: space prohibited before that close parenthesis ')'
#214: FILE: include/trace/events/libata.h:539:
+               __field( unsigned int,  qc_flags )

ERROR: space prohibited after that open parenthesis '('
#215: FILE: include/trace/events/libata.h:540:
+               __field( unsigned int,  protocol )

ERROR: space prohibited before that close parenthesis ')'
#215: FILE: include/trace/events/libata.h:540:
+               __field( unsigned int,  protocol )

ERROR: space prohibited after that open parenthesis '('
#216: FILE: include/trace/events/libata.h:541:
+               __field( unsigned int,  hsm_state )

ERROR: space prohibited before that close parenthesis ')'
#216: FILE: include/trace/events/libata.h:541:
+               __field( unsigned int,  hsm_state )

ERROR: space prohibited after that open parenthesis '('
#217: FILE: include/trace/events/libata.h:542:
+               __field( unsigned char, dev_state )

ERROR: space prohibited before that close parenthesis ')'
#217: FILE: include/trace/events/libata.h:542:
+               __field( unsigned char, dev_state )

ERROR: space required after that ',' (ctx:VxV)
#232: FILE: include/trace/events/libata.h:557:
+                 __entry->protocol,__parse_qc_flags(__entry->qc_flags),
                                   ^

WARNING: line over 80 characters
#247: FILE: include/trace/events/libata.h:572:
+       TP_PROTO(struct ata_queued_cmd *qc, unsigned int offset, unsigned int count),

ERROR: space prohibited after that open parenthesis '('
#252: FILE: include/trace/events/libata.h:577:
+               __field( unsigned int,  ata_port )

ERROR: space prohibited before that close parenthesis ')'
#252: FILE: include/trace/events/libata.h:577:
+               __field( unsigned int,  ata_port )

ERROR: space prohibited after that open parenthesis '('
#253: FILE: include/trace/events/libata.h:578:
+               __field( unsigned int,  ata_dev )

ERROR: space prohibited before that close parenthesis ')'
#253: FILE: include/trace/events/libata.h:578:
+               __field( unsigned int,  ata_dev )

ERROR: space prohibited after that open parenthesis '('
#254: FILE: include/trace/events/libata.h:579:
+               __field( unsigned int,  tag     )

ERROR: space prohibited before that close parenthesis ')'
#254: FILE: include/trace/events/libata.h:579:
+               __field( unsigned int,  tag     )

ERROR: space prohibited after that open parenthesis '('
#255: FILE: include/trace/events/libata.h:580:
+               __field( unsigned int,  flags   )

ERROR: space prohibited before that close parenthesis ')'
#255: FILE: include/trace/events/libata.h:580:
+               __field( unsigned int,  flags   )

ERROR: space prohibited after that open parenthesis '('
#256: FILE: include/trace/events/libata.h:581:
+               __field( unsigned int,  offset  )

ERROR: space prohibited before that close parenthesis ')'
#256: FILE: include/trace/events/libata.h:581:
+               __field( unsigned int,  offset  )

ERROR: space prohibited after that open parenthesis '('
#257: FILE: include/trace/events/libata.h:582:
+               __field( unsigned int,  bytes   )

ERROR: space prohibited before that close parenthesis ')'
#257: FILE: include/trace/events/libata.h:582:
+               __field( unsigned int,  bytes   )

WARNING: line over 80 characters
#276: FILE: include/trace/events/libata.h:601:
+            TP_PROTO(struct ata_queued_cmd *qc, unsigned int offset, unsigned int count),

WARNING: line over 80 characters
#280: FILE: include/trace/events/libata.h:605:
+            TP_PROTO(struct ata_queued_cmd *qc, unsigned int offset, unsigned int count),

WARNING: line over 80 characters
#284: FILE: include/trace/events/libata.h:609:
+            TP_PROTO(struct ata_queued_cmd *qc, unsigned int offset, unsigned int count),

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

> Signed-off-by: Hannes Reinecke <hare@suse.com>
> ---
>  drivers/ata/libata-sff.c      | 12 +++---
>  drivers/ata/libata-trace.c    | 29 +++++++++++++
>  include/trace/events/libata.h | 95 +++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 129 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/ata/libata-sff.c b/drivers/ata/libata-sff.c
> index a5e6be6955ae..6b961eadc201 100644
> --- a/drivers/ata/libata-sff.c
> +++ b/drivers/ata/libata-sff.c
> @@ -660,7 +660,7 @@ static void ata_pio_sector(struct ata_queued_cmd *qc)
>  	page = nth_page(page, (offset >> PAGE_SHIFT));
>  	offset %= PAGE_SIZE;
>  
> -	DPRINTK("data %s\n", qc->tf.flags & ATA_TFLAG_WRITE ? "write" : "read");
> +	trace_ata_sff_pio_transfer_data(qc, offset, qc->sect_size);
>  
>  	/* do the actual data transfer */
>  	buf = kmap_atomic(page);
> @@ -723,7 +723,7 @@ static void ata_pio_sectors(struct ata_queued_cmd *qc)
>  static void atapi_send_cdb(struct ata_port *ap, struct ata_queued_cmd *qc)
>  {
>  	/* send SCSI cdb */
> -	DPRINTK("send cdb\n");
> +	trace_atapi_send_cdb(qc, 0, qc->dev->cdb_len);
>  	WARN_ON_ONCE(qc->dev->cdb_len < 12);
>  
>  	ap->ops->sff_data_xfer(qc, qc->cdb, qc->dev->cdb_len, 1);
> @@ -794,7 +794,7 @@ static int __atapi_pio_bytes(struct ata_queued_cmd *qc, unsigned int bytes)
>  	/* don't cross page boundaries */
>  	count = min(count, (unsigned int)PAGE_SIZE - offset);
>  
> -	DPRINTK("data %s\n", qc->tf.flags & ATA_TFLAG_WRITE ? "write" : "read");
> +	trace_atapi_pio_transfer_data(qc, offset, count);
>  
>  	/* do the actual data transfer */
>  	buf = kmap_atomic(page);
> @@ -976,8 +976,7 @@ int ata_sff_hsm_move(struct ata_port *ap, struct ata_queued_cmd *qc,
>  	WARN_ON_ONCE(in_wq != ata_hsm_ok_in_wq(ap, qc));
>  
>  fsm_start:
> -	DPRINTK("ata%u: protocol %d task_state %d (dev_stat 0x%X)\n",
> -		ap->print_id, qc->tf.protocol, ap->hsm_task_state, status);
> +	trace_ata_sff_hsm_state(qc, status);
>  
>  	switch (ap->hsm_task_state) {
>  	case HSM_ST_FIRST:
> @@ -1178,8 +1177,7 @@ int ata_sff_hsm_move(struct ata_port *ap, struct ata_queued_cmd *qc,
>  		}
>  
>  		/* no more data to transfer */
> -		DPRINTK("ata%u: dev %u command complete, drv_stat 0x%x\n",
> -			ap->print_id, qc->dev->devno, status);
> +		trace_ata_sff_hsm_command_complete(qc, status);
>  
>  		WARN_ON_ONCE(qc->err_mask & (AC_ERR_DEV | AC_ERR_HSM));
>  
> diff --git a/drivers/ata/libata-trace.c b/drivers/ata/libata-trace.c
> index 08e001303a82..5a9fba18411b 100644
> --- a/drivers/ata/libata-trace.c
> +++ b/drivers/ata/libata-trace.c
> @@ -137,6 +137,35 @@ libata_trace_parse_qc_flags(struct trace_seq *p, unsigned int qc_flags)
>  	return ret;
>  }
>  
> +const char *
> +libata_trace_parse_tf_flags(struct trace_seq *p, unsigned int tf_flags)
> +{
> +	const char *ret = trace_seq_buffer_ptr(p);
> +
> +	trace_seq_printf(p, "%x", tf_flags);
> +	if (tf_flags) {
> +		trace_seq_printf(p, "{ ");
> +		if (tf_flags & ATA_TFLAG_LBA48)
> +			trace_seq_printf(p, "LBA48 ");
> +		if (tf_flags & ATA_TFLAG_ISADDR)
> +			trace_seq_printf(p, "ISADDR ");
> +		if (tf_flags & ATA_TFLAG_DEVICE)
> +			trace_seq_printf(p, "DEV ");
> +		if (tf_flags & ATA_TFLAG_WRITE)
> +			trace_seq_printf(p, "WRITE ");
> +		if (tf_flags & ATA_TFLAG_LBA)
> +			trace_seq_printf(p, "LBA ");
> +		if (tf_flags & ATA_TFLAG_FUA)
> +			trace_seq_printf(p, "FUA ");
> +		if (tf_flags & ATA_TFLAG_POLLING)
> +			trace_seq_printf(p, "POLL ");
> +		trace_seq_putc(p, '}');
> +	}
> +	trace_seq_putc(p, 0);
> +
> +	return ret;
> +}
> +
>  const char *
>  libata_trace_parse_subcmd(struct trace_seq *p, unsigned char cmd,
>  			  unsigned char feature, unsigned char hob_nsect)
> diff --git a/include/trace/events/libata.h b/include/trace/events/libata.h
> index 476acf823928..acfc5d739b17 100644
> --- a/include/trace/events/libata.h
> +++ b/include/trace/events/libata.h
> @@ -148,6 +148,15 @@
>  		ata_class_name(ATA_DEV_ZAC_UNSUP),	\
>  		ata_class_name(ATA_DEV_NONE))
>  
> +#define ata_sff_hsm_state_name(state)	{ state, #state }
> +#define show_sff_hsm_state_name(val)				\
> +    __print_symbolic(val,				\
> +		ata_sff_hsm_state_name(HSM_ST_IDLE),	\
> +		ata_sff_hsm_state_name(HSM_ST_FIRST),	\
> +		ata_sff_hsm_state_name(HSM_ST),		\
> +		ata_sff_hsm_state_name(HSM_ST_LAST),	\
> +		ata_sff_hsm_state_name(HSM_ST_ERR))
> +
>  const char *libata_trace_parse_status(struct trace_seq*, unsigned char);
>  #define __parse_status(s) libata_trace_parse_status(p, s)
>  
> @@ -160,6 +169,9 @@ const char *libata_trace_parse_eh_err_mask(struct trace_seq *, unsigned int);
>  const char *libata_trace_parse_qc_flags(struct trace_seq *, unsigned int);
>  #define __parse_qc_flags(f) libata_trace_parse_qc_flags(p, f)
>  
> +const char *libata_trace_parse_tf_flags(struct trace_seq *, unsigned int);
> +#define __parse_tf_flags(f) libata_trace_parse_tf_flags(p, f)
> +
>  const char *libata_trace_parse_subcmd(struct trace_seq *, unsigned char,
>  				      unsigned char, unsigned char);
>  #define __parse_subcmd(c,f,h) libata_trace_parse_subcmd(p, c, f, h)
> @@ -514,6 +526,89 @@ DEFINE_EVENT(ata_link_reset_end_template, ata_link_softreset_end,
>  	     TP_PROTO(struct ata_link *link, unsigned int *class, int rc),
>  	     TP_ARGS(link, class, rc));
>  
> +DECLARE_EVENT_CLASS(ata_sff_hsm_template,
> +
> +	TP_PROTO(struct ata_queued_cmd *qc, unsigned char status),
> +
> +	TP_ARGS(qc, status),
> +
> +	TP_STRUCT__entry(
> +		__field( unsigned int,	ata_port )
> +		__field( unsigned int,	ata_dev	)
> +		__field( unsigned int,	tag	)
> +		__field( unsigned int,	qc_flags )
> +		__field( unsigned int,	protocol )
> +		__field( unsigned int,	hsm_state )
> +		__field( unsigned char,	dev_state )
> +	),
> +
> +	TP_fast_assign(
> +		__entry->ata_port	= qc->ap->print_id;
> +		__entry->ata_dev	= qc->dev->link->pmp + qc->dev->devno;
> +		__entry->tag		= qc->tag;
> +		__entry->qc_flags	= qc->flags;
> +		__entry->protocol	= qc->tf.protocol;
> +		__entry->hsm_state	= qc->ap->hsm_task_state;
> +		__entry->dev_state	= status;
> +	),
> +
> +	TP_printk("ata_port=%u ata_dev=%u tag=%d protocol=%d flags=%s task_state=%s dev_stat=0x%X",
> +		  __entry->ata_port, __entry->ata_dev, __entry->tag,
> +		  __entry->protocol,__parse_qc_flags(__entry->qc_flags),
> +		  show_sff_hsm_state_name(__entry->hsm_state),
> +		  __entry->dev_state)
> +);
> +
> +DEFINE_EVENT(ata_sff_hsm_template, ata_sff_hsm_state,
> +	TP_PROTO(struct ata_queued_cmd *qc, unsigned char state),
> +	TP_ARGS(qc, state));
> +
> +DEFINE_EVENT(ata_sff_hsm_template, ata_sff_hsm_command_complete,
> +	TP_PROTO(struct ata_queued_cmd *qc, unsigned char state),
> +	TP_ARGS(qc, state));
> +
> +DECLARE_EVENT_CLASS(ata_transfer_data_template,
> +
> +	TP_PROTO(struct ata_queued_cmd *qc, unsigned int offset, unsigned int count),
> +
> +	TP_ARGS(qc, offset, count),
> +
> +	TP_STRUCT__entry(
> +		__field( unsigned int,	ata_port )
> +		__field( unsigned int,	ata_dev	)
> +		__field( unsigned int,	tag	)
> +		__field( unsigned int,	flags	)
> +		__field( unsigned int,	offset	)
> +		__field( unsigned int,	bytes	)
> +	),
> +
> +	TP_fast_assign(
> +		__entry->ata_port	= qc->ap->print_id;
> +		__entry->ata_dev	= qc->dev->link->pmp + qc->dev->devno;
> +		__entry->tag		= qc->tag;
> +		__entry->flags		= qc->tf.flags;
> +		__entry->offset		= offset;
> +		__entry->bytes		= count;
> +	),
> +
> +	TP_printk("ata_port=%u ata_dev=%u tag=%d flags=%s offset=%u bytes=%u",
> +		  __entry->ata_port, __entry->ata_dev, __entry->tag,
> +		  __parse_tf_flags(__entry->flags),
> +		  __entry->offset, __entry->bytes)
> +);
> +
> +DEFINE_EVENT(ata_transfer_data_template, ata_sff_pio_transfer_data,
> +	     TP_PROTO(struct ata_queued_cmd *qc, unsigned int offset, unsigned int count),
> +	     TP_ARGS(qc, offset, count));
> +
> +DEFINE_EVENT(ata_transfer_data_template, atapi_pio_transfer_data,
> +	     TP_PROTO(struct ata_queued_cmd *qc, unsigned int offset, unsigned int count),
> +	     TP_ARGS(qc, offset, count));
> +
> +DEFINE_EVENT(ata_transfer_data_template, atapi_send_cdb,
> +	     TP_PROTO(struct ata_queued_cmd *qc, unsigned int offset, unsigned int count),
> +	     TP_ARGS(qc, offset, count));
> +
>  #endif /*  _TRACE_LIBATA_H */
>  
>  /* This part must be outside protection */
