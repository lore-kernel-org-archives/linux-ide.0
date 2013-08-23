From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH v4 2/3] libata: Add support for SEND/RECEIVE FPDMA QUEUED
Date: Fri, 23 Aug 2013 16:43:37 +0400
Message-ID: <521758F9.6040303@cogentembedded.com>
References: <1377250847-24132-1-git-send-email-marc.ceeeee@gmail.com> <1377250847-24132-3-git-send-email-marc.ceeeee@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-lb0-f179.google.com ([209.85.217.179]:36768 "EHLO
	mail-lb0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753803Ab3HWMnc (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 23 Aug 2013 08:43:32 -0400
Received: by mail-lb0-f179.google.com with SMTP id v1so422124lbd.38
        for <linux-ide@vger.kernel.org>; Fri, 23 Aug 2013 05:43:31 -0700 (PDT)
In-Reply-To: <1377250847-24132-3-git-send-email-marc.ceeeee@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Marc C <marc.ceeeee@gmail.com>
Cc: tj@kernel.org, linux-ide@vger.kernel.org

Hello.

On 23-08-2013 13:40, Marc C wrote:

> From: Marc Carino <marc.ceeeee@gmail.com>

> Add support for the following ATA opcodes, which are present
> in SATA 3.1 and T13 ATA ACS-3:

>          SEND FPDMA QUEUED
>          RECEIVE FPDMA QUEUED

> Signed-off-by: Marc Carino <marc.ceeeee@gmail.com>
[...]

> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
> index 9062aa0..34ccadb 100644
> --- a/drivers/ata/libata-core.c
> +++ b/drivers/ata/libata-core.c
> @@ -2141,6 +2141,26 @@ static int ata_dev_config_ncq(struct ata_device *dev,
>   	else
>   		snprintf(desc, desc_sz, "NCQ (depth %d/%d)%s", hdepth,
>   			ddepth, aa_desc);
> +
> +	if ((ap->flags & ATA_FLAG_FPDMA_AUX) &&
> +		ata_id_has_ncq_send_and_recv(dev->id)) {

     Please start this line under the second ( above. It's the style preferred 
in libata as it's easier on the eyes.

> +		err_mask = ata_read_log_page(dev,
> +					     ATA_LOG_NCQ_SEND_RECV,
> +					     0,
> +					     ap->sector_buf,
> +					     1);
> +		if (err_mask) {
> +			ata_dev_dbg(dev,
> +				    "failed to get NCQ Send/Recv Log "
> +				    "Emask 0x%x\n",
> +				    err_mask);
> +		} else {
> +			dev->flags |= ATA_DFLAG_NCQ_SEND_RECV;
> +			memcpy(dev->ncq_send_recv_cmds, ap->sector_buf,
> +				ATA_LOG_NCQ_SEND_RECV_SIZE);
> +		}
> +	}
> +

WBR, Sergei

