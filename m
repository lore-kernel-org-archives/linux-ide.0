From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] ata_piix: Add HP Compaq nc6000 to the broken poweroff list
Date: Wed, 20 May 2009 00:15:39 +0200
Message-ID: <200905200015.39917.rjw@sisk.pl>
References: <1242686264-23173-1-git-send-email-syrjala@sci.fi>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:37587 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753441AbZESWQH (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 19 May 2009 18:16:07 -0400
In-Reply-To: <1242686264-23173-1-git-send-email-syrjala@sci.fi>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Ville Syrjala <syrjala@sci.fi>
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org, Tejun Heo <htejun@gmail.com>

On Tuesday 19 May 2009, Ville Syrjala wrote:
> HP Compaq nc6000 suffers from the double disk spindown issue.
> Add it to the broken poweroff DMI list.

Patch looks good to me FWIW.

> Signed-off-by: Ville Syrjala <syrjala@sci.fi>
> ---
>  drivers/ata/ata_piix.c |    9 +++++++++
>  1 files changed, 9 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/ata/ata_piix.c b/drivers/ata/ata_piix.c
> index d51a17c..1aeb708 100644
> --- a/drivers/ata/ata_piix.c
> +++ b/drivers/ata/ata_piix.c
> @@ -1455,6 +1455,15 @@ static bool piix_broken_system_poweroff(struct pci_dev *pdev)
>  			/* PCI slot number of the controller */
>  			.driver_data = (void *)0x1FUL,
>  		},
> +		{
> +			.ident = "HP Compaq nc6000",
> +			.matches = {
> +				DMI_MATCH(DMI_SYS_VENDOR, "Hewlett-Packard"),
> +				DMI_MATCH(DMI_PRODUCT_NAME, "HP Compaq nc6000"),
> +			},
> +			/* PCI slot number of the controller */
> +			.driver_data = (void *)0x1FUL,
> +		},
>  
>  		{ }	/* terminate list */
>  	};
