From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: [PATCH] i.MX PATA cleanup and i.MX51 support
Date: Tue, 9 Apr 2013 09:41:35 +0200
Message-ID: <20130409074135.GB10373@pengutronix.de>
References: <1365067509-10186-1-git-send-email-s.hauer@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:47093 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751186Ab3DIHlj (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 9 Apr 2013 03:41:39 -0400
Content-Disposition: inline
In-Reply-To: <1365067509-10186-1-git-send-email-s.hauer@pengutronix.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org, Shawn Guo <shawn.guo@linaro.org>, linux-arm-kernel@lists.infradead.org

Hi Jeff,

Any comments to this series? Can you queue 1-4 for the next merge
window?

Sascha

On Thu, Apr 04, 2013 at 11:25:03AM +0200, Sascha Hauer wrote:
> The following contains some cleanup and devicetree support for the
> i.MX PATA driver. Also i.MX51 PATA support is added.
> 
> The first four patches should go via the ata tree, the others through
> arm-soc, they do not depend on each other.
> 
> Sascha
> 
> ----------------------------------------------------------------
> Sascha Hauer (6):
>       ata: i.MX PATA: Use devm_clk_get
>       ata: i.MX PATA: cleanup error path
>       ata: i.MX PATA: use void __iomem * for regs
>       ata: i.MX PATA: add devicetree support
>       ARM: i.MX5: Add PATA and SRTC clocks
>       ARM: i.MX51: Add PATA support
> 
>  Documentation/devicetree/bindings/ata/imx-pata.txt | 17 +++++++++
>  .../devicetree/bindings/clock/imx5-clock.txt       |  2 +
>  arch/arm/boot/dts/imx51.dtsi                       | 44 ++++++++++++++++++++++
>  arch/arm/mach-imx/clk-imx51-imx53.c                |  4 +-
>  drivers/ata/pata_imx.c                             | 36 +++++++++++++-----
>  5 files changed, 92 insertions(+), 11 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/ata/imx-pata.txt
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
