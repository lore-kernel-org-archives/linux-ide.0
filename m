From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [v7 3/3] sata: imx: add ahci sata support on imx platforms
Date: Tue, 16 Jul 2013 11:37:15 +0800
Message-ID: <20130716033711.GF28375@S2101-09.ap.freescale.net>
References: <1373945328-20893-1-git-send-email-Hong-Xing.Zhu@freescale.com>
 <1373945328-20893-4-git-send-email-Hong-Xing.Zhu@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from co9ehsobe001.messaging.microsoft.com ([207.46.163.24]:38533
	"EHLO co9outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758521Ab3GPDhR (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 15 Jul 2013 23:37:17 -0400
Content-Disposition: inline
In-Reply-To: <1373945328-20893-4-git-send-email-Hong-Xing.Zhu@freescale.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Richard Zhu <richard.zhuhongxing@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, jgarzik@pobox.com, tj@kernel.org, rob.herring@calxeda.com, s.hauer@pengutronix.de, linux-ide@vger.kernel.org, Richard Zhu <r65037@freescale.com>

On Tue, Jul 16, 2013 at 11:28:48AM +0800, Richard Zhu wrote:
> From: Richard Zhu <r65037@freescale.com>
> 
> imx6q contains one Synopsys AHCI SATA controller,
> But it can't share ahci_platform driver with other
> controllers.
> Because there are some misalignments of the generic
> AHCI controller.
> The bits definitions of the HBA registers, the Vendor
> Specific registers, the AHCI PHY clock and the AHCI
> signals adjustment window(GPR13 register).
>  - CAP_SSS(bit20) of the HOST_CAP is writable, default
>  value is '0', should be configured to be '1'
>  - bit0 (only one AHCI SATA port on imx6q) of the
>  HOST_PORTS_IMPL should be set to be '1'.(default 0)
>  - One Vendor Specific register HOST_TIMER1MS(offset:0xe0)
>  should be configured regarding to the frequency of AHB
>  bus clock.
>  - Configurations of the AHCI PHY clock, and the signal
>  parameters of the GPR13
> 
> Setup its own ahci sata driver, contained the imx6q specific
> initialized codes, re-use the generic ahci_platform driver, and
> keep the generic ahci_platform driver clean as much as possible.
> 
> Signed-off-by: Richard Zhu <r65037@freescale.com>

Reviewed-by: Shawn Guo <shawn.guo@linaro.org>

