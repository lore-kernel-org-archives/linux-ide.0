Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A50A4C433F5
	for <linux-ide@archiver.kernel.org>; Thu,  9 Dec 2021 00:34:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232772AbhLIAhx (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 8 Dec 2021 19:37:53 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:62527 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbhLIAhv (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 8 Dec 2021 19:37:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1639010059; x=1670546059;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=TV90WLxTNYsuDXawbJ3IYV96DflPfeipLc8dwBJisr0=;
  b=A3nrLszUjsMyGryTLD3uXHDuzrUgj/whNGZx8veidMraUY9ipBXBdqLL
   hoei3POEuKZGK+esP64Y0dlMO/GmCSwxZBKI7WjBQ2DcKBgiIwAITdGqd
   52Jp84pJn9spMIYhKcbqyoPBOM3J9SsoTZzsFeimgzq8LaQwwbI91Y8TY
   yz5cTAZK6TJpnTyPHQZ8CJqMWGof5w8cXwMuDr+NhbQq1Xfj0YN053FAv
   eaJZRzUuwHFAgyt+QNO57qjy95wL8s5ZIliI3x4QAMRcKiXGlmGXbiXw4
   fZ0rbaBFwq0co/wtfJf28zjRprn79GzXpAdmypcGvvkaAQQzpE+twKG6J
   w==;
X-IronPort-AV: E=Sophos;i="5.88,190,1635177600"; 
   d="scan'208";a="299635274"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 09 Dec 2021 08:34:19 +0800
IronPort-SDR: SjlHm2hzvCQjtK8qbOBuxim8Ff4CV6v52W9/lqUHf5uubbfzdOh5tUBbvs40dY5h296LqGwDtJ
 cYwkqpQNubX2+31I+e8HxeqO/qminPtuPsw4u503ZuJMKbqaVS7ia8gspfwdbJbCola8qjfSUA
 aPl+Nkef/4gTZK4MGk7gObw3GC9eExcTlKGJLdNwX/1zKFv9ys0O0L0hUh23bCwPFormFi4RYt
 jzmlKieV2Lw14Gic6DXOmQ3XSgIU26GO7Nad+regjUfg36jtrZfvRs//FyOknJDdP/ahdVFgz3
 AIQ2CtYlB1DmrbGoLFMglRCw
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2021 16:07:22 -0800
IronPort-SDR: gmM9P6LETlJ7RYESyhJAC43nimAQOnJBcI6vN927iBO+JKcVq1HM8QcMe2+1HzNJj3e45iy/n2
 1kduPxHBnUHFJGP1CA9Qx2WhBsFFZaE01P46vWfsQ3MHDCS5KpNGpcXABvDcG7o8C1Xw7+wBur
 i3bfSuKpYVqVs5isKDmwH8evX2oaMWyLaKQMs7GhMV3VS05ibqbrF+ZP6y5o5YUyiT1KMmfxfg
 twuBBedHfXbEMyazeQyC4+jMVTZQZrnPmX234CGM7vwh+Ugu0aIKtlJbt6M/StkDgm2AKhSOOm
 aSM=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2021 16:34:19 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4J8ZmB4zhTz1RvTh
        for <linux-ide@vger.kernel.org>; Wed,  8 Dec 2021 16:34:18 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1639010057; x=1641602058; bh=TV90WLxTNYsuDXawbJ3IYV96DflPfeipLc8
        dwBJisr0=; b=Qw6lBnoxehIFj3wMsPqQmLB//BWh/JQjs0XvT77AHHyyQMzybkB
        hGNC4DC/KCn23x82crbb85YRxWC/Uikcpg3LVNq4tDlVS0MOBNKUDeHPrGP/nJ13
        YF6HAkjEm0fWetsQGXYkYm4Xz/uAFHfM3KL41pbdoZ0lZhg9sV8VBOzaU+Id9hzh
        rcRhNE9ewtwMD3sDkFEqXtOia5Z/EYSoDrf4K54J4mgwXxZgQ6RPjoli6MVETqbP
        KmmogxAKt+p3xNoWvngtr1PF0Cjck/NeqfMJLm0O7NlmfOwqLswUg7xuVS0fJAco
        Uf+eFvY8ydD0NC9r3+oi1HQygeQoFjmR0TA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id ZfhZtIMU49Yp for <linux-ide@vger.kernel.org>;
        Wed,  8 Dec 2021 16:34:17 -0800 (PST)
Received: from [10.225.54.48] (unknown [10.225.54.48])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4J8Zm872zPz1RtVG;
        Wed,  8 Dec 2021 16:34:16 -0800 (PST)
Message-ID: <a3368acf-d517-7a6c-04d5-44c903ceff43@opensource.wdc.com>
Date:   Thu, 9 Dec 2021 09:34:15 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.3.2
Subject: Re: [PATCH 02/73] libata: Add ata_port_classify() helper
Content-Language: en-US
To:     Hannes Reinecke <hare@suse.de>,
        Damien LeMoal <damien.lemoal@wdc.com>
Cc:     linux-ide@vger.kernel.org,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
References: <20211208163255.114660-1-hare@suse.de>
 <20211208163255.114660-3-hare@suse.de>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital
In-Reply-To: <20211208163255.114660-3-hare@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 2021/12/09 1:31, Hannes Reinecke wrote:
> Add an ata_port_classify() helper to print out the results from
> the device classification and remove the debugging statements
> from ata_dev_classify(). Also provide a mapping ata_dev_class_string()
> to provide a string representation for those instances calling
> ata_dev_classify() directly.
> 
> Signed-off-by: Hannes Reinecke <hare@suse.de>
> Reviewed-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> ---
>  drivers/ata/libahci.c       |  2 +-
>  drivers/ata/libata-core.c   | 67 ++++++++++++++++++++++++++++---------
>  drivers/ata/libata-sff.c    |  2 +-
>  drivers/ata/sata_fsl.c      |  2 +-
>  drivers/ata/sata_inic162x.c |  2 +-
>  drivers/ata/sata_sil24.c    |  2 +-
>  include/linux/libata.h      |  2 ++
>  7 files changed, 58 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/ata/libahci.c b/drivers/ata/libahci.c
> index 8b651f55fc84..21dbcd551443 100644
> --- a/drivers/ata/libahci.c
> +++ b/drivers/ata/libahci.c
> @@ -1300,7 +1300,7 @@ unsigned int ahci_dev_classify(struct ata_port *ap)
>  	tf.lbal		= (tmp >> 8)	& 0xff;
>  	tf.nsect	= (tmp)		& 0xff;
>  
> -	return ata_dev_classify(&tf);
> +	return ata_port_classify(ap, &tf);
>  }
>  EXPORT_SYMBOL_GPL(ahci_dev_classify);
>  
> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
> index f6a9e2f22a94..6cac413caf83 100644
> --- a/drivers/ata/libata-core.c
> +++ b/drivers/ata/libata-core.c
> @@ -969,6 +969,27 @@ const char *sata_spd_string(unsigned int spd)
>  	return spd_str[spd - 1];
>  }
>  
> +const char *ata_dev_class_string(unsigned int class)

