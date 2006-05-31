From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH v2] Snoop SET FEATURES - WRITE CACHE ENABLE/DISABLE command
Date: Wed, 31 May 2006 19:09:13 +0900
Message-ID: <447D6B49.5020103@gmail.com>
References: <1148980614.3466.52.camel@forrest26.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=EUC-KR
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.183]:23260 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S964935AbWEaKJU (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 31 May 2006 06:09:20 -0400
Received: by py-out-1112.google.com with SMTP id e30so1018193pya
        for <linux-ide@vger.kernel.org>; Wed, 31 May 2006 03:09:19 -0700 (PDT)
In-Reply-To: <1148980614.3466.52.camel@forrest26.sh.intel.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "zhao, forrest" <forrest.zhao@intel.com>
Cc: jeff@garzik.org, liml@rtr.ca, ric@emc.com, linux-ide@vger.kernel.org

Hello, Zhao.

zhao, forrest wrote:
[--snip--]
> diff --git a/drivers/scsi/libata-scsi.c b/drivers/scsi/libata-scsi.c
> index 9e5cb9f..810f42e 100644
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
> +	if ((!(cdb[2] & 0x20)) && (qc->tf.command == ATA_CMD_SET_FEATURES) &&

!(cdb[2] & 0x20) seems out of place, and revalidation should be
scheduled only when the qc is completing successfully.  ie. !need_sense,
but if used that way the variable name doesn't make much sense.  IMHO,
renaming it to something like failed would be better.

> +	    ((qc->tf.feature == SETFEATURES_WC_ON) ||
> +	     (qc->tf.feature == SETFEATURES_WC_OFF))) {
> +		qc->ap->eh_info.action = ATA_EH_REVALIDATE;

Please do action |= ATA_EH_REVALIDATE.  Also, above schedules
revalidation for both devices for a PATA port.  Currently, there is no
way to specify which device is offending from qc completion path.  I'll
submit a patch to allow it.  After the patch, please add
qc->ap->eh_info.dev = qc->dev such that only the affected device is
revalidated.

Thanks.

-- 
tejun
