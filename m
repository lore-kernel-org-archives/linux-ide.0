From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH v3] Snoop SET FEATURES - WRITE CACHE ENABLE/DISABLE command
Date: Fri, 02 Jun 2006 17:45:52 +0900
Message-ID: <447FFAC0.5000706@gmail.com>
References: <1149236748.13451.80.camel@forrest26.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=EUC-KR
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.182]:208 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1751335AbWFBIqA (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 2 Jun 2006 04:46:00 -0400
Received: by py-out-1112.google.com with SMTP id b36so564637pyb
        for <linux-ide@vger.kernel.org>; Fri, 02 Jun 2006 01:46:00 -0700 (PDT)
In-Reply-To: <1149236748.13451.80.camel@forrest26.sh.intel.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "zhao, forrest" <forrest.zhao@intel.com>
Cc: jeff@garzik.org, liml@rtr.ca, ric@emc.com, linux-ide@vger.kernel.org

zhao, forrest wrote:
> diff --git a/drivers/scsi/libata-eh.c b/drivers/scsi/libata-eh.c
> index 71b45ad..0622ad5 100644
> --- a/drivers/scsi/libata-eh.c
> +++ b/drivers/scsi/libata-eh.c
> @@ -1356,6 +1356,8 @@ static int ata_eh_revalidate(struct ata_
>  			if (rc)
>  				break;
>  
> +			/* schedule the scsi_rescan_device() here */
> +			queue_work(ata_scsi_wq, &(ap->scsi_rescan_task));

Can you remove parentheses around ap->scsi_rescan_task?

>  			ehc->i.action &= ~ATA_EH_REVALIDATE;
>  		}
>  	}
> diff --git a/drivers/scsi/libata-scsi.c b/drivers/scsi/libata-scsi.c
> index 9e5cb9f..4e86807 100644
> --- a/drivers/scsi/libata-scsi.c
> +++ b/drivers/scsi/libata-scsi.c
> @@ -1269,6 +1269,17 @@ static void ata_scsi_qc_complete(struct 
>  	u8 *cdb = cmd->cmnd;
>   	int need_sense = (qc->err_mask != 0);
>  
> +	/* We snoop the SET_FEATURES - Write Cache ON/OFF command, and
> +	 * schedule EH_REVALIDATE operation to update the IDENTIFY DEVICE
> +	 * cache
> +	 */
> +	if (!need_sense && (qc->tf.command == ATA_CMD_SET_FEATURES) &&
> +	    ((qc->tf.feature == SETFEATURES_WC_ON) ||
> +	     (qc->tf.feature == SETFEATURES_WC_OFF))) {
> +		qc->ap->eh_info.action = ATA_EH_REVALIDATE;

Please do eh_info.action |= ATA_EH_REVALIDATE.
                         ^^^

-- 
tejun
