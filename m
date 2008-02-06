From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [patch 1/1] ata: drivers/ata/sata_mv.c needs dmapool.h
Date: Wed, 06 Feb 2008 07:03:55 -0500
Message-ID: <47A9A22B.9090803@garzik.org>
References: <200802050743.m157hPsJ010259@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:40528 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761814AbYBFMD4 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 6 Feb 2008 07:03:56 -0500
In-Reply-To: <200802050743.m157hPsJ010259@imap1.linux-foundation.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: akpm@linux-foundation.org
Cc: linux-ide@vger.kernel.org

akpm@linux-foundation.org wrote:
> From: Andrew Morton <akpm@linux-foundation.org>
> 
> mips:
> 
> drivers/ata/sata_mv.c: In function `mv_port_free_dma_mem':
> drivers/ata/sata_mv.c:1080: error: implicit declaration of function `dma_pool_free'
> 
> Cc: Jeff Garzik <jeff@garzik.org>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> ---
> 
>  drivers/ata/sata_mv.c |    1 +
>  1 file changed, 1 insertion(+)
> 
> diff -puN drivers/ata/sata_mv.c~ata-drivers-ata-sata_mvc-needs-dmapoolh drivers/ata/sata_mv.c
> --- a/drivers/ata/sata_mv.c~ata-drivers-ata-sata_mvc-needs-dmapoolh
> +++ a/drivers/ata/sata_mv.c
> @@ -69,6 +69,7 @@
>  #include <linux/blkdev.h>
>  #include <linux/delay.h>
>  #include <linux/interrupt.h>
> +#include <linux/dmapool.h>
>  #include <linux/dma-mapping.h>
>  #include <linux/device.h>
>  #include <scsi/scsi_host.h>

applied


