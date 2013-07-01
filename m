From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: [v2 4/4] sata: imx: add ahci sata support on imx platforms
Date: Mon, 1 Jul 2013 14:44:45 +0200
Message-ID: <20130701124445.GW516@pengutronix.de>
References: <1372672975-2997-1-git-send-email-r65037@freescale.com>
 <1372672975-2997-5-git-send-email-r65037@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:37029 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752752Ab3GAMpM (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 1 Jul 2013 08:45:12 -0400
Content-Disposition: inline
In-Reply-To: <1372672975-2997-5-git-send-email-r65037@freescale.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Richard Zhu <richard.zhuhongxing@gmail.com>
Cc: shawn.guo@linaro.org, linux-arm-kernel@lists.infradead.org, jgarzik@pobox.com, avorontsov@ru.mvista.com, rob.herring@calxeda.com, linux-ide@vger.kernel.org, Richard Zhu <r65037@freescale.com>

On Mon, Jul 01, 2013 at 06:02:55PM +0800, Richard Zhu wrote:
> imx6q contains one Synopsys AHCI SATA controller,
> But it can't shares ahci_platform driver with other
> controllers.
> Because there are some misalignments of the bits
> definitions of the HBA registers and the Vendor
> Specific registers
>  - CAP_SSS(bit20) of the HOST_CAP is writable, default
>  value is '0', should be configured to be '1'
>  - bit0 (only one AHCI SATA port on imx6q) of the
>  HOST_PORTS_IMPL should be set to be '1'.(default 0)
>  - One Vendor Specific register HOST_TIMER1MS(offset:0xe0)
>  should be configured regarding to the frequency of AHB
>  bus clock.
> 
> Setup its own ahci sata driver, enable the imx6q ahci
> sata support, and update the ahci sata binding document.
> 
> Signed-off-by: Richard Zhu <r65037@freescale.com>

Wait a minute. We suggested to add a i.MX specific ahci driver to put
the i.MX speicific setup in there. Now you really post a separate i.MX
driver, but instead of putting the setup in there, it's a nearly
identical copy of the generic driver *without* the setup and the setup
is still in arch/arm/. That doesn't make sense to me.

> + */
> +static int imx_sata_init(void __iomem *mmio)
> +{
> +	int ret;
> +	struct clk *ahb_clk;
> +
> +	ret = readl(mmio + HOST_CAP);
> +	if (!(ret & HOST_CAP_SSS))
> +		writel(ret |= HOST_CAP_SSS, mmio + HOST_CAP);
> +	ret = readl(mmio + HOST_PORTS_IMPL);
> +	if (!(ret & 0x1))
> +		writel((ret | 0x1), mmio + HOST_PORTS_IMPL);
> +	ahb_clk = clk_get_sys(NULL, "ahb");

use devm_clk_get

> +
> +	if (pdata && pdata->ata_port_info)
> +		pi = *pdata->ata_port_info;
> +
> +	hpriv = devm_kzalloc(dev, sizeof(*hpriv), GFP_KERNEL);
> +	if (!hpriv) {
> +		dev_err(dev, "can't alloc ahci_host_priv\n");
> +		return -ENOMEM;
> +	}
> +
> +	hpriv->flags |= (unsigned long)pi.private_data;
> +
> +	hpriv->mmio = devm_ioremap(dev, mem->start, resource_size(mem));
> +	if (!hpriv->mmio) {
> +		dev_err(dev, "can't map %pR\n", mem);
> +		return -ENOMEM;
> +	}
> +
> +	hpriv->clk = clk_get(dev, NULL);

devm_clk_get.

> +	if (IS_ERR(hpriv->clk)) {
> +		dev_err(dev, "can't get clock\n");

That's an error. You should react to it.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
