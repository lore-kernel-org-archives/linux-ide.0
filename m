Return-Path: <SRS0=vLfT=36=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44849C352A3
	for <linux-ide@archiver.kernel.org>; Mon, 10 Feb 2020 12:50:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03EA92051A
	for <linux-ide@archiver.kernel.org>; Mon, 10 Feb 2020 12:50:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="oP6yI4QX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730685AbgBJMoj (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 10 Feb 2020 07:44:39 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:60601 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728154AbgBJMoi (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 10 Feb 2020 07:44:38 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20200210124436euoutp02b60c9ac950541bdc5ca85f8c3f40d292~yCyXnI8Be3156131561euoutp02E
        for <linux-ide@vger.kernel.org>; Mon, 10 Feb 2020 12:44:36 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20200210124436euoutp02b60c9ac950541bdc5ca85f8c3f40d292~yCyXnI8Be3156131561euoutp02E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1581338676;
        bh=+CfYHelMNhqkZBSKal3mEjsVhVH304Qa0jaRKTO4fgg=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=oP6yI4QXGeZdUNGW4AjKGSzBoY2NAHKKxKwuDsS925qEDLZLJ+i2MRmQqYfDSKRam
         DZ8yvhrw13SbgM/8CyHkkXzGsp5M3KnfQiFWGR+gxBwzDutQRTaIFhbX20aFBk8mpk
         PJbCpdB4uM6yPf5/8pKXcOJQQOvvOC3sPHitLXdI=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200210124436eucas1p26f9dc798132449d915ca708c9e0dc6fc~yCyXa8DQh3065130651eucas1p2o;
        Mon, 10 Feb 2020 12:44:36 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id F0.F6.60698.430514E5; Mon, 10
        Feb 2020 12:44:36 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200210124435eucas1p2836dd60beb00d6ab2eb8da28432d64d0~yCyXC-3pA3065130651eucas1p2n;
        Mon, 10 Feb 2020 12:44:35 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200210124435eusmtrp2664889af74f9d9aca3e6dc4dab0193af~yCyXCgzNL2890128901eusmtrp29;
        Mon, 10 Feb 2020 12:44:35 +0000 (GMT)
X-AuditID: cbfec7f5-a29ff7000001ed1a-64-5e4150340b05
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 26.42.07950.330514E5; Mon, 10
        Feb 2020 12:44:35 +0000 (GMT)
