From: Kukjin Kim <kgene.kim@samsung.com>
Subject: RE: [PATCH 2/2] driver: ata: add new Exynos5250 SATA PHY controller
 driver
Date: Tue, 29 Jan 2013 10:13:51 -0800
Message-ID: <06c701cdfe4c$665a5ca0$330f15e0$@samsung.com>
References: <1359472758-31350-1-git-send-email-vasanthananthan@gmail.com>
 <1359472758-31350-3-git-send-email-vasanthananthan@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <1359472758-31350-3-git-send-email-vasanthananthan@gmail.com>
Content-language: en-us
Sender: linux-samsung-soc-owner@vger.kernel.org
To: 'Vasanth Ananthan' <vasanthananthan@gmail.com>, linux-ide@vger.kernel.org
Cc: jeff@garzik.org, jgarzik@redhat.com, linux-samsung-soc@vger.kernel.org, thomas.abraham@linaro.org, girish.shivananjappa@linaro.org, 'Vasanth Ananthan' <vasanth.a@samsung.com>
List-Id: linux-ide@vger.kernel.org

Vasanth Ananthan wrote:
> 
> Adding platform driver and I2C client driver for SATA PHY controller
> for Samsung Exynos5250.
> 
Well, I think, if required, you need to implement that via DT...

> The PHY controller in Exynos5250 has both the APB interface
> and I2C client interface, hence it requires both a platform driver
> and an I2C client driver. The PHY controller's primary charecteristics
> are handled through the APB interface, facilitated by the platform driver
> and the 40 bit interface should be enabled through the I2C interface,
> facilitated by the I2C client driver.
> 
> Further, this PHY controller driver uses PHY framework introduced by this
> patchset. The driver registers its initialization/shutdown call back to
the
> framework and corresponding port this PHY controller is assciated with
> gets this PHY and initializes it.
> 
> Signed-off-by: Vasanth Ananthan <vasanth.a@samsung.com>
> ---
>  arch/arm/mach-exynos/include/mach/regs-pmu.h  |    3 +
>  arch/arm/mach-exynos/include/mach/regs-sata.h |   29 +++
>  drivers/ata/Makefile                          |    2 +-
>  drivers/ata/sata_exynos_phy.c                 |  265
> +++++++++++++++++++++++++
>  4 files changed, 298 insertions(+), 1 deletion(-)
>  create mode 100644 arch/arm/mach-exynos/include/mach/regs-sata.h

If this header file is used only for sata driver, this can be moved into
drivers/ata/.

>  create mode 100644 drivers/ata/sata_exynos_phy.c
> 
> diff --git a/arch/arm/mach-exynos/include/mach/regs-pmu.h
> b/arch/arm/mach-exynos/include/mach/regs-pmu.h
> index 3f30aa1..fd813d9 100644
> --- a/arch/arm/mach-exynos/include/mach/regs-pmu.h
> +++ b/arch/arm/mach-exynos/include/mach/regs-pmu.h
> @@ -369,4 +369,7 @@
> 
>  #define EXYNOS5_OPTION_USE_RETENTION				(1 <<
> 4)
> 
> +/* Only for EXYNOS5250 */
> +#define EXYNOS5_SATA_PHY_CONTROL
> 	S5P_PMUREG(0x0724)

This should be handled into the driver. Please don't make a dependency with
SoC for your driver.

[...]

> -obj-$(CONFIG_SATA_PHY)		+= sata_phy.o
> +obj-$(CONFIG_SATA_PHY)		+= sata_phy.o sata_exynos_phy.o

Do you _really_ want to build the sata_exynos_phy.c under CONFIG_SATA_PHY? I
don't think so.

[...]

Thanks.

- Kukjin
