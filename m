From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v2] ata: dwc: add DMADEVICES dependency
Date: Wed, 11 May 2016 16:58:32 +0300
Message-ID: <CAHp75Vc9xCWJ3VpPt5OUaq4S_2MfBWNR3eVuoCDmySTgWPAn6g@mail.gmail.com>
References: <1462974151-1467200-1-git-send-email-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1462974151-1467200-1-git-send-email-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Tejun Heo <tj@kernel.org>, Mans Rullgard <mans@mansr.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, linux-ide@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-ide@vger.kernel.org

On Wed, May 11, 2016 at 4:42 PM, Arnd Bergmann <arnd@arndb.de> wrote:
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

Looks reasonable to me:
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> ---
>  drivers/ata/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
> index 41b0725e58ad..e2dc4c045146 100644
> --- a/drivers/ata/Kconfig
> +++ b/drivers/ata/Kconfig
> @@ -313,6 +313,7 @@ config ATA_PIIX
>
>  config SATA_DWC
>         tristate "DesignWare Cores SATA support"
> +       depends on DMADEVICES
>         select GENERIC_PHY
>         help
>           This option enables support for the on-chip SATA controller of the
> --
> 2.7.0
>



-- 
With Best Regards,
Andy Shevchenko
