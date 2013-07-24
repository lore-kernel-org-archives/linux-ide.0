From: Tejun Heo <tj@kernel.org>
Subject: Re: [v8 3/3] ahci_imx: add ahci sata support on imx platforms
Date: Wed, 24 Jul 2013 12:30:38 -0400
Message-ID: <20130724163038.GF20377@mtj.dyndns.org>
References: <1374646529-24432-1-git-send-email-Hong-Xing.Zhu@freescale.com>
 <1374646529-24432-4-git-send-email-Hong-Xing.Zhu@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-gg0-f173.google.com ([209.85.161.173]:41931 "EHLO
	mail-gg0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754344Ab3GXQaq (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 24 Jul 2013 12:30:46 -0400
Received: by mail-gg0-f173.google.com with SMTP id k5so90194ggn.4
        for <linux-ide@vger.kernel.org>; Wed, 24 Jul 2013 09:30:43 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1374646529-24432-4-git-send-email-Hong-Xing.Zhu@freescale.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Richard Zhu <richard.zhuhongxing@gmail.com>
Cc: shawn.guo@linaro.org, linux-arm-kernel@lists.infradead.org, jgarzik@pobox.com, rob.herring@calxeda.com, s.hauer@pengutronix.de, linux-ide@vger.kernel.org, Richard Zhu <r65037@freescale.com>

On Wed, Jul 24, 2013 at 02:15:29PM +0800, Richard Zhu wrote:
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
> Reviewed-by: Shawn Guo <shawn.guo@linaro.org>

Applied 2-3 to libata/for-3.11-fixes with minor adjustments.

Thanks.

-- 
tejun
