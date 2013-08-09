From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH v3 3/3] libata: Add support for queued DSM TRIM
Date: Fri, 09 Aug 2013 18:07:04 +0400
Message-ID: <5204F788.2080805@cogentembedded.com>
References: <1376023752-3105-1-git-send-email-marc.ceeeee@gmail.com> <1376023752-3105-4-git-send-email-marc.ceeeee@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-la0-f47.google.com ([209.85.215.47]:33536 "EHLO
	mail-la0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758018Ab3HIOG5 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 9 Aug 2013 10:06:57 -0400
Received: by mail-la0-f47.google.com with SMTP id eo20so2963518lab.6
        for <linux-ide@vger.kernel.org>; Fri, 09 Aug 2013 07:06:56 -0700 (PDT)
In-Reply-To: <1376023752-3105-4-git-send-email-marc.ceeeee@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Marc C <marc.ceeeee@gmail.com>
Cc: tj@kernel.org, linux-ide@vger.kernel.org

Hello.

On 08/09/2013 08:49 AM, Marc C wrote:

> From: Marc Carino <marc.ceeeee@gmail.com>

> Some new SSDs support the queued version of the DSM TRIM command.
> Let the driver use the new command if supported.

> Signed-off-by: Marc Carino <marc.ceeeee@gmail.com>
> ---
>   drivers/ata/libata-scsi.c | 27 +++++++++++++++++++++------
>   1 file changed, 21 insertions(+), 6 deletions(-)

> diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
> index 83c0890..1605ffc 100644
> --- a/drivers/ata/libata-scsi.c
> +++ b/drivers/ata/libata-scsi.c
> @@ -3098,12 +3098,27 @@ static unsigned int ata_scsi_write_same_xlat(struct ata_queued_cmd *qc)
>   	buf = page_address(sg_page(scsi_sglist(scmd)));
>   	size = ata_set_lba_range_entries(buf, 512, block, n_block);
>
> -	tf->protocol = ATA_PROT_DMA;
> -	tf->hob_feature = 0;
> -	tf->feature = ATA_DSM_TRIM;
> -	tf->hob_nsect = (size / 512) >> 8;
> -	tf->nsect = size / 512;
> -	tf->command = ATA_CMD_DSM;
> +	if (ata_ncq_enabled(dev) &&
> +	    (dev->ncq_send_recv_cmds[ATA_LOG_NCQ_SEND_RECV_DSM_OFFSET] &
> +	     ATA_LOG_NCQ_SEND_RECV_DSM_TRIM)) {
> +		/* Newer devices support queued TRIM commands */
> +		tf->protocol = ATA_PROT_NCQ;
> +		tf->command = ATA_CMD_FPDMA_SEND;
> +		tf->hob_nsect = ATA_SUBCMD_FPDMA_SEND_DSM & 0x1f;
> +		tf->nsect = qc->tag << 3;
> +		tf->hob_feature = (size / 512) >> 8;
> +		tf->feature = size / 512;
> +
> +		qc->auxiliary = 1;
> +	} else {
> +		tf->protocol = ATA_PROT_DMA;
> +		tf->hob_feature = 0;
> +		tf->feature = ATA_DSM_TRIM;
> +		tf->hob_nsect = (size / 512) >> 8;
> +		tf->nsect = size / 512;
> +		tf->command = ATA_CMD_DSM;
> +	}
> +

    The remaining issue I see with this is that we don't check whether the 
controller/driver is capable of transferring the new commands to device, i.e. 
that it's FIS-based.

WBR, Sergei

