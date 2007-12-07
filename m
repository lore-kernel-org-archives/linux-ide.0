From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH #upstream-fixes] ata_piix: add Toshiba Tecra M4 to broken
 suspend list
Date: Fri, 07 Dec 2007 15:29:41 -0500
Message-ID: <4759AD35.3050004@garzik.org>
References: <47560165.3070008@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:57772 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751311AbXLGU3n (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 7 Dec 2007 15:29:43 -0500
In-Reply-To: <47560165.3070008@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>

Tejun Heo wrote:
> From: Peter Schwenke <peter@bluetoad.com.au>
> 
> Add Toshiba Tecra M4 to broken suspend list.  This is from OSDL
> bugzilla bug 7780.
> 
> Signed-off-by: Peter Schwenke <peter@bluetoad.com.au>
> Signed-off-by: Tejun Heo <htejun@gmail.com>
> ---
>  drivers/ata/ata_piix.c |    7 +++++++
>  1 files changed, 7 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/ata/ata_piix.c b/drivers/ata/ata_piix.c
> index b538e1d..bb62a58 100644
> --- a/drivers/ata/ata_piix.c
> +++ b/drivers/ata/ata_piix.c
> @@ -974,6 +974,13 @@ static int piix_broken_suspend(void)
>  			},
>  		},
>  		{
> +			.ident = "TECRA M4",
> +			.matches = {
> +				DMI_MATCH(DMI_SYS_VENDOR, "TOSHIBA"),
> +				DMI_MATCH(DMI_PRODUCT_NAME, "Tecra M4"),
> +			},
> +		},
> +		{
>  			.ident = "TECRA M5",

applied


