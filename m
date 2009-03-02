From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH] ide: identify data word 53 bit 1 doesn't cover words
 62 and 63
Date: Tue, 03 Mar 2009 00:46:41 +0300
Message-ID: <49AC53C1.5050904@ru.mvista.com>
References: <200903022009.50660.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:22083 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752682AbZCBVqs (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 2 Mar 2009 16:46:48 -0500
In-Reply-To: <200903022009.50660.sshtylyov@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bzolnier@gmail.com
Cc: linux-ide@vger.kernel.org

Hello, i wrote:

> The IDE code assumed for years that the but 1 of the identify data word 53 also
> covers SW/MW DMA information in words 62 and 63 but is has always covered only
> words 64 thru 70, with words 62 and 63 being defined by the original ATA spec.,
> not by ATA-2...
>
> This fix however should only concern *very* old hard disks and rather old CF
> cards...
>
> Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>
>
> ---
> This patch is against the recent Linus' tree...
>
>  drivers/ide/ide-dma-sff.c |    5 ++---
>  drivers/ide/ide-dma.c     |   32 ++++++++++++++------------------
>  2 files changed, 16 insertions(+), 21 deletions(-)
>
> Index: linux-2.6/drivers/ide/ide-dma-sff.c
> ===================================================================
> --- linux-2.6.orig/drivers/ide/ide-dma-sff.c
> +++ linux-2.6/drivers/ide/ide-dma-sff.c
> @@ -38,9 +38,8 @@ int config_drive_for_dma(ide_drive_t *dr
>  	 * Enable DMA on any drive that has mode2 DMA
>  	 * (multi or single) enabled
>  	 */
> -	if (id[ATA_ID_FIELD_VALID] & 2)	/* regular DMA */
> -		if ((id[ATA_ID_MWDMA_MODES] & 0x404) == 0x404 ||
> -		    (id[ATA_ID_SWDMA_MODES] & 0x404) == 0x404)
> +	if ((id[ATA_ID_MWDMA_MODES] & 0x404) == 0x404 ||
> +	    (id[ATA_ID_SWDMA_MODES] & 0x404) == 0x404)
>  			return 1;
>   

   Oops, this needs to be moved to the left. I'll repost.

MBR, Sergei


