Return-Path: <SRS0=vLfT=36=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45ED2C352A3
	for <linux-ide@archiver.kernel.org>; Mon, 10 Feb 2020 15:44:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 010FF20715
	for <linux-ide@archiver.kernel.org>; Mon, 10 Feb 2020 15:44:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="VQxWDlfJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726816AbgBJPor (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 10 Feb 2020 10:44:47 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:34442 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726796AbgBJPor (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 10 Feb 2020 10:44:47 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20200210154444euoutp013a959325271ef59170a63491732847a1~yFPpvIGHG1132611326euoutp01T
        for <linux-ide@vger.kernel.org>; Mon, 10 Feb 2020 15:44:44 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20200210154444euoutp013a959325271ef59170a63491732847a1~yFPpvIGHG1132611326euoutp01T
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1581349485;
        bh=IDZHYGQEDITIq/mhNGqa7n3IN7AyeXLKhg/CH62ViS8=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=VQxWDlfJELtntAIPpX6Yoc18voLFZYFpwoofb7ncmKiD5+bFY3l8M1zVv/J5bY8bS
         HKXbqWYsJAomCkzcoGkNM6qIxSYks83h/ig+o0x4rq8MVSRcDF9eV0I0skrKMIdXJH
         xJMqQG44GZ1BRC+MNXf9sIJX+EpT7hdXXuWVbLcU=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200210154444eucas1p11c15915d667b4d53585915fe26a87772~yFPplNulf2009720097eucas1p1e;
        Mon, 10 Feb 2020 15:44:44 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id A2.0D.60679.C6A714E5; Mon, 10
        Feb 2020 15:44:44 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200210154444eucas1p21edc375cf16177ef2f5052f080f36526~yFPpI-bl70962409624eucas1p2I;
        Mon, 10 Feb 2020 15:44:44 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200210154444eusmtrp18ec8d0dd5d5536a1569465657645a65c~yFPpIdKpC2285922859eusmtrp1q;
        Mon, 10 Feb 2020 15:44:44 +0000 (GMT)
X-AuditID: cbfec7f4-0e5ff7000001ed07-64-5e417a6c1d94
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 0F.C1.08375.C6A714E5; Mon, 10
        Feb 2020 15:44:44 +0000 (GMT)
