From: Tejun Heo <tj@kernel.org>
Subject: Re: [bz87101 PATCH] libata: allow sata_sil24 to opt-out of tag
 ordered submission
Date: Tue, 4 Nov 2014 09:27:14 -0500
Message-ID: <20141104142714.GE14459@htj.dyndns.org>
References: <20141029171402.17994.16801.stgit@viggo.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qc0-f176.google.com ([209.85.216.176]:47773 "EHLO
	mail-qc0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751104AbaKDO1S (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 4 Nov 2014 09:27:18 -0500
Content-Disposition: inline
In-Reply-To: <20141029171402.17994.16801.stgit@viggo.jf.intel.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Dan Williams <dan.j.williams@intel.com>
Cc: linux-ide@vger.kernel.org, Ronny Hegewald <Ronny.Hegewald@online.de>, stable@vger.kernel.org

Hello, Dan.

On Wed, Oct 29, 2014 at 10:21:08AM -0700, Dan Williams wrote:
> diff --git a/drivers/ata/libata.h b/drivers/ata/libata.h
> index 5f4e0cca56ec..16f75854cd99 100644
> --- a/drivers/ata/libata.h
> +++ b/drivers/ata/libata.h
> @@ -90,6 +90,8 @@ extern int ata_down_xfermask_limit(struct ata_device *dev, unsigned int sel);
>  extern unsigned int ata_dev_set_feature(struct ata_device *dev,
>  					u8 enable, u8 feature);
>  extern void ata_sg_clean(struct ata_queued_cmd *qc);
> +extern struct ata_queued_cmd *ata_qc_new_tag_order(struct ata_port *ap);
> +extern struct ata_queued_cmd *ata_qc_new_fifo_order(struct ata_port *ap);
>  extern void ata_qc_free(struct ata_queued_cmd *qc);
>  extern void ata_qc_issue(struct ata_queued_cmd *qc);
>  extern void __ata_qc_complete(struct ata_queued_cmd *qc);
> diff --git a/drivers/ata/sata_sil24.c b/drivers/ata/sata_sil24.c
> index d81b20ddb527..59719ded8ef1 100644
> --- a/drivers/ata/sata_sil24.c
> +++ b/drivers/ata/sata_sil24.c
> @@ -30,8 +30,9 @@
>  #include <scsi/scsi_cmnd.h>
>  #include <linux/libata.h>
>  
> -#define DRV_NAME	"sata_sil24"
> -#define DRV_VERSION	"1.1"
> +#include "libata.h"
> +
> +#define SATA_SIL24_DRV_VERSION "1.1"

Why are we changing these in this patch?

> @@ -397,6 +398,7 @@ static struct ata_port_operations sil24_ops = {
>  	.qc_prep		= sil24_qc_prep,
>  	.qc_issue		= sil24_qc_issue,
>  	.qc_fill_rtf		= sil24_qc_fill_rtf,
> +	.qc_new			= ata_qc_new_fifo_order,

Maybe it'd be easier to just make it a flag?  Are we expecting other
varieties here?

Thanks.

-- 
tejun
