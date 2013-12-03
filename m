From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH V6 2/3] ahci: imx: Pull out the clock enable/disable calls
Date: Tue, 3 Dec 2013 07:42:01 -0500
Message-ID: <20131203124201.GF8277@htj.dyndns.org>
References: <1385369222-5288-1-git-send-email-marex@denx.de>
 <1385369222-5288-2-git-send-email-marex@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qe0-f49.google.com ([209.85.128.49]:56173 "EHLO
	mail-qe0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753628Ab3LCMmF (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 3 Dec 2013 07:42:05 -0500
Received: by mail-qe0-f49.google.com with SMTP id w7so14586352qeb.22
        for <linux-ide@vger.kernel.org>; Tue, 03 Dec 2013 04:42:04 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1385369222-5288-2-git-send-email-marex@denx.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Marek Vasut <marex@denx.de>
Cc: linux-arm-kernel@lists.infradead.org, Shawn Guo <shawn.guo@linaro.org>, Richard Zhu <r65037@freescale.com>, Linux-IDE <linux-ide@vger.kernel.org>

On Mon, Nov 25, 2013 at 09:47:01AM +0100, Marek Vasut wrote:
> The same code for enabling and disabling SATA clock was found in multiple
> places in the driver. Implement functions that enable/disable the SATA clock
> and use them in such places instead of duplicating the code.
> 
> Signed-off-by: Marek Vasut <marex@denx.de>
> Cc: Shawn Guo <shawn.guo@linaro.org>
> Cc: Richard Zhu <r65037@freescale.com>
> Cc: Tejun Heo <tj@kernel.org>
> Cc: Linux-IDE <linux-ide@vger.kernel.org>

Applied 2-3 to libata/for-3.14.

Thanks.

-- 
tejun
