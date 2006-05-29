From: "zhao, forrest" <forrest.zhao@intel.com>
Subject: Re: [PATCH 07/12] libata-hp-prep: store attached SCSI device
Date: Mon, 29 May 2006 16:45:44 +0800
Message-ID: <1148892344.3466.19.camel@forrest26.sh.intel.com>
References: <11488839582227-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:22587 "EHLO
	azsmga101-1.ch.intel.com") by vger.kernel.org with ESMTP
	id S1750767AbWE2I50 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 29 May 2006 04:57:26 -0400
In-Reply-To: <11488839582227-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: jgarzik@pobox.com, mlord@pobox.com, albertcc@tw.ibm.com, alan@lxorguk.ukuu.org.uk, axboe@suse.de, linux-ide@vger.kernel.org

On Mon, 2006-05-29 at 15:25 +0900, Tejun Heo wrote:
> @@ -2743,16 +2743,22 @@ void ata_scsi_simulate(struct ata_device
>  
>  void ata_scsi_scan_host(struct ata_port *ap)
>  {
> -	struct ata_device *dev;
>  	unsigned int i;
>  
>  	if (ap->flags & ATA_FLAG_DISABLED)
>  		return;
>  
>  	for (i = 0; i < ATA_MAX_DEVICES; i++) {
> -		dev = &ap->device[i];
> +		struct ata_device *dev = &ap->device[i];
> +		struct scsi_device *sdev;
> +
> +		if (!ata_dev_enabled(dev) || dev->sdev)
> +			continue;
>  
> -		if (ata_dev_enabled(dev))
> -			scsi_scan_target(&ap->host->shost_gendev, 0, i, 0, 0);
> +		sdev = __scsi_add_device(ap->host, 0, i, 0, NULL);
Is it better to use macro scsi_add_device() than invoking
__scsi_add_device() directly here? I know this is only a trivial change.

> +		if (!IS_ERR(sdev)) {
> +			dev->sdev = sdev;
> +			scsi_device_put(sdev);
> +		}
>  	}
>  }

Thanks,
Forrest
