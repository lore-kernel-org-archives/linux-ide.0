From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH] libata: remove experimental tag on PATA drivers
Date: Fri, 13 Nov 2009 17:15:24 +0100
Message-ID: <200911131715.24377.bzolnier@gmail.com>
References: <4AFCC0D4.9020708@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.156]:12678 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756144AbZKMQQU (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 13 Nov 2009 11:16:20 -0500
In-Reply-To: <4AFCC0D4.9020708@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Robert Hancock <hancockrwd@gmail.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, ide <linux-ide@vger.kernel.org>, Jeff Garzik <jgarzik@pobox.com>

On Friday 13 November 2009 03:13:40 Robert Hancock wrote:
> Remove the experimental tag on Parallel ATA drivers. Though some of the
> individual PATA drivers are still marked as experimental, as a group they can
> hardly be considered to be, given they've been used in various distros for some
> time.
> 
> Signed-off-by: Robert Hancock <hancockrwd@gmail.com>

Fine but please update status of following host drivers that were
marked as "stable" prematurely by commit e3389cb first:

PATA_PDC_OLD: needs to be marked as EXPERIMENTAL (or just BROKEN)
- known reliability problems with UDMA

PATA_ALI: EXPERIMENTAL
- ATAPI DMA is still broken

PATA_CMD64X: EXPERIMENTAL
- potential data corruption issues remains unfixed for CMD64[3,6]

PATA_SIS: EXPERIMENTAL
- missing MWDMA support on newer controllers

They are all old & known problems and not present in
[ "old", "deprecated", "legacy" ] counterparts.

> diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
> index f2df6e2..33133c6 100644
> --- a/drivers/ata/Kconfig
> +++ b/drivers/ata/Kconfig
> @@ -3,7 +3,7 @@
>  #
>  
>  menuconfig ATA
> -	tristate "Serial ATA (prod) and Parallel ATA (experimental) drivers"
> +	tristate "Serial ATA and Parallel ATA drivers"
>  	depends on HAS_IOMEM
>  	depends on BLOCK
>  	depends on !(M32R || M68K) || BROKEN

-- 
Bartlomiej Zolnierkiewicz
