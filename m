Return-Path: <SRS0=xCVQ=7P=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CE59C433E0
	for <linux-ide@archiver.kernel.org>; Tue,  2 Jun 2020 08:20:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4909D207DA
	for <linux-ide@archiver.kernel.org>; Tue,  2 Jun 2020 08:20:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="FdZyRvUS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726023AbgFBIUD (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 2 Jun 2020 04:20:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725811AbgFBIUC (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 2 Jun 2020 04:20:02 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77791C061A0E
        for <linux-ide@vger.kernel.org>; Tue,  2 Jun 2020 01:20:02 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id r7so2436447wro.1
        for <linux-ide@vger.kernel.org>; Tue, 02 Jun 2020 01:20:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=ucrKANAavc1NtdTnXRC9YmP/hh/YfnXjx8eiS0Iol/Q=;
        b=FdZyRvUSL0wlJKAQLjX0RYOmaRlwJyOk9yFO3Oj3DuhLsONvhCZMZhZmgfWfkDNdPr
         7ww5coZ4a9/fvqiXRA+HEk+RzYDBJfPSVHzZ/0q/S1HUbZsW2XRMz4ZucaF3OlJP7ozC
         62sFDvx+ak+W1cfo1UyseCBnmQ/Tvj3gddBViTbO4PA8gDcity8HtsGNjpiMTIPxgqAy
         ObsSCga5PAIOjZwwIASDczGbpG54ciygDdrRDJiv9jQL2EV4dEbnnZM9M4mxVflaUa7O
         ZXgbRyp0bfb+67lZs9WhO0x6ZiNF5PS7DeYvYHLZJb/ZJWugDR1r/vAll/JKw9+UOAHw
         UL5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=ucrKANAavc1NtdTnXRC9YmP/hh/YfnXjx8eiS0Iol/Q=;
        b=Bwnh/WBfZKsyg/CvnSmHGiOTNw/FZreI6YvUQaNLANVAl2wk4htqA9ev2FI25jRLiv
         rOFSXd1D4D4z5tC9lc8K9nRwVVi7c89En3muJCDJhwjoi67rZUe8DmB0O9EtG/QXNYGS
         ctMW0u5tsofGJCA2eRErqkRl1ZOrhAnlBlBm/BoZQEZACAmTPsB80McE0SA1PSzRDOab
         DdBZahAMzfq1l8nKCGEImmh/oZVZ4l4d+U8dhcbOPCZIWFr7y+C95DMuZdp5KxbOyfMf
         QPCq9mhI1SxNjNMOASR/uQCSH6tHxrl3X0txcieCoHx0P+ffqI17c5Ih+72t1MPpU2tW
         KhJQ==
X-Gm-Message-State: AOAM533am+l+k/d41cKkuRd8xcbqicdObJsK8RmFtKV1w94eacQ0D4Ax
        TtXIp0Nx5VxTcU1RGayuUddE1w==
X-Google-Smtp-Source: ABdhPJziqtJ8towpdAmhrxob1OLK+VXu4+yoez2i5EtTZF4PeeAOc3/k3KaHbihgaipMRXQMQ/YIBQ==
X-Received: by 2002:adf:97cb:: with SMTP id t11mr15492995wrb.314.1591086001045;
        Tue, 02 Jun 2020 01:20:01 -0700 (PDT)
Received: from Red ([2a01:cb1d:3d5:a100:2e56:dcff:fed2:c6d6])
        by smtp.googlemail.com with ESMTPSA id h5sm2746408wrw.85.2020.06.02.01.19.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2020 01:20:00 -0700 (PDT)
Date:   Tue, 2 Jun 2020 10:19:58 +0200
From:   LABBE Corentin <clabbe@baylibre.com>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     thierry.reding@gmail.com, jonathanh@nvidia.com,
        pgaikwad@nvidia.com, pdeschrijver@nvidia.com,
        mturquette@baylibre.com, sboyd@kernel.org, axboe@kernel.dk,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-ide@vger.kernel.org
Subject: Re: tegra124-jetson-tk1: sata doesnt work since 5.2
Message-ID: <20200602081958.GA21773@Red>
References: <20200319074401.GA4116@Red>
 <20200531193111.GA15331@Red>
 <ff9923ca-1d02-ab5e-c335-83ee2e993061@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ff9923ca-1d02-ab5e-c335-83ee2e993061@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On Mon, Jun 01, 2020 at 05:30:37PM +0300, Dmitry Osipenko wrote:
