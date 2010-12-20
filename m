From: Anton Vorontsov <cbouatmailru@gmail.com>
Subject: Re: [PATCH 1/1] ARM: cns3xxx: ahci: Fixup for softwreset failures
 with direct connected disks with CONFIG_SATA_PMP enabled.
Date: Mon, 20 Dec 2010 20:02:17 +0300
Message-ID: <20101220170217.GA1333@oksana.dev.rtsoft.ru>
References: <1291481021-23317-1-git-send-email-mkl0301@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ey0-f171.google.com ([209.85.215.171]:64575 "EHLO
	mail-ey0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932922Ab0LTRCW (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 20 Dec 2010 12:02:22 -0500
Received: by eyg5 with SMTP id 5so1580265eyg.2
        for <linux-ide@vger.kernel.org>; Mon, 20 Dec 2010 09:02:21 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1291481021-23317-1-git-send-email-mkl0301@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: mkl0301@gmail.com
Cc: htejun@gmail.com, linux-arm-kernel@lists.infradead.org, jgarzik@pobox.com, linux-ide@vger.kernel.org

On Sun, Dec 05, 2010 at 12:43:41AM +0800, mkl0301@gmail.com wrote:
[...]

Thanks for the patch!

There are few issues though.

> +static int cns3xxx_ahci_init(struct device *dev, void __iomem *addr)
> +{
> +	u32 tmp;
> +
> +	DPRINTK("ENTER\n");
> +
> +	tmp = __raw_readl(MISC_SATA_POWER_MODE);
> +	tmp |= 0x1 << 16; /* Disable SATA PHY 0 from SLUMBER Mode */
> +	tmp |= 0x1 << 17; /* Disable SATA PHY 1 from SLUMBER Mode */
> +	__raw_writel(tmp, MISC_SATA_POWER_MODE);
> +
> +	/* Enable SATA PHY */
> +	cns3xxx_pwr_power_up(0x1 << PM_PLL_HM_PD_CTRL_REG_OFFSET_SATA_PHY0);
> +	cns3xxx_pwr_power_up(0x1 << PM_PLL_HM_PD_CTRL_REG_OFFSET_SATA_PHY1);
> +
> +	/* Enable SATA Clock */
> +	cns3xxx_pwr_clk_en(0x1 << PM_CLK_GATE_REG_OFFSET_SATA);
> +
> +	/* De-Asscer SATA Reset */
> +	cns3xxx_pwr_soft_rst(CNS3XXX_PWR_SOFTWARE_RST(SATA));
> +
> +	return 0;
> +}
> +
[...]
> -void __init cns3xxx_ahci_init(void)
> -{
> -	u32 tmp;
> -
> -	tmp = __raw_readl(MISC_SATA_POWER_MODE);
> -	tmp |= 0x1 << 16; /* Disable SATA PHY 0 from SLUMBER Mode */
> -	tmp |= 0x1 << 17; /* Disable SATA PHY 1 from SLUMBER Mode */
> -	__raw_writel(tmp, MISC_SATA_POWER_MODE);
> -
> -	/* Enable SATA PHY */
> -	cns3xxx_pwr_power_up(0x1 << PM_PLL_HM_PD_CTRL_REG_OFFSET_SATA_PHY0);
> -	cns3xxx_pwr_power_up(0x1 << PM_PLL_HM_PD_CTRL_REG_OFFSET_SATA_PHY1);
> -
> -	/* Enable SATA Clock */
> -	cns3xxx_pwr_clk_en(0x1 << PM_CLK_GATE_REG_OFFSET_SATA);
> -
> -	/* De-Asscer SATA Reset */
> -	cns3xxx_pwr_soft_rst(CNS3XXX_PWR_SOFTWARE_RST(SATA));
> -
> -	platform_device_register(&cns3xxx_ahci_pdev);
> -}

This is not good because cns3xxx_pwr_*() calls aren't thread-safe.
We must use them only from the "single-threaded" platform code,
i.e. very early.

Once we add proper clocks (clkapi) and power management (regulators)
support for CNS3xxx, we may move this into ahci->init() callback.

Plus, unfortunately this patch breaks build when AHCI_PLATFORM is
set to =m.

arch/arm/mach-cns3xxx/built-in.o: In function 'cns3xxx_ahci_softreset':
cns3420vb.c:(.text+0x36c): undefined reference to 'ahci_do_softreset'
cns3420vb.c:(.text+0x390): undefined reference to 'ahci_do_softreset'
cns3420vb.c:(.text+0x3a0): undefined reference to 'ahci_check_ready'
arch/arm/mach-cns3xxx/built-in.o:(.data+0x35c): undefined reference to 'ahci_ops'
make: *** [.tmp_vmlinux1] Error 1
