From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH V2 4/6] ARM: imx: imx53: Add SATA PHY clock
Date: Mon, 25 Nov 2013 15:21:09 +0800
Message-ID: <20131125072108.GF11613@S2101-09.ap.freescale.net>
References: <1385118304-27435-1-git-send-email-marex@denx.de>
 <1385118304-27435-4-git-send-email-marex@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from co9ehsobe003.messaging.microsoft.com ([207.46.163.26]:55595
	"EHLO co9outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751668Ab3KYHSq (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 25 Nov 2013 02:18:46 -0500
Content-Disposition: inline
In-Reply-To: <1385118304-27435-4-git-send-email-marex@denx.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Marek Vasut <marex@denx.de>
Cc: linux-arm-kernel@lists.infradead.org, Richard Zhu <r65037@freescale.com>, Tejun Heo <tj@kernel.org>, Linux-IDE <linux-ide@vger.kernel.org>

On Fri, Nov 22, 2013 at 12:05:02PM +0100, Marek Vasut wrote:
> Add SATA PHY clock which are derived from the USB PHY1 clock. Note that this
> patch derives the SATA PHY clock from USB PHY1 clock gate so that the SATA
> driver can ungate both the SATA PHY clock and USB PHY1 clock for the SATA to
> work correctly.
> 
> Signed-off-by: Marek Vasut <marex@denx.de>
> Cc: Shawn Guo <shawn.guo@linaro.org>
> Cc: Richard Zhu <r65037@freescale.com>
> Cc: Tejun Heo <tj@kernel.org>
> Cc: Linux-IDE <linux-ide@vger.kernel.org>

Applied patches #4, #5 and #6.

Shawn

