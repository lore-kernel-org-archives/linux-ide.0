From: Tejun Heo <tj@kernel.org>
Subject: Re: [RESEND PATCH 1/6] ahci: imx: Explicitly clear
 IMX6Q_GPR13_SATA_MPLL_CLK_EN
Date: Wed, 20 Nov 2013 10:13:09 -0500
Message-ID: <20131120151309.GC28946@htj.dyndns.org>
References: <1384942659-5362-1-git-send-email-marex@denx.de>
 <1384943242-8201-1-git-send-email-marex@denx.de>
 <20131120145907.GA28946@htj.dyndns.org>
 <201311201611.44120.marex@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yh0-f47.google.com ([209.85.213.47]:61554 "EHLO
	mail-yh0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751461Ab3KTPNO (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 20 Nov 2013 10:13:14 -0500
Received: by mail-yh0-f47.google.com with SMTP id 29so2247473yhl.6
        for <linux-ide@vger.kernel.org>; Wed, 20 Nov 2013 07:13:14 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <201311201611.44120.marex@denx.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Marek Vasut <marex@denx.de>
Cc: linux-arm-kernel@lists.infradead.org, Shawn Guo <shawn.guo@linaro.org>, Richard Zhu <r65037@freescale.com>, Linux-IDE <linux-ide@vger.kernel.org>

On Wed, Nov 20, 2013 at 04:11:43PM +0100, Marek Vasut wrote:
> It's already done in 2/6 of the series, I hope that is OK. Otherwise I can 
> separate this formating change from the 2/6 patch and shove it in front of this 
> one even. Which one do you prefer please?

Oops, sorry about missing that.  As long as the end result is correct,
I don't mind either way.

Thanks!

-- 
tejun
