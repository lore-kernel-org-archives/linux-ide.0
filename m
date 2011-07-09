From: Greg Dietsche <greg@gregd.org>
Subject: Re: [PATCH] ata: remove unnecessary code
Date: Sat, 9 Jul 2011 10:21:11 -0500
Message-ID: <20110709152111.GA12581@farmergreg.com>
References: <1308242361-28859-1-git-send-email-Gregory.Dietsche@cuw.edu>
Reply-To: Greg Dietsche <greg@gregd.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from que31.charter.net ([209.225.8.23]:47821 "EHLO que31.charter.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754353Ab1GIPdA (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 9 Jul 2011 11:33:00 -0400
Content-Disposition: inline
In-Reply-To: <1308242361-28859-1-git-send-email-Gregory.Dietsche@cuw.edu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com
Cc: linux-ide@vger.kernel.org, kernel-janitors@vger.kernel.org, Gregory.Dietsche@cuw.edu

On Thu, Jun 16, 2011 at 11:39:21AM -0500, Greg Dietsche wrote:
> Compile tested.
> remove unnecessary code that matches this coccinelle pattern
> 	if (...)
> 		return ret;
> 	return ret;
> 
> Signed-off-by: Greg Dietsche <Gregory.Dietsche@cuw.edu>
> ---
>  drivers/ata/pata_acpi.c |    8 +-------
>  1 files changed, 1 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/ata/pata_acpi.c b/drivers/ata/pata_acpi.c
> index 91949d9..54145ed 100644
> --- a/drivers/ata/pata_acpi.c
> +++ b/drivers/ata/pata_acpi.c
> @@ -195,8 +195,6 @@ static int pacpi_port_start(struct ata_port *ap)
>  	struct pci_dev *pdev = to_pci_dev(ap->host->dev);
>  	struct pata_acpi *acpi;
>  
> -	int ret;
> -
>  	if (ap->acpi_handle == NULL)
>  		return -ENODEV;
>  
> @@ -205,11 +203,7 @@ static int pacpi_port_start(struct ata_port *ap)
>  		return -ENOMEM;
>  	acpi->mask[0] = pacpi_discover_modes(ap, &ap->link.device[0]);
>  	acpi->mask[1] = pacpi_discover_modes(ap, &ap->link.device[1]);
> -	ret = ata_bmdma_port_start(ap);
> -	if (ret < 0)
> -		return ret;
> -
> -	return ret;
> +	return ata_bmdma_port_start(ap);
>  }
>  
>  static struct scsi_host_template pacpi_sht = {
> -- 
> 1.7.2.5
> 
any feedback on this patch?

thanks!
Greg

