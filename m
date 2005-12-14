From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 4/7] call/invoke SATA ACPI suspend/resume functions
Date: Wed, 14 Dec 2005 17:11:47 -0500
Message-ID: <43A098A3.9090606@pobox.com>
References: <20051213160110.193e3f61.randy_d_dunlap@linux.intel.com> <20051213160640.6a5154b0.randy_d_dunlap@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dvmed.net ([216.237.124.58]:19161 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S965014AbVLNWLu (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 14 Dec 2005 17:11:50 -0500
In-Reply-To: <20051213160640.6a5154b0.randy_d_dunlap@linux.intel.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Randy Dunlap <randy_d_dunlap@linux.intel.com>
Cc: ide <linux-ide@vger.kernel.org>, axboe@suse.de

Randy Dunlap wrote:
> From: Randy Dunlap <randy_d_dunlap@linux.intel.com>
> 
> Add calls to ACPI methods for SATA drives.
> 
> Signed-off-by: Randy Dunlap <randy_d_dunlap@linux.intel.com>
> ---
>  drivers/scsi/libata-core.c |    4 ++++
>  drivers/scsi/libata.h      |   26 ++++++++++++++++++++++++++
>  2 files changed, 30 insertions(+)
> 
> --- linux-2615-rc5g3.orig/drivers/scsi/libata-core.c
> +++ linux-2615-rc5g3/drivers/scsi/libata-core.c
> @@ -1345,6 +1345,8 @@ void ata_dev_config(struct ata_port *ap,
>  
>  	if (ap->ops->dev_config)
>  		ap->ops->dev_config(ap, &ap->device[i]);
> +
> +	do_drive_SDD(ap, i);
>  }
>  
>  /**
> @@ -1784,6 +1786,8 @@ static void ata_set_mode(struct ata_port
>  	if (ap->flags & ATA_FLAG_PORT_DISABLED)
>  		return;
>  
> +	do_drive_update_taskfiles(ap);
> +
>  	if (ap->ops->post_set_mode)
>  		ap->ops->post_set_mode(ap);
>  

Mostly OK.

1) The function names are awful.  I would suggest ata_acpi_push_id() and 
ata_acpi_exec_tfs() instead.

2) The call to do_drive_update_taskfiles() should be done in 
ata_bus_probe(), not inside ata_set_mode() where it is essentially 
hidden amongst code that is dedicated to a single purpose, getting the 
data xfer timings.

	Jeff


