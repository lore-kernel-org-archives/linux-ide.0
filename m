From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 86/86] libata: add private driver field to struct ata_device
Date: Thu, 03 Dec 2009 12:45:33 -0500
Message-ID: <4B17F93D.4030207@garzik.org>
References: <20091125170218.5446.13513.sendpatchset@localhost> <20091125171248.5446.22482.sendpatchset@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-gx0-f226.google.com ([209.85.217.226]:49487 "EHLO
	mail-gx0-f226.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756234AbZLCRp2 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 3 Dec 2009 12:45:28 -0500
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

applied


