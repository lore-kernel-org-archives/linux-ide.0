From: Anton Vorontsov <cbouatmailru@gmail.com>
Subject: Re: [PATCH v4 1/3] ahci_platform: rename module ahci_platform to
 ahci_platforms
Date: Sun, 9 Jan 2011 06:03:36 +0300
Message-ID: <20110109030336.GC27507@oksana.dev.rtsoft.ru>
References: <1294537775-21714-1-git-send-email-mkl0301@gmail.com>
 <1294537775-21714-2-git-send-email-mkl0301@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ew0-f46.google.com ([209.85.215.46]:61099 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751012Ab1AIDDl (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 8 Jan 2011 22:03:41 -0500
Received: by ewy5 with SMTP id 5so8317646ewy.19
        for <linux-ide@vger.kernel.org>; Sat, 08 Jan 2011 19:03:40 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1294537775-21714-2-git-send-email-mkl0301@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: mkl0301@gmail.com
Cc: htejun@gmail.com, linux-arm-kernel@lists.infradead.org, jgarzik@pobox.com, linux-ide@vger.kernel.org

On Sun, Jan 09, 2011 at 09:49:33AM +0800, mkl0301@gmail.com wrote:
> From: Mac Lin <mkl0301@gmail.com>
> 
> Due to build system limitations, intermediate and final objects can't have the
> same names. And as we're going to start building SoC-specific objects, rename
> ahci_platform to ahci_platforms, into which link ahci_platform and SoC-specific
> objects.
> 
> Signed-off-by: Mac Lin <mkl0301@gmail.com>

Acked-by: Anton Vorontsov <cbouatmailru@gmail.com>

Thanks Mac!

> ---
>  drivers/ata/Makefile |    4 +++-
>  1 files changed, 3 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/ata/Makefile b/drivers/ata/Makefile
> index 2b67c90..d17bfe7 100644
> --- a/drivers/ata/Makefile
> +++ b/drivers/ata/Makefile
> @@ -3,7 +3,9 @@ obj-$(CONFIG_ATA)		+= libata.o
>  
>  # non-SFF interface
>  obj-$(CONFIG_SATA_AHCI)		+= ahci.o libahci.o
> -obj-$(CONFIG_SATA_AHCI_PLATFORM) += ahci_platform.o libahci.o
> +obj-$(CONFIG_SATA_AHCI_PLATFORM) += ahci_platforms.o libahci.o
> +ahci_platforms-y		+= ahci_platform.o
> +
>  obj-$(CONFIG_SATA_FSL)		+= sata_fsl.o
>  obj-$(CONFIG_SATA_INIC162X)	+= sata_inic162x.o
>  obj-$(CONFIG_SATA_SIL24)	+= sata_sil24.o
> -- 
> 1.7.3

-- 
Anton Vorontsov
Email: cbouatmailru@gmail.com
