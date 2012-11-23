From: Vasanth Ananthan <vasanthananthan@gmail.com>
Subject: Re: [PATCH v2 1/6] ARM: EXYNOS5: Clock settings for SATA and SATA PHY
Date: Fri, 23 Nov 2012 14:15:27 +0530
Message-ID: <CAK1UHixL5c5ybWmUH0zU5cs=stx8eH2r-rXuuZMSMcJj=ThDng@mail.gmail.com>
References: <1351612897-14923-1-git-send-email-vasanthananthan@gmail.com>
	<1351612897-14923-2-git-send-email-vasanthananthan@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-oa0-f46.google.com ([209.85.219.46]:61226 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758010Ab2KWIp2 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 23 Nov 2012 03:45:28 -0500
In-Reply-To: <1351612897-14923-2-git-send-email-vasanthananthan@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: ben-linux@fluff.org
Cc: linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-ide@vger.kernel.org, Thomas Abraham <thomas.abraham@linaro.org>, kgene.kim@samsung.com, jgarzik@pobox.com, linux@arm.linux.org.uk, linux-i2c@vger.kernel.org

Hi,

Missed to include Ben, for I2C patch, including him and copying others.

Thanks,
Vasanth.

On Tue, Oct 30, 2012 at 9:31 PM, Vasanth Ananthan
<vasanthananthan@gmail.com> wrote:
> This patch adds neccessary clock entries for SATA, SATA PHY and
> I2C_SATAPHY
>
> Signed-off-by: Vasanth Ananthan <vasanth.a@samsung.com>
> ---
>  arch/arm/mach-exynos/clock-exynos5.c |   21 ++++++++++++++++++---
>  1 files changed, 18 insertions(+), 3 deletions(-)
>
> diff --git a/arch/arm/mach-exynos/clock-exynos5.c b/arch/arm/mach-exynos/clock-exynos5.c
> index c44ca1e..124c54f 100644
> --- a/arch/arm/mach-exynos/clock-exynos5.c
> +++ b/arch/arm/mach-exynos/clock-exynos5.c
> @@ -651,15 +651,20 @@ static struct clk exynos5_init_clocks_off[] = {
>                 .ctrlbit        = (1 << 15),
>         }, {
>                 .name           = "sata",
> -               .devname        = "ahci",
> +               .devname        = "exynos5-sata",
> +               .parent         = &exynos5_clk_aclk_200.clk,
>                 .enable         = exynos5_clk_ip_fsys_ctrl,
>                 .ctrlbit        = (1 << 6),
>         }, {
> -               .name           = "sata_phy",
> +               .name           = "sata-phy",
> +               .devname        = "exynos5-sata-phy",
> +               .parent         = &exynos5_clk_aclk_200.clk,
>                 .enable         = exynos5_clk_ip_fsys_ctrl,
>                 .ctrlbit        = (1 << 24),
>         }, {
> -               .name           = "sata_phy_i2c",
> +               .name           = "i2c",
> +               .devname        = "exynos5-sata-phy-i2c",
> +               .parent         = &exynos5_clk_aclk_200.clk,
>                 .enable         = exynos5_clk_ip_fsys_ctrl,
>                 .ctrlbit        = (1 << 25),
>         }, {
> @@ -1226,6 +1231,16 @@ static struct clksrc_clk exynos5_clksrcs[] = {
>                 .reg_div = { .reg = EXYNOS5_CLKDIV_TOP0, .shift = 24, .size = 3 },
>         }, {
>                 .clk    = {
> +                       .name           = "sclk_sata",
> +                       .devname        = "exynos5-sata",
> +                       .enable         = exynos5_clksrc_mask_fsys_ctrl,
> +                       .ctrlbit        = (1 << 24),
> +               },
> +               .sources = &exynos5_clkset_aclk,
> +               .reg_src = { .reg = EXYNOS5_CLKSRC_FSYS, .shift = 24, .size = 1 },
> +               .reg_div = { .reg = EXYNOS5_CLKDIV_FSYS0, .shift = 20, .size = 4 },
> +       }, {
> +               .clk    = {
>                         .name           = "sclk_gscl_wrap",
>                         .devname        = "s5p-mipi-csis.0",
>                         .enable         = exynos5_clksrc_mask_gscl_ctrl,
> --
> 1.7.4.1
>



-- 
Regards,

Vasanth K A
