From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] ahci: imx: PLL clock needs 100us to settle down
Date: Mon, 19 May 2014 16:09:00 -0400
Message-ID: <20140519200900.GB27506@mtj.dyndns.org>
References: <1400330761-2432-1-git-send-email-shawn.guo@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qc0-f171.google.com ([209.85.216.171]:62314 "EHLO
	mail-qc0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751291AbaESUJE (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 19 May 2014 16:09:04 -0400
Received: by mail-qc0-f171.google.com with SMTP id x13so9841256qcv.16
        for <linux-ide@vger.kernel.org>; Mon, 19 May 2014 13:09:04 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1400330761-2432-1-git-send-email-shawn.guo@freescale.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Shawn Guo <shawn.guo@freescale.com>
Cc: linux-ide@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Sat, May 17, 2014 at 08:46:01PM +0800, Shawn Guo wrote:
> The commit e783c51 (ahci: imx: software workaround for phy reset issue
> in resume) calls imx_sata_phy_reset() to reset phy immediately after
> SATA MPLL is enabled.  It seems working fine mostly, but fails in some
> case as below.
> 
> ...
> ahci-imx 2200000.sata: failed to reset phy: -110
> ahci-imx: probe of 2200000.sata failed with error -110
> 
> After talking to the designer, we learnt that when enabling i.MX6Q SATA
> MPLL, we need to wait 100us for it to settle down for safety.  Add this
> required delay to fix above failure.
> 
> Signed-off-by: Shawn Guo <shawn.guo@freescale.com>

Applied to libata/for-3.15-fixes.

Thanks.

-- 
tejun
