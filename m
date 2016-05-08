From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v2 03/23] ata: sata_dwc_460ex: set dma_boundary to 0x1fff
Date: Sun, 8 May 2016 15:41:12 -0400
Message-ID: <20160508194112.GL4775@htj.duckdns.org>
References: <1461661404-1952-1-git-send-email-andriy.shevchenko@linux.intel.com>
 <1461661404-1952-4-git-send-email-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qk0-f194.google.com ([209.85.220.194]:34746 "EHLO
	mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750849AbcEHTld (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 8 May 2016 15:41:33 -0400
Content-Disposition: inline
In-Reply-To: <1461661404-1952-4-git-send-email-andriy.shevchenko@linux.intel.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-ide@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, Christian Lamparter <chunkeey@googlemail.com>, =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mans@mansr.com>, Julian Margetson <runaway@candw.ms>

On Tue, Apr 26, 2016 at 12:03:04PM +0300, Andy Shevchenko wrote:
> diff --git a/drivers/ata/sata_dwc_460ex.c b/drivers/ata/sata_dwc_460ex.c
> index 7f95389..aee8873 100644
> --- a/drivers/ata/sata_dwc_460ex.c
> +++ b/drivers/ata/sata_dwc_460ex.c
> @@ -1151,7 +1151,13 @@ static struct scsi_host_template sata_dwc_sht = {
>  	 */
>  	.sg_tablesize		= LIBATA_MAX_PRD,
>  	/* .can_queue		= ATA_MAX_QUEUE, */
> -	.dma_boundary		= ATA_DMA_BOUNDARY,
> +	/*
> +	 * Make sure a LLI block is not created that will span 8K max FIS
> +	 * boundary. If the block spans such a FIS boundary, there is a chance
> +	 * that a DMA burst will cross that boundary -- this results in an
> +	 * error in the host controller.
> +	 */
> +	.dma_boundary		= 0x1fff /* ATA_DMA_BOUNDARY */,

The host controller can't cross 8k boundary?  Is this for real?

-- 
tejun
