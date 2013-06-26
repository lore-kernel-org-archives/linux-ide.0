From: Aaron Lu <aaron.lu@intel.com>
Subject: Re: [PATCH] libata-zpodd: must use ata_tf_init()
Date: Wed, 26 Jun 2013 10:05:40 +0800
Message-ID: <51CA4C74.50400@intel.com>
References: <201306232325.04732.sergei.shtylyov@cogentembedded.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:35500 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751195Ab3FZCFK (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 25 Jun 2013 22:05:10 -0400
In-Reply-To: <201306232325.04732.sergei.shtylyov@cogentembedded.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc: linux-ide@vger.kernel.org, tj@kernel.org, aaron.lu@intel.com

On 06/24/2013 03:25 AM, Sergei Shtylyov wrote:
> There are  some SATA controllers which have both devices 0 and 1 but this module

Do you mean a SATA port can connect to two SATA devices without PMP?
No objections to this patch, it's obviously correct, just want to learn
something more :-)

Thanks,
Aaron

> just zeroes out taskfile and sets then ATA_TFLAG_DEVICE (not sure that's needed)
> which could  lead to a wrong device being selected just before issuing command.
> Thus we should  call ata_tf_init()  which sets  up the device register value
> properly, like  all other users of ata_exec_internal() do...
> 
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
> 
> ---
> The  patch is against the 'for-3.10-fixes' branch of Tejun Heo's 'libata.git'
> repository. 
> 
>  drivers/ata/libata-zpodd.c |    7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> Index: libata/drivers/ata/libata-zpodd.c
> ===================================================================
> --- libata.orig/drivers/ata/libata-zpodd.c
> +++ libata/drivers/ata/libata-zpodd.c
> @@ -32,13 +32,14 @@ struct zpodd {
>  
>  static int eject_tray(struct ata_device *dev)
>  {
> -	struct ata_taskfile tf = {};
> +	struct ata_taskfile tf;
>  	const char cdb[] = {  GPCMD_START_STOP_UNIT,
>  		0, 0, 0,
>  		0x02,     /* LoEj */
>  		0, 0, 0, 0, 0, 0, 0,
>  	};
>  
> +	ata_tf_init(dev, &tf);
>  	tf.flags = ATA_TFLAG_ISADDR | ATA_TFLAG_DEVICE;
>  	tf.command = ATA_CMD_PACKET;
>  	tf.protocol = ATAPI_PROT_NODATA;
> @@ -52,8 +53,7 @@ static enum odd_mech_type zpodd_get_mech
>  	char buf[16];
>  	unsigned int ret;
>  	struct rm_feature_desc *desc = (void *)(buf + 8);
> -	struct ata_taskfile tf = {};
> -
> +	struct ata_taskfile tf;
>  	char cdb[] = {  GPCMD_GET_CONFIGURATION,
>  			2,      /* only 1 feature descriptor requested */
>  			0, 3,   /* 3, removable medium feature */
> @@ -62,6 +62,7 @@ static enum odd_mech_type zpodd_get_mech
>  			0, 0, 0,
>  	};
>  
> +	ata_tf_init(dev, &tf);
>  	tf.flags = ATA_TFLAG_ISADDR | ATA_TFLAG_DEVICE;
>  	tf.command = ATA_CMD_PACKET;
>  	tf.protocol = ATAPI_PROT_PIO;
> --
> To unsubscribe from this list: send the line "unsubscribe linux-ide" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

