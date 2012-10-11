From: Dan van der Ster <dan@vanderster.com>
Subject: Re: [PATCH] libata-acpi: Fix NULL ptr derference in ata_acpi_dev_handle
Date: Thu, 11 Oct 2012 10:27:39 +0200
Message-ID: <CABZ+qqkv-iuAxs=DXnQzQn+j-BWaH5jwLsuv0nREFpz3gqHE=g@mail.gmail.com>
References: <5073D44C.7070101@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ob0-f174.google.com ([209.85.214.174]:41425 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751656Ab2JKI2V (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 11 Oct 2012 04:28:21 -0400
Received: by mail-ob0-f174.google.com with SMTP id uo13so1415592obb.19
        for <linux-ide@vger.kernel.org>; Thu, 11 Oct 2012 01:28:20 -0700 (PDT)
In-Reply-To: <5073D44C.7070101@intel.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Aaron Lu <aaron.lu@intel.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org, linux-acpi@vger.kernel.org

On Tue, Oct 9, 2012 at 9:37 AM, Aaron Lu <aaron.lu@intel.com> wrote:
> commit 6b66d95895c149cbc04d4fac5a2f5477c543a8ae didn't handle SATA PMP
> case in ata_acpi_bind_device and will cause a NULL ptr dereference when
> user attached a SATA drive to the PMP port. Fix this by checking PMP
> support.
>
> This bug is reported by Dan van der Ster in the following bugzilla page:
> https://bugzilla.kernel.org/show_bug.cgi?id=48211
>
> Reported-by: Dan van der Ster <dan@vanderster.com>
> Signed-off-by: Aaron Lu <aaron.lu@intel.com>
> Cc: <stable@vger.kernel.org>
Tested-by: Dan van der Ster <dan@vanderster.com>
> ---
>  drivers/ata/libata-acpi.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/ata/libata-acpi.c b/drivers/ata/libata-acpi.c
> index fd9ecf7..5b0ba3f 100644
> --- a/drivers/ata/libata-acpi.c
> +++ b/drivers/ata/libata-acpi.c
> @@ -1105,10 +1105,15 @@ static int ata_acpi_bind_device(struct ata_port *ap, struct scsi_device *sdev,
>         struct acpi_device *acpi_dev;
>         struct acpi_device_power_state *states;
>
> -       if (ap->flags & ATA_FLAG_ACPI_SATA)
> -               ata_dev = &ap->link.device[sdev->channel];
> -       else
> +       if (ap->flags & ATA_FLAG_ACPI_SATA) {
> +               if (!sata_pmp_attached(ap))
> +                       ata_dev = &ap->link.device[sdev->id];
> +               else
> +                       ata_dev = &ap->pmp_link[sdev->channel].device[sdev->id];
> +       }
> +       else {
>                 ata_dev = &ap->link.device[sdev->id];
> +       }
>
>         *handle = ata_dev_acpi_handle(ata_dev);
>
> --
> 1.7.12.21.g871e293
>
