From: Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH v6 4/4] SCT Write Same handle ATA_DFLAG_PIO
Date: Mon, 22 Aug 2016 08:31:25 +0200
Message-ID: <bd74903b-8d07-39fb-6703-db43e827033d@suse.de>
References: <20160822042321.24367-1-shaun@tancheff.com>
 <20160822042321.24367-5-shaun@tancheff.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:39998 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750812AbcHVGb1 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
        Mon, 22 Aug 2016 02:31:27 -0400
In-Reply-To: <20160822042321.24367-5-shaun@tancheff.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Shaun Tancheff <shaun@tancheff.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>, Christoph Hellwig <hch@lst.de>, Tom Yan <tom.ty89@gmail.com>, "Martin K . Petersen" <martin.petersen@oracle.com>, Damien Le Moal <damien.lemoal@hgst.com>, Josh Bingaman <josh.bingaman@seagate.com>, Hannes Reinecke <hare@suse.com>, Shaun Tancheff <shaun.tancheff@seagate.com>

On 08/22/2016 06:23 AM, Shaun Tancheff wrote:
> Use non DMA write log when ATA_DFLAG_PIO is set.
> 
> Signed-off-by: Shaun Tancheff <shaun.tancheff@seagate.com>
> ---
> v6: Added check for ATA_DFLAG_PIO and fallback to non DMA write log for
>     SCT Write Same
> 
>  drivers/ata/libata-scsi.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
> index 37f456e..e50b7a7 100644
> --- a/drivers/ata/libata-scsi.c
> +++ b/drivers/ata/libata-scsi.c
> @@ -3485,6 +3485,8 @@ static unsigned int ata_scsi_write_same_xlat(struct ata_queued_cmd *qc)
>  		tf->device = ATA_CMD_STANDBYNOW1;
>  		tf->protocol = ATA_PROT_DMA;
>  		tf->command = ATA_CMD_WRITE_LOG_DMA_EXT;
> +		if (unlikely(dev->flags & ATA_DFLAG_PIO))
> +			tf->command = ATA_CMD_WRITE_LOG_EXT;
>  	}
>  
>  	tf->flags |= ATA_TFLAG_ISADDR | ATA_TFLAG_DEVICE | ATA_TFLAG_LBA48 |
> 
Reviewed-by: Hannes Reinecke <hare@suse.com>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare@suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 Nürnberg
GF: F. Imendörffer, J. Smithard, J. Guild, D. Upmanyu, G. Norton
HRB 21284 (AG Nürnberg)
