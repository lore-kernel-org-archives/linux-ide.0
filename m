From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: [v4 3/3] sata: imx: add ahci sata support on imx platforms
Date: Thu, 11 Jul 2013 09:55:43 +0200
Message-ID: <20130711075543.GG14452@pengutronix.de>
References: <1373445355-11453-1-git-send-email-Hong-Xing.Zhu@freescale.com>
 <1373445355-11453-4-git-send-email-Hong-Xing.Zhu@freescale.com>
 <20130710210414.GK516@pengutronix.de>
 <0E83723C55F66F43A6041464FE31119D32AE6B@039-SN2MPN1-013.039d.mgd.msft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:47994 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754774Ab3GKH4B (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 11 Jul 2013 03:56:01 -0400
Content-Disposition: inline
In-Reply-To: <0E83723C55F66F43A6041464FE31119D32AE6B@039-SN2MPN1-013.039d.mgd.msft.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Zhu Richard-R65037 <r65037@freescale.com>
Cc: Richard Zhu <richard.zhuhongxing@gmail.com>, "shawn.guo@linaro.org" <shawn.guo@linaro.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "jgarzik@pobox.com" <jgarzik@pobox.com>, "tj@kernel.org" <tj@kernel.org>, "rob.herring@calxeda.com" <rob.herring@calxeda.com>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

Hi Richard,

On Thu, Jul 11, 2013 at 07:50:50AM +0000, Zhu Richard-R65037 wrote:
> Hi Sascha:
> Sorry to make a mess on the usage of the private data.
> The private data of "imx_ahci_pdev" platform device would be used to store ata_host point.
> I shouldn't set imxpriv to the private data of "imx_ahci_pdev", so do the wrong assignment of
> The private pointer of device.

Please allocate your private data along with the platform_device in the
probe function, then in the init callback you can use container_of() to
get a pointer to the data.
Also I would recommend you to request the necessary resources (clocks,
regmap) in the probe function and not in the init callback.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
