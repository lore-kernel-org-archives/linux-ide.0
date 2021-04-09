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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02436C43460
	for <linux-ide@archiver.kernel.org>; Fri,  9 Apr 2021 11:25:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CFBE261165
	for <linux-ide@archiver.kernel.org>; Fri,  9 Apr 2021 11:25:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232815AbhDIL0H (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 9 Apr 2021 07:26:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231402AbhDIL0G (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 9 Apr 2021 07:26:06 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54073C061760;
        Fri,  9 Apr 2021 04:25:53 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id bx20so4971068edb.12;
        Fri, 09 Apr 2021 04:25:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=z3iRN/I24Xnjz+j7u+e6vGeVFrbk0mkTz1K2mX1+zZ4=;
        b=lu1+MscvHl6oYz2WRVYlnwFW4sV6Fxg8Dt5a6PFtxqn8iSZPVQA0jvOxvONLWKJzcf
         uBLEeUFYzQoaRB88la2aOnulhsqPRPbfM7AdD3Vw9k8nMr1BH5QzFnt9Nb1QWvISB51t
         VddpT+M5vXl+hYFKCJFaTuST0Y4VZoNW1rpm4SD5rmAX6J6kPBno2yzRU6PzbutuJA/G
         eBAOb3Bh7ESvcfqC+DCGU+1z3iXnyVHpe/sDhPrH97jwoog6D1HfG9ERo/1IiZ9aeGX+
         FqG5ESugET/I3+PWUV2tZzb7NOq6VaVVusFGtAKfCjcNwiGGdUdPjFcvz8YDHdP6FJki
         0jrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=z3iRN/I24Xnjz+j7u+e6vGeVFrbk0mkTz1K2mX1+zZ4=;
        b=fq2L6FXW2PBhuwSYSVPV7H8rTy/kCgjTPReVld7ctWjc3ogy94HZIEX38KA9lqwAWW
         ZGQJGZdIO7PejrmYFChHctCMHP+B7zLN3x8SoaaVEvah3DzoNxVGbU4GtnWxmbDjfSEd
         8sLZaBpwlZl63e2YCYo4+8EN9g+80VKDQ0NwcC9Iybcs8SvwldGFc5T3JT81KEV2pd4U
         VfK2sglXWBbINfl++so6fTo2eV34ObzqBPHUwFfLe1G/LuICGLL9mowpNC1rjDoLF42z
         nglxZnEg6QwDft4wXEOdTVmjT3fWK63g2JXJH3Ufo4rcc7NZHqvqs/4zxHJUeDZ27cts
         lrEA==
X-Gm-Message-State: AOAM533lO3bgPLiIHQ6rngW7rDK/5tGOVEoN+Sv2MeCkT1htFB1C/+SF
        3OwFVKqklVqs2b9IS/ztmC379K70tg0=
X-Google-Smtp-Source: ABdhPJwF/w41qz6XqwlgyMjkN5G3/aUYTUyE1FopaLpE5m91LzAeHeRGfDaHKJyyKw3CTvDssukkBg==
X-Received: by 2002:a05:6402:408:: with SMTP id q8mr16671807edv.201.1617967552100;
        Fri, 09 Apr 2021 04:25:52 -0700 (PDT)
Received: from localhost (pd9e51abe.dip0.t-ipconnect.de. [217.229.26.190])
        by smtp.gmail.com with ESMTPSA id d1sm1097407eje.26.2021.04.09.04.25.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Apr 2021 04:25:50 -0700 (PDT)
Date:   Fri, 9 Apr 2021 13:26:26 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Sowjanya Komatineni <skomatineni@nvidia.com>
Cc:     axboe@kernel.dk, digetx@gmail.com, jonathanh@nvidia.com,
        linux-ide@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] ata: ahci_tegra: call tegra_powergate_power_off only
 when PM domain is not present
Message-ID: <YHA54tOh2vLdrwXr@orome.fritz.box>
References: <1617915315-13639-1-git-send-email-skomatineni@nvidia.com>
 <1617915315-13639-2-git-send-email-skomatineni@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="fIkQHRLcmm9c6Rkl"
Content-Disposition: inline
In-Reply-To: <1617915315-13639-2-git-send-email-skomatineni@nvidia.com>
User-Agent: Mutt/2.0.6 (98f8cb83) (2021-03-06)
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org


--fIkQHRLcmm9c6Rkl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 08, 2021 at 01:55:15PM -0700, Sowjanya Komatineni wrote:
> This patch adds check to call legacy power domain API
> tegra_powergate_power_off() only when PM domain is not present.
>=20
> This is a follow-up patch to Tegra186 AHCI support patch series.
> ---
>  drivers/ata/ahci_tegra.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)

Acked-by: Thierry Reding <treding@nvidia.com>

--fIkQHRLcmm9c6Rkl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmBwOeIACgkQ3SOs138+
s6EK/w/8C9IWiy2sKUPiyf+jE7S7Trl3xGTfNCEvFEwGMUGWrm1vd9oCfpFNTZM0
x3teuqhV/jU86BHe/dGgegT6iAdCcwHZpV2ctb19ljSUkyfuk/jYFVFpJaBXMuHn
P/DPWiQRZJLCpFT+u+6eO+diQbmO7qxQfFsHx5yWFYg+1XtTm0nvYRP5RSeGhgYi
jOBER28uXpyGFzWloMYMkQSrBVkX9Jb6xguImfYhy1Z7WgtnMCt1eT9SeeCo/2y9
wtqBfVlK2RyxxAuWh8ss9GiCWM9pgyJEHjCurklkBJrnGukaiv3Ng3hwdYQvDRfL
BpjOi8fFSaV3EKk1pMqhWjcocKLHYTNk+Yz8Tx2g1b4HS+Sx5bfPtSeWdB/z67us
CvRNOCM1n43V/ZGq221cV6+y2qzwC98n6hxP0MwXZlxYOU5Tdtu7t5wBvJQeVDTm
PTBQJK1NiX8usbmgMy6E7d7VnLd71Xz7LiqzOkLHyURIRiungwWUjCGY/cLf1vGQ
Lea9lpDyxGLeO7HKCJEu4WBWB9kCTB5NMQIsUVYm75KiT3ycUCtFutTM8MfN/WlG
dzBwQSGIRK4JT3NPLD25dhEzT8wznqUjozOmpPtCqH5eaTuhhbK8gJIULRkY5MnM
7Qn88hpOXRFdOhcPNw4q0AhsSfoD5ILLTiJU+EGF2FEOZVkNhsw=
=yjN0
-----END PGP SIGNATURE-----

--fIkQHRLcmm9c6Rkl--
