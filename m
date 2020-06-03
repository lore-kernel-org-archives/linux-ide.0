Return-Path: <SRS0=RB9J=7Q=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AD39C433E0
	for <linux-ide@archiver.kernel.org>; Wed,  3 Jun 2020 10:56:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 165332067B
	for <linux-ide@archiver.kernel.org>; Wed,  3 Jun 2020 10:56:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BcPc8T4V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725833AbgFCK4G (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 3 Jun 2020 06:56:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725828AbgFCK4G (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 3 Jun 2020 06:56:06 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3E11C08C5C0;
        Wed,  3 Jun 2020 03:56:05 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id x1so1664289ejd.8;
        Wed, 03 Jun 2020 03:56:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=oxbO71oFgKHc+IV6gKkko9bwU3JZ7+Lme2nj8MvkWhw=;
        b=BcPc8T4VB6MvrjaDf5M219pdhyX4P50PVHmx6qwB/h2Te4GCCik3RgfW9Z6BvC3Zzd
         5sw19jK4PmsP5diZrZY3X5f8T248BqJpC9R8S+k+Jhtp7zYM5PK1rDXIVmaFIz3MWsGX
         1JoinFuNjPeuGkxTqStB9hWreInFm7a7CMXWnwRCbEJ6mgSFPhkdmSJ+IaIBZZNAvUqw
         Bn6ZbdgkjXYvlpXVQPzj6/LlfmNNvVLnj05kCwq8Vuzf/fPrRhaY74dFnLdPffF/NpHk
         er+Q3XT83O+RCX4F0fZGplrsm4pbD4iYi5qye9yIduTTQf1grDitCTCOglX3iwvAul12
         /8MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=oxbO71oFgKHc+IV6gKkko9bwU3JZ7+Lme2nj8MvkWhw=;
        b=Si4LJqDE+6k2rORmuuYB8c5PAEFn1h25mABFJzfMh8rWnAikes2jsqMPFL83TdKFhZ
         lvuOTUFgwD/Kq0XntPZvIxVCuQioGoTnjJDrGRabyoJaUi78Bot95oiFkRJXHJimZUkh
         XghvlChuKdyCjMhD1fG0X1wBzaAwyDTHQID5ZIaW8r7BVGMCXhvLxam5DKJaxo9WNeKA
         Hpd1i26ZL2jOeh5EAbhQCkdZ3RNewyZ3rK9YRjHkc4iMSxrV/ML4guqOgPUcA3PHRSLt
         H6z1Xpc9CwCM0paxSFKNIEalQdHvnZU6x2/H0bY3ySF5zwUDP5AlN0STmLYxyjq6/hkR
         gtVQ==
X-Gm-Message-State: AOAM530O08HhMkSbOQIgBa09Nh2KZCQ9qP+QOxSFHL2aX37ao8F4PT3i
        1cLEVJ76OUHd8EwWXwpkCtZFMm4Z
X-Google-Smtp-Source: ABdhPJwgwv8t0yOWovx6Za4Bz1rXnSeJ4jwC3MMoJdxP7iI0hM5W+28FwbzQQF6MwRaVj9nILf491Q==
X-Received: by 2002:a17:906:6156:: with SMTP id p22mr26050986ejl.329.1591181764117;
        Wed, 03 Jun 2020 03:56:04 -0700 (PDT)
Received: from localhost (pd9e51079.dip0.t-ipconnect.de. [217.229.16.121])
        by smtp.gmail.com with ESMTPSA id n6sm1010021edv.24.2020.06.03.03.56.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2020 03:56:01 -0700 (PDT)
Date:   Wed, 3 Jun 2020 12:56:00 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     LABBE Corentin <clabbe@baylibre.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>
Cc:     Dmitry Osipenko <digetx@gmail.com>, jonathanh@nvidia.com,
        pgaikwad@nvidia.com, mturquette@baylibre.com, sboyd@kernel.org,
        axboe@kernel.dk, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-ide@vger.kernel.org
Subject: Re: tegra124-jetson-tk1: sata doesnt work since 5.2
Message-ID: <20200603105600.GB3478467@ulmo>
References: <20200319074401.GA4116@Red>
 <20200531193111.GA15331@Red>
 <ff9923ca-1d02-ab5e-c335-83ee2e993061@gmail.com>
 <20200602081958.GA21773@Red>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="l76fUT7nc3MelDdI"
Content-Disposition: inline
In-Reply-To: <20200602081958.GA21773@Red>
User-Agent: Mutt/1.13.1 (2019-12-14)
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org


--l76fUT7nc3MelDdI
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 02, 2020 at 10:19:58AM +0200, LABBE Corentin wrote:
> On Mon, Jun 01, 2020 at 05:30:37PM +0300, Dmitry Osipenko wrote:
> > 31.05.2020 22:31, LABBE Corentin =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> > > On Thu, Mar 19, 2020 at 08:44:01AM +0100, LABBE Corentin wrote:
> > >> Hello
> > >>
> > >> sata doesnt work on tegra124-jetson-tk1 on next and master and at le=
ast since 5.2 (but 5.1 works).
> > >> [    0.492810] +5V_SATA: supplied by +5V_SYS
> > >> [    0.493230] +12V_SATA: supplied by +VDD_MUX
> > >> [    2.088675] tegra-ahci 70027000.sata: 70027000.sata supply ahci n=
ot found, using dummy regulator
> > >> [    2.097643] tegra-ahci 70027000.sata: 70027000.sata supply phy no=
t found, using dummy regulator
> > >> [    3.314776] tegra-ahci 70027000.sata: 70027000.sata supply ahci n=
ot found, using dummy regulator
> > >> [    3.323658] tegra-ahci 70027000.sata: 70027000.sata supply phy no=
t found, using dummy regulator
> > >> [    5.236964] tegra-ahci 70027000.sata: 70027000.sata supply ahci n=
ot found, using dummy regulator
> > >> [    5.245867] tegra-ahci 70027000.sata: 70027000.sata supply phy no=
t found, using dummy regulator
> > >> [    5.254706] tegra-ahci 70027000.sata: 70027000.sata supply target=
 not found, using dummy regulator
> > >> [    5.310270] phy phy-sata.6: phy poweron failed --> -110
> > >> [    5.315604] tegra-ahci 70027000.sata: failed to power on AHCI con=
troller: -110
> > >> [    5.323022] tegra-ahci: probe of 70027000.sata failed with error =
-110
> > >> [   35.694269] +5V_SATA: disabling
> > >> [   35.697438] +12V_SATA: disabling
> > >>
> > >> I have bisected this problem:
> > >> git bisect start
> > >> # bad: [22c58fd70ca48a29505922b1563826593b08cc00] Merge tag 'armsoc-=
soc' of git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc
> > >> git bisect bad 22c58fd70ca48a29505922b1563826593b08cc00
> > >> # good: [67e38f578aaebf34fc1278bbe45a78ee8c73dd33] ARM: ep93xx: move=
 pinctrl interfaces into include/linux/soc
> > >> git bisect good 67e38f578aaebf34fc1278bbe45a78ee8c73dd33
> > >> # good: [80f232121b69cc69a31ccb2b38c1665d770b0710] Merge git://git.k=
ernel.org/pub/scm/linux/kernel/git/davem/net-next
> > >> git bisect good 80f232121b69cc69a31ccb2b38c1665d770b0710
> > >> # good: [e57ccca1ba33e1d92cc3bbf8b6304a46948844b0] Merge tag 'sound-=
5.2-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound
> > >> git bisect good e57ccca1ba33e1d92cc3bbf8b6304a46948844b0
> > >> # bad: [983dfa4b6ee556563f7963348e4e2f97fc8a15b8] Merge tag 'for-lin=
us-5.2-rc1' of ssh://gitolite.kernel.org/pub/scm/linux/kernel/git/rw/uml
> > >> git bisect bad 983dfa4b6ee556563f7963348e4e2f97fc8a15b8
> > >> # good: [8e4ff713ce313dcabbb60e6ede1ffc193e67631f] Merge tag 'rtc-5.=
2' of git://git.kernel.org/pub/scm/linux/kernel/git/abelloni/linux
> > >> git bisect good 8e4ff713ce313dcabbb60e6ede1ffc193e67631f
> > >> # bad: [b970afcfcabd63cd3832e95db096439c177c3592] Merge tag 'powerpc=
-5.2-1' of ssh://gitolite.kernel.org/pub/scm/linux/kernel/git/powerpc/linux
> > >> git bisect bad b970afcfcabd63cd3832e95db096439c177c3592
> > >> # bad: [601e6bcc4ef02bda2831d5ac8133947b5edf597b] Merge git://git.ke=
rnel.org/pub/scm/linux/kernel/git/davem/net
> > >> git bisect bad 601e6bcc4ef02bda2831d5ac8133947b5edf597b
> > >> # good: [7e9c62bdb41af76974d594da89854a6aba645e58] Merge branches 'c=
lk-sa', 'clk-aspeed', 'clk-samsung', 'clk-ingenic' and 'clk-zynq' into clk-=
next
> > >> git bisect good 7e9c62bdb41af76974d594da89854a6aba645e58
> > >> # bad: [0caf000817353cfc5db22363ecdac63b83d3a3f9] Merge branch 'clk-=
ti' into clk-next
> > >> git bisect bad 0caf000817353cfc5db22363ecdac63b83d3a3f9
> > >> # good: [5816b74581b45cf086a84ab14e13354a65e8e22c] Merge branches 'c=
lk-hisi', 'clk-lochnagar', 'clk-allwinner', 'clk-rockchip' and 'clk-qoriq' =
into clk-next
> > >> git bisect good 5816b74581b45cf086a84ab14e13354a65e8e22c
> > >> # good: [7b4c162e03d47e037f8ee773c3e300eefb599a83] clk: at91: Mark s=
truct clk_range as const
> > >> git bisect good 7b4c162e03d47e037f8ee773c3e300eefb599a83
> > >> # bad: [e71f4d385878671991e200083c7d30eb4ca8e99a] clk: tegra: divide=
r: Mark Memory Controller clock as read-only
> > >> git bisect bad e71f4d385878671991e200083c7d30eb4ca8e99a
> > >> # bad: [924ee3d551c9deb16090230b824988bd37e72aa8] clk: tegra: emc: D=
on't enable EMC clock manually
> > >> git bisect bad 924ee3d551c9deb16090230b824988bd37e72aa8
> > >> # bad: [40db569d6769ffa3864fd1b89616b1a7323568a8] clk: tegra: Fix PL=
LM programming on Tegra124+ when PMC overrides divider
> > >> git bisect bad 40db569d6769ffa3864fd1b89616b1a7323568a8
> > >> # bad: [bff1cef5f23afbe49f5ebd766980dc612f5e9d0a] clk: tegra: Don't =
enable already enabled PLLs
> > >> git bisect bad bff1cef5f23afbe49f5ebd766980dc612f5e9d0a
> > >> # first bad commit: [bff1cef5f23afbe49f5ebd766980dc612f5e9d0a] clk: =
tegra: Don't enable already enabled PLLs
> > >>
> > >=20
> > > Hello
> > >=20
> > > I have digged a bit more and with the following "patch" I have now ac=
cess to sata again
> > > diff --git a/drivers/clk/tegra/clk-pll.c b/drivers/clk/tegra/clk-pll.c
> > > index 0b212cf2e794..b4e2020051d5 100644
> > > --- a/drivers/clk/tegra/clk-pll.c
> > > +++ b/drivers/clk/tegra/clk-pll.c
> > > @@ -1602,7 +1603,7 @@ static int clk_plle_tegra114_enable(struct clk_=
hw *hw)
> > >         unsigned long input_rate;
> > > =20
> > >         if (clk_pll_is_enabled(hw))
> > > -               return 0;
> > > +               pr_info("%s %s\n", __func__, clk_hw_get_name(&pll->hw=
));
> > > =20
> > >         input_rate =3D clk_hw_get_rate(clk_hw_get_parent(hw));
> > >=20
> > > This patch lead to a probed ahci, and I can see "clk_plle_tegra114_en=
able pll_e" in messages.
> > >=20
> > > So the bad part of bff1cef5f23afbe49f5ebd766980dc612f5e9d0a is found.
> >=20
> > Hello Labbe,
> >=20
> > Looks like indeed this PLLE change should be reverted. I see that the
> > code disables PLLE before changing its configuration, so apparently the
> > enable-check shouldn't be needed.
> >=20
> > > As additional information, my previous kernel has CONFIG_PHY_TEGRA_XU=
SB=3Dm (since firmware is on rootfs which is on sata)
> > > but with this sata fail the same, having CONFIG_PHY_TEGRA_XUSB=3Dy (a=
nd so xusb firmware in kernel) seems "necessary" for having SATA working.
> >=20
> > Sounds like PLLE needs to be enabled for SATA, but ahci-tegra driver
> > doesn't do that.
> >=20
> > Could you please try this change:
> >=20
> > --- >8 ---
> > diff --git a/drivers/clk/tegra/clk-tegra124.c
> > b/drivers/clk/tegra/clk-tegra124.c
> > index e931319dcc9d..7dbc14652830 100644
> > --- a/drivers/clk/tegra/clk-tegra124.c
> > +++ b/drivers/clk/tegra/clk-tegra124.c
> > @@ -1330,6 +1330,7 @@ static struct tegra_clk_init_table
> > common_init_table[] __initdata =3D {
> >  	{ TEGRA124_CLK_I2S3_SYNC, TEGRA124_CLK_CLK_MAX, 24576000, 0 },
> >  	{ TEGRA124_CLK_I2S4_SYNC, TEGRA124_CLK_CLK_MAX, 24576000, 0 },
> >  	{ TEGRA124_CLK_VIMCLK_SYNC, TEGRA124_CLK_CLK_MAX, 24576000, 0 },
> > +	{ TEGRA124_CLK_PLL_E, TEGRA124_CLK_CLK_MAX, 0, 1 },
> >  	/* must be the last entry */
> >  	{ TEGRA124_CLK_CLK_MAX, TEGRA124_CLK_CLK_MAX, 0, 0 },
> >  };
> > --- >8 ---
>=20
> This patch alone does not fix the issue.

Looking at clk_plle_tegra114_enable(), there's a bunch of configuration
going on other than just enabling the PLL_E and it's likely that whoever
set up the PLL_E first (probably some bootloader) didn't have the same
requirements as the kernel has (most notably I can imagine that hardware
control of the XUSB and SATA PLLs remains disabled in the bootloader due
to the different way that they are used.

Peter, do you have any more background on what could be going on here or
who might be initializing the PLL_E (and others) in an incompatible way?
An alternative might be to identify who configures the PLL badly and fix
the culprit. But that's a bit of a strong dependency for my taste,
especially given that currenty versions of the bootloaders are broken.

Thierry

--l76fUT7nc3MelDdI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl7Xgb4ACgkQ3SOs138+
s6GsNw//QBMpWb7ziuU1Ega9DHpzDyQunGvlKz/oB65CqrtL5wYJmcHJh4CZWSvw
X6p/1gujT0qY7D9sGUl6Ehw072KbFawkJssccDUyonlJQX550LG5bbtfkuHSAOeY
4fyeHHX5UdpDRB1MjlYrcHC3tfvk/BE8SJK0Isw+KdJRHgAX1gKBeblz6Sr1Yx7u
fIZGUpNkDmJRG8R6N+4tq2miwfJ577A5Z0EuxMI1pZ06rhDwgmT0gJhEFg6dz5w1
RY+ucYK9zStsvtNwiAmIvqVswrzKHwCsft5az7ahEhy5NqvwgDYY/qojYKfdERQG
Qeh36pufyc2A0llpnpKqEt5ioYc6C/5W8tzZwtfs6rQa+igW/QfrKsHTepKV/ttU
kxaa1Eab5Gr9zTd09mFeJord07IsAUI5c3m/Vwjr+4Boz0OOCBGw2o5HbAgGnqGE
52vub+1nA0TTjL9P8TsplWH8pNsE+Teqx9OuV7JAo/pXHSUbNvIDQIz5jhJ6wuHX
+6Dco3WAe6EPpd6ARkXw6qLZDBgmYNIdjd5pqiPqCxyq5lsoY1+C0vaN4WgDkkAe
Te4NQIqj6bjln9hWlPARGjopMWoMj0jUUWhcmopz3TQ8gloLjaNT/n3MHl/bF+qR
SVWI2D2Av8SBn6bJo++uE/RxKgVxoc+5q8IzrAnC9TRa4ZW140A=
=K3X4
-----END PGP SIGNATURE-----

--l76fUT7nc3MelDdI--
