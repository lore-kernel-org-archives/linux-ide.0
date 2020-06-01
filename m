Return-Path: <SRS0=gVoV=7O=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01E7AC433E0
	for <linux-ide@archiver.kernel.org>; Mon,  1 Jun 2020 14:30:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B60D120772
	for <linux-ide@archiver.kernel.org>; Mon,  1 Jun 2020 14:30:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pyWpR2G+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726124AbgFAOar (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 1 Jun 2020 10:30:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726067AbgFAOaq (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 1 Jun 2020 10:30:46 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B1F2C05BD43;
        Mon,  1 Jun 2020 07:30:46 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id s1so8413453ljo.0;
        Mon, 01 Jun 2020 07:30:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=qrXfNg8Dhf3rKXKa4YFqpN12r/srvtJJMd2BqfCjhzo=;
        b=pyWpR2G+dxSQ+AfcOgiIpEdWYHmL7eQO0yLqH5QZiiNiWKilyq5pdydncNy1V19aWg
         B9KzcrHihZn9ExL3n/LFPf/MLsfeXSBLNEoYTYltIy+FDVUe6v88lOwCS1WsZtDhQZYS
         BzffqzFiQ5I0h2YdM4VdY99XIzzbfLJWxvS7JN4BaRlHYjzDZddqcvYKZhRkdDValiwo
         YNGXJw5hgg4EgZwHJd9RFhIRkUSF1lQCoP5V0tgEIq04YIYjJRSV9Vq/oPEcTa1Iagm6
         cEP0J/U6kKRZdlAC/CTJAQtmuiACuBh8fRcjjRU0CU/xNlYQ5rQj2w465uBzmhCJaP76
         8l5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=qrXfNg8Dhf3rKXKa4YFqpN12r/srvtJJMd2BqfCjhzo=;
        b=LtFgetvjMfHnbcQxoBnwSuITAtr81iDT3P6upGWL/1ifdxyjgJmZGk/Ozy2vebpNQa
         1cKJkkdeI+9sLZLsNru/ZKUzSkyexgF+ulGgzEq/bBfsErkaIs6C6P3Ng8YmJ2KtxJMN
         xVIenQKUUpv3HaPQmaz9vxDHHabxFSh2ED52hTKh1oqhCTSOJigng0CB3MNkZU/pYhgo
         IcEZSWiWqtPMVpFsi8oVsH+OTY0Gy5nWUNYeA5avHyGFDLcYBC1oIrviAdsJ8E38sbXC
         MnbGr3IFD7STdwa7nwrYKxwFHVO5N8i30TPG+HdKNF7CqeZix2F1RyWSD+MFyIRn4Ys3
         jOgQ==
X-Gm-Message-State: AOAM532bYu7GE8MzMTxNZPKyMBcvzjUsFsd4z1rhNFpPWW4mB0SaDlbJ
        xESCMYDL+ECWRTHFCOEvMyMtcuJf
X-Google-Smtp-Source: ABdhPJworqpq/dL7ubf5GJxn9N5XNdiyDOT8oDEy1M0BHLIEgPJeM+ZwjYjAa3RfGgEjqdZxP/LlMw==
X-Received: by 2002:a05:651c:1039:: with SMTP id w25mr11674726ljm.30.1591021844175;
        Mon, 01 Jun 2020 07:30:44 -0700 (PDT)
Received: from [192.168.2.145] (109-252-173-94.dynamic.spd-mgts.ru. [109.252.173.94])
        by smtp.googlemail.com with ESMTPSA id h26sm4896061lja.0.2020.06.01.07.30.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Jun 2020 07:30:40 -0700 (PDT)
Subject: Re: tegra124-jetson-tk1: sata doesnt work since 5.2
To:     LABBE Corentin <clabbe@baylibre.com>, thierry.reding@gmail.com,
        jonathanh@nvidia.com, pgaikwad@nvidia.com, pdeschrijver@nvidia.com,
        mturquette@baylibre.com, sboyd@kernel.org, axboe@kernel.dk
Cc:     linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-ide@vger.kernel.org
References: <20200319074401.GA4116@Red> <20200531193111.GA15331@Red>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <ff9923ca-1d02-ab5e-c335-83ee2e993061@gmail.com>
Date:   Mon, 1 Jun 2020 17:30:37 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200531193111.GA15331@Red>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

31.05.2020 22:31, LABBE Corentin пишет:
> On Thu, Mar 19, 2020 at 08:44:01AM +0100, LABBE Corentin wrote:
>> Hello
>>
>> sata doesnt work on tegra124-jetson-tk1 on next and master and at least since 5.2 (but 5.1 works).
>> [    0.492810] +5V_SATA: supplied by +5V_SYS
>> [    0.493230] +12V_SATA: supplied by +VDD_MUX
>> [    2.088675] tegra-ahci 70027000.sata: 70027000.sata supply ahci not found, using dummy regulator
>> [    2.097643] tegra-ahci 70027000.sata: 70027000.sata supply phy not found, using dummy regulator
>> [    3.314776] tegra-ahci 70027000.sata: 70027000.sata supply ahci not found, using dummy regulator
>> [    3.323658] tegra-ahci 70027000.sata: 70027000.sata supply phy not found, using dummy regulator
>> [    5.236964] tegra-ahci 70027000.sata: 70027000.sata supply ahci not found, using dummy regulator
>> [    5.245867] tegra-ahci 70027000.sata: 70027000.sata supply phy not found, using dummy regulator
>> [    5.254706] tegra-ahci 70027000.sata: 70027000.sata supply target not found, using dummy regulator
>> [    5.310270] phy phy-sata.6: phy poweron failed --> -110
>> [    5.315604] tegra-ahci 70027000.sata: failed to power on AHCI controller: -110
>> [    5.323022] tegra-ahci: probe of 70027000.sata failed with error -110
>> [   35.694269] +5V_SATA: disabling
>> [   35.697438] +12V_SATA: disabling
>>
>> I have bisected this problem:
>> git bisect start
>> # bad: [22c58fd70ca48a29505922b1563826593b08cc00] Merge tag 'armsoc-soc' of git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc
>> git bisect bad 22c58fd70ca48a29505922b1563826593b08cc00
>> # good: [67e38f578aaebf34fc1278bbe45a78ee8c73dd33] ARM: ep93xx: move pinctrl interfaces into include/linux/soc
>> git bisect good 67e38f578aaebf34fc1278bbe45a78ee8c73dd33
>> # good: [80f232121b69cc69a31ccb2b38c1665d770b0710] Merge git://git.kernel.org/pub/scm/linux/kernel/git/davem/net-next
>> git bisect good 80f232121b69cc69a31ccb2b38c1665d770b0710
>> # good: [e57ccca1ba33e1d92cc3bbf8b6304a46948844b0] Merge tag 'sound-5.2-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound
>> git bisect good e57ccca1ba33e1d92cc3bbf8b6304a46948844b0
>> # bad: [983dfa4b6ee556563f7963348e4e2f97fc8a15b8] Merge tag 'for-linus-5.2-rc1' of ssh://gitolite.kernel.org/pub/scm/linux/kernel/git/rw/uml
>> git bisect bad 983dfa4b6ee556563f7963348e4e2f97fc8a15b8
>> # good: [8e4ff713ce313dcabbb60e6ede1ffc193e67631f] Merge tag 'rtc-5.2' of git://git.kernel.org/pub/scm/linux/kernel/git/abelloni/linux
>> git bisect good 8e4ff713ce313dcabbb60e6ede1ffc193e67631f
>> # bad: [b970afcfcabd63cd3832e95db096439c177c3592] Merge tag 'powerpc-5.2-1' of ssh://gitolite.kernel.org/pub/scm/linux/kernel/git/powerpc/linux
>> git bisect bad b970afcfcabd63cd3832e95db096439c177c3592
>> # bad: [601e6bcc4ef02bda2831d5ac8133947b5edf597b] Merge git://git.kernel.org/pub/scm/linux/kernel/git/davem/net
>> git bisect bad 601e6bcc4ef02bda2831d5ac8133947b5edf597b
>> # good: [7e9c62bdb41af76974d594da89854a6aba645e58] Merge branches 'clk-sa', 'clk-aspeed', 'clk-samsung', 'clk-ingenic' and 'clk-zynq' into clk-next
>> git bisect good 7e9c62bdb41af76974d594da89854a6aba645e58
>> # bad: [0caf000817353cfc5db22363ecdac63b83d3a3f9] Merge branch 'clk-ti' into clk-next
>> git bisect bad 0caf000817353cfc5db22363ecdac63b83d3a3f9
>> # good: [5816b74581b45cf086a84ab14e13354a65e8e22c] Merge branches 'clk-hisi', 'clk-lochnagar', 'clk-allwinner', 'clk-rockchip' and 'clk-qoriq' into clk-next
>> git bisect good 5816b74581b45cf086a84ab14e13354a65e8e22c
>> # good: [7b4c162e03d47e037f8ee773c3e300eefb599a83] clk: at91: Mark struct clk_range as const
>> git bisect good 7b4c162e03d47e037f8ee773c3e300eefb599a83
>> # bad: [e71f4d385878671991e200083c7d30eb4ca8e99a] clk: tegra: divider: Mark Memory Controller clock as read-only
>> git bisect bad e71f4d385878671991e200083c7d30eb4ca8e99a
>> # bad: [924ee3d551c9deb16090230b824988bd37e72aa8] clk: tegra: emc: Don't enable EMC clock manually
>> git bisect bad 924ee3d551c9deb16090230b824988bd37e72aa8
>> # bad: [40db569d6769ffa3864fd1b89616b1a7323568a8] clk: tegra: Fix PLLM programming on Tegra124+ when PMC overrides divider
>> git bisect bad 40db569d6769ffa3864fd1b89616b1a7323568a8
>> # bad: [bff1cef5f23afbe49f5ebd766980dc612f5e9d0a] clk: tegra: Don't enable already enabled PLLs
>> git bisect bad bff1cef5f23afbe49f5ebd766980dc612f5e9d0a
>> # first bad commit: [bff1cef5f23afbe49f5ebd766980dc612f5e9d0a] clk: tegra: Don't enable already enabled PLLs
>>
> 
> Hello
> 
> I have digged a bit more and with the following "patch" I have now access to sata again
> diff --git a/drivers/clk/tegra/clk-pll.c b/drivers/clk/tegra/clk-pll.c
> index 0b212cf2e794..b4e2020051d5 100644
> --- a/drivers/clk/tegra/clk-pll.c
> +++ b/drivers/clk/tegra/clk-pll.c
> @@ -1602,7 +1603,7 @@ static int clk_plle_tegra114_enable(struct clk_hw *hw)
>         unsigned long input_rate;
>  
>         if (clk_pll_is_enabled(hw))
> -               return 0;
> +               pr_info("%s %s\n", __func__, clk_hw_get_name(&pll->hw));
>  
>         input_rate = clk_hw_get_rate(clk_hw_get_parent(hw));
> 
> This patch lead to a probed ahci, and I can see "clk_plle_tegra114_enable pll_e" in messages.
> 
> So the bad part of bff1cef5f23afbe49f5ebd766980dc612f5e9d0a is found.

Hello Labbe,

Looks like indeed this PLLE change should be reverted. I see that the
code disables PLLE before changing its configuration, so apparently the
enable-check shouldn't be needed.

> As additional information, my previous kernel has CONFIG_PHY_TEGRA_XUSB=m (since firmware is on rootfs which is on sata)
> but with this sata fail the same, having CONFIG_PHY_TEGRA_XUSB=y (and so xusb firmware in kernel) seems "necessary" for having SATA working.

Sounds like PLLE needs to be enabled for SATA, but ahci-tegra driver
doesn't do that.

Could you please try this change:

--- >8 ---
diff --git a/drivers/clk/tegra/clk-tegra124.c
b/drivers/clk/tegra/clk-tegra124.c
index e931319dcc9d..7dbc14652830 100644
--- a/drivers/clk/tegra/clk-tegra124.c
+++ b/drivers/clk/tegra/clk-tegra124.c
@@ -1330,6 +1330,7 @@ static struct tegra_clk_init_table
common_init_table[] __initdata = {
 	{ TEGRA124_CLK_I2S3_SYNC, TEGRA124_CLK_CLK_MAX, 24576000, 0 },
 	{ TEGRA124_CLK_I2S4_SYNC, TEGRA124_CLK_CLK_MAX, 24576000, 0 },
 	{ TEGRA124_CLK_VIMCLK_SYNC, TEGRA124_CLK_CLK_MAX, 24576000, 0 },
+	{ TEGRA124_CLK_PLL_E, TEGRA124_CLK_CLK_MAX, 0, 1 },
 	/* must be the last entry */
 	{ TEGRA124_CLK_CLK_MAX, TEGRA124_CLK_CLK_MAX, 0, 0 },
 };
--- >8 ---
