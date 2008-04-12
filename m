From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] ata-acpi: don't call _GTF for disabled drive
Date: Sat, 12 Apr 2008 00:15:03 -0400
Message-ID: <48003747.3010406@pobox.com>
References: <1206435045.23794.13.camel@sli10-desk.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:54550 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751022AbYDLEPN (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 12 Apr 2008 00:15:13 -0400
In-Reply-To: <1206435045.23794.13.camel@sli10-desk.sh.intel.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Shaohua Li <shaohua.li@intel.com>
Cc: linux acpi <linux-acpi@vger.kernel.org>, linux-ide <linux-ide@vger.kernel.org>, Len Brown <lenb@kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>

Shaohua Li wrote:
> I got below log after a S3 resume in a ASUS A6VC laptop. The system has
> only one IDE drive. It appears there is no reason calling _GTF for
> disabled drive.
> 
> ACPI Error (dsopcode-0483): Attempt to CreateField of length zero [20070126]
> ACPI Error (psparse-0537): Method parse/execution failed [\_SB_.PCI0.IDE0.RATA] (Node df822a7c), AE_AML_OPERAND_VALUE
> ACPI Error (psparse-0537): Method parse/execution failed [\_SB_.PCI0.IDE0.CHN1.DRV0._GTF] (Node df822bd0), AE_AML_OPERAND_VALUE
> ata2.00: _GTF evaluation failed (AE 0x3006)
> ACPI Error (dsopcode-0483): Attempt to CreateField of length zero [20070126]
> ACPI Error (psparse-0537): Method parse/execution failed [\_SB_.PCI0.IDE0.RATA] (Node df822a7c), AE_AML_OPERAND_VALUE
> ACPI Error (psparse-0537): Method parse/execution failed [\_SB_.PCI0.IDE0.CHN1.DRV1._GTF] (Node df822b94), AE_AML_OPERAND_VALUE
> ata2.01: _GTF evaluation failed (AE 0x3006)
> 
> Signed-off-by: Shaohua Li <shaohua.li@intel.com>
> 
> diff --git a/drivers/ata/libata-acpi.c b/drivers/ata/libata-acpi.c
> index bf98a56..7cbf023 100644
> --- a/drivers/ata/libata-acpi.c
> +++ b/drivers/ata/libata-acpi.c
> @@ -839,7 +839,8 @@ void ata_acpi_on_resume(struct ata_port *ap)
>  		 */
>  		ata_link_for_each_dev(dev, &ap->link) {
>  			ata_acpi_clear_gtf(dev);
> -			if (ata_dev_get_GTF(dev, NULL) >= 0)
> +			if (ata_dev_enabled(dev) &&
> +			    ata_dev_get_GTF(dev, NULL) >= 0)
>  				dev->flags |= ATA_DFLAG_ACPI_PENDING;
>  		}
>  	} else {
> @@ -849,7 +850,8 @@ void ata_acpi_on_resume(struct ata_port *ap)
>  		 */
>  		ata_link_for_each_dev(dev, &ap->link) {
>  			ata_acpi_clear_gtf(dev);
> -			dev->flags |= ATA_DFLAG_ACPI_PENDING;
> +			if (ata_dev_enabled(dev))
> +				dev->flags |= ATA_DFLAG_ACPI_PENDING;

I haven't heard any comments from other ACPI folks?

I'll apply this, unless someone objects...

	Jeff



