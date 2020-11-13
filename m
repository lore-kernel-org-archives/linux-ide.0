Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4E12C55ABD
	for <linux-ide@archiver.kernel.org>; Fri, 13 Nov 2020 20:29:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 556282078B
	for <linux-ide@archiver.kernel.org>; Fri, 13 Nov 2020 20:29:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WeuZgmRf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725981AbgKMU3L (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 13 Nov 2020 15:29:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725941AbgKMU3L (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 13 Nov 2020 15:29:11 -0500
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33706C0613D1;
        Fri, 13 Nov 2020 12:29:11 -0800 (PST)
Received: by mail-wm1-x341.google.com with SMTP id h62so10995508wme.3;
        Fri, 13 Nov 2020 12:29:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=igMifKHgyPeJyPXUD0uDFjowF0SfdlH6rgYO1UwX6e4=;
        b=WeuZgmRfVP9TAwvm0Jm1GwaYOD2yvqJ7us86vi8a7CoLxYWvNLj0UhKJnBKxaOr3Wg
         ASjywrSKxvc0flz2ku3OaGd+7VP+qUCM5SIRaA8aI4HFq9/K0rMQSzKx91wcJMr5x0bZ
         KD1r98fj99nXhQzcxiw3eK0Zk6245vjyRE/s3nByo50vaAUA1U8wvmhY3acFTxs0rsl3
         Rcc6m8TyaVC5NFyxG2ANJ1h3I+tkYoJSTfwZnHtVfqVeQhd1GehiGnGJF3b8x7UcUYin
         B2Jtkd63M/FJre34cosbstkNKL3W7f6D9oF21BUHGgTZy5ruBhQL+NtMu6c/cI5+0OPP
         f/EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=igMifKHgyPeJyPXUD0uDFjowF0SfdlH6rgYO1UwX6e4=;
        b=uW745ydjvY9rOG2OKfmr9K0N+GquHE8zXHuFcWXW8Z9p0A57ae0GeCOQTKdqAmc4NK
         cfWUBKTU9+bFagLDOPH26z81Zv+gZN5nP43yXE5gCZCe+gRuN5UK4FL23tIRjER19KjG
         JLhJysG3FvNcrxhGfdh29EBi2o1NgXBRVB0PWJhDOL/6sp5UsgxElD5ywqZ8CtymKuK9
         pG+U9Ty2hYCOz6F1b6eP20+dn4ycokXvq8YQ9WFrKd+H6HCF/wJoSMeoJ3gExOAlQZ+G
         R2G2crlXtOQmjecLqhq0BaH8Vl71sAx4uPnXvqXdbUQGAvdIh9G5faYQgyM9rBut0ZXc
         VWvg==
X-Gm-Message-State: AOAM5310Mp6+7gE3HFMMwKDsQVXHDBMiX0W0TbWUm5eRIgpuUFN6+Unz
        4sZ+DmUnFqzxZ9kY2t6I3MU=
X-Google-Smtp-Source: ABdhPJzUcHCZA7Sn4cDPF10c/tIrH3b06O/vUhaYVJ/7aFSSdfBVJd461cmw9SWioZY5ue79HSKYNA==
X-Received: by 2002:a1c:bc08:: with SMTP id m8mr4457702wmf.137.1605299349844;
        Fri, 13 Nov 2020 12:29:09 -0800 (PST)
Received: from localhost ([217.111.27.204])
        by smtp.gmail.com with ESMTPSA id c185sm11830161wma.44.2020.11.13.12.29.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2020 12:29:08 -0800 (PST)
Date:   Fri, 13 Nov 2020 21:29:04 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Sowjanya Komatineni <skomatineni@nvidia.com>,
        Preetham Chandru <pchandru@nvidia.com>
Cc:     jonathanh@nvidia.com, robh+dt@kernel.org,
        devicetree@vger.kernel.org, linux-ide@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/6] Add AHCI support for Tegra186
Message-ID: <20201113202904.GC1416567@ulmo>
References: <1605296218-2510-1-git-send-email-skomatineni@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="NU0Ex4SbNnrxsi6C"
Content-Disposition: inline
In-Reply-To: <1605296218-2510-1-git-send-email-skomatineni@nvidia.com>
User-Agent: Mutt/1.14.7 (2020-08-29)
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org


--NU0Ex4SbNnrxsi6C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 13, 2020 at 11:36:52AM -0800, Sowjanya Komatineni wrote:
> This series adds support for AHCI-compliant SATA to Tegra186 SoC.
>=20
> This series includes patches for
> - Converting text based dt-binding document to YAML.
> - Adding dt-bindings for Tegra186.
> - Enabling AHCI-compliance SATA for Jetson TX2.
> - Adding Tegra186 support to Tegra AHCI driver.
>=20
> Delta between patch versions:
> [v2]:	v1 feedback related to yaml dt-binding.
> 	Removed conditional reset order in yaml and updated dts files
> 	to maintain same order for commonly available resets across
> 	Tegra124 thru Tegra186.
>=20
>=20
> Sowjanya Komatineni (6):
>   arm: tegra: Change order of SATA resets for Tegra124
>   arm64: tegra: Change order of SATA resets for Tegra132 and Tegra210
>   dt-bindings: ata: tegra: Convert binding documentation to YAML
>   dt-binding: ata: tegra: Add dt-binding documentation for Tegra186
>   arm64: tegra: Enable AHCI on Jetson TX2
>   ata: ahci_tegra: Add AHCI support for Tegra186
>=20
>  .../devicetree/bindings/ata/nvidia,tegra-ahci.yaml | 175 +++++++++++++++=
++++++
>  .../bindings/ata/nvidia,tegra124-ahci.txt          |  44 ------
>  arch/arm/boot/dts/tegra124.dtsi                    |   6 +-
>  arch/arm64/boot/dts/nvidia/tegra132.dtsi           |   6 +-
>  arch/arm64/boot/dts/nvidia/tegra186-p2771-0000.dts |   4 +
>  arch/arm64/boot/dts/nvidia/tegra186.dtsi           |  28 ++++
>  arch/arm64/boot/dts/nvidia/tegra210.dtsi           |   6 +-
>  drivers/ata/ahci_tegra.c                           |  60 +++++--
>  8 files changed, 263 insertions(+), 66 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/ata/nvidia,tegra-ah=
ci.yaml
>  delete mode 100644 Documentation/devicetree/bindings/ata/nvidia,tegra124=
-ahci.txt

Preetham,

I vaguely recall discussing this with you previously and I think you had
mentioned that we may need changes to the XUSB pad controller to add
support for the SATA lanes on Tegra186 and later.

I've tested this patch and it does seem to work fine, so I wonder if
we're just getting lucky and the power on defaults are just right for
this use-case (I've only tested on Jetson TX2) or if we don't need any
support in the XUSB pad controller driver after all.

I'm not sure if you're subscribed to linux-tegra, but if not, here's a
link to this complete patchset:

	http://patchwork.ozlabs.org/project/linux-tegra/list/?series=3D214338

Thierry

--NU0Ex4SbNnrxsi6C
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIyBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl+u7IsACgkQ3SOs138+
s6E9QA/4i5KdCng+Ib/Kdpm0U0jnEdqiR60hXPVRLC1SpwTFZJ5/TPoab47/m8Y/
ca0Qw5F4cmfcWlwiSJ8VTj+F/6gxFWE8VT7oWNm9wBbql6rYCUoD77naEDjvYu0W
y4mZ1KHkqjO3bMgc9cSIljQ9MXZN6AEE62a+QlcwPPz5KAZaV6UkVizOhQRL0Fr1
DVDQGuLzY2b2mz6ymQT/25RL/F/3jnk6RK/y/UjuTWg8lYkAklGy2wlMTS0K5fPD
U172R5+byiHE2dn6UguzO159FAyERSQWLgPeHDhy7Opxm34/luTsGCV4sCqan1Zy
utctf518BXHs2X5UYt+l3Y2Zv6kF/rAMzvisnQg6QDKiKT0RN8LzKu1xvWEyq6O6
Xye3m2MquHds/Xp6pMOfKNmUyo3qC3c6y9G0eZ/HJwq8CYCDLGny8MkUmkFZGiul
ntlAQWrkWUFM4FFjRjAw1il0ATxRyBUAsn5wnqVFZz4+rfqbSrPCw3y53+rfMBs2
u8xnTFRcUrqTSuwEevCK6ihZMt396Yj1Tcn8+fhGnkwdmUTDNFPKC+o4boaR1LOt
5gxgxglGHiXu8gTUIpUGearql/bPDpoBfX9cUFtq0KXuJy1kTv9hrC5L/wX022Ot
oRKyedhVg42TX8541q1745iSXQ0k9puKRclcpRu9R4jqwQcMBw==
=0f5C
-----END PGP SIGNATURE-----

--NU0Ex4SbNnrxsi6C--
