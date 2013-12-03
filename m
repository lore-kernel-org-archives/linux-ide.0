From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH V3 1/3] ahci: imx: Explicitly clear
 IMX6Q_GPR13_SATA_MPLL_CLK_EN
Date: Tue, 3 Dec 2013 07:41:40 -0500
Message-ID: <20131203124140.GE8277@htj.dyndns.org>
References: <1385369222-5288-1-git-send-email-marex@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qa0-f43.google.com ([209.85.216.43]:46382 "EHLO
	mail-qa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752948Ab3LCMlp (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 3 Dec 2013 07:41:45 -0500
Received: by mail-qa0-f43.google.com with SMTP id ii20so5498271qab.2
        for <linux-ide@vger.kernel.org>; Tue, 03 Dec 2013 04:41:45 -0800 (PST)
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

Applied to libata/for-3.13-fixes w/ stable cc'd.

Thanks.

-- 
tejun