> 31.05.2020 22:31, LABBE Corentin пишет:
> > On Thu, Mar 19, 2020 at 08:44:01AM +0100, LABBE Corentin wrote:
> >> Hello
> >>
> >> sata doesnt work on tegra124-jetson-tk1 on next and master and at least since 5.2 (but 5.1 works).
> >> [    0.492810] +5V_SATA: supplied by +5V_SYS
> >> [    0.493230] +12V_SATA: supplied by +VDD_MUX
> >> [    2.088675] tegra-ahci 70027000.sata: 70027000.sata supply ahci not found, using dummy regulator
> >> [    2.097643] tegra-ahci 70027000.sata: 70027000.sata supply phy not found, using dummy regulator
> >> [    3.314776] tegra-ahci 70027000.sata: 70027000.sata supply ahci not found, using dummy regulator
> >> [    3.323658] tegra-ahci 70027000.sata: 70027000.sata supply phy not found, using dummy regulator
> >> [    5.236964] tegra-ahci 70027000.sata: 70027000.sata supply ahci not found, using dummy regulator
> >> [    5.245867] tegra-ahci 70027000.sata: 70027000.sata supply phy not found, using dummy regulator
> >> [    5.254706] tegra-ahci 70027000.sata: 70027000.sata supply target not found, using dummy regulator
> >> [    5.310270] phy phy-sata.6: phy poweron failed --> -110
> >> [    5.315604] tegra-ahci 70027000.sata: failed to power on AHCI controller: -110
> >> [    5.323022] tegra-ahci: probe of 70027000.sata failed with error -110
> >> [   35.694269] +5V_SATA: disabling
> >> [   35.697438] +12V_SATA: disabling
> >>
> >> I have bisected this problem:
> >> git bisect start
> >> # bad: [22c58fd70ca48a29505922b1563826593b08cc00] Merge tag 'armsoc-soc' of git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc
> >> git bisect bad 22c58fd70ca48a29505922b1563826593b08cc00
> >> # good: [67e38f578aaebf34fc1278bbe45a78ee8c73dd33] ARM: ep93xx: move pinctrl interfaces into include/linux/soc
> >> git bisect good 67e38f578aaebf34fc1278bbe45a78ee8c73dd33
> >> # good: [80f232121b69cc69a31ccb2b38c1665d770b0710] Merge git://git.kernel.org/pub/scm/linux/kernel/git/davem/net-next
> >> git bisect good 80f232121b69cc69a31ccb2b38c1665d770b0710
> >> # good: [e57ccca1ba33e1d92cc3bbf8b6304a46948844b0] Merge tag 'sound-5.2-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound
> >> git bisect good e57ccca1ba33e1d92cc3bbf8b6304a46948844b0
> >> # bad: [983dfa4b6ee556563f7963348e4e2f97fc8a15b8] Merge tag 'for-linus-5.2-rc1' of ssh://gitolite.kernel.org/pub/scm/linux/kernel/git/rw/uml
> >> git bisect bad 983dfa4b6ee556563f7963348e4e2f97fc8a15b8
> >> # good: [8e4ff713ce313dcabbb60e6ede1ffc193e67631f] Merge tag 'rtc-5.2' of git://git.kernel.org/pub/scm/linux/kernel/git/abelloni/linux
> >> git bisect good 8e4ff713ce313dcabbb60e6ede1ffc193e67631f
> >> # bad: [b970afcfcabd63cd3832e95db096439c177c3592] Merge tag 'powerpc-5.2-1' of ssh://gitolite.kernel.org/pub/scm/linux/kernel/git/powerpc/linux
> >> git bisect bad b970afcfcabd63cd3832e95db096439c177c3592
> >> # bad: [601e6bcc4ef02bda2831d5ac8133947b5edf597b] Merge git://git.kernel.org/pub/scm/linux/kernel/git/davem/net
> >> git bisect bad 601e6bcc4ef02bda2831d5ac8133947b5edf597b
> >> # good: [7e9c62bdb41af76974d594da89854a6aba645e58] Merge branches 'clk-sa', 'clk-aspeed', 'clk-samsung', 'clk-ingenic' and 'clk-zynq' into clk-next
> >> git bisect good 7e9c62bdb41af76974d594da89854a6aba645e58
> >> # bad: [0caf000817353cfc5db22363ecdac63b83d3a3f9] Merge branch 'clk-ti' into clk-next
> >> git bisect bad 0caf000817353cfc5db22363ecdac63b83d3a3f9
> >> # good: [5816b74581b45cf086a84ab14e13354a65e8e22c] Merge branches 'clk-hisi', 'clk-lochnagar', 'clk-allwinner', 'clk-rockchip' and 'clk-qoriq' into clk-next
> >> git bisect good 5816b74581b45cf086a84ab14e13354a65e8e22c
> >> # good: [7b4c162e03d47e037f8ee773c3e300eefb599a83] clk: at91: Mark struct clk_range as const
> >> git bisect good 7b4c162e03d47e037f8ee773c3e300eefb599a83
> >> # bad: [e71f4d385878671991e200083c7d30eb4ca8e99a] clk: tegra: divider: Mark Memory Controller clock as read-only
> >> git bisect bad e71f4d385878671991e200083c7d30eb4ca8e99a
> >> # bad: [924ee3d551c9deb16090230b824988bd37e72aa8] clk: tegra: emc: Don't enable EMC clock manually
> >> git bisect bad 924ee3d551c9deb16090230b824988bd37e72aa8
> >> # bad: [40db569d6769ffa3864fd1b89616b1a7323568a8] clk: tegra: Fix PLLM programming on Tegra124+ when PMC overrides divider
> >> git bisect bad 40db569d6769ffa3864fd1b89616b1a7323568a8
> >> # bad: [bff1cef5f23afbe49f5ebd766980dc612f5e9d0a] clk: tegra: Don't enable already enabled PLLs
> >> git bisect bad bff1cef5f23afbe49f5ebd766980dc612f5e9d0a
> >> # first bad commit: [bff1cef5f23afbe49f5ebd766980dc612f5e9d0a] clk: tegra: Don't enable already enabled PLLs
> >>
> > 
> > Hello
> > 
> > I have digged a bit more and with the following "patch" I have now access to sata again
> > diff --git a/drivers/clk/tegra/clk-pll.c b/drivers/clk/tegra/clk-pll.c
> > index 0b212cf2e794..b4e2020051d5 100644
> > --- a/drivers/clk/tegra/clk-pll.c
> > +++ b/drivers/clk/tegra/clk-pll.c
> > @@ -1602,7 +1603,7 @@ static int clk_plle_tegra114_enable(struct clk_hw *hw)
> >         unsigned long input_rate;
> >  
> >         if (clk_pll_is_enabled(hw))
> > -               return 0;
> > +               pr_info("%s %s\n", __func__, clk_hw_get_name(&pll->hw));
> >  
> >         input_rate = clk_hw_get_rate(clk_hw_get_parent(hw));
> > 
> > This patch lead to a probed ahci, and I can see "clk_plle_tegra114_enable pll_e" in messages.
> > 
> > So the bad part of bff1cef5f23afbe49f5ebd766980dc612f5e9d0a is found.
> 
> Hello Labbe,
> 
> Looks like indeed this PLLE change should be reverted. I see that the
> code disables PLLE before changing its configuration, so apparently the
> enable-check shouldn't be needed.
> 
> > As additional information, my previous kernel has CONFIG_PHY_TEGRA_XUSB=m (since firmware is on rootfs which is on sata)
> > but with this sata fail the same, having CONFIG_PHY_TEGRA_XUSB=y (and so xusb firmware in kernel) seems "necessary" for having SATA working.
> 
> Sounds like PLLE needs to be enabled for SATA, but ahci-tegra driver
> doesn't do that.
> 
> Could you please try this change:
> 
> --- >8 ---
> diff --git a/drivers/clk/tegra/clk-tegra124.c
> b/drivers/clk/tegra/clk-tegra124.c
> index e931319dcc9d..7dbc14652830 100644
> --- a/drivers/clk/tegra/clk-tegra124.c
> +++ b/drivers/clk/tegra/clk-tegra124.c
> @@ -1330,6 +1330,7 @@ static struct tegra_clk_init_table
> common_init_table[] __initdata = {
>  	{ TEGRA124_CLK_I2S3_SYNC, TEGRA124_CLK_CLK_MAX, 24576000, 0 },
>  	{ TEGRA124_CLK_I2S4_SYNC, TEGRA124_CLK_CLK_MAX, 24576000, 0 },
>  	{ TEGRA124_CLK_VIMCLK_SYNC, TEGRA124_CLK_CLK_MAX, 24576000, 0 },
> +	{ TEGRA124_CLK_PLL_E, TEGRA124_CLK_CLK_MAX, 0, 1 },
>  	/* must be the last entry */
>  	{ TEGRA124_CLK_CLK_MAX, TEGRA124_CLK_CLK_MAX, 0, 0 },
>  };
> --- >8 ---

This patch alone does not fix the issue.
