From: Marek Vasut <marex@denx.de>
Subject: Re: [RESEND PATCH 1/6] ahci: imx: Explicitly clear IMX6Q_GPR13_SATA_MPLL_CLK_EN
Date: Fri, 22 Nov 2013 11:47:57 +0100
Message-ID: <201311221147.57362.marex@denx.de>
References: <1384942659-5362-1-git-send-email-marex@denx.de> <201311201611.44120.marex@denx.de> <20131120151309.GC28946@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.10]:39977 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753238Ab3KVKsD (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 22 Nov 2013 05:48:03 -0500
In-Reply-To: <20131120151309.GC28946@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, Shawn Guo <shawn.guo@linaro.org>, Richard Zhu <r65037@freescale.com>, Linux-IDE <linux-ide@vger.kernel.org>

Dear Tejun Heo,

> On Wed, Nov 20, 2013 at 04:11:43PM +0100, Marek Vasut wrote:
> > It's already done in 2/6 of the series, I hope that is OK. Otherwise I
> > can separate this formating change from the 2/6 patch and shove it in
> > front of this one even. Which one do you prefer please?
> 
> Oops, sorry about missing that.  As long as the end result is correct,
> I don't mind either way.

OK, I will leave that as is since it is fixed in 2/6. Thanks!

Best regards,
Marek Vasut
