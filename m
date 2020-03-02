Return-Path: <SRS0=3I3m=4T=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5EBBC3F2D1
	for <linux-ide@archiver.kernel.org>; Mon,  2 Mar 2020 18:17:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71F872083E
	for <linux-ide@archiver.kernel.org>; Mon,  2 Mar 2020 18:17:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="VuAWYjNW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727213AbgCBSRC (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 2 Mar 2020 13:17:02 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:33597 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726451AbgCBSRB (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 2 Mar 2020 13:17:01 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20200302181700euoutp0101fff9fd2d80bed0097d26bf947c99de~4j3lh-9HT0032100321euoutp015
        for <linux-ide@vger.kernel.org>; Mon,  2 Mar 2020 18:17:00 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20200302181700euoutp0101fff9fd2d80bed0097d26bf947c99de~4j3lh-9HT0032100321euoutp015
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1583173020;
        bh=faXwX6hdDMR6UHv0vh1dKv8VpRqcIvp/maeKOGEw0lk=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=VuAWYjNWU5zXrxW8ngXDXvTm6UiTuWjle6t3/eHIkoic8xIvC97R1V7OMxCMaguOk
         /iyXGlz6p3fxsqm9FmJ8dR0szaaxz70yzrW15mNte1kg5nQ0ag6jg4CbADyZngTe5s
         zsCWPW1NpG3K/J5/oONvONLiG2JqL2aEHrF1G3Wc=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200302181659eucas1p204128e956513618228c5b72920021b64~4j3k8eztE1900919009eucas1p2J;
        Mon,  2 Mar 2020 18:16:59 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 9F.0B.61286.B9D4D5E5; Mon,  2
        Mar 2020 18:16:59 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200302181659eucas1p11e3644471da82b52b1f1b349e2defbcf~4j3khjhS91935319353eucas1p1E;
        Mon,  2 Mar 2020 18:16:59 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200302181659eusmtrp27cd6aff56af93a99429cd47cd6eb67c8~4j3khA_ck3042930429eusmtrp2M;
        Mon,  2 Mar 2020 18:16:59 +0000 (GMT)
X-AuditID: cbfec7f2-ef1ff7000001ef66-1a-5e5d4d9bf318
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 28.8C.08375.B9D4D5E5; Mon,  2
        Mar 2020 18:16:59 +0000 (GMT)
