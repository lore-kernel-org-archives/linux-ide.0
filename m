From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] libata-acpi: fix _GTF command protocol for ATAPI devices
Date: Sat, 28 Apr 2007 14:53:24 -0400
Message-ID: <46339824.5000107@garzik.org>
References: <20070422170646.GM10619@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:53456 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751187AbXD1Sx1 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 28 Apr 2007 14:53:27 -0400
In-Reply-To: <20070422170646.GM10619@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org

Tejun Heo wrote:
> _GTF command is never ATA_PROT_ATAPI_NODATA whether the device is
> ATAPI or not.  It's always ATA_PROT_NODATA.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>
> ---
>  drivers/ata/libata-acpi.c |    3 +--
>  1 files changed, 1 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/ata/libata-acpi.c b/drivers/ata/libata-acpi.c
> index 03a0acf..cb3eab6 100644
> --- a/drivers/ata/libata-acpi.c
> +++ b/drivers/ata/libata-acpi.c
> @@ -489,8 +489,7 @@ static void taskfile_load_raw(struct ata_port *ap,
>  
>  	/* convert gtf to tf */
>  	tf.flags |= ATA_TFLAG_ISADDR | ATA_TFLAG_DEVICE; /* TBD */
> -	tf.protocol = atadev->class == ATA_DEV_ATAPI ?
> -		ATA_PROT_ATAPI_NODATA : ATA_PROT_NODATA;
> +	tf.protocol = ATA_PROT_NODATA;

Elaboration?

ATA_PROT_ATAPI_NODATA is the ATAPI version of the non-data protocol, so 
this change is unexpected.

	Jeff



