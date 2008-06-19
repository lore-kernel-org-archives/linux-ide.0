From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH #upstream-fixes] ata_piix: add TECRA M4 to broken suspend
 list
Date: Wed, 18 Jun 2008 20:30:17 -0400
Message-ID: <4859A899.6080807@garzik.org>
References: <4852383E.3000901@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:58774 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757846AbYFSAaU (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 18 Jun 2008 20:30:20 -0400
In-Reply-To: <4852383E.3000901@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>

Tejun Heo wrote:
> TOSHIBA also used "TECRA M4" in additon to "Tecra M4", add it.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>
> ---
>  drivers/ata/ata_piix.c |    7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/ata/ata_piix.c b/drivers/ata/ata_piix.c
> index 81b7ae3..a90ae03 100644
> --- a/drivers/ata/ata_piix.c
> +++ b/drivers/ata/ata_piix.c
> @@ -1043,6 +1043,13 @@ static int piix_broken_suspend(void)
>  			},
>  		},
>  		{
> +			.ident = "TECRA M4",
> +			.matches = {
> +				DMI_MATCH(DMI_SYS_VENDOR, "TOSHIBA"),
> +				DMI_MATCH(DMI_PRODUCT_NAME, "TECRA M4"),
> +			},
> +		},
> +		{
>  			.ident = "TECRA M5",
>  			.matches = {
>  				DMI_MATCH(DMI_SYS_VENDOR, "TOSHIBA"),

applied


