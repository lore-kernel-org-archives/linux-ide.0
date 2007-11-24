From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 08/12] libata: implement ata_timing_cycle2mode() and use
 it in libata-acpi and pata_acpi
Date: Fri, 23 Nov 2007 20:17:24 -0500
Message-ID: <47477BA4.80805@garzik.org>
References: <1194327550227-git-send-email-htejun@gmail.com> <11943275513901-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:45379 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752744AbXKXBR0 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 23 Nov 2007 20:17:26 -0500
In-Reply-To: <11943275513901-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: alan@lxorguk.ukuu.org.uk, linux-ide@vger.kernel.org

Tejun Heo wrote:
> libata-acpi is using separate timing tables for transfer modes
> although libata-core has the complete ata_timing table.  Implement
> ata_timing_cycle2mode() to look for matching mode given transfer type
> and cycle duration and use it in libata-acpi and pata_acpi to replace
> private timing tables.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>
> Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
> ---
>  drivers/ata/libata-acpi.c |   62 +++++++++++----------------------------------
>  drivers/ata/libata-core.c |   52 +++++++++++++++++++++++++++++++++++++
>  drivers/ata/pata_acpi.c   |   13 +++++----
>  include/linux/libata.h    |    5 +---
>  4 files changed, 75 insertions(+), 57 deletions(-)
> 
> diff --git a/drivers/ata/libata-acpi.c b/drivers/ata/libata-acpi.c
> index 06d9961..7d982c2 100644
> --- a/drivers/ata/libata-acpi.c
> +++ b/drivers/ata/libata-acpi.c
> @@ -424,22 +424,6 @@ int ata_acpi_cbl_80wire(struct ata_port *ap)
>  
>  EXPORT_SYMBOL_GPL(ata_acpi_cbl_80wire);
>  
> -/* Welcome to ACPI, bring a bucket */
> -const unsigned int ata_acpi_pio_cycle[7] = {
> -	600, 383, 240, 180, 120, 100, 80
> -};
> -EXPORT_SYMBOL_GPL(ata_acpi_pio_cycle);
> -
> -const unsigned int ata_acpi_mwdma_cycle[5] = {
> -	480, 150, 120, 100, 80
> -};
> -EXPORT_SYMBOL_GPL(ata_acpi_mwdma_cycle);
> -
> -const unsigned int ata_acpi_udma_cycle[7] = {
> -	120, 80, 60, 45, 30, 20, 15
> -};
> -EXPORT_SYMBOL_GPL(ata_acpi_udma_cycle);

ah... they go away. nice.


