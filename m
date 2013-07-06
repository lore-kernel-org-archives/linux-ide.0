From: Zhu Richard-R65037 <r65037@freescale.com>
Subject: RE: [v3 3/3] sata: imx: add ahci sata support on imx platforms
Date: Sat, 6 Jul 2013 02:03:30 +0000
Message-ID: <0E83723C55F66F43A6041464FE31119D31432D@039-SN2MPN1-012.039d.mgd.msft.net>
References: <1373017942-12583-1-git-send-email-Hong-Xing.Zhu@freescale.com>
 <1373017942-12583-4-git-send-email-Hong-Xing.Zhu@freescale.com>,<20130705174305.GA28088@mtj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from co1ehsobe006.messaging.microsoft.com ([216.32.180.189]:41143
	"EHLO co1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752528Ab3GFCDf convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 5 Jul 2013 22:03:35 -0400
In-Reply-To: <20130705174305.GA28088@mtj.dyndns.org>
Content-Language: en-US
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>, Richard Zhu <richard.zhuhongxing@gmail.com>
Cc: "shawn.guo@linaro.org" <shawn.guo@linaro.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "jgarzik@pobox.com" <jgarzik@pobox.com>, "avorontsov@ru.mvista.com" <avorontsov@ru.mvista.com>, "rob.herring@calxeda.com" <rob.herring@calxeda.com>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

Hi Tejun:
Thanks for your comments.

Best Regards
Richard Zhu
________________________________________
From: linux-ide-owner@vger.kernel.org [linux-ide-owner@vger.kernel.org] on behalf of Tejun Heo [tj@kernel.org]
Sent: Saturday, July 06, 2013 1:43 AM
To: Richard Zhu
Cc: shawn.guo@linaro.org; linux-arm-kernel@lists.infradead.org; jgarzik@pobox.com; avorontsov@ru.mvista.com; rob.herring@calxeda.com; s.hauer@pengutronix.de; linux-ide@vger.kernel.org; Zhu Richard-R65037
Subject: Re: [v3 3/3] sata: imx: add ahci sata support on imx platforms

Hello,

On Fri, Jul 05, 2013 at 05:52:22PM +0800, Richard Zhu wrote:
>  - CAP_SSS(bit20) of the HOST_CAP is writable, default
>  value is '0', should be configured to be '1'
>  - bit0 (only one AHCI SATA port on imx6q) of the
>  HOST_PORTS_IMPL should be set to be '1'.(default 0)
>  - One Vendor Specific register HOST_TIMER1MS(offset:0xe0)
>  should be configured regarding to the frequency of AHB
>  bus clock.
>  - Configurations of the AHCI PHY clock, and the signal
>  parameters of the GPR13

Can't you just add a platform specific init callback to ahci_platform?
I don't see how these small differences in init sequence justify a
separate driver.
[Richard] Just like what we dicussed in the previous v1/v2 patch-set.
Shawn has the concerns that the IP speicific codes shouldn't be put in the platform level.
So he suggested that setup a stand-alone driver, contained the imx6q ahci sata specific
codes, and re-use the generic ahci_platform driver as much as possible.
This imx6q standalone ahci sata driver just registers the platform data, and the others would be handled
by ahci_platform driver.

Thanks.

--
tejun
--
To unsubscribe from this list: send the line "unsubscribe linux-ide" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html


