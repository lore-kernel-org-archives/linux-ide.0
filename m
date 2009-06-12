From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 1/9] cmd64x: implement clear_irq() method
Date: Fri, 12 Jun 2009 18:16:58 +0200
Message-ID: <200906121816.58809.bzolnier@gmail.com>
References: <200702140101.26639.sshtylyov@ru.mvista.com> <200906102244.46334.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-fx0-f216.google.com ([209.85.220.216]:55137 "EHLO
	mail-fx0-f216.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754375AbZFLQRO (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 12 Jun 2009 12:17:14 -0400
Received: by fxm12 with SMTP id 12so735524fxm.37
        for <linux-ide@vger.kernel.org>; Fri, 12 Jun 2009 09:17:15 -0700 (PDT)
In-Reply-To: <200906102244.46334.sshtylyov@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linux-ide@vger.kernel.org


Hi Sergei,

This is a very nice series and I would like to apply it immediately
but unfortunately there is quite a few issues to be addressed first..

On Wednesday 10 June 2009 20:44:45 Sergei Shtylyov wrote:
> Convert the driver's two dma_end() methods into clear_irq() methods -- the
> driver will now use the standard dma_end() method implementation, ide_dma_end().
> 
> Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>
> 
> ---
> The patch is atop of ide-2.6.git 'for-next' branch.
> 
>  drivers/ide/cmd64x.c |   31 +++++++++++++++++--------------
>  1 files changed, 17 insertions(+), 14 deletions(-)

[...]

> @@ -226,11 +226,10 @@ static void cmd64x_set_dma_mode(ide_driv
>  		(void) pci_write_config_byte(dev, pciU, regU);
>  }
>  
> -static int cmd648_dma_end(ide_drive_t *drive)
> +static void cmd648_clear_irq(ide_drive_t *drive)
>  {
>  	ide_hwif_t *hwif	= drive->hwif;
>  	unsigned long base	= hwif->dma_base - (hwif->channel * 8);

Don't we need to check whether hwif->dma_base is valid now?

Also shouldn't this patch be done after fixing core code first?
[IOW this should be patch #5.5]
