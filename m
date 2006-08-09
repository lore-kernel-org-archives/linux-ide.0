From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 01/17] libata: implement ata_host_set_start/stop()
Date: Wed, 09 Aug 2006 00:57:49 -0400
Message-ID: <44D96B4D.5080103@pobox.com>
References: <11549198402749-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:2206 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1030255AbWHIE6H (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 9 Aug 2006 00:58:07 -0400
In-Reply-To: <11549198402749-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: alan@lxorguk.ukuu.org.uk, mlord@pobox.com, albertcc@tw.ibm.com, uchang@tw.ibm.com, forrest.zhao@intel.com, linux-ide@vger.kernel.org

Tejun Heo wrote:
> --- a/include/linux/libata.h
> +++ b/include/linux/libata.h
> @@ -174,13 +174,14 @@ enum {
>  	/* bits 24:31 of ap->flags are reserved for LLD specific flags */
>  
>  	/* struct ata_port pflags */
> -	ATA_PFLAG_EH_PENDING	= (1 << 0), /* EH pending */
> -	ATA_PFLAG_EH_IN_PROGRESS = (1 << 1), /* EH in progress */
> -	ATA_PFLAG_FROZEN	= (1 << 2), /* port is frozen */
> -	ATA_PFLAG_RECOVERED	= (1 << 3), /* recovery action performed */
> -	ATA_PFLAG_LOADING	= (1 << 4), /* boot/loading probe */
> -	ATA_PFLAG_UNLOADING	= (1 << 5), /* module is unloading */
> -	ATA_PFLAG_SCSI_HOTPLUG	= (1 << 6), /* SCSI hotplug scheduled */
> +	ATA_PFLAG_STARTED	= (1 << 0), /* port has been started */
> +	ATA_PFLAG_EH_PENDING	= (1 << 1), /* EH pending */
> +	ATA_PFLAG_EH_IN_PROGRESS = (1 << 2), /* EH in progress */
> +	ATA_PFLAG_FROZEN	= (1 << 3), /* port is frozen */
> +	ATA_PFLAG_RECOVERED	= (1 << 4), /* recovery action performed */
> +	ATA_PFLAG_LOADING	= (1 << 5), /* boot/loading probe */
> +	ATA_PFLAG_UNLOADING	= (1 << 6), /* module is unloading */
> +	ATA_PFLAG_SCSI_HOTPLUG	= (1 << 7), /* SCSI hotplug scheduled */
>  


Please don't obscure your change by all this bit renumbering.

Otherwise OK

