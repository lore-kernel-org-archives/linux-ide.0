From: Zhu Richard-R65037 <r65037@freescale.com>
Subject: RE: Re[2]: [v3 3/3] sata: imx: add ahci sata support on imx
 platforms
Date: Sat, 6 Jul 2013 01:55:19 +0000
Message-ID: <0E83723C55F66F43A6041464FE31119D31430A@039-SN2MPN1-012.039d.mgd.msft.net>
References: <1373017942-12583-1-git-send-email-Hong-Xing.Zhu@freescale.com>
 <1373017942-12583-4-git-send-email-Hong-Xing.Zhu@freescale.com>
 <20130705155911.GK516@pengutronix.de>,<1373040406.217809169@f299.mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ch1ehsobe004.messaging.microsoft.com ([216.32.181.184]:55332
	"EHLO ch1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752501Ab3GFBzY convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 5 Jul 2013 21:55:24 -0400
In-Reply-To: <1373040406.217809169@f299.mail.ru>
Content-Language: en-US
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alexander Shiyan <shc_work@mail.ru>, Sascha Hauer <s.hauer@pengutronix.de>
Cc: Richard Zhu <richard.zhuhongxing@gmail.com>, "shawn.guo@linaro.org" <shawn.guo@linaro.org>, "rob.herring@calxeda.com" <rob.herring@calxeda.com>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, "avorontsov@ru.mvista.com" <avorontsov@ru.mvista.com>, "jgarzik@pobox.com" <jgarzik@pobox.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Hi Alexander:
Thanks for your comments.

Best Regards
Richard Zhu
________________________________________
From: Alexander Shiyan [shc_work@mail.ru]
Sent: Saturday, July 06, 2013 12:06 AM
To: Sascha Hauer
Cc: Richard Zhu; Zhu Richard-R65037; shawn.guo@linaro.org; rob.herring@calxeda.com; linux-ide@vger.kernel.org; avorontsov@ru.mvista.com; jgarzik@pobox.com; linux-arm-kernel@lists.infradead.org
Subject: Re[2]: [v3 3/3] sata: imx: add ahci sata support on imx platforms

> On Fri, Jul 05, 2013 at 05:52:22PM +0800, Richard Zhu wrote:
> > From: Richard Zhu <r65037@freescale.com>
...
> > +   if (!(ret & HOST_CAP_SSS))
> > +           writel(ret |= HOST_CAP_SSS, mmio + HOST_CAP);
>
> Why do you write this conditionally? Just write it unconditionally.

"writel" with assignment is incorrect in any case.
[Richard] would be fixed later.

---

