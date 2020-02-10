Return-Path: <SRS0=vLfT=36=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24464C352A3
	for <linux-ide@archiver.kernel.org>; Mon, 10 Feb 2020 16:45:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B372E20838
	for <linux-ide@archiver.kernel.org>; Mon, 10 Feb 2020 16:45:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="rxKAc9dZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727029AbgBJQpq (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 10 Feb 2020 11:45:46 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:53836 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726896AbgBJQpq (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 10 Feb 2020 11:45:46 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20200210164543euoutp012b8ba411af141fe635aa7ee58bc07bb2~yGE44qfAP3013630136euoutp01W
        for <linux-ide@vger.kernel.org>; Mon, 10 Feb 2020 16:45:43 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20200210164543euoutp012b8ba411af141fe635aa7ee58bc07bb2~yGE44qfAP3013630136euoutp01W
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1581353143;
        bh=LeR6fhLxRyrZpkfTFal7OmMSvHQwHgftqtflUuk6GRY=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=rxKAc9dZueWTAJ7Rk61gho0t7abBb9v/6JZHrBQjKCxzebRmKIbVSTtBJewXt4YuS
         axkEpbDDyrYx4GQn/SAa/nvL36YY20KB3priuaf4uioWH2DKnp1fVjwkOlbF5UZktq
         89DwjQxyBBMNVargW29VoIuYXTrcwIHQLyWQ9Go0=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200210164543eucas1p2c8e0468b458c3d5531460cdc76ec711b~yGE4wEoay1409714097eucas1p2y;
        Mon, 10 Feb 2020 16:45:43 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id FA.54.60679.7B8814E5; Mon, 10
        Feb 2020 16:45:43 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200210164542eucas1p1eccfa77dd274a47872b9a10f1ae95c6c~yGE4QcENf1560915609eucas1p1U;
        Mon, 10 Feb 2020 16:45:42 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200210164542eusmtrp28237d07b291b112180b5b23210839a6c~yGE4P73il3080330803eusmtrp2c;
        Mon, 10 Feb 2020 16:45:42 +0000 (GMT)
X-AuditID: cbfec7f4-0e5ff7000001ed07-b8-5e4188b79ba8
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id A6.E4.07950.6B8814E5; Mon, 10
        Feb 2020 16:45:42 +0000 (GMT)
