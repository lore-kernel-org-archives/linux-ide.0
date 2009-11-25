From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 62/86] pata_pdc202xx_old: document known issues
Date: Wed, 25 Nov 2009 17:46:32 +0000
Message-ID: <20091125174632.174666be@lxorguk.ukuu.org.uk>
References: <20091125170218.5446.13513.sendpatchset@localhost>
	<20091125170948.5446.32754.sendpatchset@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:40287 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1759456AbZKYRo2 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 25 Nov 2009 12:44:28 -0500
In-Reply-To: <20091125170948.5446.32754.sendpatchset@localhost>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
Cc: linux-ide@vger.kernel.org, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org

On Wed, 25 Nov 2009 18:09:48 +0100
Bartlomiej Zolnierkiewicz <bzolnier@gmail.com> wrote:

> From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> Subject: [PATCH] pata_pdc202xx_old: document known issues
> 
> Document known issues with the driver to aid distribution makers,
> users and developers in making informed decisions instead of wasting
> their time needlessly.
> 
> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> ---
>  drivers/ata/Kconfig |    4 ++++
>  1 file changed, 4 insertions(+)
> 
> Index: b/drivers/ata/Kconfig
> ===================================================================
> --- a/drivers/ata/Kconfig
> +++ b/drivers/ata/Kconfig
> @@ -583,6 +583,10 @@ config PATA_PDC_OLD
>  	  This option enables support for the Promise 20246, 20262, 20263,
>  	  20265 and 20267 adapters.
>  
> +	  Known issues:
> +	  - UDMA transfers fail mysteriously on some chipsets
> +	  - ATAPI DMA is unsupported currently

Not sure this is useful, because the reports of UDMA failures are lower
than most other reports. Should IPV6 have "known issues, mysterious timer
list corruption" for example which occurs far more. Not do we list 'no
atapi dma' in the help for the IDE SII driver ?

Would be useful to fix (may actually just work now) but comments belong
in the driver code.
