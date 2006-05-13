From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 15/22] libata: init ap->cbl to ATA_CBL_SATA early
Date: Sat, 13 May 2006 17:42:40 -0400
Message-ID: <446652D0.3010300@pobox.com>
References: <11473487913085-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:50054 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932301AbWEMVmv (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 13 May 2006 17:42:51 -0400
In-Reply-To: <11473487913085-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: alan@lxorguk.ukuu.org.uk, axboe@suse.de, albertcc@tw.ibm.com, forrest.zhao@intel.com, efalk@google.com, linux-ide@vger.kernel.org

Tejun Heo wrote:
> Init ap->cbl to ATA_CBL_SATA in ata_host_init().  This is necessary
> for soon-to-follow SCR handling function changes.  LLDDs are free to
> change ap->cbl during probing.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>
> 
> ---
> 
>  drivers/scsi/libata-core.c |    9 ++++++---
>  1 files changed, 6 insertions(+), 3 deletions(-)
> 
> acb4ec253fe1fd0879d1afa56a97c688424d2772
> diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
> index 4cb7828..3d44cff 100644
> --- a/drivers/scsi/libata-core.c
> +++ b/drivers/scsi/libata-core.c
> @@ -2370,8 +2370,7 @@ void ata_std_probeinit(struct ata_port *
>  	if ((ap->flags & ATA_FLAG_SATA) && ap->ops->scr_read) {
>  		u32 spd;
>  
> -		/* set cable type and resume link */
> -		ap->cbl = ATA_CBL_SATA;
> +		/* resume link */
>  		sata_phy_resume(ap);
>  
>  		/* init sata_spd_limit to the current value */
> @@ -4586,7 +4585,6 @@ static void ata_host_init(struct ata_por
>  	ap->udma_mask = ent->udma_mask;
>  	ap->flags |= ent->host_flags;
>  	ap->ops = ent->port_ops;
> -	ap->cbl = ATA_CBL_NONE;
>  	ap->sata_spd_limit = UINT_MAX;
>  	ap->active_tag = ATA_TAG_POISON;
>  	ap->last_ctl = 0xFF;
> @@ -4594,6 +4592,11 @@ static void ata_host_init(struct ata_por
>  	INIT_WORK(&ap->port_task, NULL, NULL);
>  	INIT_LIST_HEAD(&ap->eh_done_q);
>  
> +	/* set cable type */
> +	ap->cbl = ATA_CBL_NONE;
> +	if (ap->flags & ATA_FLAG_SATA)
> +		ap->cbl = ATA_CBL_SATA;

ACK, though I worry about a growing inconsistency of ap->cbl use between 
PATA and SATA.