Received: from [106.120.51.71] (unknown [106.120.51.71]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200210164541eusmtip2679712e3e30fbb5dba82042b5bfd1196~yGE27lfds3164731647eusmtip26;
        Mon, 10 Feb 2020 16:45:41 +0000 (GMT)
Subject: Re: [PATCH 39/46] libata: add tracepoints for ATA error handling
To:     Hannes Reinecke <hare@suse.de>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-ide@vger.kernel.org
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Message-ID: <f696fe99-b16f-83fe-99c1-d90b78dbfbea@samsung.com>
Date:   Mon, 10 Feb 2020 17:45:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20200204165547.115220-40-hare@suse.de>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupmleLIzCtJLcpLzFFi42LZduznOd3tHY5xBvdOclisvtvPZrFn0SQm
        i2M7HjE5MHtcPlvqsfl0tcfnTXIBzFFcNimpOZllqUX6dglcGY+utLIUbPGv6Lpyn7mBcZl9
        FyMnh4SAicThL32sXYxcHEICKxgl1u54xALhfGGUmLT9HTuE85lRYsb/Y8wwLbNnnoBqWc4o
        cf3IcbCEkMBbRomtfy1BbGEBT4nnP06ygtgiAkoSH9sPsYPYzALWErMXr2cCsdkErCQmtq9i
        BLF5BewkDm//wAJiswioSux7+BxspqhAhMSnB4dZIWoEJU7OfAJWwwl0xOb9sxkhZopL3Hoy
        nwnClpfY/nYOM8hxEgLN7BKr3+1kh7jaRaJlYy/UB8ISr45vgYrLSPzfCdIM0rCOUeJvxwuo
        7u2MEssn/2ODqLKWuHPuF5DNAbRCU2L9Ln2IsKPEkdsnwMISAnwSN94KQhzBJzFp23RmiDCv
        REebEES1msSGZRvYYNZ27VzJPIFRaRaS12YheWcWkndmIexdwMiyilE8tbQ4Nz212CgvtVyv
        ODG3uDQvXS85P3cTIzCJnP53/MsOxl1/kg4xCnAwKvHwVgQ6xgmxJpYVV+YeYpTgYFYS4bWU
        BgrxpiRWVqUW5ccXleakFh9ilOZgURLnNV70MlZIID2xJDU7NbUgtQgmy8TBKdXA6LRYMpNn
        S2GXsV/lt7Q836Nr12xfLOTCG/BekVVjpcjznC/njySJ+ezZuvrJ/2tGNxYVSE1iv//F+b8i
        j9151hsTGVc4JilLMLS6uy8/yBq3rvhh76KSS6EfKxeyaN84z/T2z/m39lav5zRk5BVpWs+a
        vf0V2+niieczd8/Kan35bcaGU2Vua5RYijMSDbWYi4oTAf4Iz48eAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprDIsWRmVeSWpSXmKPExsVy+t/xe7rbOhzjDH6t0LJYfbefzWLPoklM
        Fsd2PGJyYPa4fLbUY/Ppao/Pm+QCmKP0bIryS0tSFTLyi0tslaINLYz0DC0t9IxMLPUMjc1j
        rYxMlfTtbFJSczLLUov07RL0Mh5daWUp2OJf0XXlPnMD4zL7LkZODgkBE4nZM0+wgthCAksZ
        Jd6sqOxi5ACKy0gcX18GUSIs8edaF1sXIxdQyWtGicdHzrCDJIQFPCWe/zgJ1isioCTxsf0Q
        WJxZwFpi9uL1TBANGxglLq/awASSYBOwkpjYvooRxOYVsJM4vP0DC4jNIqAqse/hc2YQW1Qg
        QuLwjllQNYISJ2c+AavhBDp08/7ZjBAL1CX+zLvEDGGLS9x6Mp8JwpaX2P52DvMERqFZSNpn
        IWmZhaRlFpKWBYwsqxhFUkuLc9Nzi430ihNzi0vz0vWS83M3MQJjZtuxn1t2MHa9Cz7EKMDB
        qMTDeyHYMU6INbGsuDL3EKMEB7OSCK+lNFCINyWxsiq1KD++qDQntfgQoynQcxOZpUST84Hx
        nFcSb2hqaG5haWhubG5sZqEkztshcDBGSCA9sSQ1OzW1ILUIpo+Jg1OqgXFTnezuq1XFggbl
        LRWcBs1LGo884EiR/V7DE+MWoClvnXlP9vn33ty3WslLHy0P3VW1uHFb51rdLUcff7V5eDh4
        T0ga5xkm0SkOF1fIr/tVERjGyrLowsT1elGn8nddkPUqsGiYLLTw4JU4jeDnK11XxBy6pb64
        dKqp2GPWiUYvP9d4V7VH5CixFGckGmoxFxUnAgD1dclprwIAAA==
X-CMS-MailID: 20200210164542eucas1p1eccfa77dd274a47872b9a10f1ae95c6c
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200204165617eucas1p2c5b1b2779b90001b9ffec17711415b51
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200204165617eucas1p2c5b1b2779b90001b9ffec17711415b51
References: <20200204165547.115220-1-hare@suse.de>
        <CGME20200204165617eucas1p2c5b1b2779b90001b9ffec17711415b51@eucas1p2.samsung.com>
        <20200204165547.115220-40-hare@suse.de>
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org


On 2/4/20 5:55 PM, Hannes Reinecke wrote:
> Add tracepoints for ATA error handling, and remove the related
> DPRINTK() calls.
> 
> Signed-off-by: Hannes Reinecke <hare@suse.de>

Please move the removal to a separate (post-)patch
(like it has been done for reset tracepoints).

Also there is a lot of complaints from checkpatch.pl script
regarding CodingStyle:

WARNING: line over 80 characters
#259: FILE: include/trace/events/libata.h:459:
+       TP_PROTO(struct ata_link *link, unsigned int devno, unsigned int eh_action),

ERROR: space prohibited after that open parenthesis '('
#264: FILE: include/trace/events/libata.h:464:
+               __field( unsigned int,  ata_port )

ERROR: space prohibited before that close parenthesis ')'
#264: FILE: include/trace/events/libata.h:464:
+               __field( unsigned int,  ata_port )

ERROR: space prohibited after that open parenthesis '('
#265: FILE: include/trace/events/libata.h:465:
+               __field( unsigned int,  ata_dev )

ERROR: space prohibited before that close parenthesis ')'
#265: FILE: include/trace/events/libata.h:465:
+               __field( unsigned int,  ata_dev )

ERROR: space prohibited after that open parenthesis '('
#266: FILE: include/trace/events/libata.h:466:
+               __field( unsigned int,  eh_action )

ERROR: space prohibited before that close parenthesis ')'
#266: FILE: include/trace/events/libata.h:466:
+               __field( unsigned int,  eh_action )

WARNING: line over 80 characters
#281: FILE: include/trace/events/libata.h:481:
+            TP_PROTO(struct ata_link *link, unsigned int devno, unsigned int eh_action),

WARNING: line over 80 characters
#285: FILE: include/trace/events/libata.h:485:
+            TP_PROTO(struct ata_link *link, unsigned int devno, unsigned int eh_action),

ERROR: space prohibited after that open parenthesis '('
#302: FILE: include/trace/events/libata.h:575:
+               __field( unsigned int,  ata_port )

ERROR: space prohibited before that close parenthesis ')'
#302: FILE: include/trace/events/libata.h:575:
+               __field( unsigned int,  ata_port )

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

> ---
>  drivers/ata/libata-eh.c       | 22 +++++-----------
>  drivers/ata/libata-pmp.c      |  8 ------
>  include/trace/events/libata.h | 60 +++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 67 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
> index ef3576eb5874..f37dad5f9c17 100644
> --- a/drivers/ata/libata-eh.c
> +++ b/drivers/ata/libata-eh.c
> @@ -526,8 +526,6 @@ void ata_scsi_error(struct Scsi_Host *host)
>  	unsigned long flags;
>  	LIST_HEAD(eh_work_q);
>  
> -	DPRINTK("ENTER\n");
> -
>  	spin_lock_irqsave(host->host_lock, flags);
>  	list_splice_init(&host->eh_cmd_q, &eh_work_q);
>  	spin_unlock_irqrestore(host->host_lock, flags);
> @@ -541,7 +539,6 @@ void ata_scsi_error(struct Scsi_Host *host)
>  	/* finish or retry handled scmd's and clean up */
>  	WARN_ON(!list_empty(&eh_work_q));
>  
> -	DPRINTK("EXIT\n");
>  }
>  
>  /**
> @@ -933,7 +930,7 @@ void ata_std_sched_eh(struct ata_port *ap)
>  	ata_eh_set_pending(ap, 1);
>  	scsi_schedule_eh(ap->scsi_host);
>  
> -	DPRINTK("port EH scheduled\n");
> +	trace_ata_std_sched_eh(ap);
>  }
>  EXPORT_SYMBOL_GPL(ata_std_sched_eh);
>  
> @@ -1060,7 +1057,7 @@ static void __ata_port_freeze(struct ata_port *ap)
>  
>  	ap->pflags |= ATA_PFLAG_FROZEN;
>  
> -	DPRINTK("ata%u port frozen\n", ap->print_id);
> +	trace_ata_port_freeze(ap);
>  }
>  
>  /**
> @@ -1208,7 +1205,7 @@ void ata_eh_thaw_port(struct ata_port *ap)
>  
>  	spin_unlock_irqrestore(ap->lock, flags);
>  
> -	DPRINTK("ata%u port thawed\n", ap->print_id);
> +	trace_ata_port_thaw(ap);
>  }
>  
>  static void ata_eh_scsidone(struct scsi_cmnd *scmd)
> @@ -1347,6 +1344,8 @@ void ata_eh_about_to_do(struct ata_link *link, struct ata_device *dev,
>  	struct ata_eh_context *ehc = &link->eh_context;
>  	unsigned long flags;
>  
> +	trace_ata_eh_about_to_do(link, dev ? dev->devno : 0, action);
> +
>  	spin_lock_irqsave(ap->lock, flags);
>  
>  	ata_eh_clear_action(link, dev, ehi, action);
> @@ -1377,6 +1376,8 @@ void ata_eh_done(struct ata_link *link, struct ata_device *dev,
>  {
>  	struct ata_eh_context *ehc = &link->eh_context;
>  
> +	trace_ata_eh_done(link, dev ? dev->devno : 0, action);
> +
>  	ata_eh_clear_action(link, dev, &ehc->i, action);
>  }
>  
> @@ -2119,8 +2120,6 @@ static void ata_eh_link_autopsy(struct ata_link *link)
>  	u32 serror;
>  	int rc;
>  
> -	DPRINTK("ENTER\n");
> -
>  	if (ehc->i.flags & ATA_EHI_NO_AUTOPSY)
>  		return;
>  
> @@ -2227,7 +2226,6 @@ static void ata_eh_link_autopsy(struct ata_link *link)
>  		ehc->i.action |= ata_eh_speed_down(dev, eflags, all_err_mask);
>  		trace_ata_eh_link_autopsy(dev, ehc->i.action, all_err_mask);
>  	}
> -	DPRINTK("EXIT\n");
>  }
>  
>  /**
> @@ -3126,8 +3124,6 @@ static int ata_eh_revalidate_and_attach(struct ata_link *link,
>  	unsigned long flags;
>  	int rc = 0;
>  
> -	DPRINTK("ENTER\n");
> -
>  	/* For PATA drive side cable detection to work, IDENTIFY must
>  	 * be done backwards such that PDIAG- is released by the slave
>  	 * device before the master device is identified.
> @@ -3241,7 +3237,6 @@ static int ata_eh_revalidate_and_attach(struct ata_link *link,
>  
>   err:
>  	*r_failed_dev = dev;
> -	DPRINTK("EXIT rc=%d\n", rc);
>  	return rc;
>  }
>  
> @@ -3755,8 +3750,6 @@ int ata_eh_recover(struct ata_port *ap, ata_prereset_fn_t prereset,
>  	int rc, nr_fails;
>  	unsigned long flags, deadline;
>  
> -	DPRINTK("ENTER\n");
> -
>  	/* prep for recovery */
>  	ata_for_each_link(link, ap, EDGE) {
>  		struct ata_eh_context *ehc = &link->eh_context;
> @@ -3964,7 +3957,6 @@ int ata_eh_recover(struct ata_port *ap, ata_prereset_fn_t prereset,
>  	if (rc && r_failed_link)
>  		*r_failed_link = link;
>  
> -	DPRINTK("EXIT, rc=%d\n", rc);
>  	return rc;
>  }
>  
> diff --git a/drivers/ata/libata-pmp.c b/drivers/ata/libata-pmp.c
> index 3ff14071617c..438caf3a7d8c 100644
> --- a/drivers/ata/libata-pmp.c
> +++ b/drivers/ata/libata-pmp.c
> @@ -652,8 +652,6 @@ static int sata_pmp_revalidate(struct ata_device *dev, unsigned int new_class)
>  	u32 *gscr = (void *)ap->sector_buf;
>  	int rc;
>  
> -	DPRINTK("ENTER\n");
> -
>  	ata_eh_about_to_do(link, NULL, ATA_EH_REVALIDATE);
>  
>  	if (!ata_dev_enabled(dev)) {
> @@ -686,12 +684,10 @@ static int sata_pmp_revalidate(struct ata_device *dev, unsigned int new_class)
>  
>  	ata_eh_done(link, NULL, ATA_EH_REVALIDATE);
>  
> -	DPRINTK("EXIT, rc=0\n");
>  	return 0;
>  
>   fail:
>  	ata_dev_err(dev, "PMP revalidation failed (errno=%d)\n", rc);
> -	DPRINTK("EXIT, rc=%d\n", rc);
>  	return rc;
>  }
>  
> @@ -759,8 +755,6 @@ static int sata_pmp_eh_recover_pmp(struct ata_port *ap,
>  	int detach = 0, rc = 0;
>  	int reval_failed = 0;
>  
> -	DPRINTK("ENTER\n");
> -
>  	if (dev->flags & ATA_DFLAG_DETACH) {
>  		detach = 1;
>  		goto fail;
> @@ -827,7 +821,6 @@ static int sata_pmp_eh_recover_pmp(struct ata_port *ap,
>  	/* okay, PMP resurrected */
>  	ehc->i.flags = 0;
>  
> -	DPRINTK("EXIT, rc=0\n");
>  	return 0;
>  
>   fail:
> @@ -837,7 +830,6 @@ static int sata_pmp_eh_recover_pmp(struct ata_port *ap,
>  	else
>  		ata_dev_disable(dev);
>  
> -	DPRINTK("EXIT, rc=%d\n", rc);
>  	return rc;
>  }
>  
> diff --git a/include/trace/events/libata.h b/include/trace/events/libata.h
> index 40027d8424f8..c882c8f9b405 100644
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
