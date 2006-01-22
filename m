From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 02/12] libata: make the owner of a qc responsible for
 freeing it
Date: Sun, 22 Jan 2006 04:37:56 -0500
Message-ID: <43D35274.2060402@pobox.com>
References: <1137916710182-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dvmed.net ([216.237.124.58]:21222 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932271AbWAVJh7 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 22 Jan 2006 04:37:59 -0500
In-Reply-To: <1137916710182-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org, albertcc@tw.ibm.com

Tejun Heo wrote:
> --- a/drivers/scsi/libata-scsi.c
> +++ b/drivers/scsi/libata-scsi.c
> @@ -1219,7 +1219,7 @@ nothing_to_do:
>  	return 1;
>  }
>  
> -static int ata_scsi_qc_complete(struct ata_queued_cmd *qc)
> +static void ata_scsi_qc_complete(struct ata_queued_cmd *qc)
>  {
>  	struct scsi_cmnd *cmd = qc->scsicmd;
>  	u8 *cdb = cmd->cmnd;
> @@ -1256,7 +1256,7 @@ static int ata_scsi_qc_complete(struct a
>  
>  	qc->scsidone(cmd);
>  
> -	return 0;
> +	ata_qc_free(qc);
>  }
>  
>  /**
> @@ -1982,7 +1982,7 @@ void ata_scsi_badcmd(struct scsi_cmnd *c
>  	done(cmd);
>  }
>  
> -static int atapi_sense_complete(struct ata_queued_cmd *qc)
> +static void atapi_sense_complete(struct ata_queued_cmd *qc)
>  {
>  	if (qc->err_mask && ((qc->err_mask & AC_ERR_DEV) == 0))
>  		/* FIXME: not quite right; we don't want the
> @@ -1993,7 +1993,7 @@ static int atapi_sense_complete(struct a
>  		ata_gen_ata_desc_sense(qc);
>  
>  	qc->scsidone(qc->scsicmd);
> -	return 0;
> +	ata_qc_free(qc);
>  }
>  
>  /* is it pointless to prefer PIO for "safety reasons"? */
> @@ -2050,7 +2050,7 @@ static void atapi_request_sense(struct a
>  	DPRINTK("EXIT\n");
>  }
>  
> -static int atapi_qc_complete(struct ata_queued_cmd *qc)
> +static void atapi_qc_complete(struct ata_queued_cmd *qc)
>  {
>  	struct scsi_cmnd *cmd = qc->scsicmd;
>  	unsigned int err_mask = qc->err_mask;
> @@ -2060,7 +2060,7 @@ static int atapi_qc_complete(struct ata_
>  	if (unlikely(err_mask & AC_ERR_DEV)) {
>  		cmd->result = SAM_STAT_CHECK_CONDITION;
>  		atapi_request_sense(qc);
> -		return 1;
> +		return;
>  	}
>  
>  	else if (unlikely(err_mask))
> @@ -2100,7 +2100,7 @@ static int atapi_qc_complete(struct ata_
>  	}
>  
>  	qc->scsidone(cmd);
> -	return 0;
> +	ata_qc_free(qc);


Can you describe the ATAPI error handling flow, after applying these two 
changes (patch #1 and this one, patch #2)?

	Jeff


