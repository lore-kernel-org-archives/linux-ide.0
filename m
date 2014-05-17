From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH] ahci: imx: PLL clock needs 100us to settle down
Date: Sat, 17 May 2014 10:58:20 -0300
Message-ID: <CAOMZO5BDg1g=Gr6o8kW3X--ZajBsKZcKwSmse7374tC2e=ju1A@mail.gmail.com>
References: <1400330761-2432-1-git-send-email-shawn.guo@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ve0-f174.google.com ([209.85.128.174]:40221 "EHLO
	mail-ve0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756421AbaEQN6V (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 17 May 2014 09:58:21 -0400
Received: by mail-ve0-f174.google.com with SMTP id jw12so4493770veb.19
        for <linux-ide@vger.kernel.org>; Sat, 17 May 2014 06:58:20 -0700 (PDT)
In-Reply-To: <1400330761-2432-1-git-send-email-shawn.guo@freescale.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Shawn Guo <shawn.guo@freescale.com>
Cc: Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Sat, May 17, 2014 at 9:46 AM, Shawn Guo <shawn.guo@freescale.com> wrote:
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

On my sabresd board that was not connected to any sata disk I was
always getting the 'failed to reset phy' error.

With this patch the error goes away and the driver probes successfully.

Tested-by: Fabio Estevam <fabio.estevam@freescale.com>
