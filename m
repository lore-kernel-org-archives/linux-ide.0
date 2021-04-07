Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26EAEC43460
	for <linux-ide@archiver.kernel.org>; Wed,  7 Apr 2021 15:04:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0401D6139E
	for <linux-ide@archiver.kernel.org>; Wed,  7 Apr 2021 15:04:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353294AbhDGPEa (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 7 Apr 2021 11:04:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349164AbhDGPE3 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 7 Apr 2021 11:04:29 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 623A2C061756;
        Wed,  7 Apr 2021 08:04:18 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id n2so21980447ejy.7;
        Wed, 07 Apr 2021 08:04:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=lVnIXbBGBkETdl7KVyo5Gb61eNH9oJX+i+rpUHX8D7k=;
        b=vKcOS6h+BLqrHv8hrYFu6lChjX++K94oaUGNBdhl3RjJMJ2bsD6flBuhiMpoJQwB4A
         HRXIaGnKpVqguSDYslpESRRhiOcdZQSws75Z/lnnf6wz9OC+D430JN0ph3mQGLm9PJk2
         FO/wTBDoO4hb+5a3h+A+OHUOTCkmdYpxTIgqmswwtGkmQNZlznAjmZ+wY8ID+sHp2Ufb
         Bpahvcm3m1gNZeac/oSJzOkPFlGu6rqPKDco5zhF7TFWDqG68HzyirfAl9W8nrVZ+iEy
         SXYp6DINdjlZJm9hmOvKmivNe1MbS4d3m1s00lxG/+xRVaDXKzUnbLz6ZrxykBkHrRz+
         jjzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=lVnIXbBGBkETdl7KVyo5Gb61eNH9oJX+i+rpUHX8D7k=;
        b=igIIFql9EBmqI2Peip5vm5iORmzh0rANBXwaidfUTfc2dHSnj4qrAMBMaDAg8oo+38
         Q8s6bztgjL1gZysa3eK7aM8bBReyAsyUr4bsyimSop2CBbMxBpwlRYMvxqWUhUi9VYhO
         vAS7FNLErM2m+He3PIUwI3J0Iku4WDvQDI0MlQEp1Wq3AfrM6o0YjmCXHqx1oU9edWFK
         CJ83uhbxJHvRg203KoB3RYIsMnm7OKxvLitfX9gWw4ITHKbd3kKupaaLF3pj22IscEY2
         XF21Lj6pgPM1RJZUu6ao5y0BJ3TDnX44bYDRtscCdkMuR95zGX8t/hPLLtg0Mow0mNs9
         jHXQ==
X-Gm-Message-State: AOAM533XIyeToiK/BAj0iFUfGcTkwjX0MkPXGBmx3vUOP3H2QZUzX46Q
        n2IJNq7COfEktCF27cPIyxc=
X-Google-Smtp-Source: ABdhPJyi3VO48xXobhLvjUSy3+0Xq2NULPIPobVnvNcYvz1nYd/4GR7EjN35vQYM4MaRJBxr2OMNaw==
X-Received: by 2002:a17:906:c058:: with SMTP id bm24mr4247830ejb.335.1617807857181;
        Wed, 07 Apr 2021 08:04:17 -0700 (PDT)
Received: from localhost ([62.96.65.119])
        by smtp.gmail.com with ESMTPSA id t1sm3080709eds.53.2021.04.07.08.04.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Apr 2021 08:04:15 -0700 (PDT)
Date:   Wed, 7 Apr 2021 17:04:50 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Sowjanya Komatineni <skomatineni@nvidia.com>
Cc:     axboe@kernel.dk, jonathanh@nvidia.com, robh+dt@kernel.org,
        pchandru@nvidia.com, devicetree@vger.kernel.org,
        linux-ide@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/3] dt-binding: ata: tegra: Add dt-binding
 documentation for Tegra186
Message-ID: <YG3KErgCxoJIudV7@orome.fritz.box>
References: <1617758731-12380-1-git-send-email-skomatineni@nvidia.com>
 <1617758731-12380-3-git-send-email-skomatineni@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="6LA5F7Xuy6+H6lVt"
Content-Disposition: inline
In-Reply-To: <1617758731-12380-3-git-send-email-skomatineni@nvidia.com>
User-Agent: Mutt/2.0.6 (98f8cb83) (2021-03-06)
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org


--6LA5F7Xuy6+H6lVt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 06, 2021 at 06:25:30PM -0700, Sowjanya Komatineni wrote:
> This patch adds dt-bindings documentation for Tegra186 AHCI
> controller.
>=20
> Reviewed-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
> ---
>  .../devicetree/bindings/ata/nvidia,tegra-ahci.yaml | 38 ++++++++++++++++=
++++++
>  1 file changed, 38 insertions(+)

Acked-by: Thierry Reding <treding@nvidia.com>

--6LA5F7Xuy6+H6lVt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmBtyhIACgkQ3SOs138+
s6HArA/9Ej0NtWGSl4Rb71JHX/hU7jS3yBcGdQ0TdbhTYg5nfKoNSYvDs9SEqAyQ
usMUc8IJHz+tl6gBgFlnnkfTlglDPJmktXgR1N11cxOfmiZDr/uMtmwdjJveJSuI
OTYvEFflQ/scepQp2h3sVC7RvRQD7RVHBggBS79w6apSpMIDUu7on22+cEZBDYnN
cU3zQCRjelRv58PLAMwXvhD9I7jgaNLWiVMxGFw5F+UxrcqzVR4MYcpIFf00sET6
cjla3lWqB4zHI0mEe6PoHBdnbLoNGgZ8Wxum7jPLQkUtbVERHSSR+8K56wjvztt2
r3zebPe1lV5WheTMG9HsV+Z7xK6YBJUC7uYS1Nf1f+S0jLVLw9CcucODOj5KDzDq
q3iduFLstOJQ0eJnkeOWFyxn8bu2dccsxHiiazAclqxz94N4lvK5zcQy+CTZQ246
TpvsqrhOvL7wSJane8NJft6Ic8/8ZWLYd7wtT+gLB9yz4DxFJkJK3t5AJRvkCRAM
9peQrENxvmxZIInTZ1MeNcaaFkorj8INdfBstO8OnwU6jYW0BmiWApjZgGNLWZ/J
f4MtXMAtbrdBFXRm8DGGmIx0ig9ABvPYo1bpWLMpVyMr5ywNU4lQWwF6kvLvTlpe
Qag1ptWg4ZKFSYCTwxfCWXDdvzXSV22d9BEaoZ+qDzZGUOPjkm8=
=P1Nx
-----END PGP SIGNATURE-----

--6LA5F7Xuy6+H6lVt--
