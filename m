Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1DA82AE6C
	for <linux-ide@vger.kernel.org>; Wed, 24 Jul 2024 17:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721842359; cv=none; b=ZfTlVAFLGCSvAAK5hUC/9X1lkJWrsDtBxWcimpvXMCTPwaepW74KJkzEg1XwkuodRPNX3dVUIYftKDoU/RJsm2mQGq90FL+9RR/JKT2PhczrqSAt2e24ske98FBqr+6Dy2I+FtOnEYYjrmZcdveXVxGB29bc0kgJFYk+jthooJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721842359; c=relaxed/simple;
	bh=7DmkZRIB/xrby40T7HbFBKjYOj5yAkcXkdduVd69cCM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fHKF7GtocUuIKbbKC+EJAuTiqv8B2/GlJ8+GKI/RbpHjNc/W68g8EaF+gDOsgwI4oCEvlBTPTdsYBya+js8h7ngi44X4OzLymBE9v4fctDWrqvb3vGNZEFbHuZW8O1QH/3ctYnCxriEWQeppNP4Lvtq5MmfytUks3+50vbHfU2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ogyVIssF; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ogyVIssF"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1fc49c1f3e5so200855ad.1
        for <linux-ide@vger.kernel.org>; Wed, 24 Jul 2024 10:32:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721842357; x=1722447157; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7M+b/MyKHuHCcNbyDDaIdd7Prn5Ul3AiNmIVTdw0l4Q=;
        b=ogyVIssFmaC2q1W0DNbI0aWgFG2pk/ZU0S4qZ0g4Z9qLpah75XA5l2fKRcCBb/MEPx
         vsjjLqwYfePl1gSLE/zde238C7/JQMLS6JWlEhZvaQeVD4/6/RVcsLmB7yxPoYNmgxy8
         s4ooMHpOAPqIabAdUCrlKPPUESuyqOxaMns8PP92vno9VVaN+xZFuTX1p2yTSQoebwht
         HAlgZ0kHJF/UdWazUJagOLhLwjPvXstnI3u0+kZfxiLkeUa2Nb34nh22xS0kD6rL9BFF
         wuGIDKTIeRsuWEqNQ6BJU9pk2pmXGwmjzkgDnpV9RsVrC+lHhk8ejHU8/xLMANd1xyn4
         KL/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721842357; x=1722447157;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7M+b/MyKHuHCcNbyDDaIdd7Prn5Ul3AiNmIVTdw0l4Q=;
        b=at3luNrzeF2oc978dr7PW5x14UopiVe8aVP78svlRE9Rhx1imEmbyroreSs5U32J6u
         BtachdIqH/Os55Jlft0Ch4F+0htU1YJD31fTfFPS+Ag8vjOkbQAawjraQiPswlu5CRXx
         XfVS+P2m0ij5zaYXqp8YS/HGc8Uw6tfuE4/MeiocxuBWYDvC4NoSOMMfrmOYIcILdub6
         wtx1pizZUJsUd20SlFzXC4grpaBKzficpB2bstUDQmDUGl4B6nXgtmkGKBKyDOi6daBm
         MtwQCk6nj8FCG4MqcruhTkDGnjPuhL7UJrLWjWGr9vVwW6AxrqvRqhacIVoM9rPmfLYq
         iODw==
X-Gm-Message-State: AOJu0YyIfmIYpp5v8pGTDVmJpIdKsRRLMHVylu8tcmSjFl4ntH/z43JJ
	MlN+v8gxs7Yn5qAjgpv+uaPONmEW2jTC6Mt19KQDd48jd5vIk72U5sITE/3wE+uHyK1DAuEX/cS
	i4Q==
X-Google-Smtp-Source: AGHT+IGyfuVtaBZeMo0uVII3Hs8oLeVeUb8qn/gs1F7Sn2GKS/jTrQN3Q5x2W+Tm3CTjW4N6THVbtQ==
X-Received: by 2002:a17:902:e74e:b0:1fb:2ee5:378a with SMTP id d9443c01a7336-1fed3ad73f6mr2780455ad.44.1721842356437;
        Wed, 24 Jul 2024 10:32:36 -0700 (PDT)
