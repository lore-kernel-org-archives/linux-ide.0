From: Tejun Heo <tj@kernel.org>
Subject: Re: [v3 3/3] sata: imx: add ahci sata support on imx platforms
Date: Fri, 5 Jul 2013 10:43:05 -0700
Message-ID: <20130705174305.GA28088@mtj.dyndns.org>
References: <1373017942-12583-1-git-send-email-Hong-Xing.Zhu@freescale.com>
 <1373017942-12583-4-git-send-email-Hong-Xing.Zhu@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ve0-f171.google.com ([209.85.128.171]:39818 "EHLO
	mail-ve0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752029Ab3GERnM (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 5 Jul 2013 13:43:12 -0400
Received: by mail-ve0-f171.google.com with SMTP id b10so1986750vea.30
        for <linux-ide@vger.kernel.org>; Fri, 05 Jul 2013 10:43:12 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1373017942-12583-4-git-send-email-Hong-Xing.Zhu@freescale.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Richard Zhu <richard.zhuhongxing@gmail.com>
Cc: shawn.guo@linaro.org, linux-arm-kernel@lists.infradead.org, jgarzik@pobox.com, avorontsov@ru.mvista.com, rob.herring@calxeda.com, s.hauer@pengutronix.de, linux-ide@vger.kernel.org, Richard Zhu <r65037@freescale.com>

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

Thanks.

-- 
tejun