Received: from [106.120.51.71] (unknown [106.120.51.71]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200210124434eusmtip2c9236884a86e97ace8e91aca2d2cf1fb~yCyV_KQBp0038300383eusmtip2N;
        Mon, 10 Feb 2020 12:44:34 +0000 (GMT)
Subject: Re: [PATCH 08/46] libata: Add ata_port_classify() helper
To:     Hannes Reinecke <hare@suse.de>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-ide@vger.kernel.org
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Message-ID: <1960187e-257d-bf6b-9531-c3c517e918f6@samsung.com>
Date:   Mon, 10 Feb 2020 13:44:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20200204165547.115220-9-hare@suse.de>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpjleLIzCtJLcpLzFFi42LZduznOV2TAMc4g969ghar7/azWexZNInJ
        4tiOR0wOzB6Xz5Z6bD5d7fF5k1wAcxSXTUpqTmZZapG+XQJXxpWevSwFF+wr1ty8ytTAuN24
        i5GDQ0LARKJjbVQXIxeHkMAKRolpp7YzdjFyAjlfGCUObVGHSHxmlFh2s4EJJAHSsLt1KxtE
        0XJGiZlr6iHst4wSPzZogNjCAo4Shw+vZgexRQSUJD62HwKzmQWsJWYvXg82h03ASmJi+yqw
        ZbwCdhLvzlwEi7MIqEpM39UBNl9UIELi04PDrBA1ghInZz5hATmaU8BYYtc3f4iR4hK3nsxn
        grDlJba/ncMMcWYzu8S3n0oQtotE86FjLBC2sMSr41vYIWwZif87QXq5gOx1jBJ/O14wQzjb
        GSWWT/7HBlFlLXHn3C82kMXMApoS63fpQ4QdJY7uucUMCUQ+iRtvBSFu4JOYtG06VJhXoqNN
        CKJaTWLDsg1sMGu7dq5knsCoNAvJY7OQfDMLyTezEPYuYGRZxSieWlqcm55abJyXWq5XnJhb
        XJqXrpecn7uJEZg6Tv87/nUH474/SYcYBTgYlXh4Zzg6xAmxJpYVV+YeYpTgYFYS4bWUdowT
        4k1JrKxKLcqPLyrNSS0+xCjNwaIkzmu86GWskEB6YklqdmpqQWoRTJaJg1OqgZFj5acLvKzt
        uYaVB3aIVOqeTsgNfr/gXBNf5Er5l5cKJig8uTfHckdc4fpbj39x/bHavEHRQVkzSkljERNz
        +wbZkjmus9zYv5kda0/bfnSb1l6nNrurdw+xXfi7fjPXjfyTz7bFLJ4n0a0hd3jNlzd35oZ9
        t5Bq9A8RES+6ysz321nvVITKpU1KLMUZiYZazEXFiQApGFDEGQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprDIsWRmVeSWpSXmKPExsVy+t/xe7rGAY5xBrMOWlisvtvPZrFn0SQm
        i2M7HjE5MHtcPlvqsfl0tcfnTXIBzFF6NkX5pSWpChn5xSW2StGGFkZ6hpYWekYmlnqGxuax
        VkamSvp2NimpOZllqUX6dgl6GVd69rIUXLCvWHPzKlMD43bjLkZODgkBE4ndrVvZuhi5OIQE
        ljJKnLp+gbGLkQMoISNxfH0ZRI2wxJ9rXVA1rxklNj3dygqSEBZwlDh8eDU7iC0ioCTxsf0Q
        mM0sYC0xe/F6JoiG9YwSZztvgCXYBKwkJravYgSxeQXsJN6ducgEYrMIqEpM39XBBmKLCkRI
        HN4xC6pGUOLkzCcsIAdxChhL7PrmDzFfXeLPvEvMELa4xK0n85kgbHmJ7W/nME9gFJqFpHsW
        kpZZSFpmIWlZwMiyilEktbQ4Nz232EivODG3uDQvXS85P3cTIzBmth37uWUHY9e74EOMAhyM
        Sjy8DvYOcUKsiWXFlbmHGCU4mJVEeC2lHeOEeFMSK6tSi/Lji0pzUosPMZoC/TaRWUo0OR8Y
        z3kl8YamhuYWlobmxubGZhZK4rwdAgdjhATSE0tSs1NTC1KLYPqYODilGhhD3TcmNGS/Mjc+
        vZQ5rm6Ctpt6yct1alulZa3LtcMXapeyPP///iHHmycv/c+9nq+yfk9PfW2KwtoovoYflQwM
        x752XfnS/ST3MXvuil62ifd63m17L5VuuL3yrHR+Qf/FJ4dNd5dfOH3ggcSp/2Fv9r25cDr2
        y6bPHvP3LWeLP7ctTO4DT/RZJZbijERDLeai4kQAqtLwGa8CAAA=
X-CMS-MailID: 20200210124435eucas1p2836dd60beb00d6ab2eb8da28432d64d0
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200204165612eucas1p28955522b9717c3c135c3e9974404d7d2
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200204165612eucas1p28955522b9717c3c135c3e9974404d7d2
References: <20200204165547.115220-1-hare@suse.de>
        <CGME20200204165612eucas1p28955522b9717c3c135c3e9974404d7d2@eucas1p2.samsung.com>
        <20200204165547.115220-9-hare@suse.de>
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org


On 2/4/20 5:55 PM, Hannes Reinecke wrote:
> Add an ata_port_classify() helper to print out the results from
> the device classification and remove the debugging statements
> from ata_dev_classify(). Also provide a mapping ata_dev_class_string()
> to provide a string representation for those instances calling
> ata_dev_classify() directly.
> 
> Signed-off-by: Hannes Reinecke <hare@suse.de>
> ---
>  drivers/ata/libahci.c       |  2 +-
>  drivers/ata/libata-core.c   | 68 ++++++++++++++++++++++++++++++++++-----------
>  drivers/ata/libata-sff.c    |  5 ++++
>  drivers/ata/sata_fsl.c      |  2 +-
>  drivers/ata/sata_inic162x.c |  2 +-
>  drivers/ata/sata_sil24.c    |  2 +-
>  include/linux/libata.h      |  3 ++
>  7 files changed, 64 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/ata/libahci.c b/drivers/ata/libahci.c
> index 4055071f213f..c1bc973ecc16 100644
> --- a/drivers/ata/libahci.c
> +++ b/drivers/ata/libahci.c
> @@ -1276,7 +1276,7 @@ unsigned int ahci_dev_classify(struct ata_port *ap)
>  	tf.lbal		= (tmp >> 8)	& 0xff;
>  	tf.nsect	= (tmp)		& 0xff;
>  
> -	return ata_dev_classify(&tf);
> +	return ata_port_classify(ap, &tf);
>  }
>  EXPORT_SYMBOL_GPL(ahci_dev_classify);
>  
> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
> index 0f5715cfa1c4..b2b96420a2f2 100644
> --- a/drivers/ata/libata-core.c
> +++ b/drivers/ata/libata-core.c
> @@ -1025,6 +1025,27 @@ const char *sata_spd_string(unsigned int spd)
>  	return spd_str[spd - 1];
>  }
>  
> +const char *ata_dev_class_string(unsigned int class)
> +{
> +	static const char * const class_str[] = {
> +		"unknown",
> +		"ATA",
> +		"ATA (unsupported)",
> +		"ATAPI",
> +		"ATAPI (unsupported",
> +		"PMP",
> +		"PMP (unsupported)",
> +		"SEMB",
> +		"SEMB (unsupported)",
> +		"ZAC",
> +		"ZAC (unsupported)",
> +		"none",
> +	};
> +	if (class == 0 || (class - 1) >= ARRAY_SIZE(class_str))
> +		return "unknown";
> +	return class_str[class - 1];
> +}
> +
>  /**
>   *	ata_dev_classify - determine device type based on ATA-spec signature
>   *	@tf: ATA taskfile register set for device to be identified
> @@ -1063,35 +1084,48 @@ unsigned int ata_dev_classify(const struct ata_taskfile *tf)
>  	 * SEMB signature.  This is worked around in
>  	 * ata_dev_read_id().
>  	 */
> -	if ((tf->lbam == 0) && (tf->lbah == 0)) {
> -		DPRINTK("found ATA device by sig\n");
> +	if ((tf->lbam == 0) && (tf->lbah == 0))
>  		return ATA_DEV_ATA;
> -	}
>  
> -	if ((tf->lbam == 0x14) && (tf->lbah == 0xeb)) {
> -		DPRINTK("found ATAPI device by sig\n");
> +	if ((tf->lbam == 0x14) && (tf->lbah == 0xeb))
>  		return ATA_DEV_ATAPI;
> -	}
>  
> -	if ((tf->lbam == 0x69) && (tf->lbah == 0x96)) {
> -		DPRINTK("found PMP device by sig\n");
> +	if ((tf->lbam == 0x69) && (tf->lbah == 0x96))
>  		return ATA_DEV_PMP;
> -	}
>  
> -	if ((tf->lbam == 0x3c) && (tf->lbah == 0xc3)) {
> -		DPRINTK("found SEMB device by sig (could be ATA device)\n");
> +	if ((tf->lbam == 0x3c) && (tf->lbah == 0xc3))
>  		return ATA_DEV_SEMB;
> -	}
>  
> -	if ((tf->lbam == 0xcd) && (tf->lbah == 0xab)) {
> -		DPRINTK("found ZAC device by sig\n");
> +	if ((tf->lbam == 0xcd) && (tf->lbah == 0xab))
>  		return ATA_DEV_ZAC;
> -	}
>  
> -	DPRINTK("unknown device\n");
>  	return ATA_DEV_UNKNOWN;
>  }
>  
> +/**
> + *	ata_port_classify - determine device type based on ATA-spec signature
> + *	@ap: ATA port device on which the classification should be run
> + *	@tf: ATA taskfile register set for device to be identified
> + *
> + *	A wrapper around ata_dev_classify() to provide additional logging
> + *
> + *	RETURNS:
> + *	Device type, %ATA_DEV_ATA, %ATA_DEV_ATAPI, %ATA_DEV_PMP,
> + *	%ATA_DEV_ZAC, or %ATA_DEV_UNKNOWN the event of failure.
> + */
> +unsigned int ata_port_classify(struct ata_port *ap,
> +			      const struct ata_taskfile *tf)
> +{
> +	unsigned int class = ata_dev_classify(tf);
> +
> +	if (class != ATA_DEV_UNKNOWN)
> +		ata_port_dbg(ap, "found %s device by sig\n",
> +			     ata_dev_class_string(class));
> +	else
> +		ata_port_dbg(ap, "found unknown device\n");
> +	return class;
> +}
> +
>  /**
>   *	ata_id_string - Convert IDENTIFY DEVICE page into string
>   *	@id: IDENTIFY DEVICE results we will examine
> @@ -7267,6 +7301,7 @@ EXPORT_SYMBOL_GPL(ata_xfer_mask2mode);
>  EXPORT_SYMBOL_GPL(ata_xfer_mode2mask);
>  EXPORT_SYMBOL_GPL(ata_xfer_mode2shift);
>  EXPORT_SYMBOL_GPL(ata_mode_string);
> +EXPORT_SYMBOL_GPL(ata_dev_class_string);

This is not needed currently, please remove it.

Also EXPORT_SYMBOL_GPL() for ata_dev_classify() should be now
removed too.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

>  EXPORT_SYMBOL_GPL(ata_id_xfermask);
>  EXPORT_SYMBOL_GPL(ata_do_set_mode);
>  EXPORT_SYMBOL_GPL(ata_std_qc_defer);
> @@ -7282,6 +7317,7 @@ EXPORT_SYMBOL_GPL(sata_link_hardreset);
>  EXPORT_SYMBOL_GPL(sata_std_hardreset);
>  EXPORT_SYMBOL_GPL(ata_std_postreset);
>  EXPORT_SYMBOL_GPL(ata_dev_classify);
> +EXPORT_SYMBOL_GPL(ata_port_classify);
>  EXPORT_SYMBOL_GPL(ata_dev_pair);
>  EXPORT_SYMBOL_GPL(ata_ratelimit);
>  EXPORT_SYMBOL_GPL(ata_msleep);
> diff --git a/drivers/ata/libata-sff.c b/drivers/ata/libata-sff.c
> index 931ae61d69fb..60509997137f 100644
> --- a/drivers/ata/libata-sff.c
> +++ b/drivers/ata/libata-sff.c
> @@ -1839,6 +1839,11 @@ unsigned int ata_sff_dev_classify(struct ata_device *dev, int present,
>  
>  	/* determine if device is ATA or ATAPI */
>  	class = ata_dev_classify(&tf);
> +	if (class != ATA_DEV_UNKNOWN)
> +		ata_dev_dbg(dev, "found %s device by sig\n",
> +			     ata_dev_class_string(class));
> +	else
> +		ata_dev_dbg(dev, "found unknown device\n");
>  
>  	if (class == ATA_DEV_UNKNOWN) {
>  		/* If the device failed diagnostic, it's likely to
> diff --git a/drivers/ata/sata_fsl.c b/drivers/ata/sata_fsl.c
> index d55ee244d693..0864c4fafa39 100644
> --- a/drivers/ata/sata_fsl.c
> +++ b/drivers/ata/sata_fsl.c
> @@ -812,7 +812,7 @@ static unsigned int sata_fsl_dev_classify(struct ata_port *ap)
>  	tf.lbal = (temp >> 8) & 0xff;
>  	tf.nsect = temp & 0xff;
>  
> -	return ata_dev_classify(&tf);
> +	return ata_port_classify(ap, &tf);
>  }
>  
>  static int sata_fsl_hardreset(struct ata_link *link, unsigned int *class,
> diff --git a/drivers/ata/sata_inic162x.c b/drivers/ata/sata_inic162x.c
> index a6b76cc12a66..12f189f2ab1e 100644
> --- a/drivers/ata/sata_inic162x.c
> +++ b/drivers/ata/sata_inic162x.c
> @@ -657,7 +657,7 @@ static int inic_hardreset(struct ata_link *link, unsigned int *class,
>  		}
>  
>  		inic_tf_read(ap, &tf);
> -		*class = ata_dev_classify(&tf);
> +		*class = ata_port_classify(ap, &tf);
>  	}
>  
>  	return 0;
> diff --git a/drivers/ata/sata_sil24.c b/drivers/ata/sata_sil24.c
> index 560070d4f1d0..2373cf5d8d14 100644
> --- a/drivers/ata/sata_sil24.c
> +++ b/drivers/ata/sata_sil24.c
> @@ -677,7 +677,7 @@ static int sil24_softreset(struct ata_link *link, unsigned int *class,
>  	}
>  
>  	sil24_read_tf(ap, 0, &tf);
> -	*class = ata_dev_classify(&tf);
> +	*class = ata_port_classify(ap, &tf);
>  
>  	DPRINTK("EXIT, class=%u\n", *class);
>  	return 0;
> diff --git a/include/linux/libata.h b/include/linux/libata.h
> index 437d2f27bfdd..c7ffe6fb39f1 100644
> --- a/include/linux/libata.h
> +++ b/include/linux/libata.h
> @@ -1173,7 +1173,10 @@ extern int ata_std_qc_defer(struct ata_queued_cmd *qc);
>  extern enum ata_completion_errors ata_noop_qc_prep(struct ata_queued_cmd *qc);
>  extern void ata_sg_init(struct ata_queued_cmd *qc, struct scatterlist *sg,
>  		 unsigned int n_elem);
> +extern const char *ata_dev_class_string(unsigned int class);
>  extern unsigned int ata_dev_classify(const struct ata_taskfile *tf);
> +extern unsigned int ata_port_classify(struct ata_port *ap,
> +				      const struct ata_taskfile *tf);
>  extern void ata_dev_disable(struct ata_device *adev);
>  extern void ata_id_string(const u16 *id, unsigned char *s,
>  			  unsigned int ofs, unsigned int len);
> 
