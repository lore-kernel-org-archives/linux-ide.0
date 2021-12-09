Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C612EC433F5
	for <linux-ide@archiver.kernel.org>; Thu,  9 Dec 2021 00:57:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241725AbhLIBBE (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 8 Dec 2021 20:01:04 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:29716 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241770AbhLIBBA (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 8 Dec 2021 20:01:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1639011446; x=1670547446;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=zFzRN2miyh/dsy3XJ+EyqN/Pt4BleeX6mmxczmOx0LU=;
  b=IZBrID/h0ZxqjwhsiKW2I8meJshzhvAQDBe5ndKGL020V1LmWdA2HKKj
   BdrvWNtInNcJjBosx0Naw6SiBruYrVQM4T3arpZUXb5UpSSsP4Wx1n8iI
   HtxScQRCkCi+hXCTuqfceYLEpKjI8Hr0LoZhss0wp85ZooCSRRaM15YAj
   BXYkmuPlVRYvo0PZbyFhV4hSwMSeGWBlY8nqVS+0CPKtNXdQ86zhdPA5F
   qCgbWnMoKBQi9ooep5e5a1FRKhM4Hswu+Da1QePj4DTwE8WXrpuK01w+P
   WhkROC0lMNckZF6VONoEIUa50FDK50fm0bhgD4K0daOtl5qpmNpP18cGw
   Q==;
X-IronPort-AV: E=Sophos;i="5.88,190,1635177600"; 
   d="scan'208";a="187794075"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 09 Dec 2021 08:57:26 +0800
IronPort-SDR: bF3yWOE02KdnBjyzueHEt1Wdln1Yn9zHVZPpqEm5m5miT2tdz/aPGgjHfzSRWEeenkERkNoIP6
 XaYjm7s+hzLElLXZy6ZbE9/SeFEvsu/Dc77gK/vHER30QUzimK15yMvY5cdrfAdKYRpIj7ih9E
 BzPx4aLxRrq2vBJe+Y8DYNURAMp4KDUDHUYnvIV2DaqRyhIesH7KTo47k6bEjaxASe593m8J1y
 gvoDqiu2L1ahrJyblWT80Xdt7mz6uBEC4BaJVU4kwdFwzxYn2QjdY4NhEgnyyYwzQ/R61hlYbq
 PBKm2Si89VRyKCSXgz66T/MF
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2021 16:30:29 -0800
IronPort-SDR: unqFuaEqbJlAaDXckqJ0wvNK+yIR6m30DIDDjCxNV+MCHVlJgIfTV9HS1SthhxiYjSFCQ7xRAR
 uglo6oYCNQnowqwwKnjQX3jmfDEWTTSMx4GOAWu6y8QorD7KIVKl47Rm/ui1Sur61fXR7OvHDn
 lZO/WZeAiLv8mhekvC+TnnYUcGGFc2rRPcBJLizGPvB6abbGKiUEgd2PahetoVO6izhPQznWSQ
 jew7NjpbwNLYh9XT7NlNAKNXdQ0rjfL2DJqD65OzKTPtkFzCblfPm8nQ9yj2iVexM7nG8fjRdh
 Xeg=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2021 16:57:28 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4J8bGt5bfYz1RvTh
        for <linux-ide@vger.kernel.org>; Wed,  8 Dec 2021 16:57:26 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1639011446; x=1641603447; bh=zFzRN2miyh/dsy3XJ+EyqN/Pt4BleeX6mmx
        czmOx0LU=; b=cZRc0Oe6xKMpUtlhm/YQG92qxZh0BFZl4MMkcrUb9w2D4Lv7E0w
        js46y2STPCUJxIrO0Q/prfLAtc52ipbgCO7f2oSVKLp4//9eAcT9pFpA/3Se3/mJ
        myM2W9m2UXidW+WqT16xvEs5ritYMccy6YYXHT+EPYtWWCgbK+b61NWAdHOyZsCX
        GlHtGqP06gNqHNU45X0dS6DSCefwmNQjUj/lah/HEKJDpaEAgm3OpQpLrF4JuS1N
        BegSiBl+WfWr+U39bvOcktv8K0gSQynT41XdWsMzNdPDJpVSi7f680mxbzYujV7b
        EqBMzGIDF1bTB8NYlfeE7xWAf/kKXPW32Lw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id WtY80J0KhW9b for <linux-ide@vger.kernel.org>;
        Wed,  8 Dec 2021 16:57:26 -0800 (PST)
Received: from [10.225.54.48] (unknown [10.225.54.48])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4J8bGs6jVMz1RtVG;
        Wed,  8 Dec 2021 16:57:25 -0800 (PST)
Message-ID: <b6f926ad-8dca-4593-1a43-3a89bf2585e8@opensource.wdc.com>
Date:   Thu, 9 Dec 2021 09:57:24 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.3.2
Subject: Re: [PATCH 21/73] libata: move ata_{port,link,dev}_dbg to standard
 dev_XXX() macros
Content-Language: en-US
To:     Hannes Reinecke <hare@suse.de>
Cc:     linux-ide@vger.kernel.org
References: <20211208163255.114660-1-hare@suse.de>
 <20211208163255.114660-22-hare@suse.de>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital
In-Reply-To: <20211208163255.114660-22-hare@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 2021/12/09 1:32, Hannes Reinecke wrote:
> Use standard dev_{dbg,info,notice,warn,err} macros instead of the
> hand-crafted printk helpers.
> 
> Signed-off-by: Hannes Reinecke <hare@suse.de>
> ---
>  drivers/ata/libata-acpi.c    | 48 +++++++++++++++-------------
>  drivers/ata/libata-core.c    | 61 ------------------------------------
>  drivers/ata/pata_ixp4xx_cf.c |  6 ++--
>  include/linux/libata.h       | 48 ++++++++++------------------
>  4 files changed, 45 insertions(+), 118 deletions(-)
> 
> diff --git a/drivers/ata/libata-acpi.c b/drivers/ata/libata-acpi.c
> index 7a7d6642edcc..7007377880ce 100644
> --- a/drivers/ata/libata-acpi.c
> +++ b/drivers/ata/libata-acpi.c
> @@ -650,9 +650,7 @@ static int ata_acpi_run_tf(struct ata_device *dev,
>  	struct ata_taskfile *pptf = NULL;
>  	struct ata_taskfile tf, ptf, rtf;
>  	unsigned int err_mask;
> -	const char *level;
>  	const char *descr;
> -	char msg[60];
>  	int rc;
>  
>  	if ((gtf->tf[0] == 0) && (gtf->tf[1] == 0) && (gtf->tf[2] == 0)
> @@ -666,6 +664,10 @@ static int ata_acpi_run_tf(struct ata_device *dev,
>  		pptf = &ptf;
>  	}
>  
> +	descr = ata_get_cmd_descript(tf.command);
> +	if (!descr)
> +		descr = "unknown";

Change ata_get_cmd_descript() last silly "return NULL;" to "return "unknown";"
and you can avoid the if here, and even the descr local variable.
This could be done in a prep patch.

While at it, I would rename this function to ata_cmd_name() to simplify things
("descript" is very misleading for just human readable string...).

> +
>  	if (!ata_acpi_filter_tf(dev, &tf, pptf)) {
>  		rtf = tf;
>  		err_mask = ata_exec_internal(dev, &rtf, NULL,
> @@ -673,40 +675,42 @@ static int ata_acpi_run_tf(struct ata_device *dev,
>  
>  		switch (err_mask) {
>  		case 0:
> -			level = KERN_DEBUG;
> -			snprintf(msg, sizeof(msg), "succeeded");
> +			ata_dev_dbg(dev,
> +				"ACPI cmd %02x/%02x:%02x:%02x:%02x:%02x:%02x"
> +				"(%s) succeeded\n",
> +				tf.command, tf.feature, tf.nsect, tf.lbal,
> +				tf.lbam, tf.lbah, tf.device, descr);
>  			rc = 1;
>  			break;
>  
>  		case AC_ERR_DEV:
> -			level = KERN_INFO;
> -			snprintf(msg, sizeof(msg),
> -				 "rejected by device (Stat=0x%02x Err=0x%02x)",
> -				 rtf.command, rtf.feature);
> +			ata_dev_info(dev,
> +				"ACPI cmd %02x/%02x:%02x:%02x:%02x:%02x:%02x"
> +				"(%s) rejected by device (Stat=0x%02x Err=0x%02x)",
> +				tf.command, tf.feature, tf.nsect, tf.lbal,
> +				tf.lbam, tf.lbah, tf.device, descr,
> +				rtf.command, rtf.feature);
>  			rc = 0;
>  			break;
>  
>  		default:
> -			level = KERN_ERR;
> -			snprintf(msg, sizeof(msg),
> -				 "failed (Emask=0x%x Stat=0x%02x Err=0x%02x)",
> -				 err_mask, rtf.command, rtf.feature);
> +			ata_dev_err(dev,
> +				"ACPI cmd %02x/%02x:%02x:%02x:%02x:%02x:%02x"
> +				"(%s) failed (Emask=0x%x Stat=0x%02x Err=0x%02x)",
> +				tf.command, tf.feature, tf.nsect, tf.lbal,
> +				tf.lbam, tf.lbah, tf.device, descr,
> +				err_mask, rtf.command, rtf.feature);
>  			rc = -EIO;
>  			break;
>  		}
>  	} else {
> -		level = KERN_INFO;
> -		snprintf(msg, sizeof(msg), "filtered out");
> +		ata_dev_info(dev,
> +			"ACPI cmd %02x/%02x:%02x:%02x:%02x:%02x:%02x"
> +			"(%s) filtered out\n",
> +			tf.command, tf.feature, tf.nsect, tf.lbal,
> +			tf.lbam, tf.lbah, tf.device, descr);
>  		rc = 0;
>  	}
> -	descr = ata_get_cmd_descript(tf.command);
> -
> -	ata_dev_printk(dev, level,
> -		       "ACPI cmd %02x/%02x:%02x:%02x:%02x:%02x:%02x (%s) %s\n",
> -		       tf.command, tf.feature, tf.nsect, tf.lbal,
> -		       tf.lbam, tf.lbah, tf.device,
> -		       (descr ? descr : "unknown"), msg);
> -
>  	return rc;
>  }
>  
> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
> index ef5ae37bfac0..de5f4bf1c90c 100644
> --- a/drivers/ata/libata-core.c
> +++ b/drivers/ata/libata-core.c
> @@ -6548,67 +6548,6 @@ const struct ata_port_info ata_dummy_port_info = {
>  };
>  EXPORT_SYMBOL_GPL(ata_dummy_port_info);
>  
> -/*
> - * Utility print functions
> - */
> -void ata_port_printk(const struct ata_port *ap, const char *level,
> -		     const char *fmt, ...)
> -{
> -	struct va_format vaf;
> -	va_list args;
> -
> -	va_start(args, fmt);
> -
> -	vaf.fmt = fmt;
> -	vaf.va = &args;
> -
> -	printk("%sata%u: %pV", level, ap->print_id, &vaf);
> -
> -	va_end(args);
> -}
> -EXPORT_SYMBOL(ata_port_printk);
> -
> -void ata_link_printk(const struct ata_link *link, const char *level,
> -		     const char *fmt, ...)
> -{
> -	struct va_format vaf;
> -	va_list args;
> -
> -	va_start(args, fmt);
> -
> -	vaf.fmt = fmt;
> -	vaf.va = &args;
> -
> -	if (sata_pmp_attached(link->ap) || link->ap->slave_link)
> -		printk("%sata%u.%02u: %pV",
> -		       level, link->ap->print_id, link->pmp, &vaf);
> -	else
> -		printk("%sata%u: %pV",
> -		       level, link->ap->print_id, &vaf);
> -
> -	va_end(args);
> -}
> -EXPORT_SYMBOL(ata_link_printk);
> -
> -void ata_dev_printk(const struct ata_device *dev, const char *level,
> -		    const char *fmt, ...)
> -{
> -	struct va_format vaf;
> -	va_list args;
> -
> -	va_start(args, fmt);
> -
> -	vaf.fmt = fmt;
> -	vaf.va = &args;
> -
> -	printk("%sata%u.%02u: %pV",
> -	       level, dev->link->ap->print_id, dev->link->pmp + dev->devno,
> -	       &vaf);
> -
> -	va_end(args);
> -}
> -EXPORT_SYMBOL(ata_dev_printk);
> -
>  void ata_print_version(const struct device *dev, const char *version)
>  {
>  	dev_printk(KERN_DEBUG, dev, "version %s\n", version);
> diff --git a/drivers/ata/pata_ixp4xx_cf.c b/drivers/ata/pata_ixp4xx_cf.c
> index 99c63087c8ae..17b557c91e1c 100644
> --- a/drivers/ata/pata_ixp4xx_cf.c
> +++ b/drivers/ata/pata_ixp4xx_cf.c
> @@ -114,7 +114,7 @@ static void ixp4xx_set_piomode(struct ata_port *ap, struct ata_device *adev)
>  {
>  	struct ixp4xx_pata *ixpp = ap->host->private_data;
>  
> -	ata_dev_printk(adev, KERN_INFO, "configured for PIO%d 8bit\n",
> +	ata_dev_info(adev, "configured for PIO%d 8bit\n",
>  		       adev->pio_mode - XFER_PIO_0);
>  	ixp4xx_set_8bit_timing(ixpp, adev->pio_mode);
>  }
> @@ -132,8 +132,8 @@ static unsigned int ixp4xx_mmio_data_xfer(struct ata_queued_cmd *qc,
>  	struct ixp4xx_pata *ixpp = ap->host->private_data;
>  	unsigned long flags;
>  
> -	ata_dev_printk(adev, KERN_DEBUG, "%s %d bytes\n", (rw == READ) ? "READ" : "WRITE",
> -		       buflen);
> +	ata_dev_dbg(adev, "%s %d bytes\n", (rw == READ) ? "READ" : "WRITE",
> +		    buflen);
>  	spin_lock_irqsave(ap->lock, flags);
>  
>  	/* set the expansion bus in 16bit mode and restore
> diff --git a/include/linux/libata.h b/include/linux/libata.h
> index 235fdbeb19ea..a807d2d43d70 100644
> --- a/include/linux/libata.h
> +++ b/include/linux/libata.h
> @@ -1489,51 +1489,38 @@ static inline int sata_srst_pmp(struct ata_link *link)
>  	return link->pmp;
>  }
>  
> -/*
> - * printk helpers
> - */
> -__printf(3, 4)
> -void ata_port_printk(const struct ata_port *ap, const char *level,
> -		     const char *fmt, ...);
> -__printf(3, 4)
> -void ata_link_printk(const struct ata_link *link, const char *level,
> -		     const char *fmt, ...);
> -__printf(3, 4)
> -void ata_dev_printk(const struct ata_device *dev, const char *level,
> -		    const char *fmt, ...);
> -
>  #define ata_port_err(ap, fmt, ...)				\
> -	ata_port_printk(ap, KERN_ERR, fmt, ##__VA_ARGS__)
> +	dev_err(&ap->tdev, fmt, ##__VA_ARGS__)
>  #define ata_port_warn(ap, fmt, ...)				\
> -	ata_port_printk(ap, KERN_WARNING, fmt, ##__VA_ARGS__)
> +	dev_warn(&ap->tdev, fmt, ##__VA_ARGS__)
>  #define ata_port_notice(ap, fmt, ...)				\
> -	ata_port_printk(ap, KERN_NOTICE, fmt, ##__VA_ARGS__)
> +	dev_notice(&ap->tdev, fmt, ##__VA_ARGS__)
>  #define ata_port_info(ap, fmt, ...)				\
> -	ata_port_printk(ap, KERN_INFO, fmt, ##__VA_ARGS__)
> +	dev_info(&ap->tdev, fmt, ##__VA_ARGS__)
>  #define ata_port_dbg(ap, fmt, ...)				\
> -	ata_port_printk(ap, KERN_DEBUG, fmt, ##__VA_ARGS__)
> +	dev_dbg(&ap->tdev, "%s: " fmt, __func__, ##__VA_ARGS__)
>  
>  #define ata_link_err(link, fmt, ...)				\
> -	ata_link_printk(link, KERN_ERR, fmt, ##__VA_ARGS__)
> +	dev_err(&link->tdev, fmt, ##__VA_ARGS__)
>  #define ata_link_warn(link, fmt, ...)				\
> -	ata_link_printk(link, KERN_WARNING, fmt, ##__VA_ARGS__)
> +	dev_warn(&link->tdev, fmt, ##__VA_ARGS__)
>  #define ata_link_notice(link, fmt, ...)				\
> -	ata_link_printk(link, KERN_NOTICE, fmt, ##__VA_ARGS__)
> +	dev_notice(&link->tdev, fmt, ##__VA_ARGS__)
>  #define ata_link_info(link, fmt, ...)				\
> -	ata_link_printk(link, KERN_INFO, fmt, ##__VA_ARGS__)
> +	dev_info(&link->tdev, fmt, ##__VA_ARGS__)
>  #define ata_link_dbg(link, fmt, ...)				\
> -	ata_link_printk(link, KERN_DEBUG, fmt, ##__VA_ARGS__)
> +	dev_dbg(&link->tdev, "%s: " fmt, __func__, ##__VA_ARGS__)
>  
>  #define ata_dev_err(dev, fmt, ...)				\
> -	ata_dev_printk(dev, KERN_ERR, fmt, ##__VA_ARGS__)
> +	dev_err(&dev->tdev, fmt, ##__VA_ARGS__)
>  #define ata_dev_warn(dev, fmt, ...)				\
> -	ata_dev_printk(dev, KERN_WARNING, fmt, ##__VA_ARGS__)
> +	dev_warn(&dev->tdev, fmt, ##__VA_ARGS__)
>  #define ata_dev_notice(dev, fmt, ...)				\
> -	ata_dev_printk(dev, KERN_NOTICE, fmt, ##__VA_ARGS__)
> +	dev_notice(&dev->tdev, fmt, ##__VA_ARGS__)
>  #define ata_dev_info(dev, fmt, ...)				\
> -	ata_dev_printk(dev, KERN_INFO, fmt, ##__VA_ARGS__)
> +	dev_info(&dev->tdev, fmt, ##__VA_ARGS__)
>  #define ata_dev_dbg(dev, fmt, ...)				\
> -	ata_dev_printk(dev, KERN_DEBUG, fmt, ##__VA_ARGS__)
> +	dev_dbg(&dev->tdev, "%s: " fmt, __func__, ##__VA_ARGS__)
>  
>  void ata_print_version(const struct device *dev, const char *version);
>  
> @@ -2067,11 +2054,8 @@ static inline u8 ata_wait_idle(struct ata_port *ap)
>  {
>  	u8 status = ata_sff_busy_wait(ap, ATA_BUSY | ATA_DRQ, 1000);
>  
> -#ifdef ATA_DEBUG
>  	if (status != 0xff && (status & (ATA_BUSY | ATA_DRQ)))
> -		ata_port_printk(ap, KERN_DEBUG, "abnormal Status 0x%X\n",
> -				status);
> -#endif
> +		ata_port_dbg(ap, "abnormal Status 0x%X\n", status);
>  
>  	return status;
>  }
> 


-- 
Damien Le Moal
Western Digital Research
