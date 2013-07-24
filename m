From: Zhu Richard-R65037 <r65037@freescale.com>
Subject: RE: [v3 3/3] sata: imx: add ahci sata support on imx platforms
Date: Wed, 24 Jul 2013 02:21:18 +0000
Message-ID: <0E83723C55F66F43A6041464FE31119D34517C@039-SN2MPN1-011.039d.mgd.msft.net>
References: <1373017942-12583-1-git-send-email-Hong-Xing.Zhu@freescale.com>
 <1373017942-12583-4-git-send-email-Hong-Xing.Zhu@freescale.com>
 <20130705174305.GA28088@mtj.dyndns.org>
 <0E83723C55F66F43A6041464FE31119D31432D@039-SN2MPN1-012.039d.mgd.msft.net>
 <20130706020737.GA9029@mtj.dyndns.org>
 <0E83723C55F66F43A6041464FE31119D3441A3@039-SN2MPN1-011.039d.mgd.msft.net>
 <20130723162623.GD21100@mtj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-db8lp0184.outbound.messaging.microsoft.com ([213.199.154.184]:49069
	"EHLO db8outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750901Ab3GXCVX convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 23 Jul 2013 22:21:23 -0400
In-Reply-To: <20130723162623.GD21100@mtj.dyndns.org>
Content-Language: en-US
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Richard Zhu <richard.zhuhongxing@gmail.com>, "shawn.guo@linaro.org" <shawn.guo@linaro.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "jgarzik@pobox.com" <jgarzik@pobox.com>, "avorontsov@ru.mvista.com" <avorontsov@ru.mvista.com>, "rob.herring@calxeda.com" <rob.herring@calxeda.com>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

Hi Tejun:
Thanks a lot.

No problem, I can rename the driver from sata_imx to ahci_imx.

Best Regards
Richard Zhu


-----Original Message-----
From: Tejun Heo [mailto:htejun@gmail.com] On Behalf Of Tejun Heo
Sent: Wednesday, July 24, 2013 12:26 AM
To: Zhu Richard-R65037
Cc: Richard Zhu; shawn.guo@linaro.org; linux-arm-kernel@lists.infradead.org; jgarzik@pobox.com; avorontsov@ru.mvista.com; rob.herring@calxeda.com; s.hauer@pengutronix.de; linux-ide@vger.kernel.org
Subject: Re: [v3 3/3] sata: imx: add ahci sata support on imx platforms

Hello,

On Mon, Jul 22, 2013 at 07:02:56AM +0000, Zhu Richard-R65037 wrote:
> Re-send this email to you and community.
> I'm afraid that you may be missed or don't receive it.

Sorry about the delay.  I was on the road.

> BTW, can you help to pick up the #2 and #3(reviewed and acked by Shawn) of the v7 patch-set of this serial?
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

Just one thing, can you please rename the driver to ahci_imx?  I'd like to keep all ahci drivers with ahci prefix (yeah, there's already an exception, I know).

Thanks.

--
tejun


