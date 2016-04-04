From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH 08/14] libata: evaluate SCSI sense code
Date: Mon, 4 Apr 2016 14:21:46 +0300
Message-ID: <57024E4A.7070503@cogentembedded.com>
References: <1459763047-125551-1-git-send-email-hare@suse.de>
 <1459763047-125551-9-git-send-email-hare@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-lb0-f180.google.com ([209.85.217.180]:36795 "EHLO
	mail-lb0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755104AbcDDLVv (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 4 Apr 2016 07:21:51 -0400
Received: by mail-lb0-f180.google.com with SMTP id qe11so155829867lbc.3
        for <linux-ide@vger.kernel.org>; Mon, 04 Apr 2016 04:21:50 -0700 (PDT)
In-Reply-To: <1459763047-125551-9-git-send-email-hare@suse.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Hannes Reinecke <hare@suse.de>, Tejun Heo <tj@kernel.org>
Cc: linux-ide@vger.kernel.org, "Martin K. Petersen" <martin.petersen@oracle.com>, Christoph Hellwig <hch@lst.de>, Shaun Tancheff <shaun.tancheff@seagate.com>, Damien Le Moal <damien.lemoal@hgst.com>, linux-scsi@vger.kernel.org, Sathya Prakash <sathya.prakash@broadcom.com>

On 4/4/2016 12:44 PM, Hannes Reinecke wrote:

> Whenever a sense code is set it would need to be evaluated to
> update the error mask.
>
> Signed-off-by: Hannes Reinecke <hare@suse.de>
> ---
>   drivers/ata/libata-eh.c   | 28 +++++++++++++++++++---------
>   drivers/scsi/scsi_error.c |  3 ++-
>   include/scsi/scsi_eh.h    |  1 +
>   3 files changed, 22 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
> index d33e7b8..99bb9f9 100644
> --- a/drivers/ata/libata-eh.c
> +++ b/drivers/ata/libata-eh.c
> @@ -1919,20 +1919,30 @@ static unsigned int ata_eh_analyze_tf(struct ata_queued_cmd *qc,
[...]
>
> +	if (qc->flags & ATA_QCFLAG_SENSE_VALID) {
> +		int ret = scsi_check_sense(qc->scsicmd);
> +		/*
> +		 * SUCCESS here means that the sense code could

    Could be?

> +		 * evaluated and should be passed to the upper layers
> +		 * for correct evaluation.
> +		 * FAILED means the sense code could not interpreted

    Could not be?

> +		 * and the device would need to be reset.
> +		 * NEEDS_RETRY and ADD_TO_MLQUEUE means that the
> +		 * command would need to be retried.
> +		 */
> +		if (ret == NEEDS_RETRY || ret == ADD_TO_MLQUEUE) {
> +			qc->flags |= ATA_QCFLAG_RETRY;
> +			qc->err_mask |= AC_ERR_OTHER;
> +		} else if (ret != SUCCESS)
> +			qc->err_mask |= AC_ERR_HSM;

    This is asking to be a *switch* statement instead.

[...]

MBR, Sergei

