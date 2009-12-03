From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 86/86] libata: add private driver field to struct ata_device
Date: Thu, 03 Dec 2009 03:04:40 -0500
Message-ID: <4B177118.5020501@garzik.org>
References: <20091125170218.5446.13513.sendpatchset@localhost> <20091125171248.5446.22482.sendpatchset@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yw0-f182.google.com ([209.85.211.182]:52336 "EHLO
	mail-yw0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751061AbZLCIEf (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 3 Dec 2009 03:04:35 -0500
In-Reply-To: <20091125171248.5446.22482.sendpatchset@localhost>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On 11/25/2009 12:12 PM, Bartlomiej Zolnierkiewicz wrote:
> From: Bartlomiej Zolnierkiewicz<bzolnier@gmail.com>
> Subject: [PATCH] libata: add private driver field to struct ata_device
>
> This brings struct ata_device in-line with struct ata_{port,host}.
>
> Signed-off-by: Bartlomiej Zolnierkiewicz<bzolnier@gmail.com>
> ---
>   include/linux/libata.h |    1 +
>   1 file changed, 1 insertion(+)
>
> Index: b/include/linux/libata.h
> ===================================================================
> --- a/include/linux/libata.h
> +++ b/include/linux/libata.h
> @@ -585,6 +585,7 @@ struct ata_device {
>   	unsigned int		horkage;	/* List of broken features */
>   	unsigned long		flags;		/* ATA_DFLAG_xxx */
>   	struct scsi_device	*sdev;		/* attached SCSI device */
> +	void			*private_data;
>   #ifdef CONFIG_ATA_ACPI
>   	acpi_handle		acpi_handle;
>   	union acpi_object	*gtf_cache;

I'm fine with this, and would like to merge this sooner rather than later.

However, BIG FAT WARNING:  you must take special care to be sure you 
don't leak as devices appear and disappear, etc.  IOW, watch your object 
lifetimes carefully.  Object lifetime was the reason this was not added 
until now.


