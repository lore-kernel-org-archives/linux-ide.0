From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH V3 1/3] ahci: imx: Explicitly clear
 IMX6Q_GPR13_SATA_MPLL_CLK_EN
Date: Fri, 29 Nov 2013 17:28:18 -0500
Message-ID: <20131129222818.GM21755@mtj.dyndns.org>
References: <1385369222-5288-1-git-send-email-marex@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qa0-f42.google.com ([209.85.216.42]:53726 "EHLO
	mail-qa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752054Ab3K2W2W (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 29 Nov 2013 17:28:22 -0500
Received: by mail-qa0-f42.google.com with SMTP id k4so2294623qaq.8
        for <linux-ide@vger.kernel.org>; Fri, 29 Nov 2013 14:28:21 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1385369222-5288-1-git-send-email-marex@denx.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Marek Vasut <marex@denx.de>
Cc: linux-arm-kernel@lists.infradead.org, Shawn Guo <shawn.guo@linaro.org>, Richard Zhu <r65037@freescale.com>, Linux-IDE <linux-ide@vger.kernel.org>

On Mon, Nov 25, 2013 at 09:47:00AM +0100, Marek Vasut wrote:
> We must clear this IMX6Q_GPR13_SATA_MPLL_CLK_EN bit on i.MX6Q, otherwise
> Linux will fail to find the attached drive on some boards.
> 
> This entire fix was:
> Reported-by: Eric Nelson <eric.nelson@boundarydevices.com>
> 
> Signed-off-by: Marek Vasut <marex@denx.de>
> Cc: Shawn Guo <shawn.guo@linaro.org>
> Cc: Richard Zhu <r65037@freescale.com>
> Cc: Tejun Heo <tj@kernel.org>
> Cc: Linux-IDE <linux-ide@vger.kernel.org>

There have been a lot of review activities on this series.  If you
guys more or less agree now, can you please reply with
acked/reviewed-by's?

Thanks.

-- 
tejun
