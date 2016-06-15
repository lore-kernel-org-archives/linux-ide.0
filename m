From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH resend] libata:fix kernel panic when hotplug
Date: Wed, 15 Jun 2016 13:56:07 -0400
Message-ID: <20160615175607.GE24102@mtj.duckdns.org>
References: <1465982132-26151-1-git-send-email-dingxiang@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qk0-f194.google.com ([209.85.220.194]:32865 "EHLO
	mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751889AbcFOR4o (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 15 Jun 2016 13:56:44 -0400
Content-Disposition: inline
In-Reply-To: <1465982132-26151-1-git-send-email-dingxiang@huawei.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: DingXiang <dingxiang@huawei.com>
Cc: linux-ide@vger.kernel.org, fangwei1@huawei.com, miaoxie@huawei.com, wangyijing@huawei.com, zhangaihua1@huawei.com, zhaohongjiang@huawei.com, houtao1@huawei.com, linux-kernel@vger.kernel.org

Hello,

On Wed, Jun 15, 2016 at 05:15:32PM +0800, DingXiang wrote:
> From: Miao Xie <miaoxie@huawei.com>
> 
> In normal condition,if we use sas protocol and hotplug a sata disk on a port,
> the sas driver will send event "PORTE_BYTES_DMAED" and call function "sas_porte_bytes_dmaed".
> But if a sata disk is run io and unplug it,then plug a new sata disk,this operation may cause
> a kernel panic like this:

Can you please flow the text so that it fits inside 80 column?

...
> Signed-off-by:Dingxiang <dingxiang@huawei.com>
> Signed-off-by:Chenqilin <chenqilin2@huawei.com>

Can you please put a space between the first and last names?

Please also cc linux-scsi and people who are more familiar with SAS.

> diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
> index 61dc7a9..ac5ec4d 100644
> --- a/drivers/ata/libata-eh.c
> +++ b/drivers/ata/libata-eh.c
> @@ -816,8 +816,12 @@ void ata_scsi_port_error_handler(struct Scsi_Host *host, struct ata_port *ap)
>  
>  	if (ap->pflags & ATA_PFLAG_LOADING)
>  		ap->pflags &= ~ATA_PFLAG_LOADING;
> -	else if (ap->pflags & ATA_PFLAG_SCSI_HOTPLUG)
> -		schedule_delayed_work(&ap->hotplug_task, 0);
> +	else if (ap->pflags & ATA_PFLAG_SCSI_HOTPLUG){
> +		if(ap->flags & ATA_FLAG_SAS_HOST)
> +			ap->pflags &= ~ATA_PFLAG_SCSI_HOTPLUG;
> +		else
> +			schedule_delayed_work(&ap->hotplug_task, 0);
> +	}

ATA_PFLAG_SCSI_HOTPLUG is cleared below anyway, so the above can be

	else if ((ap->pflags & ATA_PFLAG_SCSI_HOTPLUG) &&
		 !(ap->pflags & ATA_PFLAG_SAS_HOST))

Thanks.

-- 
tejun