Received: from [106.120.51.71] (unknown [106.120.51.71]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200302181659eusmtip2fdc57104f07b1df570e4f1439c288de7~4j3kO32RV1012210122eusmtip27;
        Mon,  2 Mar 2020 18:16:59 +0000 (GMT)
Subject: Re: [PATCH 25/42] libata-sff: add tracepoints for
 ata_sff_flush_pio_task()
To:     Hannes Reinecke <hare@suse.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
        linux-ide@vger.kernel.org
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Message-ID: <732b2250-6049-941b-90ce-2cbdcd5c1340@samsung.com>
Date:   Mon, 2 Mar 2020 19:16:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20200213095412.23773-26-hare@suse.de>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprCKsWRmVeSWpSXmKPExsWy7djP87qzfWPjDD4cM7RYfbefzWLPoklM
        Fsd2PGKy+LX8KKMDi8fls6Uem1Z1snlsPl3t8XmTXABLFJdNSmpOZllqkb5dAlfGvyWzWAv6
        hSpe317L1MD4mq+LkZNDQsBE4t7VPUxdjFwcQgIrGCXONB1lgXC+MEpM2LwbKvOZUaL9z1om
        mJanuw+zQSSWM0r87F/EDJIQEngL5LzTBLGFBUIltn7+zAhiiwgoSXxsP8QOYjMLREhs3AAx
        iE3ASmJi+yqwGl4BO4m/v44BrebgYBFQkVj9UBAkLApU/unBYVaIEkGJkzOfsIDYnALGEg+P
        L2CDGCkucevJfCYIW15i+9s5zCC3SQj0s0uceL+HEeJoF4lPp1azQtjCEq+Ob2GHsGUk/u+c
        zwTRsI5R4m/HC6ju7YwSyyf/Y4Oospa4c+4XG8h1zAKaEut36UOEHSWOtDYzgoQlBPgkbrwV
        hDiCT2LStunMEGFeiY42IYhqNYkNyzawwazt2rmSeQKj0iwkr81C8s4sJO/MQti7gJFlFaN4
        amlxbnpqsWFearlecWJucWleul5yfu4mRmBaOf3v+KcdjF8vJR1iFOBgVOLhDWCOjRNiTSwr
        rsw9xCjBwawkwuvLGR0nxJuSWFmVWpQfX1Sak1p8iFGag0VJnNd40ctYIYH0xJLU7NTUgtQi
        mCwTB6dUAyNfbr3+A54zLl3bm+tK1/I16SRen8XYtGOJcuJTl1tu8+XNHj+SjeIp75/4o/6F
        zZt5ExUSXe+rPVK8aeN/LEyr00Ph8Vz7VZ0i7SeDH/ldbU8JaryYIKw2O1f4TVt07UUP8Zvm
        lyfZFaSmuVzOPn7KwP5wUpXqUxHPWZXi+acXbTzCupxbU4mlOCPRUIu5qDgRAFF5G3MnAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrGIsWRmVeSWpSXmKPExsVy+t/xe7qzfWPjDNZ+EbNYfbefzWLPoklM
        Fsd2PGKy+LX8KKMDi8fls6Uem1Z1snlsPl3t8XmTXABLlJ5NUX5pSapCRn5xia1StKGFkZ6h
        pYWekYmlnqGxeayVkamSvp1NSmpOZllqkb5dgl7GvyWzWAv6hSpe317L1MD4mq+LkZNDQsBE
        4unuw2xdjFwcQgJLGSWOvjnF1MXIAZSQkTi+vgyiRljiz7UuqJrXjBL9m98xgSSEBUIltn7+
        zAhiiwgoSXxsP8QOYjMLREh0vzoD1bCOUWLuzw6wBjYBK4mJ7avAGngF7CT+/jrGArKMRUBF
        YvVDQZCwKFDv4R2zoEoEJU7OfMICYnMKGEs8PL6ADWK+usSfeZeYIWxxiVtP5jNB2PIS29/O
        YZ7AKDQLSfssJC2zkLTMQtKygJFlFaNIamlxbnpusaFecWJucWleul5yfu4mRmAcbTv2c/MO
        xksbgw8xCnAwKvHwBjDHxgmxJpYVV+YeYpTgYFYS4fXljI4T4k1JrKxKLcqPLyrNSS0+xGgK
        9NtEZinR5HxgjOeVxBuaGppbWBqaG5sbm1koifN2CByMERJITyxJzU5NLUgtgulj4uCUamDM
        eFazmjdg2Zy8Yx/D52duO/0r2l9F4TmT/P3kpsePD/dxFjBt47zaHb3X962a0RVLn6LNxZ/n
        /9r97XHvwTbOsBlnnbZtFqhVXb754lyulgeGxgbnZ8WZdH84/0Jg8qMTiZGruww4deyUK1yv
        LSr2iFz1oNNkxYvIYwtvZxzPvX1Lp1piu9w8JZbijERDLeai4kQAmZRqoLkCAAA=
X-CMS-MailID: 20200302181659eucas1p11e3644471da82b52b1f1b349e2defbcf
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200213095440eucas1p2a43d2043e08ca76c13211cbaa4360fb1
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200213095440eucas1p2a43d2043e08ca76c13211cbaa4360fb1
References: <20200213095412.23773-1-hare@suse.de>
        <CGME20200213095440eucas1p2a43d2043e08ca76c13211cbaa4360fb1@eucas1p2.samsung.com>
        <20200213095412.23773-26-hare@suse.de>
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org


On 2/13/20 10:53 AM, Hannes Reinecke wrote:
> Replace DPRINTK calls with tracepoints.
> 
> Signed-off-by: Hannes Reinecke <hare@suse.de>

Reviewed-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

> ---
>  drivers/ata/libata-sff.c      |  5 +----
>  include/trace/events/libata.h | 25 +++++++++++++++++++++++++
>  2 files changed, 26 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/ata/libata-sff.c b/drivers/ata/libata-sff.c
> index f6a54b574b25..ffe633f13f55 100644
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
> -		ata_port_dbg(ap, "EXIT\n");
>  }
>  
>  static void ata_sff_pio_task(struct work_struct *work)
> diff --git a/include/trace/events/libata.h b/include/trace/events/libata.h
> index a4200ef943f3..bebde8a72b9c 100644
> --- a/include/trace/events/libata.h
> +++ b/include/trace/events/libata.h
> @@ -617,6 +617,31 @@ DEFINE_EVENT(ata_transfer_data_template, atapi_send_cdb,
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
