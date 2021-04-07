Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5DD8C433B4
	for <linux-ide@archiver.kernel.org>; Wed,  7 Apr 2021 15:05:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AC7E461382
	for <linux-ide@archiver.kernel.org>; Wed,  7 Apr 2021 15:05:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353302AbhDGPF2 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 7 Apr 2021 11:05:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243817AbhDGPF0 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 7 Apr 2021 11:05:26 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60083C061756;
        Wed,  7 Apr 2021 08:05:16 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id 18so3773968edx.3;
        Wed, 07 Apr 2021 08:05:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=9wCDbHG9uHSkQXLgeZOxm41BJ4Rijo35t+pPRhh+alw=;
        b=bkBQzncieJEEkMCfw6papmxYMiln+jyQw1UyUrdu4kcFhesdnUNVBepYKnvHUaX3PU
         DAH91HIwKnywp6t8rOYujma1/IIuNa65Aer0RKYcCPQOHKkphxJXGtuXOvO1sjjondZ1
         lZjEQbKo5WlIKUfcHSq8ABAoBVdQUMkXq9oMua5cKIku4Fd2XNu/6nZZFvTs56N8tqqO
         MuhjFE0cmh9YXSJrId94WBv4eq/o1O44ZwECpbp8Sb/N9S0w8AXRo+uM9tvYk8hmW2w1
         Azc8oaVz6qMaJ+TkGhtO1X6sr3X+2aB6tmBZjUGREsQtWwY3OsT3vex+VIfONWwefxow
         ZVpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9wCDbHG9uHSkQXLgeZOxm41BJ4Rijo35t+pPRhh+alw=;
        b=J3mIVzoforwmwlrHLVOXoZqlOo99J0XKApTIAX3Op4qQZQZJakvfpFg7rKEehpBjtd
         wCEtEk1JnnS0t5iP4AfPDwhj0WmJIXypEzoYj89SFFqj4riLlRaK+ToaKvyq5IbBQc5O
         qenUC7yre0i2fnfqUN9Hm5LG4an64t23h+aE6dYNtf+M0U6DiULTekWDJ9tutRu60I6b
         h4Iduox7OitV/t9LxnrXYWpS9XA2LOLOuLNp16adHj7aZ6kaS3Ft7OMT/9fY9uOZvmXb
         l3Q6W+WCWqUZuoV+ANlMpeaHyeUU8pQUI50UOO3BWCWD+nUJQVGytay3Kca/4t5af9T+
         90iw==
X-Gm-Message-State: AOAM531KCLmmg5BMSGDBV4nVAJx+L1jihoRHLdFIZvT7hzC3b3nndLJy
        7SAL8GQ49PasUJ7S929N3zw=
X-Google-Smtp-Source: ABdhPJzsyQtJWCKLEPffahHXWH+zmRZrc/D7Dnk7mdUZT6rzxyungHRqUwjWiphvBHPlTjACyHHzbA==
X-Received: by 2002:a05:6402:518b:: with SMTP id q11mr4975719edd.151.1617807914996;
        Wed, 07 Apr 2021 08:05:14 -0700 (PDT)
Received: from localhost ([62.96.65.119])
        by smtp.gmail.com with ESMTPSA id kx3sm7958626ejc.44.2021.04.07.08.05.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Apr 2021 08:05:13 -0700 (PDT)
Date:   Wed, 7 Apr 2021 17:05:48 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Sowjanya Komatineni <skomatineni@nvidia.com>
Cc:     axboe@kernel.dk, jonathanh@nvidia.com, robh+dt@kernel.org,
        pchandru@nvidia.com, devicetree@vger.kernel.org,
        linux-ide@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 3/3] ata: ahci_tegra: Add AHCI support for Tegra186
Message-ID: <YG3KTNpsNuuxv4mZ@orome.fritz.box>
References: <1617758731-12380-1-git-send-email-skomatineni@nvidia.com>
 <1617758731-12380-4-git-send-email-skomatineni@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="5wXc6glE45+qlMXy"
Content-Disposition: inline
In-Reply-To: <1617758731-12380-4-git-send-email-skomatineni@nvidia.com>
User-Agent: Mutt/2.0.6 (98f8cb83) (2021-03-06)
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org


--5wXc6glE45+qlMXy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 06, 2021 at 06:25:31PM -0700, Sowjanya Komatineni wrote:
> This patch adds support for AHCI-compliant Serial ATA controller
> on Tegra186 SoC.
>=20
> Tegra186 does not have sata-oob reset.
> Tegra186 SATA_NVOOB register filed COMMA_CNT position and width are
> different compared to Tegra210 and prior.
>=20
> So, this patch adds a flag has_sata_oob_rst and tegra_ahci_regs to
> SoC specific strcuture tegra_ahci_soc and updated their implementation
> accordingly.
>=20
> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
> ---
>  drivers/ata/ahci_tegra.c | 60 +++++++++++++++++++++++++++++++++++++-----=
------
>  1 file changed, 47 insertions(+), 13 deletions(-)

Acked-by: Thierry Reding <treding@nvidia.com>

--5wXc6glE45+qlMXy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmBtykwACgkQ3SOs138+
s6GmuQ//SBUyXnbF2lnf8ODdawHvuEG6M9dXdj+OXc5seDzMJSkk7OSb7xcgODop
mGxWH15Zh9qA3Ut+ZnVVEXUqB3lOsWVrl/JzwdYMEgiGLzdNbiuKOnk/PM/L06/r
b10f5WTcq4kX1CuV8ODrRQAY0H/uquDCGDry9C1B86BzkFkZmdXZB/eoWI1hFdIH
BmkP62ZM+mDUlEs4aRGzjwKJSsbDEJ3UY24CgZH+lH2jJgF5js5fDB4JZHi4Y1t1
0yBysy71BwyAYk2JsafrgrV200aH1EVudxbANJjD1J8LSFy46Vd9TYvy7Nz8ItZy
1fBYnGvGEduU6z0wwHO1KgRTW127I0zD/w34tYSDYXHu5mBHIFBD1oCxaqCXEMCM
MMV03S4JQtyFBz5HC7JIcndgMQGyqbmiJb9pShft6XTdOLus/gvnPkwM4LKWfzZw
xjTfQN0HPZEu1b6/pdlLWzicAN3BfQbXdnH+FZb7eyd1b6q1zohwCJJmm9pH/v0/
fofpjcblpyvx2f3w4dwlbfszq1+8XRDYr38MBGXTOZKn78iyUYUwvoCxKhyJ7t+M
fDpi9V0TWUkxLPdr8Y2sHjB1ACdMM+gpDRdGfpXJW9zcVVWjPRRs6Ltp8ck8NGeH
gdfyyCmb5W1W2HTmn5M7/UxBCr0k9O01asi59f5Mq0BJyLSUx0E=
=bItX
-----END PGP SIGNATURE-----

--5wXc6glE45+qlMXy--
