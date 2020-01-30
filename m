Return-Path: <SRS0=S1Gt=3T=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 525CBC33C9E
	for <linux-ide@archiver.kernel.org>; Thu, 30 Jan 2020 11:08:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2C2F206D5
	for <linux-ide@archiver.kernel.org>; Thu, 30 Jan 2020 11:08:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Js+rt4Yh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726902AbgA3LID (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 30 Jan 2020 06:08:03 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:50155 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726949AbgA3LID (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 30 Jan 2020 06:08:03 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20200130110801euoutp0289fc08bc2423ac3a785c994e80bbd6c4~upX5HKycN1124611246euoutp02f
        for <linux-ide@vger.kernel.org>; Thu, 30 Jan 2020 11:08:01 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20200130110801euoutp0289fc08bc2423ac3a785c994e80bbd6c4~upX5HKycN1124611246euoutp02f
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1580382481;
        bh=eBfjw6919UFR113+pZce9b8Ny2lvk2Qsz2r+gBN4vXY=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=Js+rt4YhiKeK0NYrjne7j0Jg8PnVQv2cNtP363gA/S8bn5HP67C4XAKos1GeTAC9r
         gnS+QY5IR7JRIF6XNIl4/Nu8fBZtv7tfagKxfTIz6IKEDo3jGIH5C9C+7KWnvlGwPi
         r1A2HXsCfK6GkddPy2Tntsxvo5DU2T1lRMAU4gsI=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200130110800eucas1p10a7100d167827795a9e82d13ad36c291~upX4-jB-G2930929309eucas1p18;
        Thu, 30 Jan 2020 11:08:00 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id CA.41.60679.019B23E5; Thu, 30
        Jan 2020 11:08:00 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200130110800eucas1p203fe3b2fb0823a6bc9be13edfee880c1~upX4hvXEE2838128381eucas1p2T;
        Thu, 30 Jan 2020 11:08:00 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200130110800eusmtrp2c5122cd58aebfdcd72426855a2773cb8~upX4hHnnQ0076100761eusmtrp2P;
        Thu, 30 Jan 2020 11:08:00 +0000 (GMT)
X-AuditID: cbfec7f4-0cbff7000001ed07-2a-5e32b9103fbd
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 44.C0.07950.019B23E5; Thu, 30
        Jan 2020 11:08:00 +0000 (GMT)
Received: from [106.120.51.71] (unknown [106.120.51.71]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200130110759eusmtip23b7ed9085032485fab3668f33ab09479~upX4E2L3L2008020080eusmtip2R;
        Thu, 30 Jan 2020 11:07:59 +0000 (GMT)
Subject: Re: [PATCH 14/24] libata: move DPRINTK to ata debugging
To:     Hannes Reinecke <hare@suse.de>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-ide@vger.kernel.org,
        Hannes Reinecke <hare@suse.com>
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Message-ID: <0d85b773-8319-37b5-d298-e5b5d8d5272a@samsung.com>
Date:   Thu, 30 Jan 2020 12:07:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20181213104716.31930-26-hare@suse.de>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprOKsWRmVeSWpSXmKPExsWy7djP87oCO43iDE70GVisvtvPZrHgzV42
        iz2LJjFZHNvxiMmBxePy2VKP9VuusnhsPl3t8XmTXABLFJdNSmpOZllqkb5dAlfGnM8mBbO2
        M1bsfbmKpYFx1STGLkZODgkBE4l3ZyazdjFycQgJrGCUWH/yPjOE84VR4sTFL0wQzmdGib2f
        b7HBtCydtpIRIrGcUWJm0wwo5y2jxL4t21lBqoQFHCTWHX3NDmKLCChJfGw/BGYzC8RJNF25
        C2azCVhJTGxfBXYIr4CdxP0Z68B6WQRUJS6fvc4MYosKREh8enCYFaJGUOLkzCcsIDangLHE
        59W7mCFmikvcejKfCcKWl9j+dg7YDxICk9kl5t88xg5xtovEk83roGxhiVfHt0DZMhL/d85n
        gmhYxyjxt+MFVPd2Ronlk/9BPW0tcefcLyCbA2iFpsT6XfoQYUeJlr7FzCBhCQE+iRtvBSGO
        4JOYtG06VJhXoqNNCKJaTWLDsg1sMGu7dq5knsCoNAvJa7OQvDMLyTuzEPYuYGRZxSieWlqc
        m55abJSXWq5XnJhbXJqXrpecn7uJEZhcTv87/mUH464/SYcYBTgYlXh4NTYYxQmxJpYVV+Ye
        YpTgYFYS4RV1NYwT4k1JrKxKLcqPLyrNSS0+xCjNwaIkzmu86GWskEB6YklqdmpqQWoRTJaJ
        g1OqgXFWeHk/69kvBUfWc7aoH/QNWr6e25nv64f4tCaH1HjbM+8/mx3PYjX7dkZjWtm7K0cX
        /vN2CDeqUz3ZdnfZwnbrfFVnF8HPYRpch060qzNlyt2x2b/9T+O2dSq7Tz+985DpL7tul/G3
        GVs+sByO+2WzZ+cNlj/NzJOnvb0hZcU9wXxS5/yIE+1KLMUZiYZazEXFiQDZ8NxfKgMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrBIsWRmVeSWpSXmKPExsVy+t/xe7oCO43iDF4vFLJYfbefzWLBm71s
        FnsWTWKyOLbjEZMDi8fls6Ue67dcZfHYfLra4/MmuQCWKD2bovzSklSFjPziElulaEMLIz1D
        Sws9IxNLPUNj81grI1MlfTublNSczLLUIn27BL2MOZ9NCmZtZ6zY+3IVSwPjqkmMXYycHBIC
        JhJLp60Esrk4hASWMkrc2jiLuYuRAyghI3F8fRlEjbDEn2tdbBA1rxkl+tc0gzULCzhIrDv6
        mh3EFhFQkvjYfgjMZhaIk/jXt5sJomEdo8SOJ0+YQBJsAlYSE9tXgTXzCthJ3J+xjhXEZhFQ
        lbh89joziC0qECFxeMcsqBpBiZMzn7CA2JwCxhKfV+9ihligLvFn3iUoW1zi1pP5TBC2vMT2
        t3OYJzAKzULSPgtJyywkLbOQtCxgZFnFKJJaWpybnltspFecmFtcmpeul5yfu4kRGEvbjv3c
        soOx613wIUYBDkYlHl6NDUZxQqyJZcWVuYcYJTiYlUR4RV0N44R4UxIrq1KL8uOLSnNSiw8x
        mgI9N5FZSjQ5HxjneSXxhqaG5haWhubG5sZmFkrivB0CB2OEBNITS1KzU1MLUotg+pg4OKUa
        GH2Pqu15cuGBwEy9hO16WwONGJ+dOC+UfGTmd+WOnbcnt5YkJ2SJu915t99k/86U+x9y/5av
        PfEyL3PK51f6iTNSvj7cyHV6zeQkHiHXedvUH5Y/OXSzNZdN5rfompyr2jLnPzbqNV5s/a3C
        dF56Z9vHVENTDenaNbb/N675FNGgpfba7NJtvXwlluKMREMt5qLiRAA4Iy9LuwIAAA==
X-CMS-MailID: 20200130110800eucas1p203fe3b2fb0823a6bc9be13edfee880c1
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20181213104817epcas1p25cb6abb26bf269e4ec5619c3920d3c83
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20181213104817epcas1p25cb6abb26bf269e4ec5619c3920d3c83
References: <20181213104716.31930-1-hare@suse.de>
        <CGME20181213104817epcas1p25cb6abb26bf269e4ec5619c3920d3c83@epcas1p2.samsung.com>
        <20181213104716.31930-26-hare@suse.de>
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org


On 12/13/18 11:47 AM, Hannes Reinecke wrote:
> Replace all DPRINTK calls with the ata_XXX_dbg functions.
> 
> Signed-off-by: Hannes Reinecke <hare@suse.com>
> ---
>  drivers/ata/libata-core.c | 39 ++++++++++++++++++++-------------------
>  drivers/ata/libata-eh.c   | 26 +++++++++++++-------------
>  drivers/ata/libata-pmp.c  | 12 ++++++------
>  drivers/ata/libata-scsi.c | 26 ++++++++++++--------------
>  drivers/ata/libata-sff.c  | 39 ++++++++++++++++++++-------------------
>  5 files changed, 71 insertions(+), 71 deletions(-)
> 
> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
> index b8c3f9e6af89..f4b5a61b1c63 100644
> --- a/drivers/ata/libata-core.c
> +++ b/drivers/ata/libata-core.c
> @@ -841,7 +841,7 @@ int ata_build_rw_tf(struct ata_taskfile *tf, struct ata_device *dev,
>  		head  = track % dev->heads;
>  		sect  = (u32)block % dev->sectors + 1;
>  
> -		DPRINTK("block %u track %u cyl %u head %u sect %u\n",
> +		ata_dev_dbg(dev, "block %u track %u cyl %u head %u sect %u\n",

Please preserve __func__ printing in the conversion.

>  			(u32)block, track, cyl, head, sect);
>  
>  		/* Check whether the converted CHS can fit.
> @@ -2063,7 +2063,7 @@ unsigned int ata_read_log_page(struct ata_device *dev, u8 log,
>  	unsigned int err_mask;
>  	bool dma = false;
>  
> -	DPRINTK("read log page - log 0x%x, page 0x%x\n", log, page);
> +	ata_dev_dbg(dev, "read log page - log 0x%x, page 0x%x\n", log, page);

ditto (+ please also remove redundant "read log page" while at it).

>  	/*
>  	 * Return error without actually issuing the command on controllers
> @@ -2099,7 +2099,7 @@ unsigned int ata_read_log_page(struct ata_device *dev, u8 log,
>  		goto retry;
>  	}
>  
> -	DPRINTK("EXIT, err_mask=%x\n", err_mask);
> +	ata_dev_dbg(dev, "read_log_page - err_mask=%x\n", err_mask);

ditto (+ please also remove redundant "read log page" while at it).

>  	return err_mask;
>  }
>  
> @@ -3564,7 +3564,7 @@ static int ata_dev_set_mode(struct ata_device *dev)
>  			dev_err_whine = " (device error ignored)";
>  	}
>  
> -	DPRINTK("xfer_shift=%u, xfer_mode=0x%x\n",
> +	ata_dev_dbg(dev, "xfer_shift=%u, xfer_mode=0x%x\n",

Please preserve __func__ printing in the conversion.

>  		dev->xfer_shift, (int)dev->xfer_mode);
>  
>  	if (!(ehc->i.flags & ATA_EHI_QUIET) ||
> @@ -4074,7 +4074,8 @@ int sata_link_hardreset(struct ata_link *link, const unsigned long *timing,
>  	u32 scontrol;
>  	int rc;
>  
> -	DPRINTK("ENTER\n");
> +	ata_link_dbg(link, "%s: ENTER, %s\n", __func__,
> +		     online ? (*online ? "online" : "offline") : "unknown");

Please document enhancements in the patch description.
 
>  	if (online)
>  		*online = false;
> @@ -4151,7 +4152,7 @@ int sata_link_hardreset(struct ata_link *link, const unsigned long *timing,
>  			*online = false;
>  		ata_link_err(link, "COMRESET failed (errno=%d)\n", rc);
>  	}
> -	DPRINTK("EXIT, rc=%d\n", rc);
> +	ata_link_dbg(link, "%s: EXIT, rc=%d\n", __func__, rc);
>  	return rc;
>  }
>  
> @@ -4197,7 +4198,7 @@ void ata_std_postreset(struct ata_link *link, unsigned int *classes)
>  {
>  	u32 serror;
>  
> -	DPRINTK("ENTER\n");
> +	ata_link_dbg(link, "%s: ENTER\n", __func__);
>  
>  	/* reset complete, clear SError */
>  	if (!sata_scr_read(link, SCR_ERROR, &serror))
> @@ -4206,7 +4207,7 @@ void ata_std_postreset(struct ata_link *link, unsigned int *classes)
>  	/* print link status */
>  	sata_print_link_status(link);
>  
> -	DPRINTK("EXIT\n");
> +	ata_link_dbg(link, "%s: EXIT\n", __func__);
>  }
>  
>  /**
> @@ -4823,7 +4824,7 @@ static unsigned int ata_dev_set_xfermode(struct ata_device *dev)
>  	unsigned int err_mask;
>  
>  	/* set up set-features taskfile */
> -	DPRINTK("set features - xfer mode\n");
> +	ata_dev_dbg(dev, "set features - xfer mode\n");

Please preserve __func__ printing in the conversion
(+ remove redundant "set features" while at it).

>  	/* Some controllers and ATAPI devices show flaky interrupt
>  	 * behavior after setting xfer mode.  Use polling instead.
> @@ -4845,7 +4846,7 @@ static unsigned int ata_dev_set_xfermode(struct ata_device *dev)
>  	/* On some disks, this command causes spin-up, so we need longer timeout */
>  	err_mask = ata_exec_internal(dev, &tf, NULL, DMA_NONE, NULL, 0, 15000);
>  
> -	DPRINTK("EXIT, err_mask=%x\n", err_mask);
> +	ata_dev_dbg(dev, "%s: EXIT, err_mask=%x\n", __func__, err_mask);
>  	return err_mask;
>  }
>  
> @@ -4871,7 +4872,8 @@ unsigned int ata_dev_set_feature(struct ata_device *dev, u8 enable, u8 feature)
>  	unsigned long timeout = 0;
>  
>  	/* set up set-features taskfile */
> -	DPRINTK("set features - SATA features\n");
> +	ata_dev_dbg(dev, "set features - SATA features %x enable %x\n",
> +		    feature, enable);

Please preserve __func__ printing in the conversion
(+ remove redundant "set features" while at it).
 
>  	ata_tf_init(dev, &tf);
>  	tf.command = ATA_CMD_SET_FEATURES;
> @@ -4885,7 +4887,7 @@ unsigned int ata_dev_set_feature(struct ata_device *dev, u8 enable, u8 feature)
>  			  ata_probe_timeout * 1000 : SETFEATURES_SPINUP_TIMEOUT;
>  	err_mask = ata_exec_internal(dev, &tf, NULL, DMA_NONE, NULL, 0, timeout);
>  
> -	DPRINTK("EXIT, err_mask=%x\n", err_mask);
> +	ata_dev_dbg(dev, "%s: EXIT, err_mask=%x\n", __func__, err_mask);
>  	return err_mask;
>  }
>  EXPORT_SYMBOL_GPL(ata_dev_set_feature);
> @@ -4913,7 +4915,8 @@ static unsigned int ata_dev_init_params(struct ata_device *dev,
>  		return AC_ERR_INVALID;
>  
>  	/* set up init dev params taskfile */
> -	DPRINTK("init dev params \n");
> +	ata_dev_dbg(dev, "init dev params, heads %u sectors %u\n",
> +		    heads, sectors);

Please preserve __func__ printing in the conversion
(+ remove redundant "init dev params" while at it).

Please document enhancements in the patch description.
 
>  	ata_tf_init(dev, &tf);
>  	tf.command = ATA_CMD_INIT_DEV_PARAMS;
> @@ -4929,7 +4932,7 @@ static unsigned int ata_dev_init_params(struct ata_device *dev,
>  	if (err_mask == AC_ERR_DEV && (tf.feature & ATA_ABORTED))
>  		err_mask = 0;
>  
> -	DPRINTK("EXIT, err_mask=%x\n", err_mask);
> +	ata_dev_dbg(dev, "%s: EXIT, err_mask=%x\n", __func__, err_mask);
>  	return err_mask;
>  }
>  
> @@ -6001,8 +6004,6 @@ struct ata_port *ata_port_alloc(struct ata_host *host)
>  {
>  	struct ata_port *ap;
>  
> -	DPRINTK("ENTER\n");

Please either keep it or document the removal in the patch description.

> -
>  	ap = kzalloc(sizeof(*ap), GFP_KERNEL);
>  	if (!ap)
>  		return NULL;
> @@ -6118,7 +6119,7 @@ struct ata_host *ata_host_alloc(struct device *dev, int max_ports)
>  	int i;
>  	void *dr;
>  
> -	DPRINTK("ENTER\n");
> +	dev_dbg(dev, "%s: ENTER\n", __func__);
>  
>  	/* alloc a container for our list of ATA ports (buses) */
>  	sz = sizeof(struct ata_host) + (max_ports + 1) * sizeof(void *);
> @@ -6467,9 +6468,9 @@ int ata_port_probe(struct ata_port *ap)
>  		__ata_port_probe(ap);
>  		ata_port_wait_eh(ap);
>  	} else {
> -		DPRINTK("ata%u: bus probe begin\n", ap->print_id);
> +		ata_port_dbg(ap, "bus probe begin\n");

Please preserve __func__ printing in the conversion.

>  		rc = ata_bus_probe(ap);
> -		DPRINTK("ata%u: bus probe end\n", ap->print_id);
> +		ata_port_dbg(ap, "bus probe end\n");

ditto

>  	}
>  	return rc;
>  }
> diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
> index 01306c018398..4c5e93499562 100644
> --- a/drivers/ata/libata-eh.c
> +++ b/drivers/ata/libata-eh.c
> @@ -543,7 +543,7 @@ void ata_scsi_error(struct Scsi_Host *host)
>  	unsigned long flags;
>  	LIST_HEAD(eh_work_q);
>  
> -	DPRINTK("ENTER\n");
> +	ata_port_dbg(ap, "%s: ENTER\n", __func__);
>  
>  	spin_lock_irqsave(host->host_lock, flags);
>  	list_splice_init(&host->eh_cmd_q, &eh_work_q);
> @@ -558,7 +558,7 @@ void ata_scsi_error(struct Scsi_Host *host)
>  	/* finish or retry handled scmd's and clean up */
>  	WARN_ON(!list_empty(&eh_work_q));
>  
> -	DPRINTK("EXIT\n");
> +	ata_port_dbg(ap, "%s: EXIT\n", __func__);
>  }
>  
>  /**
> @@ -954,7 +954,7 @@ void ata_std_sched_eh(struct ata_port *ap)
>  	ata_eh_set_pending(ap, 1);
>  	scsi_schedule_eh(ap->scsi_host);
>  
> -	DPRINTK("port EH scheduled\n");
> +	ata_port_dbg(ap, "port EH scheduled\n");

Please preserve __func__ printing in the conversion.

>  }
>  EXPORT_SYMBOL_GPL(ata_std_sched_eh);
>  
> @@ -1081,7 +1081,7 @@ static void __ata_port_freeze(struct ata_port *ap)
>  
>  	ap->pflags |= ATA_PFLAG_FROZEN;
>  
> -	DPRINTK("ata%u port frozen\n", ap->print_id);
> +	ata_port_dbg(ap, "port frozen\n");

ditto

>  }
>  
>  /**
> @@ -1229,7 +1229,7 @@ void ata_eh_thaw_port(struct ata_port *ap)
>  
>  	spin_unlock_irqrestore(ap->lock, flags);
>  
> -	DPRINTK("ata%u port thawed\n", ap->print_id);
> +	ata_port_dbg(ap, "port thawed\n");

ditto

>  }
>  
>  static void ata_eh_scsidone(struct scsi_cmnd *scmd)
> @@ -1558,7 +1558,7 @@ static void ata_eh_request_sense(struct ata_queued_cmd *qc,
>  		return;
>  	}
>  
> -	DPRINTK("ATA request sense\n");
> +	ata_dev_dbg(dev, "ATA request sense\n");

ditto

>  	ata_tf_init(dev, &tf);
>  	tf.flags |= ATA_TFLAG_ISADDR | ATA_TFLAG_DEVICE;
> @@ -1600,7 +1600,7 @@ unsigned int atapi_eh_request_sense(struct ata_device *dev,
>  	struct ata_port *ap = dev->link->ap;
>  	struct ata_taskfile tf;
>  
> -	DPRINTK("ATAPI request sense\n");
> +	ata_dev_dbg(dev, "ATAPI request sense\n");

ditto
 
>  	memset(sense_buf, 0, SCSI_SENSE_BUFFERSIZE);
>  
> @@ -2138,7 +2138,7 @@ static void ata_eh_link_autopsy(struct ata_link *link)
>  	u32 serror;
>  	int rc;
>  
> -	DPRINTK("ENTER\n");
> +	ata_link_dbg(link, "%s: ENTER\n", __func__);
>  
>  	if (ehc->i.flags & ATA_EHI_NO_AUTOPSY)
>  		return;
> @@ -2246,7 +2246,7 @@ static void ata_eh_link_autopsy(struct ata_link *link)
>  		ehc->i.action |= ata_eh_speed_down(dev, eflags, all_err_mask);
>  		trace_ata_eh_link_autopsy(dev, ehc->i.action, all_err_mask);
>  	}
> -	DPRINTK("EXIT\n");
> +	ata_link_dbg(link, "%s: EXIT\n", __func__);
>  }
>  
>  /**
> @@ -3130,7 +3130,7 @@ static int ata_eh_revalidate_and_attach(struct ata_link *link,
>  	unsigned long flags;
>  	int rc = 0;
>  
> -	DPRINTK("ENTER\n");
> +	ata_link_dbg(link, "%s: ENTER\n", __func__);
>  
>  	/* For PATA drive side cable detection to work, IDENTIFY must
>  	 * be done backwards such that PDIAG- is released by the slave
> @@ -3245,7 +3245,7 @@ static int ata_eh_revalidate_and_attach(struct ata_link *link,
>  
>   err:
>  	*r_failed_dev = dev;
> -	DPRINTK("EXIT rc=%d\n", rc);
> +	ata_link_dbg(link, "%s: EXIT rc=%d\n", __func__, rc);
>  	return rc;
>  }
>  
> @@ -3759,7 +3759,7 @@ int ata_eh_recover(struct ata_port *ap, ata_prereset_fn_t prereset,
>  	int rc, nr_fails;
>  	unsigned long flags, deadline;
>  
> -	DPRINTK("ENTER\n");
> +	ata_port_dbg(ap, "%s: ENTER\n", __func__);
>  
>  	/* prep for recovery */
>  	ata_for_each_link(link, ap, EDGE) {
> @@ -3968,7 +3968,7 @@ int ata_eh_recover(struct ata_port *ap, ata_prereset_fn_t prereset,
>  	if (rc && r_failed_link)
>  		*r_failed_link = link;
>  
> -	DPRINTK("EXIT, rc=%d\n", rc);
> +	ata_port_dbg(ap, "%s: EXIT, rc=%d\n", __func__, rc);
>  	return rc;
>  }
>  
> diff --git a/drivers/ata/libata-pmp.c b/drivers/ata/libata-pmp.c
> index 2ae1799f4992..2f0c5ac1d96d 100644
> --- a/drivers/ata/libata-pmp.c
> +++ b/drivers/ata/libata-pmp.c
> @@ -653,7 +653,7 @@ static int sata_pmp_revalidate(struct ata_device *dev, unsigned int new_class)
>  	u32 *gscr = (void *)ap->sector_buf;
>  	int rc;
>  
> -	DPRINTK("ENTER\n");
> +	ata_dev_dbg(dev, "%s: ENTER\n", __func__);
>  
>  	ata_eh_about_to_do(link, NULL, ATA_EH_REVALIDATE);
>  
> @@ -687,12 +687,12 @@ static int sata_pmp_revalidate(struct ata_device *dev, unsigned int new_class)
>  
>  	ata_eh_done(link, NULL, ATA_EH_REVALIDATE);
>  
> -	DPRINTK("EXIT, rc=0\n");
> +	ata_dev_dbg(dev, "%s: EXIT, rc=0\n", __func__);
>  	return 0;
>  
>   fail:
>  	ata_dev_err(dev, "PMP revalidation failed (errno=%d)\n", rc);
> -	DPRINTK("EXIT, rc=%d\n", rc);
> +	ata_dev_dbg(dev, "%s: EXIT, rc=%d\n", __func__, rc);
>  	return rc;
>  }
>  
> @@ -760,7 +760,7 @@ static int sata_pmp_eh_recover_pmp(struct ata_port *ap,
>  	int detach = 0, rc = 0;
>  	int reval_failed = 0;
>  
> -	DPRINTK("ENTER\n");
> +	ata_port_dbg(ap, "%s: ENTER\n", __func__);
>  
>  	if (dev->flags & ATA_DFLAG_DETACH) {
>  		detach = 1;
> @@ -828,7 +828,7 @@ static int sata_pmp_eh_recover_pmp(struct ata_port *ap,
>  	/* okay, PMP resurrected */
>  	ehc->i.flags = 0;
>  
> -	DPRINTK("EXIT, rc=0\n");
> +	ata_port_dbg(ap, "%s: EXIT, rc=0\n", __func__);
>  	return 0;
>  
>   fail:
> @@ -838,7 +838,7 @@ static int sata_pmp_eh_recover_pmp(struct ata_port *ap,
>  	else
>  		ata_dev_disable(dev);
>  
> -	DPRINTK("EXIT, rc=%d\n", rc);
> +	ata_port_dbg(ap, "%s: EXIT, rc=%d\n", __func__, rc);
>  	return rc;
>  }
>  
> diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
> index 3d4887d0e84a..9746df3da567 100644
> --- a/drivers/ata/libata-scsi.c
> +++ b/drivers/ata/libata-scsi.c
> @@ -1769,7 +1769,7 @@ static unsigned int ata_scsi_verify_xlat(struct ata_queued_cmd *qc)
>  		head  = track % dev->heads;
>  		sect  = (u32)block % dev->sectors + 1;
>  
> -		DPRINTK("block %u track %u cyl %u head %u sect %u\n",
> +		ata_dev_dbg(dev, "block %u track %u cyl %u head %u sect %u\n",

Please preserve __func__ printing in the conversion.

>  			(u32)block, track, cyl, head, sect);
>  
>  		/* Check whether the converted CHS can fit.
> @@ -1873,7 +1873,7 @@ static unsigned int ata_scsi_rw_xlat(struct ata_queued_cmd *qc)
>  			tf_flags |= ATA_TFLAG_FUA;
>  		break;
>  	default:
> -		DPRINTK("no-byte command\n");
> +		ata_dev_dbg(qc->dev, "no-byte command %x\n", cdb[0]);

ditto

>  		fp = 0;
>  		goto invalid_fld;
>  	}
> @@ -2027,7 +2027,7 @@ static int ata_scsi_translate(struct ata_device *dev, struct scsi_cmnd *cmd,
>  early_finish:
>  	ata_qc_free(qc);
>  	cmd->scsi_done(cmd);
> -	DPRINTK("EXIT - early finish (good or error)\n");
> +	ata_dev_dbg(dev, "%s: EXIT - early finish (good or error)\n", __func__);
>  	return 0;
>  
>  err_did:
> @@ -2035,12 +2035,12 @@ static int ata_scsi_translate(struct ata_device *dev, struct scsi_cmnd *cmd,
>  	cmd->result = (DID_ERROR << 16);
>  	cmd->scsi_done(cmd);
>  err_mem:
> -	DPRINTK("EXIT - internal\n");
> +	ata_dev_dbg(dev, "%s: EXIT - internal\n", __func__);
>  	return 0;
>  
>  defer:
>  	ata_qc_free(qc);
> -	DPRINTK("EXIT - defer\n");
> +	ata_dev_dbg(dev, "%s: EXIT - defer rc %d\n", __func__, rc);
>  	if (rc == ATA_DEFER_LINK)
>  		return SCSI_MLQUEUE_DEVICE_BUSY;
>  	else
> @@ -2807,7 +2807,7 @@ static void atapi_request_sense(struct ata_queued_cmd *qc)
>  	struct ata_port *ap = qc->ap;
>  	struct scsi_cmnd *cmd = qc->scsicmd;
>  
> -	DPRINTK("ATAPI request sense\n");
> +	ata_port_dbg(ap, "ATAPI request sense\n");

ditto

>  	memset(cmd->sense_buffer, 0, SCSI_SENSE_BUFFERSIZE);
>  
> @@ -2848,7 +2848,7 @@ static void atapi_request_sense(struct ata_queued_cmd *qc)
>  
>  	ata_qc_issue(qc);
>  
> -	DPRINTK("EXIT\n");
> +	ata_port_dbg(ap, "%s: EXIT\n", __func__);
>  }
>  
>  /*
> @@ -2956,10 +2956,8 @@ static unsigned int atapi_xlat(struct ata_queued_cmd *qc)
>  	qc->complete_fn = atapi_qc_complete;
>  
>  	qc->tf.flags |= ATA_TFLAG_ISADDR | ATA_TFLAG_DEVICE;
> -	if (scmd->sc_data_direction == DMA_TO_DEVICE) {
> +	if (scmd->sc_data_direction == DMA_TO_DEVICE)
>  		qc->tf.flags |= ATA_TFLAG_WRITE;
> -		DPRINTK("direction: write\n");

Please either keep it or document the removal in the patch description.

> -	}
>  
>  	qc->tf.command = ATA_CMD_PACKET;
>  	ata_qc_set_pc_nbytes(qc);
> @@ -4342,7 +4340,7 @@ static inline int __ata_scsi_queuecmd(struct scsi_cmnd *scmd,
>  	return rc;
>  
>   bad_cdb_len:
> -	DPRINTK("bad CDB len=%u, scsi_op=0x%02x, max=%u\n",
> +	ata_dev_dbg(dev, "bad CDB len=%u, scsi_op=0x%02x, max=%u\n",

Please preserve __func__ printing in the conversion.

>  		scmd->cmd_len, scsi_op, dev->cdb_len);
>  	scmd->result = DID_ERROR << 16;
>  	scmd->scsi_done(scmd);
> @@ -4783,7 +4781,7 @@ void ata_scsi_hotplug(struct work_struct *work)
>  	int i;
>  
>  	if (ap->pflags & ATA_PFLAG_UNLOADING) {
> -		DPRINTK("ENTER/EXIT - unloading\n");
> +		ata_port_dbg(ap, "%s: ENTER/EXIT - unloading\n", __func__);
>  		return;
>  	}
>  
> @@ -4808,7 +4806,7 @@ void ata_scsi_hotplug(struct work_struct *work)
>  		msleep(10);
>  #endif
>  
> -	DPRINTK("ENTER\n");
> +	ata_port_dbg(ap, "%s: ENTER\n", __func__);
>  	mutex_lock(&ap->scsi_scan_mutex);
>  
>  	/* Unplug detached devices.  We cannot use link iterator here
> @@ -4824,7 +4822,7 @@ void ata_scsi_hotplug(struct work_struct *work)
>  	ata_scsi_scan_host(ap, 0);
>  
>  	mutex_unlock(&ap->scsi_scan_mutex);
> -	DPRINTK("EXIT\n");
> +	ata_port_dbg(ap, "%s: EXIT\n", __func__);
>  }
>  
>  /**
> diff --git a/drivers/ata/libata-sff.c b/drivers/ata/libata-sff.c
> index c5ea0fc635e5..3326c3b02c61 100644
> --- a/drivers/ata/libata-sff.c
> +++ b/drivers/ata/libata-sff.c
> @@ -351,8 +351,8 @@ static void ata_dev_select(struct ata_port *ap, unsigned int device,
>  			   unsigned int wait, unsigned int can_sleep)
>  {
>  	if (ata_msg_probe(ap))
> -		ata_port_info(ap, "ata_dev_select: ENTER, device %u, wait %u\n",
> -			      device, wait);
> +		ata_port_info(ap, "%s: ENTER, device %u, wait %u\n",
> +			      __func__, device, wait);
>  
>  	if (wait)
>  		ata_wait_idle(ap);
> @@ -514,7 +514,7 @@ EXPORT_SYMBOL_GPL(ata_sff_tf_read);
>   */
>  void ata_sff_exec_command(struct ata_port *ap, const struct ata_taskfile *tf)
>  {
> -	DPRINTK("ata%u: cmd 0x%X\n", ap->print_id, tf->command);
> +	ata_port_dbg(ap, "cmd 0x%X\n", tf->command);

Please preserve __func__ printing in the conversion.

>  	iowrite8(tf->command, ap->ioaddr.command_addr);
>  	ata_sff_pause(ap);
> @@ -684,7 +684,8 @@ static void ata_pio_sector(struct ata_queued_cmd *qc)
>  	page = nth_page(page, (offset >> PAGE_SHIFT));
>  	offset %= PAGE_SIZE;
>  
> -	DPRINTK("data %s\n", qc->tf.flags & ATA_TFLAG_WRITE ? "write" : "read");
> +	ata_port_dbg(ap, "data %s\n",
> +		     qc->tf.flags & ATA_TFLAG_WRITE ? "write" : "read");

ditto

>  
>  	/* do the actual data transfer */
>  	buf = kmap_atomic(page);
> @@ -745,7 +746,7 @@ static void ata_pio_sectors(struct ata_queued_cmd *qc)
>  static void atapi_send_cdb(struct ata_port *ap, struct ata_queued_cmd *qc)
>  {
>  	/* send SCSI cdb */
> -	DPRINTK("send cdb\n");
> +	ata_port_dbg(ap, "send cdb %x proto %d\n", qc->cdb[0], qc->tf.protocol);

Please preserve __func__ printing in the conversion.

Please document enhancements in the patch description.

>  	WARN_ON_ONCE(qc->dev->cdb_len < 12);
>  
>  	ap->ops->sff_data_xfer(qc, qc->cdb, qc->dev->cdb_len, 1);
> @@ -815,7 +816,8 @@ static int __atapi_pio_bytes(struct ata_queued_cmd *qc, unsigned int bytes)
>  	/* don't cross page boundaries */
>  	count = min(count, (unsigned int)PAGE_SIZE - offset);
>  
> -	DPRINTK("data %s\n", qc->tf.flags & ATA_TFLAG_WRITE ? "write" : "read");
> +	ata_dev_dbg(dev, "data %s\n",
> +		    qc->tf.flags & ATA_TFLAG_WRITE ? "write" : "read");

Please preserve __func__ printing in the conversion.

>  	/* do the actual data transfer */
>  	buf = kmap_atomic(page);
> @@ -997,8 +999,8 @@ int ata_sff_hsm_move(struct ata_port *ap, struct ata_queued_cmd *qc,
>  	WARN_ON_ONCE(in_wq != ata_hsm_ok_in_wq(ap, qc));
>  
>  fsm_start:
> -	DPRINTK("ata%u: protocol %d task_state %d (dev_stat 0x%X)\n",
> -		ap->print_id, qc->tf.protocol, ap->hsm_task_state, status);
> +	ata_port_dbg(ap, "protocol %d task_state %d (dev_stat 0x%X)\n",
> +		qc->tf.protocol, ap->hsm_task_state, status);

ditto

>  	switch (ap->hsm_task_state) {
>  	case HSM_ST_FIRST:
> @@ -1199,8 +1201,8 @@ int ata_sff_hsm_move(struct ata_port *ap, struct ata_queued_cmd *qc,
>  		}
>  
>  		/* no more data to transfer */
> -		DPRINTK("ata%u: dev %u command complete, drv_stat 0x%x\n",
> -			ap->print_id, qc->dev->devno, status);
> +		ata_port_dbg(ap, "dev %u command complete, drv_stat 0x%x\n",
> +			qc->dev->devno, status);

ditto

>  		WARN_ON_ONCE(qc->err_mask & (AC_ERR_DEV | AC_ERR_HSM));
>  
> @@ -1257,7 +1259,7 @@ EXPORT_SYMBOL_GPL(ata_sff_queue_pio_task);
>  
>  void ata_sff_flush_pio_task(struct ata_port *ap)
>  {
> -	DPRINTK("ENTER\n");
> +	ata_port_dbg(ap, "%s: ENTER\n", __func__);
>  
>  	cancel_delayed_work_sync(&ap->sff_pio_task);
>  
> @@ -1951,7 +1953,7 @@ static int ata_bus_softreset(struct ata_port *ap, unsigned int devmask,
>  {
>  	struct ata_ioports *ioaddr = &ap->ioaddr;
>  
> -	DPRINTK("ata%u: bus reset via SRST\n", ap->print_id);
> +	ata_port_dbg(ap, "bus reset via SRST\n");
ditto
 
>  	if (ap->ioaddr.ctl_addr) {
>  		/* software reset.  causes dev0 to be selected */
> @@ -1990,7 +1992,7 @@ int ata_sff_softreset(struct ata_link *link, unsigned int *classes,
>  	int rc;
>  	u8 err;
>  
> -	DPRINTK("ENTER\n");
> +	ata_port_dbg(ap, "%s: ENTER\n", __func__);
>  
>  	/* determine if device 0/1 are present */
>  	if (ata_devchk(ap, 0))
> @@ -2002,7 +2004,7 @@ int ata_sff_softreset(struct ata_link *link, unsigned int *classes,
>  	ap->ops->sff_dev_select(ap, 0);
>  
>  	/* issue bus reset */
> -	DPRINTK("about to softreset, devmask=%x\n", devmask);
> +	ata_port_dbg(ap, "about to softreset, devmask=%x\n", devmask);

ditto

>  	rc = ata_bus_softreset(ap, devmask, deadline);
>  	/* if link is occupied, -ENODEV too is an error */
>  	if (rc && (rc != -ENODEV || sata_scr_valid(link))) {
> @@ -2017,7 +2019,8 @@ int ata_sff_softreset(struct ata_link *link, unsigned int *classes,
>  		classes[1] = ata_sff_dev_classify(&link->device[1],
>  						  devmask & (1 << 1), &err);
>  
> -	DPRINTK("EXIT, classes[0]=%u [1]=%u\n", classes[0], classes[1]);
> +	ata_port_dbg(ap, "%s: EXIT, classes[0]=%u [1]=%u\n",
> +		     __func__, classes[0], classes[1]);
>  	return 0;
>  }
>  EXPORT_SYMBOL_GPL(ata_sff_softreset);
> @@ -2050,7 +2053,7 @@ int sata_sff_hardreset(struct ata_link *link, unsigned int *class,
>  	if (online)
>  		*class = ata_sff_dev_classify(link->device, 1, NULL);
>  
> -	DPRINTK("EXIT, class=%u\n", *class);
> +	ata_link_dbg(link, "%s: EXIT, class=%u\n", __func__, *class);
>  	return rc;
>  }
>  EXPORT_SYMBOL_GPL(sata_sff_hardreset);
> @@ -2081,7 +2084,7 @@ void ata_sff_postreset(struct ata_link *link, unsigned int *classes)
>  
>  	/* bail out if no device is present */
>  	if (classes[0] == ATA_DEV_NONE && classes[1] == ATA_DEV_NONE) {
> -		DPRINTK("EXIT, no device\n");
> +		ata_link_dbg(link, "%s: EXIT, no device\n", __func__);
>  		return;
>  	}
>  
> @@ -2462,8 +2465,6 @@ static int ata_pci_init_one(struct pci_dev *pdev,
>  	struct ata_host *host = NULL;
>  	int rc;
>  
> -	DPRINTK("ENTER\n");
> -

Please either keep it or document the removal in the patch description.

>  	pi = ata_sff_find_valid_pi(ppi);
>  	if (!pi) {
>  		dev_err(&pdev->dev, "no valid port_info specified\n");

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
