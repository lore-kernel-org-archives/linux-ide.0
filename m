From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 7/7] SATA ACPI debug-only output
Date: Wed, 14 Dec 2005 17:23:58 -0500
Message-ID: <43A09B7E.8020402@pobox.com>
References: <20051213160110.193e3f61.randy_d_dunlap@linux.intel.com> <20051213161028.7b459b23.randy_d_dunlap@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dvmed.net ([216.237.124.58]:30681 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S965028AbVLNWYA (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 14 Dec 2005 17:24:00 -0500
In-Reply-To: <20051213161028.7b459b23.randy_d_dunlap@linux.intel.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Randy Dunlap <randy_d_dunlap@linux.intel.com>
Cc: ide <linux-ide@vger.kernel.org>, axboe@suse.de

Randy Dunlap wrote:
> From: Randy Dunlap <randy_d_dunlap@linux.intel.com>
> 
> Add some extra debug-only output.
> 
> Signed-off-by: Randy Dunlap <randy_d_dunlap@linux.intel.com>
> ---
>  drivers/scsi/ata_acpi.c    |   17 ++++++++++++-----
>  drivers/scsi/libata-core.c |    6 +++---
>  2 files changed, 15 insertions(+), 8 deletions(-)
> 
> --- linux-2615-rc5g3.orig/drivers/scsi/ata_acpi.c
> +++ linux-2615-rc5g3/drivers/scsi/ata_acpi.c
> @@ -183,9 +183,10 @@ static int get_sata_adr(struct device *d
>  	winfo->drivenum = drive;
>  
>  	status = acpi_get_devices(NULL, get_devices, winfo, NULL);
> -	if (ACPI_FAILURE(status))
> +	if (ACPI_FAILURE(status)) {
> +		DEBPRINT("acpi_get_devices failed\n");

don't invent your own debugprint, use libata's


