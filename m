From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 4/5] pata: Update experimental tags
Date: Wed, 18 Nov 2009 19:19:19 +0100
Message-ID: <200911181919.19127.bzolnier@gmail.com>
References: <20091117144450.15430.83450.stgit@localhost.localdomain> <20091117145137.15430.11229.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ey-out-2122.google.com ([74.125.78.24]:57155 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758217AbZKRSVF (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 18 Nov 2009 13:21:05 -0500
In-Reply-To: <20091117145137.15430.11229.stgit@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

On Tuesday 17 November 2009 15:51:39 Alan Cox wrote:
> Signed-off-by: Alan Cox <alan@linux.intel.com>
> ---
> 
>  drivers/ata/Kconfig |    8 ++++----
>  1 files changed, 4 insertions(+), 4 deletions(-)
> 
> 
> diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
> index f2df6e2..36931e0 100644
> --- a/drivers/ata/Kconfig
> +++ b/drivers/ata/Kconfig
> @@ -374,7 +374,7 @@ config PATA_HPT366
>  	  If unsure, say N.
>  
>  config PATA_HPT37X
> -	tristate "HPT 370/370A/371/372/374/302 PATA support (Experimental)"
> +	tristate "HPT 370/370A/371/372/374/302 PATA support"
>  	depends on PCI && EXPERIMENTAL
>  	help
>  	  This option enables support for the majority of the later HPT
> @@ -383,7 +383,7 @@ config PATA_HPT37X
>  	  If unsure, say N.
>  
>  config PATA_HPT3X2N
> -	tristate "HPT 372N/302N PATA support (Experimental)"
> +	tristate "HPT 372N/302N PATA support"
>  	depends on PCI && EXPERIMENTAL
>  	help
>  	  This option enables support for the N variant HPT PATA

Maybe they are 'stable' but when it comes to features they are behind hpt366
(i.e. they lack PCI PM), which is also much cleaner than your drivers, easier
to understand and much smaller..

 1609 drivers/ide/hpt366.c

  432 drivers/ata/pata_hpt366.c
 1041 drivers/ata/pata_hpt37x.c
  594 drivers/ata/pata_hpt3x2n.c
 2067 total

(we can still easily cut more than 100 LOC from hpt366)

Having separate drivers wasn't the best decisions from the maintainability
point-of-view.   It added needless complexity (different chips share the same
PCI IDs which make detection across multiple drivers extremely painful) and
confusion (i.e. would you have guessed that HPT302 is supported by pata_hpt37x
while HPT302N by pata_hpt3x2n?).

-- 
Bartlomiej Zolnierkiewicz
