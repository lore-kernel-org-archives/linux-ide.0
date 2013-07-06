From: Tejun Heo <tj@kernel.org>
Subject: Re: [v3 3/3] sata: imx: add ahci sata support on imx platforms
Date: Fri, 5 Jul 2013 19:07:37 -0700
Message-ID: <20130706020737.GA9029@mtj.dyndns.org>
References: <1373017942-12583-1-git-send-email-Hong-Xing.Zhu@freescale.com>
 <1373017942-12583-4-git-send-email-Hong-Xing.Zhu@freescale.com>
 <20130705174305.GA28088@mtj.dyndns.org>
 <0E83723C55F66F43A6041464FE31119D31432D@039-SN2MPN1-012.039d.mgd.msft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pd0-f182.google.com ([209.85.192.182]:39076 "EHLO
	mail-pd0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752528Ab3GFCHk (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 5 Jul 2013 22:07:40 -0400
Received: by mail-pd0-f182.google.com with SMTP id r10so2429858pdi.13
        for <linux-ide@vger.kernel.org>; Fri, 05 Jul 2013 19:07:39 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <0E83723C55F66F43A6041464FE31119D31432D@039-SN2MPN1-012.039d.mgd.msft.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Zhu Richard-R65037 <r65037@freescale.com>
Cc: Richard Zhu <richard.zhuhongxing@gmail.com>, "shawn.guo@linaro.org" <shawn.guo@linaro.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "jgarzik@pobox.com" <jgarzik@pobox.com>, "avorontsov@ru.mvista.com" <avorontsov@ru.mvista.com>, "rob.herring@calxeda.com" <rob.herring@calxeda.com>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

Hello,

On Sat, Jul 06, 2013 at 02:03:30AM +0000, Zhu Richard-R65037 wrote:
> [Richard] Just like what we dicussed in the previous v1/v2
> patch-set.  Shawn has the concerns that the IP speicific codes
> shouldn't be put in the platform level.  So he suggested that setup
> a stand-alone driver, contained the imx6q ahci sata specific codes,
> and re-use the generic ahci_platform driver as much as possible.
> This imx6q standalone ahci sata driver just registers the platform
> data, and the others would be handled by ahci_platform driver.

Oh, I'm not objecting to the ahci specific part not being in platform
code.  I'm wondering whether specific handling for imx6q can be
included into ahci_platform rather than being in its own driver.  It
just seems that there aren't too many differences.  I could be
misreading it so if there are enough differences to warrant a separate
driver, please enlighten me.

Thanks!

-- 
tejun
