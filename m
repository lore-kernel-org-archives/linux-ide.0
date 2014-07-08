From: Andrew Bresticker <abrestic@chromium.org>
Subject: Re: [PATCH v2 4/7] clk: tegra: Enable hardware control of SATA PLL
Date: Mon, 7 Jul 2014 18:26:33 -0700
Message-ID: <CAL1qeaHo_HEoXoCQjQuqux_BNPtz4BtOnrYTa4=vcNQCYxiDSg@mail.gmail.com>
References: <1403101406-15439-1-git-send-email-mperttunen@nvidia.com>
	<1403101406-15439-5-git-send-email-mperttunen@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-lb0-f176.google.com ([209.85.217.176]:52340 "EHLO
	mail-lb0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753595AbaGHB0g (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 7 Jul 2014 21:26:36 -0400
Received: by mail-lb0-f176.google.com with SMTP id w7so3413764lbi.21
        for <linux-ide@vger.kernel.org>; Mon, 07 Jul 2014 18:26:34 -0700 (PDT)
In-Reply-To: <1403101406-15439-5-git-send-email-mperttunen@nvidia.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mikko Perttunen <mperttunen@nvidia.com>
Cc: Stephen Warren <swarren@wwwdotorg.org>, Thierry Reding <thierry.reding@gmail.com>, Tejun Heo <tj@kernel.org>, Peter De Schrijver <pdeschrijver@nvidia.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>, linux-ide@vger.kernel.org

On Wed, Jun 18, 2014 at 7:23 AM, Mikko Perttunen <mperttunen@nvidia.com> wrote:
> This makes the SATA PLL be controlled by hardware instead of software.
> This is required for working SATA support.
>
> Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
> Acked-by: Stephen Warren <swarren@nvidia.com>

I know Peter sent a pull request including this patch already, but I
don't see it yet in Mike's tree, so perhaps it's possible to address
my comment below (or else I'll include it in the next spin of my XUSB
series.

> diff --git a/drivers/clk/tegra/clk-pll.c b/drivers/clk/tegra/clk-pll.c

> @@ -1361,6 +1364,11 @@ static int clk_plle_tegra114_enable(struct clk_hw *hw)
>         val |= XUSBIO_PLL_CFG0_SEQ_ENABLE;
>         pll_writel(val, XUSBIO_PLL_CFG0, pll);
>
> +       /* Enable hw control of SATA pll */
> +       val = pll_readl(SATA_PLL_CFG0, pll);
> +       val &= ~SATA_PLL_CFG0_PADPLL_RESET_SWCTL;
> +       pll_writel(val, SATA_PLL_CFG0, pll);
> +

Apparently the procedure for enabling the SATA PLL for XUSB (when the
SATA lane is used) is slightly different.  Specifically, it would be:

val = pll_readl(SATA_PLL_CFG0, pll);
val &= ~SATA_PLL_CFG0_PADPLL_RESET_SWCTL;
val |= SATA_PLL_CFG0_PADPLL_USE_LOCKDET;
val |= SATA_PLL_CFG0_SEQ_START_STATE;
pll_writel(val, SATA_PLL_CFG0, pll);

udelay(1);

val = pll_readl(SATA_PLL_CFG0, pll);
val |= SATA_PLL_CFG0_SEQ_ENABLE;
pll_writel(val, SATA_PLL_CFG0, pll);

Do you know if this sequence also works when the SATA lane is used for SATA?
