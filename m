From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [patch] sata_dwc_460ex: indent an if statement
Date: Mon, 30 Mar 2015 13:59:24 +0300
Message-ID: <1427713164.14897.442.camel@linux.intel.com>
References: <20150330103025.GA27144@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:9570 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752720AbbC3K71 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 30 Mar 2015 06:59:27 -0400
In-Reply-To: <20150330103025.GA27144@mwanda>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org, kernel-janitors@vger.kernel.org

On Mon, 2015-03-30 at 13:30 +0300, Dan Carpenter wrote:
> We shuffled some code around in 8b3444852a2b ('sata_dwc_460ex: move to
> generic DMA driver') an accidentally deleted a tab character here.  It
> causes a Smatch warning "if statement not indented".
> 
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> 
> diff --git a/drivers/ata/sata_dwc_460ex.c b/drivers/ata/sata_dwc_460ex.c
> index 5ab4849..9020349 100644
> --- a/drivers/ata/sata_dwc_460ex.c
> +++ b/drivers/ata/sata_dwc_460ex.c
> @@ -295,7 +295,7 @@ static void dma_dwc_xfer_done(void *hsdev_instance)
>  	}
>  
>  	if ((hsdevp->dma_interrupt_count % 2) == 0)
> -	sata_dwc_dma_xfer_complete(ap, 1);
> +		sata_dwc_dma_xfer_complete(ap, 1);
>  
>  	spin_unlock_irqrestore(&host->lock, flags);
>  }


-- 
Andy Shevchenko <andriy.shevchenko@intel.com>
Intel Finland Oy

