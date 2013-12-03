From: Marek Vasut <marex@denx.de>
Subject: Re: [PATCH V3 1/3] ahci: imx: Explicitly clear IMX6Q_GPR13_SATA_MPLL_CLK_EN
Date: Tue, 3 Dec 2013 14:41:35 +0100
Message-ID: <201312031441.35741.marex@denx.de>
References: <1385369222-5288-1-git-send-email-marex@denx.de> <20131203124140.GE8277@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.10]:49250 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752485Ab3LCNlu (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 3 Dec 2013 08:41:50 -0500
In-Reply-To: <20131203124140.GE8277@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, Shawn Guo <shawn.guo@linaro.org>, Richard Zhu <r65037@freescale.com>, Linux-IDE <linux-ide@vger.kernel.org>

Dear Tejun Heo,

> On Mon, Nov 25, 2013 at 09:47:00AM +0100, Marek Vasut wrote:
> > We must clear this IMX6Q_GPR13_SATA_MPLL_CLK_EN bit on i.MX6Q, otherwise
> > Linux will fail to find the attached drive on some boards.
> > 
> > This entire fix was:
> > Reported-by: Eric Nelson <eric.nelson@boundarydevices.com>
> > 
> > Signed-off-by: Marek Vasut <marex@denx.de>
> > Cc: Shawn Guo <shawn.guo@linaro.org>
> > Cc: Richard Zhu <r65037@freescale.com>
> > Cc: Tejun Heo <tj@kernel.org>
> > Cc: Linux-IDE <linux-ide@vger.kernel.org>
> 
> Applied to libata/for-3.13-fixes w/ stable cc'd.

Thank you!

Best regards,
Marek Vasut
