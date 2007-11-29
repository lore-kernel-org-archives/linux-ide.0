From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 13/14] libata: implement ATAPI per-command-type DMA
 horkages
Date: Thu, 29 Nov 2007 16:04:00 +0000
Message-ID: <20071129160400.106d8c5b@the-village.bc.nu>
References: <1196346817387-git-send-email-htejun@gmail.com>
	<1196346820396-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:58304 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1762734AbXK2QIO (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 29 Nov 2007 11:08:14 -0500
In-Reply-To: <1196346820396-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
Cc: jeff@garzik.org, linux-ide@vger.kernel.org, liml@rtr.ca, albertl@mail.com, jens.axboe@oracle.com, Tejun Heo <htejun@gmail.com>

On Thu, 29 Nov 2007 23:33:36 +0900
Tejun Heo <htejun@gmail.com> wrote:

> ATAPI DMA is filled with mines.  Sector aligned READ transfers usually
> work but many other commands transfer non-sector aligned or variable
> number of bytes, and there are devices and controllers which have
> problems dealing with such non-aligned DMA transactions.
> 
> This patch implement ATAPI per-command-type DMA horkages and EH logic
> to set those quickly.  This way, failures localized to certain command
> type don't affect other operations (most importantly READs) and
> working configuration is found quickly such that the device can be
> used.

This I think makes sense. We want to fail rapidly when we discover DMA
problems with ATAPI and non core commands. OTOH we want to be pretty
resistant to randomly dropping into PIO on stuff we know works reliably.


> +	ATAPI_DMA_HORKAGE_WRITE		= (1 << 28), /* PIO for WRITEs */
> +	ATAPI_DMA_HORKAGE_READ_CD	= (1 << 29), /* PIO for READ_CDs */
> +	ATAPI_DMA_HORKAGE_READ_DVD_STR	= (1 << 30), /* PIO for READ DVD STR */
> +	ATAPI_DMA_HORKAGE_MISC		= (1 << 31), /* PIO for MISC commands */
> +
>  	 /* DMA mask for user DMA control: User visible values; DO NOT
>  	    renumber */
>  	ATA_DMA_MASK_ATA	= (1 << 0),	/* DMA on ATA Disk */

What are the locking rules for ->horkage at this point ?
