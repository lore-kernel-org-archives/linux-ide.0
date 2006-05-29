From: "zhao, forrest" <forrest.zhao@intel.com>
Subject: Re: [PATCH 04/12] libata-hp-prep: update ata_scsi_find_dev() and
	friends
Date: Mon, 29 May 2006 16:40:36 +0800
Message-ID: <1148892037.3466.15.camel@forrest26.sh.intel.com>
References: <11488839582103-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:49334 "EHLO
	fmsmga101-1.fm.intel.com") by vger.kernel.org with ESMTP
	id S1750778AbWE2Iw2 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 29 May 2006 04:52:28 -0400
In-Reply-To: <11488839582103-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: jgarzik@pobox.com, mlord@pobox.com, albertcc@tw.ibm.com, alan@lxorguk.ukuu.org.uk, axboe@suse.de, linux-ide@vger.kernel.org

On Mon, 2006-05-29 at 15:25 +0900, Tejun Heo wrote:
> 113b8fe60b97a6ce664d6098f23b56b75247de87
> diff --git a/drivers/scsi/libata-scsi.c b/drivers/scsi/libata-scsi.c
> index 9e5cb9f..9adc5c1 100644
> --- a/drivers/scsi/libata-scsi.c
> +++ b/drivers/scsi/libata-scsi.c
> @@ -52,8 +52,12 @@ #include "libata.h"
>  #define SECTOR_SIZE	512
>  
>  typedef unsigned int (*ata_xlat_func_t)(struct ata_queued_cmd *qc, const u8 *scsicmd);
> -static struct ata_device *
> -ata_scsi_find_dev(struct ata_port *ap, const struct scsi_device *scsidev);
> +
> +static struct ata_device * __ata_scsi_find_dev(struct ata_port *ap,
> +					const struct scsi_device *scsidev);
> +static struct ata_device * ata_scsi_find_dev(struct ata_port *ap,
> +					    const struct scsi_device *scsidev);
> +
>  
>  #define RW_RECOVERY_MPAGE 0x1
>  #define RW_RECOVERY_MPAGE_LEN 12
> @@ -2308,6 +2312,23 @@ static unsigned int atapi_xlat(struct at
>  	return 0;
>  }
>  
> +static struct ata_device * ata_find_dev(struct ata_port *ap, int id)
> +{
> +	if (likely(id == 0 || (id == 1 && ap->flags & ATA_FLAG_SLAVE_POSS)))
> +		return &ap->device[id];
> +	return NULL;
> +}
> +

>From my understanding, the definition of function ata_find_dev() should
be in libata-core.c instead of libata-scsi.c. Does it make sense to you?

Thanks,
Forrest
