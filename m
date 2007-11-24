From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 06/12] libata: separate out ata_acpi_gtm_xfermask() from
 pacpi_discover_modes()
Date: Fri, 23 Nov 2007 20:14:57 -0500
Message-ID: <47477B11.2070108@garzik.org>
References: <1194327550227-git-send-email-htejun@gmail.com> <11943275511318-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:45360 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752723AbXKXBO7 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 23 Nov 2007 20:14:59 -0500
In-Reply-To: <11943275511318-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: alan@lxorguk.ukuu.org.uk, linux-ide@vger.kernel.org

Tejun Heo wrote:
> Finding out matching transfer mode from ACPI GTM values is useful for
> other purposes too.  Separate out the function and timing tables from
> pata_acpi::pacpi_discover_modes().
> 
> Other than checking shared-configuration bit after doing
> ata_acpi_gtm() in pacpi_discover_modes() which should be safe, this
> patch doesn't introduce any behavior change.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>
> Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
> ---
>  drivers/ata/libata-acpi.c |   78 +++++++++++++++++++++++++++++++++++++++++++++
>  drivers/ata/pata_acpi.c   |   66 ++++++-------------------------------
>  include/linux/libata.h    |   25 ++++++++++++++
>  3 files changed, 114 insertions(+), 55 deletions(-)
> 
> diff --git a/drivers/ata/libata-acpi.c b/drivers/ata/libata-acpi.c
> index 08a52dd..5ffa542 100644
> --- a/drivers/ata/libata-acpi.c
> +++ b/drivers/ata/libata-acpi.c
> @@ -424,6 +424,84 @@ int ata_acpi_cbl_80wire(struct ata_port *ap)
>  
>  EXPORT_SYMBOL_GPL(ata_acpi_cbl_80wire);
>  
> +/* Welcome to ACPI, bring a bucket */
> +const unsigned int ata_acpi_pio_cycle[7] = {
> +	600, 383, 240, 180, 120, 100, 80
> +};
> +EXPORT_SYMBOL_GPL(ata_acpi_pio_cycle);
> +
> +const unsigned int ata_acpi_mwdma_cycle[5] = {
> +	480, 150, 120, 100, 80
> +};
> +EXPORT_SYMBOL_GPL(ata_acpi_mwdma_cycle);
> +
> +const unsigned int ata_acpi_udma_cycle[7] = {
> +	120, 80, 60, 45, 30, 20, 15
> +};
> +EXPORT_SYMBOL_GPL(ata_acpi_udma_cycle);

these exports seem a bit ugly

If pressed I will apply, but...