This should be static.

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

Add a blank line after the declaration.

> +	if (class == 0 || (class - 1) >= ARRAY_SIZE(class_str))
> +		return "unknown";
> +	return class_str[class - 1];

Why class - 1 ? The class_str entries directly match the values of the
ATA_DEV_XXX macros...

> +}
> +
>  /**
>   *	ata_dev_classify - determine device type based on ATA-spec signature
>   *	@tf: ATA taskfile register set for device to be identified
> @@ -1007,36 +1028,50 @@ unsigned int ata_dev_classify(const struct ata_taskfile *tf)
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
>  EXPORT_SYMBOL_GPL(ata_dev_classify);
>  
> +/**
> + *     ata_port_classify - determine device type based on ATA-spec signature
> + *     @ap: ATA port device on which the classification should be run
> + *     @tf: ATA taskfile register set for device to be identified
> + *
> + *     A wrapper around ata_dev_classify() to provide additional logging
> + *
> + *     RETURNS:
> + *     Device type, %ATA_DEV_ATA, %ATA_DEV_ATAPI, %ATA_DEV_PMP,
> + *     %ATA_DEV_ZAC, or %ATA_DEV_UNKNOWN the event of failure.
> + */
> +unsigned int ata_port_classify(struct ata_port *ap,
> +			       const struct ata_taskfile *tf)
> +{
> +	unsigned int class = ata_dev_classify(tf);
> +
> +	if (class != ATA_DEV_UNKNOWN)
> +		ata_port_dbg(ap, "found %s device by sig\n",
> +			     ata_dev_class_string(class));
> +	else
> +		ata_port_dbg(ap, "found unknown device\n");

Why the if-else here ? ata_dev_class_string(() handles ATA_DEV_UNKNOWN and "bad"
class values saying "unknown" already. So this all seems redundant. If this is
removed, then ata_dev_class_string() could be coded in here since this is the
sole user of that helper.

> +	return class;
> +}
> +EXPORT_SYMBOL_GPL(ata_port_classify);
> +
>  /**
>   *	ata_id_string - Convert IDENTIFY DEVICE page into string
>   *	@id: IDENTIFY DEVICE results we will examine
> diff --git a/drivers/ata/libata-sff.c b/drivers/ata/libata-sff.c
> index 39c026f3948c..a119fabe0919 100644
> --- a/drivers/ata/libata-sff.c
> +++ b/drivers/ata/libata-sff.c
> @@ -1853,7 +1853,7 @@ unsigned int ata_sff_dev_classify(struct ata_device *dev, int present,
>  		return ATA_DEV_NONE;
>  
>  	/* determine if device is ATA or ATAPI */
> -	class = ata_dev_classify(&tf);
> +	class = ata_port_classify(ap, &tf);
>  
>  	if (class == ATA_DEV_UNKNOWN) {
>  		/* If the device failed diagnostic, it's likely to
> diff --git a/drivers/ata/sata_fsl.c b/drivers/ata/sata_fsl.c
> index e5838b23c9e0..dbc57b7a58b8 100644
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
> index e517bd8822a5..b6239dae524a 100644
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
> index f99ec6f7d7c0..7e9c1945dc81 100644
> --- a/drivers/ata/sata_sil24.c
> +++ b/drivers/ata/sata_sil24.c
> @@ -680,7 +680,7 @@ static int sil24_softreset(struct ata_link *link, unsigned int *class,
>  	}
>  
>  	sil24_read_tf(ap, 0, &tf);
> -	*class = ata_dev_classify(&tf);
> +	*class = ata_port_classify(ap, &tf);
>  
>  	DPRINTK("EXIT, class=%u\n", *class);
>  	return 0;
> diff --git a/include/linux/libata.h b/include/linux/libata.h
> index 2a8404b26083..235fdbeb19ea 100644
> --- a/include/linux/libata.h
> +++ b/include/linux/libata.h
> @@ -1160,6 +1160,8 @@ extern enum ata_completion_errors ata_noop_qc_prep(struct ata_queued_cmd *qc);
>  extern void ata_sg_init(struct ata_queued_cmd *qc, struct scatterlist *sg,
>  		 unsigned int n_elem);
>  extern unsigned int ata_dev_classify(const struct ata_taskfile *tf);
> +extern unsigned int ata_port_classify(struct ata_port *ap,
> +				      const struct ata_taskfile *tf);
>  extern void ata_dev_disable(struct ata_device *adev);
>  extern void ata_id_string(const u16 *id, unsigned char *s,
>  			  unsigned int ofs, unsigned int len);
> 


-- 
Damien Le Moal
Western Digital Research
