From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH V2 1/6] ahci: imx: Explicitly clear
 IMX6Q_GPR13_SATA_MPLL_CLK_EN
Date: Mon, 25 Nov 2013 15:24:14 +0800
Message-ID: <20131125072412.GG11613@S2101-09.ap.freescale.net>
References: <1385118304-27435-1-git-send-email-marex@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from co1ehsobe003.messaging.microsoft.com ([216.32.180.186]:20505
	"EHLO co1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751778Ab3KYHVx (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 25 Nov 2013 02:21:53 -0500
Content-Disposition: inline
In-Reply-To: <1385118304-27435-1-git-send-email-marex@denx.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Marek Vasut <marex@denx.de>
Cc: linux-arm-kernel@lists.infradead.org, Richard Zhu <r65037@freescale.com>, Tejun Heo <tj@kernel.org>, Linux-IDE <linux-ide@vger.kernel.org>

On Fri, Nov 22, 2013 at 12:04:59PM +0100, Marek Vasut wrote:
> We must clear this IMX6Q_GPR13_SATA_MPLL_CLK_EN bit on i.MX6Q, otherwise
> Linux will fail to find the attached drive on some boards.
> 
> This entire fix was:
> Reported-by: Eric Nelson <eric.nelson@boundarydevices.com>
> 
> Signed-off-by: Marek Vasut <marex@denx.de>
> Cc: Shawn Guo <shawn.guo@linaro.org>

For patches 1 ~ 3, other than the error that Troy pointed out,

Reviewed-by: Shawn Guo <shawn.guo@linaro.org>

> Cc: Richard Zhu <r65037@freescale.com>
> Cc: Tejun Heo <tj@kernel.org>
> Cc: Linux-IDE <linux-ide@vger.kernel.org>

