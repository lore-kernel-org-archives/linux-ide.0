From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 2.6.23-rc3] pata_via cable override for Arima W730-K8
Date: Wed, 22 Aug 2007 12:36:11 +0100
Message-ID: <20070822123611.5b6ad8a9@the-village.bc.nu>
References: <200708220926.l7M9Q3eb014746@alkaid.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:34613 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754218AbXHVL2F (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 22 Aug 2007 07:28:05 -0400
In-Reply-To: <200708220926.l7M9Q3eb014746@alkaid.it.uu.se>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mikael Pettersson <mikpe@it.uu.se>
Cc: linux-ide@vger.kernel.org

> This patch updates the pata_via cable override DMI table to also
> recognise my Targa Visionary 811 laptop (== Arima W730-K8).
> With this patch pata_via does UDMA100 just like the old IDE driver.
> 
> Signed-off-by: Mikael Pettersson <mikpe@it.uu.se>

Acked-by: Alan Cox <alan@redhat.com>

> ---
>  drivers/ata/pata_via.c |    7 +++++++
>  1 files changed, 7 insertions(+)
> 
> --- linux-2.6.23-rc3/drivers/ata/pata_via.c.~1~	2007-08-21 00:45:11.000000000 +0200
> +++ linux-2.6.23-rc3/drivers/ata/pata_via.c	2007-08-21 01:01:27.000000000 +0200
> @@ -136,6 +136,13 @@ static struct dmi_system_id cable_dmi_ta
>  			DMI_MATCH(DMI_BOARD_NAME, "Ferrari 3400"),
>  		},
>  	},
> +	{
> +		.ident = "Arima W730-K8",
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_VENDOR, "ACTEBIS"),
> +			DMI_MATCH(DMI_BOARD_NAME, "SAM#451B"),
> +		},
> +	},
>  	{ }
>  };
>  


-- 
--
	"Alan, I'm getting a bit worried about you."
				-- Linus Torvalds