Received: from [106.120.51.71] (unknown [106.120.51.71]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200210154444eusmtip2bcd7bf8d35127cb627829922522ff574~yFPo2xece3242532425eusmtip2T;
        Mon, 10 Feb 2020 15:44:44 +0000 (GMT)
Subject: Re: [PATCH 29/46] libata-sff: add tracepoints for
 ata_sff_flush_pio_task()
To:     Hannes Reinecke <hare@suse.de>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-ide@vger.kernel.org,
        Hannes Reinecke <hare@suse.com>
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Message-ID: <e4da58ec-bed2-bb2f-531f-182c22d831f5@samsung.com>
Date:   Mon, 10 Feb 2020 16:44:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20200204165547.115220-30-hare@suse.de>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprCKsWRmVeSWpSXmKPExsWy7djPc7o5VY5xBv0PDCxW3+1ns1jwZi+b
        xZ5Fk5gsju14xOTA4nH5bKnH+i1XWTw2n672+LxJLoAlissmJTUnsyy1SN8ugSvjSfdS1oIl
        EhWHHi1mb2C8KtzFyMkhIWAicaxjNlsXIxeHkMAKRolnd2YwQThfGCUOTDvNCuF8ZpTYcKSN
        BaZlweMuRhBbSGA5o0TH0RKIoreMEtPfLmEHSQgLhEqcWDWDDcQWEVCS+Nh+CCzOLBAn0XTl
        LpjNJmAlMbF9FdggXgE7iVMt/8DqWQRUJf7svgwWFxWIkPj04DArRI2gxMmZT8CO4AQ64unK
        KSwQM8Ulbj2ZzwRhy0tsfzuHGeLQfnaJKyv5IWwXiRNP5zFB2MISr45vYYewZSROT+5hAXlA
        QmAdo8TfjhfMEM52RonlkyEukhCwlrhz7heQzQG0QVNi/S59iLCjxOrJ3UwgYQkBPokbbwUh
        buCTmLRtOjNEmFeio00IolpNYsOyDWwwa7t2rmSewKg0C8lns5B8MwvJN7MQ9i5gZFnFKJ5a
        WpybnlpslJdarlecmFtcmpeul5yfu4kRmFZO/zv+ZQfjrj9JhxgFOBiVeHgrAh3jhFgTy4or
        cw8xSnAwK4nwWkoDhXhTEiurUovy44tKc1KLDzFKc7AoifMaL3oZKySQnliSmp2aWpBaBJNl
        4uCUamDsa34WFlncX5Bg1BNXwbHvzua+1zofP1TPnn7URG/JrfuHCqdLTzmy61zaowwnZZHq
        ew6/ct+8Cvdj3uB3IvfRHpfNOjYP3ldYFFgWO2Zf452u+unQB91EHo+MF+m9NQZdu7bPazrL
        W3j6/p2YA+59XHfmO3T6hOxeGe/fxugdJX0ic+HOvMNKLMUZiYZazEXFiQDcg/7oJwMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrOIsWRmVeSWpSXmKPExsVy+t/xe7o5VY5xBm/XC1msvtvPZrHgzV42
        iz2LJjFZHNvxiMmBxePy2VKP9VuusnhsPl3t8XmTXABLlJ5NUX5pSapCRn5xia1StKGFkZ6h
        pYWekYmlnqGxeayVkamSvp1NSmpOZllqkb5dgl7Gk+6lrAVLJCoOPVrM3sB4VbiLkZNDQsBE
        YsHjLsYuRi4OIYGljBKPL/WzdDFyACVkJI6vL4OoEZb4c62LDaLmNaPEkk/LGUESwgKhEidW
        zWADsUUElCQ+th9iB7GZBeIk/vXtZoJo2MAosWLmJhaQBJuAlcTE9lVgzbwCdhKnWv6BNbMI
        qEr82X0ZLC4qECFxeMcsqBpBiZMzn4D1cgJd+nTlFBaIBeoSf+ZdYoawxSVuPZnPBGHLS2x/
        O4d5AqPQLCTts5C0zELSMgtJywJGllWMIqmlxbnpucWGesWJucWleel6yfm5mxiBkbTt2M/N
        OxgvbQw+xCjAwajEw1sR6BgnxJpYVlyZe4hRgoNZSYTXUhooxJuSWFmVWpQfX1Sak1p8iNEU
        6LmJzFKiyfnAKM8riTc0NTS3sDQ0NzY3NrNQEuftEDgYIySQnliSmp2aWpBaBNPHxMEp1cCo
        lrZKmL+4W1lMIWGSe05B2oYznNF87FtytzP/D2n5ZDChllHr/Ez1xWJ/HfY+S1LTOLsy40L6
        wmD5w9s4v+k3Hajr+VpcvvZTW4HCGlaxPY/+n7jc+6whO/D+zEW2e9hbZUpys9M+5Pcc+TGN
        a71d26/EpU572O7u08p22TizNvf7xejd344rsRRnJBpqMRcVJwIADlPTVroCAAA=
X-CMS-MailID: 20200210154444eucas1p21edc375cf16177ef2f5052f080f36526
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200204165615eucas1p241ffe6de633f8b8ff5c6929cbd8b41ac
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200204165615eucas1p241ffe6de633f8b8ff5c6929cbd8b41ac
References: <20200204165547.115220-1-hare@suse.de>
        <CGME20200204165615eucas1p241ffe6de633f8b8ff5c6929cbd8b41ac@eucas1p2.samsung.com>
        <20200204165547.115220-30-hare@suse.de>
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org


On 2/4/20 5:55 PM, Hannes Reinecke wrote:
> Replace DPRINTK calls with tracepoints.

Please consider moving the removal to a separate (post-)patch
(for consistency with reset tracepoints conversion etc.).

Also there are some complaints from checkpatch.pl script
regarding CodingStyle:

ERROR: space prohibited after that open parenthesis '('
#119: FILE: include/trace/events/libata.h:619:
+               __field( unsigned int,  ata_port )

ERROR: space prohibited before that close parenthesis ')'
#119: FILE: include/trace/events/libata.h:619:
+               __field( unsigned int,  ata_port )

ERROR: space prohibited after that open parenthesis '('
#120: FILE: include/trace/events/libata.h:620:
+               __field( unsigned char, hsm_state )

ERROR: space prohibited before that close parenthesis ')'
#120: FILE: include/trace/events/libata.h:620:
+               __field( unsigned char, hsm_state )

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

> Signed-off-by: Hannes Reinecke <hare@suse.com>
> ---
>  drivers/ata/libata-sff.c      |  5 +----
>  include/trace/events/libata.h | 25 +++++++++++++++++++++++++
>  2 files changed, 26 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/ata/libata-sff.c b/drivers/ata/libata-sff.c
> index 6b961eadc201..228f801ef611 100644
> --- a/drivers/ata/libata-sff.c
> +++ b/drivers/ata/libata-sff.c
> @@ -1234,7 +1234,7 @@ EXPORT_SYMBOL_GPL(ata_sff_queue_pio_task);
>  
>  void ata_sff_flush_pio_task(struct ata_port *ap)
>  {
> -	DPRINTK("ENTER\n");
> +	trace_ata_sff_flush_pio_task(ap);
>  
>  	cancel_delayed_work_sync(&ap->sff_pio_task);
>  
> @@ -1251,9 +1251,6 @@ void ata_sff_flush_pio_task(struct ata_port *ap)
>  	spin_unlock_irq(ap->lock);
>  
>  	ap->sff_pio_task_link = NULL;
> -
> -	if (ata_msg_ctl(ap))
> -		ata_port_dbg(ap, "%s: EXIT\n", __func__);
>  }
>  
>  static void ata_sff_pio_task(struct work_struct *work)
> diff --git a/include/trace/events/libata.h b/include/trace/events/libata.h
> index acfc5d739b17..446f56cb3f01 100644
> --- a/include/trace/events/libata.h
> +++ b/include/trace/events/libata.h
> @@ -609,6 +609,31 @@ DEFINE_EVENT(ata_transfer_data_template, atapi_send_cdb,
>  	     TP_PROTO(struct ata_queued_cmd *qc, unsigned int offset, unsigned int count),
>  	     TP_ARGS(qc, offset, count));
>  
> +DECLARE_EVENT_CLASS(ata_sff_template,
> +
> +	TP_PROTO(struct ata_port *ap),
> +
> +	TP_ARGS(ap),
> +
> +	TP_STRUCT__entry(
> +		__field( unsigned int,	ata_port )
> +		__field( unsigned char,	hsm_state )
> +	),
> +
> +	TP_fast_assign(
> +		__entry->ata_port	= ap->print_id;
> +		__entry->hsm_state	= ap->hsm_task_state;
> +	),
> +
> +	TP_printk("ata_port=%u task_state=%s",
> +		  __entry->ata_port,
> +		  show_sff_hsm_state_name(__entry->hsm_state))
> +);
> +
> +DEFINE_EVENT(ata_sff_template, ata_sff_flush_pio_task,
> +	     TP_PROTO(struct ata_port *ap),
> +	     TP_ARGS(ap));
> +
>  #endif /*  _TRACE_LIBATA_H */
>  
>  /* This part must be outside protection */
>
