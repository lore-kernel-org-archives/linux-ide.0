From: Julian Margetson <runaway@candw.ms>
Subject: Re: [PATCH 1/1] ata: select DW_DMAC in case of SATA_DWC
Date: Tue, 05 May 2015 07:37:27 -0400
Message-ID: <5548AB77.4000208@candw.ms>
References: <1430817243-98654-1-git-send-email-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-vn0-f45.google.com ([209.85.216.45]:45414 "EHLO
	mail-vn0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753440AbbEELhc (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 5 May 2015 07:37:32 -0400
Received: by vnbg190 with SMTP id g190so16635123vnb.12
        for <linux-ide@vger.kernel.org>; Tue, 05 May 2015 04:37:30 -0700 (PDT)
In-Reply-To: <1430817243-98654-1-git-send-email-andriy.shevchenko@linux.intel.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org, Ian Munsie <imunsie@au1.ibm.com>, Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org

Thank you.
this resolves the build issue .

On 5/5/2015 5:14 AM, Andy Shevchenko wrote:
> Since sata_dwc_460ex.c was moved to generic DMA driver we have to ensure that
> user can still compile it.
>
> Fixes: 8b3444852a2b (sata_dwc_460ex: move to generic DMA driver)
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>   drivers/ata/Kconfig | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
> index ee5209f..9dca4b9 100644
> --- a/drivers/ata/Kconfig
> +++ b/drivers/ata/Kconfig
> @@ -270,6 +270,7 @@ config ATA_PIIX
>   config SATA_DWC
>   	tristate "DesignWare Cores SATA support"
>   	depends on 460EX
> +	select DW_DMAC
>   	help
>   	  This option enables support for the on-chip SATA controller of the
>   	  AppliedMicro processor 460EX.

