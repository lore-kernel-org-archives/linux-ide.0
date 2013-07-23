From: Tejun Heo <tj@kernel.org>
Subject: Re: [v3 3/3] sata: imx: add ahci sata support on imx platforms
Date: Tue, 23 Jul 2013 12:26:23 -0400
Message-ID: <20130723162623.GD21100@mtj.dyndns.org>
References: <1373017942-12583-1-git-send-email-Hong-Xing.Zhu@freescale.com>
 <1373017942-12583-4-git-send-email-Hong-Xing.Zhu@freescale.com>
 <20130705174305.GA28088@mtj.dyndns.org>
 <0E83723C55F66F43A6041464FE31119D31432D@039-SN2MPN1-012.039d.mgd.msft.net>
 <20130706020737.GA9029@mtj.dyndns.org>
 <0E83723C55F66F43A6041464FE31119D3441A3@039-SN2MPN1-011.039d.mgd.msft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yh0-f42.google.com ([209.85.213.42]:61032 "EHLO
	mail-yh0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932595Ab3GWQ0b (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 23 Jul 2013 12:26:31 -0400
Received: by mail-yh0-f42.google.com with SMTP id l109so477028yhq.1
        for <linux-ide@vger.kernel.org>; Tue, 23 Jul 2013 09:26:30 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <0E83723C55F66F43A6041464FE31119D3441A3@039-SN2MPN1-011.039d.mgd.msft.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Zhu Richard-R65037 <r65037@freescale.com>
Cc: Richard Zhu <richard.zhuhongxing@gmail.com>, "shawn.guo@linaro.org" <shawn.guo@linaro.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "jgarzik@pobox.com" <jgarzik@pobox.com>, "avorontsov@ru.mvista.com" <avorontsov@ru.mvista.com>, "rob.herring@calxeda.com" <rob.herring@calxeda.com>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

Hello,

On Mon, Jul 22, 2013 at 07:02:56AM +0000, Zhu Richard-R65037 wrote:
> Re-send this email to you and community.
> I'm afraid that you may be missed or don't receive it.

Sorry about the delay.  I was on the road.

> BTW, can you help to pick up the #2 and #3(reviewed and acked by Shawn) of the v7 patch-set of this serial?
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

Just one thing, can you please rename the driver to ahci_imx?  I'd
like to keep all ahci drivers with ahci prefix (yeah, there's already
an exception, I know).

Thanks.

-- 
tejun
