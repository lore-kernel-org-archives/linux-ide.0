From: Zhu Richard-R65037 <r65037@freescale.com>
Subject: RE: [v4 3/3] sata: imx: add ahci sata support on imx platforms
Date: Thu, 11 Jul 2013 07:50:50 +0000
Message-ID: <0E83723C55F66F43A6041464FE31119D32AE6B@039-SN2MPN1-013.039d.mgd.msft.net>
References: <1373445355-11453-1-git-send-email-Hong-Xing.Zhu@freescale.com>
 <1373445355-11453-4-git-send-email-Hong-Xing.Zhu@freescale.com>
 <20130710210414.GK516@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-db8lp0186.outbound.messaging.microsoft.com ([213.199.154.186]:39923
	"EHLO db8outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754162Ab3GKHsp convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 11 Jul 2013 03:48:45 -0400
In-Reply-To: <20130710210414.GK516@pengutronix.de>
Content-Language: en-US
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sascha Hauer <s.hauer@pengutronix.de>, Richard Zhu <richard.zhuhongxing@gmail.com>
Cc: "shawn.guo@linaro.org" <shawn.guo@linaro.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "jgarzik@pobox.com" <jgarzik@pobox.com>, "tj@kernel.org" <tj@kernel.org>, "rob.herring@calxeda.com" <rob.herring@calxeda.com>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

Hi Sascha:
Sorry to make a mess on the usage of the private data.
The private data of "imx_ahci_pdev" platform device would be used to store ata_host point.
I shouldn't set imxpriv to the private data of "imx_ahci_pdev", so do the wrong assignment of
The private pointer of device.

Best Regards
Richard Zhu


-----Original Message-----
From: Sascha Hauer [mailto:s.hauer@pengutronix.de] 
Sent: Thursday, July 11, 2013 5:04 AM
To: Richard Zhu
Cc: shawn.guo@linaro.org; linux-arm-kernel@lists.infradead.org; jgarzik@pobox.com; tj@kernel.org; rob.herring@calxeda.com; linux-ide@vger.kernel.org; Zhu Richard-R65037
Subject: Re: [v4 3/3] sata: imx: add ahci sata support on imx platforms

On Wed, Jul 10, 2013 at 04:35:55PM +0800, Richard Zhu wrote:
> From: Richard Zhu <r65037@freescale.com>
> 
> imx6q contains one Synopsys AHCI SATA controller, But it can't shares 
> ahci_platform driver with other controllers.
> Because there are some misalignments of the generic AHCI controller.
> The bits definitions of the HBA registers, the Vendor Specific 
> registers, and the AHCI PHY clock.
>  - CAP_SSS(bit20) of the HOST_CAP is writable, default  value is '0', 
> should be configured to be '1'
>  - bit0 (only one AHCI SATA port on imx6q) of the  HOST_PORTS_IMPL 
> should be set to be '1'.(default 0)
>  - One Vendor Specific register HOST_TIMER1MS(offset:0xe0)  should be 
> configured regarding to the frequency of AHB  bus clock.
>  - Configurations of the AHCI PHY clock, and the signal  parameters of 
> the GPR13
> 
> Setup its own ahci sata driver, contained the imx6q specific 
> initialized codes, and re-use the generic ahci_platform drier,
> 
> Signed-off-by: Richard Zhu <r65037@freescale.com>
> ---
>  drivers/ata/Kconfig    |    9 ++
>  drivers/ata/Makefile   |    1 +
>  drivers/ata/sata_imx.c |  237 
> ++++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 247 insertions(+), 0 deletions(-)  create mode 
> 100644 drivers/ata/sata_imx.c
> 

[...]

> +
> +/* imx6q ahci module initialization. */ static int 
> +imx6q_sata_init(struct device *dev, void __iomem *mmio) {
> +	int ret = 0;
> +	unsigned int rc;
> +	struct regmap *gpr;
> +	struct clk *ahb_clk;
> +	struct imx_ahci_priv *imxpriv = (struct imx_ahci_priv *)dev->p;

Just because a pointer points to valid memory doesn't mean that it's free to use for your purposes. If you look closer maybe you realize that the imxpriv pointer you use here is another one than the one you allocate below in your probe function.

I give up here. Maybe I'll write a driver for this when I find time for it.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |


