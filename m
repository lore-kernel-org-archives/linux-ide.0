Return-Path: <SRS0=3I3m=4T=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F67FC3F2CD
	for <linux-ide@archiver.kernel.org>; Mon,  2 Mar 2020 18:09:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E027F2146E
	for <linux-ide@archiver.kernel.org>; Mon,  2 Mar 2020 18:09:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="R5PlsWff"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727104AbgCBSJU (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 2 Mar 2020 13:09:20 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:60864 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726997AbgCBSJU (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 2 Mar 2020 13:09:20 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20200302180919euoutp01bb83bdd16b4074c121b362c304a3a427~4jw318CSi2590625906euoutp01S
        for <linux-ide@vger.kernel.org>; Mon,  2 Mar 2020 18:09:19 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20200302180919euoutp01bb83bdd16b4074c121b362c304a3a427~4jw318CSi2590625906euoutp01S
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1583172559;
        bh=bKX7Gg3gL88VNxWrPAyk9nF+eus/tVadb9lzjcR9ou0=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=R5PlsWffG2NW8EajVxL+6YUjRFqMniy+GbKTTgDWvjrBkH9nOrmbAgM8rA5JpLLeP
         J2ntSOJw5wVAM9ameIIoetm1SVQY8POyCtJZTZHcDRDbgqLw5p6yAEPJ0Q8kARx0aH
         HIy87nVY9fmF36439YC9HFMYFRqv3uf5/sRSVGMI=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200302180918eucas1p13301604bf0f1c1212b6c3139b18a61ca~4jw3TiMuM2947429474eucas1p1O;
        Mon,  2 Mar 2020 18:09:18 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 84.80.60698.ECB4D5E5; Mon,  2
        Mar 2020 18:09:18 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200302180917eucas1p2b50d1dcf51f9249b0b8115ee11b31d52~4jw2ojzGg3262232622eucas1p2F;
        Mon,  2 Mar 2020 18:09:17 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200302180917eusmtrp2bb6b0b92c8ce0578e11282177ada3bc6~4jw2oBB992560325603eusmtrp2V;
        Mon,  2 Mar 2020 18:09:17 +0000 (GMT)
X-AuditID: cbfec7f5-a0fff7000001ed1a-d3-5e5d4bcedc40
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id D5.5C.08375.DCB4D5E5; Mon,  2
        Mar 2020 18:09:17 +0000 (GMT)
Received: from [106.120.51.71] (unknown [106.120.51.71]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200302180917eusmtip2da94cafe910d5a800cae4877cfdb37e1~4jw2W_NaQ1012210122eusmtip2t;
        Mon,  2 Mar 2020 18:09:17 +0000 (GMT)
Subject: Re: [PATCH 27/42] libata: add tracepoints for ATA error handling
To:     Hannes Reinecke <hare@suse.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
        linux-ide@vger.kernel.org
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Message-ID: <2f196565-4e1f-930f-e84a-cd384c8de94f@samsung.com>
Date:   Mon, 2 Mar 2020 19:09:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20200213095412.23773-28-hare@suse.de>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprCKsWRmVeSWpSXmKPExsWy7djPc7rnvGPjDL73y1msvtvPZrFn0SQm
        i2M7HjFZ/Fp+lNGBxePy2VKPTas62Tw2n672+LxJLoAlissmJTUnsyy1SN8ugSvj4MpXbAXT
        VSpmvzjM3sB4SLaLkZNDQsBE4nrTKrYuRi4OIYEVjBLPXjcyQjhfGCW2bJzBDOF8ZpR4eWIR
        kMMB1rLkaB1EfDmjxJ2Oa1DtbxklTqxtYwKZKyzgKfHt8wF2EFtEQEniY/shMJtZIEJi44a1
        YDVsAlYSE9tXMYLYvAJ2Er/P/2cFsVkEVCQO7D4IZosC1X96cJgVokZQ4uTMJywgR3AKGEuc
        fC0NMVJc4taT+UwQtrzE9rdzwI6WEOhnl5i9qIMd4k8Xic7dPxghbGGJV8e3QMVlJP7vBGkG
        aVjHKPG34wVU93ZGieWT/7FBVFlL3Dn3iw1kM7OApsT6XfoQYUeJto2TWSGhwidx460gxBF8
        EpO2TYcGFq9ER5sQRLWaxIZlG9hg1nbtXMk8gVFpFpLPZiF5ZxaSd2Yh7F3AyLKKUTy1tDg3
        PbXYOC+1XK84Mbe4NC9dLzk/dxMjMK2c/nf86w7GfX+SDjEKcDAq8fAGMMfGCbEmlhVX5h5i
        lOBgVhLh9eWMjhPiTUmsrEotyo8vKs1JLT7EKM3BoiTOa7zoZayQQHpiSWp2ampBahFMlomD
        U6qBcb3rnt8P9y81t51u7CQuGRN5aWqh6ySpSGHVC5Kafx4bMMqmv9hn+Sdycn94kQnH9Q6j
        L3/Oan4M+FficJe35LPBMu4Dmkr2qb7MBZfW/OgqK5pzpbTkZ0LS4oisOzu7n3lpqiw29vXa
        N+XQqbNqb2Xi1lxP+bZolWpNoVtUp7s058MPlZHKSizFGYmGWsxFxYkAbqsfoicDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrKIsWRmVeSWpSXmKPExsVy+t/xe7pnvWPjDD4e0bNYfbefzWLPoklM
        Fsd2PGKy+LX8KKMDi8fls6Uem1Z1snlsPl3t8XmTXABLlJ5NUX5pSapCRn5xia1StKGFkZ6h
        pYWekYmlnqGxeayVkamSvp1NSmpOZllqkb5dgl7GwZWv2Aqmq1TMfnGYvYHxkGwXIweHhICJ
        xJKjdV2MXBxCAksZJW6vvMIOEZeROL6+rIuRE8gUlvhzrYsNouY1o8SM+y/ZQBLCAp4S3z4f
        YAexRQSUJD62HwKzmQUiJLpfnYFqWMco8WnWJlaQBJuAlcTE9lWMIDavgJ3E7/P/weIsAioS
        B3YfBLNFgZoP75gFVSMocXLmExaQgzgFjCVOvpaGmK8u8WfeJWYIW1zi1pP5TBC2vMT2t3OY
        JzAKzULSPQtJyywkLbOQtCxgZFnFKJJaWpybnltsqFecmFtcmpeul5yfu4kRGEXbjv3cvIPx
        0sbgQ4wCHIxKPLwBzLFxQqyJZcWVuYcYJTiYlUR4fTmj44R4UxIrq1KL8uOLSnNSiw8xmgL9
        NpFZSjQ5HxjheSXxhqaG5haWhubG5sZmFkrivB0CB2OEBNITS1KzU1MLUotg+pg4OKUaGP0N
        789LdBX7PzXlROv8gE139PLVuv//fFX5ZWOP44XWxMyf1w4ntwUyLtoY4Xy88Zy5p1Rs9eGp
        v53YO9YpPN0Yf6rpxu1Fx8Orby1Z+e9A/JMVdytab7w3/JaqHFQR+GjKst1mAkfO5qtK7u1w
        v6jt87ps66/VBw/4H7cJWWZk0cHgoHPDuEmJpTgj0VCLuag4EQC6MZlVuAIAAA==
X-CMS-MailID: 20200302180917eucas1p2b50d1dcf51f9249b0b8115ee11b31d52
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200213095437eucas1p11996271daf7d8ff1cc169682a84b7ded
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200213095437eucas1p11996271daf7d8ff1cc169682a84b7ded
References: <20200213095412.23773-1-hare@suse.de>
        <CGME20200213095437eucas1p11996271daf7d8ff1cc169682a84b7ded@eucas1p1.samsung.com>
        <20200213095412.23773-28-hare@suse.de>
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org


On 2/13/20 10:53 AM, Hannes Reinecke wrote:
> Add tracepoints for ATA error handling.
> 
> Signed-off-by: Hannes Reinecke <hare@suse.de>

Reviewed-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

> ---
>  drivers/ata/libata-eh.c       | 10 +++++---
>  include/trace/events/libata.h | 60 +++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 67 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
> index ef3576eb5874..a068b5370aac 100644
> --- a/drivers/ata/libata-eh.c
> +++ b/drivers/ata/libata-eh.c
> @@ -933,7 +933,7 @@ void ata_std_sched_eh(struct ata_port *ap)
>  	ata_eh_set_pending(ap, 1);
>  	scsi_schedule_eh(ap->scsi_host);
>  
> -	DPRINTK("port EH scheduled\n");
> +	trace_ata_std_sched_eh(ap);
>  }
>  EXPORT_SYMBOL_GPL(ata_std_sched_eh);
>  
> @@ -1060,7 +1060,7 @@ static void __ata_port_freeze(struct ata_port *ap)
>  
>  	ap->pflags |= ATA_PFLAG_FROZEN;
>  
> -	DPRINTK("ata%u port frozen\n", ap->print_id);
> +	trace_ata_port_freeze(ap);
>  }
>  
>  /**
> @@ -1208,7 +1208,7 @@ void ata_eh_thaw_port(struct ata_port *ap)
>  
>  	spin_unlock_irqrestore(ap->lock, flags);
>  
> -	DPRINTK("ata%u port thawed\n", ap->print_id);
> +	trace_ata_port_thaw(ap);
>  }
>  
>  static void ata_eh_scsidone(struct scsi_cmnd *scmd)
> @@ -1347,6 +1347,8 @@ void ata_eh_about_to_do(struct ata_link *link, struct ata_device *dev,
>  	struct ata_eh_context *ehc = &link->eh_context;
>  	unsigned long flags;
>  
> +	trace_ata_eh_about_to_do(link, dev ? dev->devno : 0, action);
> +
>  	spin_lock_irqsave(ap->lock, flags);
>  
>  	ata_eh_clear_action(link, dev, ehi, action);
> @@ -1377,6 +1379,8 @@ void ata_eh_done(struct ata_link *link, struct ata_device *dev,
>  {
>  	struct ata_eh_context *ehc = &link->eh_context;
>  
> +	trace_ata_eh_done(link, dev ? dev->devno : 0, action);
> +
>  	ata_eh_clear_action(link, dev, &ehc->i, action);
>  }
>  
> diff --git a/include/trace/events/libata.h b/include/trace/events/libata.h
> index bebde8a72b9c..35e84ff735b0 100644
> --- a/include/trace/events/libata.h
> +++ b/include/trace/events/libata.h
> @@ -454,6 +454,37 @@ TRACE_EVENT(ata_eh_link_autopsy_qc,
>  		  __parse_eh_err_mask(__entry->eh_err_mask))
>  );
>  
> +DECLARE_EVENT_CLASS(ata_eh_action_template,
> +
> +	TP_PROTO(struct ata_link *link, unsigned int devno, unsigned int eh_action),
> +
> +	TP_ARGS(link, devno, eh_action),
> +
> +	TP_STRUCT__entry(
> +		__field( unsigned int,	ata_port )
> +		__field( unsigned int,	ata_dev	)
> +		__field( unsigned int,	eh_action )
> +	),
> +
> +	TP_fast_assign(
> +		__entry->ata_port	= link->ap->print_id;
> +		__entry->ata_dev	= link->pmp + devno;
> +		__entry->eh_action	= eh_action;
> +	),
> +
> +	TP_printk("ata_port=%u ata_dev=%u eh_action=%s",
> +		  __entry->ata_port, __entry->ata_dev,
> +		  __parse_eh_action(__entry->eh_action))
> +);
> +
> +DEFINE_EVENT(ata_eh_action_template, ata_eh_about_to_do,
> +	     TP_PROTO(struct ata_link *link, unsigned int devno, unsigned int eh_action),
> +	     TP_ARGS(link, devno, eh_action));
> +
> +DEFINE_EVENT(ata_eh_action_template, ata_eh_done,
> +	     TP_PROTO(struct ata_link *link, unsigned int devno, unsigned int eh_action),
> +	     TP_ARGS(link, devno, eh_action));
> +
>  DECLARE_EVENT_CLASS(ata_link_reset_begin_template,
>  
>  	TP_PROTO(struct ata_link *link, unsigned int *class, unsigned long deadline),
> @@ -534,6 +565,35 @@ DEFINE_EVENT(ata_link_reset_end_template, ata_slave_postreset,
>  	     TP_PROTO(struct ata_link *link, unsigned int *class, int rc),
>  	     TP_ARGS(link, class, rc));
>  
> +DECLARE_EVENT_CLASS(ata_port_eh_begin_template,
> +
> +	TP_PROTO(struct ata_port *ap),
> +
> +	TP_ARGS(ap),
> +
> +	TP_STRUCT__entry(
> +		__field( unsigned int,	ata_port )
> +	),
> +
> +	TP_fast_assign(
> +		__entry->ata_port	= ap->print_id;
> +	),
> +
> +	TP_printk("ata_port=%u", __entry->ata_port)
> +);
> +
> +DEFINE_EVENT(ata_port_eh_begin_template, ata_std_sched_eh,
> +	     TP_PROTO(struct ata_port *ap),
> +	     TP_ARGS(ap));
> +
> +DEFINE_EVENT(ata_port_eh_begin_template, ata_port_freeze,
> +	     TP_PROTO(struct ata_port *ap),
> +	     TP_ARGS(ap));
> +
> +DEFINE_EVENT(ata_port_eh_begin_template, ata_port_thaw,
> +	     TP_PROTO(struct ata_port *ap),
> +	     TP_ARGS(ap));
> +
>  DECLARE_EVENT_CLASS(ata_sff_hsm_template,
>  
>  	TP_PROTO(struct ata_queued_cmd *qc, unsigned char status),
> 