Received: from google.com (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fd6f470d78sm97040355ad.258.2024.07.24.10.32.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jul 2024 10:32:35 -0700 (PDT)
Date: Wed, 24 Jul 2024 17:32:32 +0000
From: Igor Pylypiv <ipylypiv@google.com>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: linux-ide@vger.kernel.org, Niklas Cassel <cassel@kernel.org>
Subject: Re: [PATCH v5 4/4] ata: libata: Print horkages applied to devices
Message-ID: <ZqE6sNnZ3TJamsTH@google.com>
References: <20240724054539.182655-1-dlemoal@kernel.org>
 <20240724054539.182655-5-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240724054539.182655-5-dlemoal@kernel.org>

On Wed, Jul 24, 2024 at 02:45:39PM +0900, Damien Le Moal wrote:
> Introduce the function ata_dev_print_horkage() to print the horkage
> flags that will be used for a device. This new function is called from
> ata_dev_horkage() when a match on a device model or device model and
> revision is found for a device in the ata_dev_horkages array.
> 
> To implement this function, the ATA_HORKAGE_ flags are redefined using
> the new enum ata_horkage which defines the bit shift for each horkage
> flag. The array of strings ata_horkage_names is used to define the name
> of each flag, which are printed by ata_dev_print_horkage().
> 
> Example output for a device listed in the ata_dev_horkages array and
> which has the ATA_HORKAGE_DISABLE flag applied:
> 
> [10193.461270] ata1: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
> [10193.469190] ata1.00: Model 'ASMT109x- Config', rev '2143 5', applying horkages: disable
> [10193.469195] ata1.00: unsupported device, disabling
> [10193.481564] ata1.00: disable device
> 
> And while at it, make sure to use the unsigned int type for horkage
> flags as struct ata_device->horkage is an unsigned int.
> 
> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>

Reviewed-by: Igor Pylypiv <ipylypiv@google.com>

Thanks,
Igor
> ---
>  drivers/ata/libata-core.c |  82 +++++++++++++++++++++++++---
>  include/linux/libata.h    | 112 +++++++++++++++++++++++++-------------
>  2 files changed, 149 insertions(+), 45 deletions(-)
> 
> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
> index 4ef1d14aba1e..b29c798c6834 100644
> --- a/drivers/ata/libata-core.c
> +++ b/drivers/ata/libata-core.c
> @@ -84,7 +84,7 @@ static unsigned int ata_dev_init_params(struct ata_device *dev,
>  					u16 heads, u16 sectors);
>  static unsigned int ata_dev_set_xfermode(struct ata_device *dev);
>  static void ata_dev_xfermask(struct ata_device *dev);
> -static unsigned long ata_dev_horkage(const struct ata_device *dev);
> +static unsigned int ata_dev_horkage(const struct ata_device *dev);
>  
>  static DEFINE_IDA(ata_ida);
>  
> @@ -3987,10 +3987,73 @@ int ata_dev_revalidate(struct ata_device *dev, unsigned int new_class,
>  	return rc;
>  }
>  
> +static const char * const ata_horkage_names[] = {
> +	[__ATA_HORKAGE_DIAGNOSTIC]	= "diagnostic",
> +	[__ATA_HORKAGE_NODMA]		= "nodma",
> +	[__ATA_HORKAGE_NONCQ]		= "noncq",
> +	[__ATA_HORKAGE_MAX_SEC_128]	= "maxsec128",
> +	[__ATA_HORKAGE_BROKEN_HPA]	= "brokenhpa",
> +	[__ATA_HORKAGE_DISABLE]		= "disable",
> +	[__ATA_HORKAGE_HPA_SIZE]	= "hpasize",
> +	[__ATA_HORKAGE_IVB]		= "ivb",
> +	[__ATA_HORKAGE_STUCK_ERR]	= "stuckerr",
> +	[__ATA_HORKAGE_BRIDGE_OK]	= "bridgeok",
> +	[__ATA_HORKAGE_ATAPI_MOD16_DMA]	= "atapimod16dma",
> +	[__ATA_HORKAGE_FIRMWARE_WARN]	= "firmwarewarn",
> +	[__ATA_HORKAGE_1_5_GBPS]	= "1.5gbps",
> +	[__ATA_HORKAGE_NOSETXFER]	= "nosetxfer",
> +	[__ATA_HORKAGE_BROKEN_FPDMA_AA]	= "brokenfpdmaaa",
> +	[__ATA_HORKAGE_DUMP_ID]		= "dumpid",
> +	[__ATA_HORKAGE_MAX_SEC_LBA48]	= "maxseclba48",
> +	[__ATA_HORKAGE_ATAPI_DMADIR]	= "atapidmadir",
> +	[__ATA_HORKAGE_NO_NCQ_TRIM]	= "noncqtrim",
> +	[__ATA_HORKAGE_NOLPM]		= "nolpm",
> +	[__ATA_HORKAGE_WD_BROKEN_LPM]	= "wdbrokenlpm",
> +	[__ATA_HORKAGE_ZERO_AFTER_TRIM]	= "zeroaftertrim",
> +	[__ATA_HORKAGE_NO_DMA_LOG]	= "nodmalog",
> +	[__ATA_HORKAGE_NOTRIM]		= "notrim",
> +	[__ATA_HORKAGE_MAX_SEC_1024]	= "maxsec1024",
> +	[__ATA_HORKAGE_MAX_TRIM_128M]	= "maxtrim128m",
> +	[__ATA_HORKAGE_NO_NCQ_ON_ATI]	= "noncqonati",
> +	[__ATA_HORKAGE_NO_ID_DEV_LOG]	= "noiddevlog",
> +	[__ATA_HORKAGE_NO_LOG_DIR]	= "nologdir",
> +	[__ATA_HORKAGE_NO_FUA]		= "nofua",
> +};
> +
> +static void ata_dev_print_horkage(const struct ata_device *dev,
> +				  const char *model, const char *rev,
> +				  unsigned int horkage)
> +{
> +	int n = 0, i;
> +	size_t sz;
> +	char *str;
> +
> +	if (!horkage)
> +		return;
> +
> +	sz = 64 + ARRAY_SIZE(ata_horkage_names) * 16;
> +	str = kmalloc(sz, GFP_KERNEL);
> +	if (!str)
> +		return;
> +
> +	n = snprintf(str, sz, "Model '%s', rev '%s', applying horkages:",
> +		     model, rev);
> +
> +	for (i = 0; i < ARRAY_SIZE(ata_horkage_names); i++) {
> +		if (horkage & (1U << i))
> +			n += snprintf(str + n, sz - n,
> +				      " %s", ata_horkage_names[i]);
> +	}
> +
> +	ata_dev_warn(dev, "%s\n", str);
> +
> +	kfree(str);
> +}
> +
>  struct ata_dev_horkage_entry {
>  	const char *model_num;
>  	const char *model_rev;
> -	unsigned long horkage;
> +	unsigned int horkage;
>  };
>  
>  static const struct ata_dev_horkage_entry ata_dev_horkages[] = {
> @@ -4266,21 +4329,24 @@ static const struct ata_dev_horkage_entry ata_dev_horkages[] = {
>  	{ }
>  };
>  
> -static unsigned long ata_dev_horkage(const struct ata_device *dev)
> +static unsigned int ata_dev_horkage(const struct ata_device *dev)
>  {
>  	unsigned char model_num[ATA_ID_PROD_LEN + 1];
>  	unsigned char model_rev[ATA_ID_FW_REV_LEN + 1];
>  	const struct ata_dev_horkage_entry *ad = ata_dev_horkages;
>  
> +	/* dev->horkage is an unsigned int. */
> +	BUILD_BUG_ON(__ATA_HORKAGE_MAX > 32);
> +
>  	ata_id_c_string(dev->id, model_num, ATA_ID_PROD, sizeof(model_num));
>  	ata_id_c_string(dev->id, model_rev, ATA_ID_FW_REV, sizeof(model_rev));
>  
>  	while (ad->model_num) {
> -		if (glob_match(ad->model_num, model_num)) {
> -			if (ad->model_rev == NULL)
> -				return ad->horkage;
> -			if (glob_match(ad->model_rev, model_rev))
> -				return ad->horkage;
> +		if (glob_match(ad->model_num, model_num) &&
> +		    (!ad->model_rev || glob_match(ad->model_rev, model_rev))) {
> +			ata_dev_print_horkage(dev, model_num, model_rev,
> +					      ad->horkage);
> +			return ad->horkage;
>  		}
>  		ad++;
>  	}
> diff --git a/include/linux/libata.h b/include/linux/libata.h
> index 17394098bee9..b1768db0089b 100644
> --- a/include/linux/libata.h
> +++ b/include/linux/libata.h
> @@ -55,6 +55,48 @@
>  /* defines only for the constants which don't work well as enums */
>  #define ATA_TAG_POISON		0xfafbfcfdU
>  
> +/*
> + * Horkage types. May be set by libata or controller on drives.
> + * Some horkage may be drive/controller pair dependent.
> + * ata_device->horkage is an unsigned int, so __ATA_HORKAGE_MAX must not
> + * exceed 32.
> + */
> +enum ata_horkage {
> +	__ATA_HORKAGE_DIAGNOSTIC,	/* Failed boot diag */
> +	__ATA_HORKAGE_NODMA,		/* DMA problems */
> +	__ATA_HORKAGE_NONCQ,		/* Don't use NCQ */
> +	__ATA_HORKAGE_MAX_SEC_128,	/* Limit max sects to 128 */
> +	__ATA_HORKAGE_BROKEN_HPA,	/* Broken HPA */
> +	__ATA_HORKAGE_DISABLE,		/* Disable it */
> +	__ATA_HORKAGE_HPA_SIZE,		/* Native size off by one */
> +	__ATA_HORKAGE_IVB,		/* cbl det validity bit bugs */
> +	__ATA_HORKAGE_STUCK_ERR,	/* Stuck ERR on next PACKET */
> +	__ATA_HORKAGE_BRIDGE_OK,	/* No bridge limits */
> +	__ATA_HORKAGE_ATAPI_MOD16_DMA,	/* Use ATAPI DMA for commands that are
> +					 * not a multiple of 16 bytes */
> +	__ATA_HORKAGE_FIRMWARE_WARN,	/* Firmware update warning */
> +	__ATA_HORKAGE_1_5_GBPS,		/* Force 1.5 Gbps */
> +	__ATA_HORKAGE_NOSETXFER,	/* Skip SETXFER, SATA only */
> +	__ATA_HORKAGE_BROKEN_FPDMA_AA,	/* Skip AA */
> +	__ATA_HORKAGE_DUMP_ID,		/* Dump IDENTIFY data */
> +	__ATA_HORKAGE_MAX_SEC_LBA48,	/* Set max sects to 65535 */
> +	__ATA_HORKAGE_ATAPI_DMADIR,	/* Device requires dmadir */
> +	__ATA_HORKAGE_NO_NCQ_TRIM,	/* Do not use queued TRIM */
> +	__ATA_HORKAGE_NOLPM,		/* Do not use LPM */
> +	__ATA_HORKAGE_WD_BROKEN_LPM,	/* Some WDs have broken LPM */
> +	__ATA_HORKAGE_ZERO_AFTER_TRIM,	/* Guarantees zero after trim */
> +	__ATA_HORKAGE_NO_DMA_LOG,	/* Do not use DMA for log read */
> +	__ATA_HORKAGE_NOTRIM,		/* Do not use TRIM */
> +	__ATA_HORKAGE_MAX_SEC_1024,	/* Limit max sects to 1024 */
> +	__ATA_HORKAGE_MAX_TRIM_128M,	/* Limit max trim size to 128M */
> +	__ATA_HORKAGE_NO_NCQ_ON_ATI,	/* Disable NCQ on ATI chipset */
> +	__ATA_HORKAGE_NO_ID_DEV_LOG,	/* Identify device log missing */
> +	__ATA_HORKAGE_NO_LOG_DIR,	/* Do not read log directory */
> +	__ATA_HORKAGE_NO_FUA,		/* Do not use FUA */
> +
> +	__ATA_HORKAGE_MAX,
> +};
> +
>  enum {
>  	/* various global constants */
>  	LIBATA_MAX_PRD		= ATA_MAX_PRD / 2,
> @@ -362,43 +404,39 @@ enum {
>  	 */
>  	ATA_EH_CMD_TIMEOUT_TABLE_SIZE = 8,
>  
> -	/* Horkage types. May be set by libata or controller on drives
> -	   (some horkage may be drive/controller pair dependent */
> -
> -	ATA_HORKAGE_DIAGNOSTIC	= (1 << 0),	/* Failed boot diag */
> -	ATA_HORKAGE_NODMA	= (1 << 1),	/* DMA problems */
> -	ATA_HORKAGE_NONCQ	= (1 << 2),	/* Don't use NCQ */
> -	ATA_HORKAGE_MAX_SEC_128	= (1 << 3),	/* Limit max sects to 128 */
> -	ATA_HORKAGE_BROKEN_HPA	= (1 << 4),	/* Broken HPA */
> -	ATA_HORKAGE_DISABLE	= (1 << 5),	/* Disable it */
> -	ATA_HORKAGE_HPA_SIZE	= (1 << 6),	/* native size off by one */
> -	ATA_HORKAGE_IVB		= (1 << 8),	/* cbl det validity bit bugs */
> -	ATA_HORKAGE_STUCK_ERR	= (1 << 9),	/* stuck ERR on next PACKET */
> -	ATA_HORKAGE_BRIDGE_OK	= (1 << 10),	/* no bridge limits */
> -	ATA_HORKAGE_ATAPI_MOD16_DMA = (1 << 11), /* use ATAPI DMA for commands
> -						    not multiple of 16 bytes */
> -	ATA_HORKAGE_FIRMWARE_WARN = (1 << 12),	/* firmware update warning */
> -	ATA_HORKAGE_1_5_GBPS	= (1 << 13),	/* force 1.5 Gbps */
> -	ATA_HORKAGE_NOSETXFER	= (1 << 14),	/* skip SETXFER, SATA only */
> -	ATA_HORKAGE_BROKEN_FPDMA_AA	= (1 << 15),	/* skip AA */
> -	ATA_HORKAGE_DUMP_ID	= (1 << 16),	/* dump IDENTIFY data */
> -	ATA_HORKAGE_MAX_SEC_LBA48 = (1 << 17),	/* Set max sects to 65535 */
> -	ATA_HORKAGE_ATAPI_DMADIR = (1 << 18),	/* device requires dmadir */
> -	ATA_HORKAGE_NO_NCQ_TRIM	= (1 << 19),	/* don't use queued TRIM */
> -	ATA_HORKAGE_NOLPM	= (1 << 20),	/* don't use LPM */
> -	ATA_HORKAGE_WD_BROKEN_LPM = (1 << 21),	/* some WDs have broken LPM */
> -	ATA_HORKAGE_ZERO_AFTER_TRIM = (1 << 22),/* guarantees zero after trim */
> -	ATA_HORKAGE_NO_DMA_LOG	= (1 << 23),	/* don't use DMA for log read */
> -	ATA_HORKAGE_NOTRIM	= (1 << 24),	/* don't use TRIM */
> -	ATA_HORKAGE_MAX_SEC_1024 = (1 << 25),	/* Limit max sects to 1024 */
> -	ATA_HORKAGE_MAX_TRIM_128M = (1 << 26),	/* Limit max trim size to 128M */
> -	ATA_HORKAGE_NO_NCQ_ON_ATI = (1 << 27),	/* Disable NCQ on ATI chipset */
> -	ATA_HORKAGE_NO_ID_DEV_LOG = (1 << 28),	/* Identify device log missing */
> -	ATA_HORKAGE_NO_LOG_DIR	= (1 << 29),	/* Do not read log directory */
> -	ATA_HORKAGE_NO_FUA	= (1 << 30),	/* Do not use FUA */
> -
> -	 /* DMA mask for user DMA control: User visible values; DO NOT
> -	    renumber */
> +	/* Horkage flags */
> +	ATA_HORKAGE_DIAGNOSTIC      = (1U << __ATA_HORKAGE_DIAGNOSTIC),
> +	ATA_HORKAGE_NODMA           = (1U << __ATA_HORKAGE_NODMA),
> +	ATA_HORKAGE_NONCQ           = (1U << __ATA_HORKAGE_NONCQ),
> +	ATA_HORKAGE_MAX_SEC_128     = (1U << __ATA_HORKAGE_MAX_SEC_128),
> +	ATA_HORKAGE_BROKEN_HPA      = (1U << __ATA_HORKAGE_BROKEN_HPA),
> +	ATA_HORKAGE_DISABLE         = (1U << __ATA_HORKAGE_DISABLE),
> +	ATA_HORKAGE_HPA_SIZE        = (1U << __ATA_HORKAGE_HPA_SIZE),
> +	ATA_HORKAGE_IVB             = (1U << __ATA_HORKAGE_IVB),
> +	ATA_HORKAGE_STUCK_ERR       = (1U << __ATA_HORKAGE_STUCK_ERR),
> +	ATA_HORKAGE_BRIDGE_OK       = (1U << __ATA_HORKAGE_BRIDGE_OK),
> +	ATA_HORKAGE_ATAPI_MOD16_DMA = (1U << __ATA_HORKAGE_ATAPI_MOD16_DMA),
> +	ATA_HORKAGE_FIRMWARE_WARN   = (1U << __ATA_HORKAGE_FIRMWARE_WARN),
> +	ATA_HORKAGE_1_5_GBPS        = (1U << __ATA_HORKAGE_1_5_GBPS),
> +	ATA_HORKAGE_NOSETXFER       = (1U << __ATA_HORKAGE_NOSETXFER),
> +	ATA_HORKAGE_BROKEN_FPDMA_AA = (1U << __ATA_HORKAGE_BROKEN_FPDMA_AA),
> +	ATA_HORKAGE_DUMP_ID         = (1U << __ATA_HORKAGE_DUMP_ID),
> +	ATA_HORKAGE_MAX_SEC_LBA48   = (1U << __ATA_HORKAGE_MAX_SEC_LBA48),
> +	ATA_HORKAGE_ATAPI_DMADIR    = (1U << __ATA_HORKAGE_ATAPI_DMADIR),
> +	ATA_HORKAGE_NO_NCQ_TRIM     = (1U << __ATA_HORKAGE_NO_NCQ_TRIM),
> +	ATA_HORKAGE_NOLPM           = (1U << __ATA_HORKAGE_NOLPM),
> +	ATA_HORKAGE_WD_BROKEN_LPM   = (1U << __ATA_HORKAGE_WD_BROKEN_LPM),
> +	ATA_HORKAGE_ZERO_AFTER_TRIM = (1U << __ATA_HORKAGE_ZERO_AFTER_TRIM),
> +	ATA_HORKAGE_NO_DMA_LOG      = (1U << __ATA_HORKAGE_NO_DMA_LOG),
> +	ATA_HORKAGE_NOTRIM          = (1U << __ATA_HORKAGE_NOTRIM),
> +	ATA_HORKAGE_MAX_SEC_1024    = (1U << __ATA_HORKAGE_MAX_SEC_1024),
> +	ATA_HORKAGE_MAX_TRIM_128M   = (1U << __ATA_HORKAGE_MAX_TRIM_128M),
> +	ATA_HORKAGE_NO_NCQ_ON_ATI   = (1U << __ATA_HORKAGE_NO_NCQ_ON_ATI),
> +	ATA_HORKAGE_NO_ID_DEV_LOG   = (1U << __ATA_HORKAGE_NO_ID_DEV_LOG),
> +	ATA_HORKAGE_NO_LOG_DIR      = (1U << __ATA_HORKAGE_NO_LOG_DIR),
> +	ATA_HORKAGE_NO_FUA          = (1U << __ATA_HORKAGE_NO_FUA),
> +
> +	/* User visible DMA mask for DMA control. DO NOT renumber. */
>  	ATA_DMA_MASK_ATA	= (1 << 0),	/* DMA on ATA Disk */
>  	ATA_DMA_MASK_ATAPI	= (1 << 1),	/* DMA on ATAPI */
>  	ATA_DMA_MASK_CFA	= (1 << 2),	/* DMA on CF Card */
> -- 
> 2.45.2
> 
> 
