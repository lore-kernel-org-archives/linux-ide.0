From: Zhu Richard-R65037 <r65037@freescale.com>
Subject: RE: [v8 3/3] ahci_imx: add ahci sata support on imx platforms
Date: Thu, 25 Jul 2013 01:32:29 +0000
Message-ID: <0E83723C55F66F43A6041464FE31119D346BC3@039-SN2MPN1-011.039d.mgd.msft.net>
References: <1374646529-24432-1-git-send-email-Hong-Xing.Zhu@freescale.com>
 <1374646529-24432-4-git-send-email-Hong-Xing.Zhu@freescale.com>
 <20130724163038.GF20377@mtj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from co9ehsobe002.messaging.microsoft.com ([207.46.163.25]:37318
	"EHLO co9outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753983Ab3GYBdU convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 24 Jul 2013 21:33:20 -0400
In-Reply-To: <20130724163038.GF20377@mtj.dyndns.org>
Content-Language: en-US
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>, Richard Zhu <richard.zhuhongxing@gmail.com>
Cc: "shawn.guo@linaro.org" <shawn.guo@linaro.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "jgarzik@pobox.com" <jgarzik@pobox.com>, "rob.herring@calxeda.com" <rob.herring@calxeda.com>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

Thanks a lot. :).

Best Regards
Richard Zhu


-----Original Message-----
From: Tejun Heo [mailto:htejun@gmail.com] On Behalf Of Tejun Heo
Sent: Thursday, July 25, 2013 12:31 AM
To: Richard Zhu
Cc: shawn.guo@linaro.org; linux-arm-kernel@lists.infradead.org; jgarzik@pobox.com; rob.herring@calxeda.com; s.hauer@pengutronix.de; linux-ide@vger.kernel.org; Zhu Richard-R65037
Subject: Re: [v8 3/3] ahci_imx: add ahci sata support on imx platforms

On Wed, Jul 24, 2013 at 02:15:29PM +0800, Richard Zhu wrote:
> From: Richard Zhu <r65037@freescale.com>
> 
> imx6q contains one Synopsys AHCI SATA controller, But it can't share 
> ahci_platform driver with other controllers.
> Because there are some misalignments of the generic AHCI controller.
> The bits definitions of the HBA registers, the Vendor Specific 
> registers, the AHCI PHY clock and the AHCI signals adjustment 
> window(GPR13 register).
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
> initialized codes, re-use the generic ahci_platform driver, and keep 
> the generic ahci_platform driver clean as much as possible.
> 
> Signed-off-by: Richard Zhu <r65037@freescale.com>
> Reviewed-by: Shawn Guo <shawn.guo@linaro.org>

Applied 2-3 to libata/for-3.11-fixes with minor adjustments.

Thanks.

--
tejun


