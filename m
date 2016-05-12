From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v2] ata: dwc: add DMADEVICES dependency
Date: Thu, 12 May 2016 12:04:57 -0400
Message-ID: <20160512160457.GV4775@htj.duckdns.org>
References: <1462974151-1467200-1-git-send-email-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qg0-f67.google.com ([209.85.192.67]:33170 "EHLO
	mail-qg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751648AbcELQXb (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 12 May 2016 12:23:31 -0400
Content-Disposition: inline
In-Reply-To: <1462974151-1467200-1-git-send-email-arnd@arndb.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Mans Rullgard <mans@mansr.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, May 11, 2016 at 03:42:08PM +0200, Arnd Bergmann wrote:
> The dwc_460ex SATA driver has become available on non-powerpc architectures
> and may cause randconfig build errors when CONFIG_DMADEVICES is not set
> and SATA_DWC_OLD_DMA is enabled:
> 
> warning: (SATA_DWC_OLD_DMA) selects DW_DMAC_CORE which has unmet direct dependencies (DMADEVICES)
> ERROR: "dw_dma_probe" [drivers/ata/sata_dwc_460ex.ko] undefined!
> ERROR: "dw_dma_remove" [drivers/ata/sata_dwc_460ex.ko] undefined!
> 
> This adds an explcit Kconfig dependency to CONFIG_SATA_DWC so we
> cannot run into broken configurations. While it would also be
> possible to build the driver with both CONFIG_DMADEVICES
> and SATA_DWC_OLD_DMA disabled, that case is not useful because
> there is no fallback to PIO mode when the DMA engine is not
> usable.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Fixes: 50b433753df6 ("ata: sata_dwc_460ex: use "dmas" DT property to find dma channel")

Applied to libata/for-4.7-dw.

Thanks.

-- 
tejun
