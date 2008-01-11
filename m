From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH] IDE: terminate ACPI DMI list
Date: Fri, 11 Jan 2008 12:26:51 +0100
Message-ID: <200801111226.51590.bzolnier@gmail.com>
References: <20080111045918.GA17491@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.175]:49711 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757247AbYAKLPS (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 11 Jan 2008 06:15:18 -0500
Received: by ug-out-1314.google.com with SMTP id z38so454665ugc.16
        for <linux-ide@vger.kernel.org>; Fri, 11 Jan 2008 03:15:16 -0800 (PST)
In-Reply-To: <20080111045918.GA17491@havoc.gtf.org>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: linux-ide@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>

On Friday 11 January 2008, Jeff Garzik wrote:
> Fix oops reported by Trond.
> 
> Signed-off-by: Jeff Garzik <jgarzik@redhat.com>

Acked-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

Linus, could you apply it?

> ---
>  drivers/ide/ide-acpi.c |    2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/ide/ide-acpi.c b/drivers/ide/ide-acpi.c
> index fe6768a..899d565 100644
> --- a/drivers/ide/ide-acpi.c
> +++ b/drivers/ide/ide-acpi.c
> @@ -85,6 +85,8 @@ static const struct dmi_system_id ide_acpi_dmi_table[] = {
>  			DMI_MATCH(DMI_BIOS_VERSION, "KAM1.60")
>  		},
>  	},
> +
> +	{ }	/* terminate list */
>  };
>  
>  static int ide_acpi_blacklist(void)
