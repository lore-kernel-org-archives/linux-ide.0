From: Kukjin Kim <kgene.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: RE: [PATCH v2 1/6] ARM: EXYNOS5: Clock settings for SATA and SATA PHY
Date: Fri, 23 Nov 2012 18:19:09 +0900
Message-ID: <113401cdc95b$98767780$c9636680$%kim@samsung.com>
References: <1351612897-14923-1-git-send-email-vasanthananthan@gmail.com>
 <1351612897-14923-2-git-send-email-vasanthananthan@gmail.com>
 <CAK1UHixL5c5ybWmUH0zU5cs=stx8eH2r-rXuuZMSMcJj=ThDng@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-reply-to: <CAK1UHixL5c5ybWmUH0zU5cs=stx8eH2r-rXuuZMSMcJj=ThDng-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Content-language: ko
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: 'Vasanth Ananthan' <vasanthananthan-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-ide-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, 'Thomas Abraham' <thomas.abraham-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, jgarzik-e+AXbWqSrlAAvxtiuMwx3w@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-ide@vger.kernel.org

Vasanth Ananthan wrote:
> 
> Hi,
> 
> Missed to include Ben, for I2C patch, including him and copying others.
> 
Vasanth, you didn't my reply? I already applied this 1st and 2nd patches.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.

> 
> On Tue, Oct 30, 2012 at 9:31 PM, Vasanth Ananthan
> <vasanthananthan-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> > This patch adds neccessary clock entries for SATA, SATA PHY and
> > I2C_SATAPHY
> >
> > Signed-off-by: Vasanth Ananthan <vasanth.a-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
> > ---
> >  arch/arm/mach-exynos/clock-exynos5.c |   21 ++++++++++++++++++---
> >  1 files changed, 18 insertions(+), 3 deletions(-)
> >
> > diff --git a/arch/arm/mach-exynos/clock-exynos5.c b/arch/arm/mach-
> exynos/clock-exynos5.c
> > index c44ca1e..124c54f 100644
> > --- a/arch/arm/mach-exynos/clock-exynos5.c
> > +++ b/arch/arm/mach-exynos/clock-exynos5.c
> > @@ -651,15 +651,20 @@ static struct clk exynos5_init_clocks_off[] = {
> >                 .ctrlbit        = (1 << 15),
> >         }, {
> >                 .name           = "sata",
> > -               .devname        = "ahci",
> > +               .devname        = "exynos5-sata",
> > +               .parent         = &exynos5_clk_aclk_200.clk,
> >                 .enable         = exynos5_clk_ip_fsys_ctrl,
> >                 .ctrlbit        = (1 << 6),
> >         }, {
> > -               .name           = "sata_phy",
> > +               .name           = "sata-phy",
> > +               .devname        = "exynos5-sata-phy",
> > +               .parent         = &exynos5_clk_aclk_200.clk,
> >                 .enable         = exynos5_clk_ip_fsys_ctrl,
> >                 .ctrlbit        = (1 << 24),
> >         }, {
> > -               .name           = "sata_phy_i2c",
> > +               .name           = "i2c",
> > +               .devname        = "exynos5-sata-phy-i2c",
> > +               .parent         = &exynos5_clk_aclk_200.clk,
> >                 .enable         = exynos5_clk_ip_fsys_ctrl,
> >                 .ctrlbit        = (1 << 25),
> >         }, {
> > @@ -1226,6 +1231,16 @@ static struct clksrc_clk exynos5_clksrcs[] = {
> >                 .reg_div = { .reg = EXYNOS5_CLKDIV_TOP0, .shift = 24,
.size
> = 3 },
> >         }, {
> >                 .clk    = {
> > +                       .name           = "sclk_sata",
> > +                       .devname        = "exynos5-sata",
> > +                       .enable         = exynos5_clksrc_mask_fsys_ctrl,
> > +                       .ctrlbit        = (1 << 24),
> > +               },
> > +               .sources = &exynos5_clkset_aclk,
> > +               .reg_src = { .reg = EXYNOS5_CLKSRC_FSYS, .shift = 24,
.size
> = 1 },
> > +               .reg_div = { .reg = EXYNOS5_CLKDIV_FSYS0, .shift =
> 20, .size = 4 },
> > +       }, {
> > +               .clk    = {
> >                         .name           = "sclk_gscl_wrap",
> >                         .devname        = "s5p-mipi-csis.0",
> >                         .enable         = exynos5_clksrc_mask_gscl_ctrl,
> > --
> > 1.7.4.1
> >
> 
> 
> 
> --
