From: Zhu Richard-R65037 <r65037@freescale.com>
Subject: RE: [v4 3/3] sata: imx: add ahci sata support on imx platforms
Date: Thu, 11 Jul 2013 09:07:36 +0000
Message-ID: <0E83723C55F66F43A6041464FE31119D32AF10@039-SN2MPN1-013.039d.mgd.msft.net>
References: <1373445355-11453-1-git-send-email-Hong-Xing.Zhu@freescale.com>
 <1373445355-11453-4-git-send-email-Hong-Xing.Zhu@freescale.com>
 <20130710210414.GK516@pengutronix.de>
 <0E83723C55F66F43A6041464FE31119D32AE6B@039-SN2MPN1-013.039d.mgd.msft.net>
 <20130711075543.GG14452@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from co9ehsobe005.messaging.microsoft.com ([207.46.163.28]:21260
	"EHLO co9outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755838Ab3GKJFp convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 11 Jul 2013 05:05:45 -0400
In-Reply-To: <20130711075543.GG14452@pengutronix.de>
Content-Language: en-US
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Richard Zhu <richard.zhuhongxing@gmail.com>, "shawn.guo@linaro.org" <shawn.guo@linaro.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "jgarzik@pobox.com" <jgarzik@pobox.com>, "tj@kernel.org" <tj@kernel.org>, "rob.herring@calxeda.com" <rob.herring@calxeda.com>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

Hi Sascha:
Thanks for your comments.
Yes, it is.
That's is what I done in the V5 patch-set. The patch-set is almost done, would send out a moment later.

Best Regards
Richard Zhu


-----Original Message-----
From: Sascha Hauer [mailto:s.hauer@pengutronix.de] 
Sent: Thursday, July 11, 2013 3:56 PM
To: Zhu Richard-R65037
Cc: Richard Zhu; shawn.guo@linaro.org; linux-arm-kernel@lists.infradead.org; jgarzik@pobox.com; tj@kernel.org; rob.herring@calxeda.com; linux-ide@vger.kernel.org
Subject: Re: [v4 3/3] sata: imx: add ahci sata support on imx platforms

Hi Richard,

On Thu, Jul 11, 2013 at 07:50:50AM +0000, Zhu Richard-R65037 wrote:
> Hi Sascha:
> Sorry to make a mess on the usage of the private data.
> The private data of "imx_ahci_pdev" platform device would be used to store ata_host point.
> I shouldn't set imxpriv to the private data of "imx_ahci_pdev", so do 
> the wrong assignment of The private pointer of device.

Please allocate your private data along with the platform_device in the probe function, then in the init callback you can use container_of() to get a pointer to the data.
Also I would recommend you to request the necessary resources (clocks,
regmap) in the probe function and not in the init callback.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |


