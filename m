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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51108C433ED
	for <linux-ide@archiver.kernel.org>; Wed,  7 Apr 2021 15:04:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 30BCC6113D
	for <linux-ide@archiver.kernel.org>; Wed,  7 Apr 2021 15:04:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353285AbhDGPET (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 7 Apr 2021 11:04:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353287AbhDGPES (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 7 Apr 2021 11:04:18 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30667C061756;
        Wed,  7 Apr 2021 08:04:07 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id b7so28260224ejv.1;
        Wed, 07 Apr 2021 08:04:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=1t4RL4yv0gY9xykK7QETl02rSiyVW266AV2ADMw4tEg=;
        b=Ht2LkJG2M6J280K78XIWrSR9Gbtz0z4CIlzOnl/FVzC9qkHm1/YpsaHXO817GTOYm+
         LwFXLQ2Z7bBN6DGmmgL1s8ZSFU27Mn6BIZQTHaco3s5deX0KkJ5DjbNkEA38NJ3mLf9x
         7Ug4HZdqb6mcqTd7AWsp3ecxH4wcb3rgIg58Pn9wTNTwJjGk0LN1Moq4krf06ilcNKEN
         4f8tn1yDMEWEEvt1P+m7zixz9TuCavGCaeTpJGov7HYiDA3UeFoiZXcAspSxv3L3p0D2
         LSt4fP1bsGk+z1wzjvTfXXqm3lUt8ujaBQrR8PAGCUfuGXzahPkzS5DAJBwxqej/xJ3c
         7r5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=1t4RL4yv0gY9xykK7QETl02rSiyVW266AV2ADMw4tEg=;
        b=M0yLAu18PZQOX8ZNMz/4yUmpWdKR3+zlnfChSo29hnrKduEH3ciUjNtleNJEcYBW5l
         3mZbSltoVGRWJVxPRaWaFepqBXFAFsGpEyQZeNvKnHp95pjRPqJ4KkJ9YpoUxjztwTxt
         MxFk8PJHIRONvJL3WyJaFMlCaD2WzaHY62+VNfJWDLuaZlf4iE+pJxxvfKNTMitoQNu+
         rhNg07TwacQPWEny7TJM7UGHNiPTtRvliS5rMr2Sr1WAAjR8l9l7FTZY5H9tiBAzpy0Z
         yJFobis6ztM0aXvBxHEpXBHCweZ3Dzp0wqOe0UvIGylgoe5luz8uzbjOxYeW7CowxIJs
         GzDg==
X-Gm-Message-State: AOAM532pXIAtOWY2daiCiK8QRldeVQM1KeoU4BbsOMBUqqizodpnoqRT
        y5n6dhlr4vXExwCWl+y87ZXqiQzazyQ=
X-Google-Smtp-Source: ABdhPJyqRYwVP8aGoIneu6ErqOgqrfPMFnLcI7ea1bveeQFKSZeBTOVvH2J2svkUf1SwKgG6S9gJDQ==
X-Received: by 2002:a17:906:f42:: with SMTP id h2mr2986949ejj.317.1617807845921;
        Wed, 07 Apr 2021 08:04:05 -0700 (PDT)
Received: from localhost ([62.96.65.119])
        by smtp.gmail.com with ESMTPSA id z4sm2995442edb.97.2021.04.07.08.04.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Apr 2021 08:04:04 -0700 (PDT)
Date:   Wed, 7 Apr 2021 17:04:39 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Sowjanya Komatineni <skomatineni@nvidia.com>
Cc:     axboe@kernel.dk, jonathanh@nvidia.com, robh+dt@kernel.org,
        pchandru@nvidia.com, devicetree@vger.kernel.org,
        linux-ide@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/3] dt-bindings: ata: tegra: Convert binding
 documentation to YAML
Message-ID: <YG3KB/gWWuu60AZG@orome.fritz.box>
References: <1617758731-12380-1-git-send-email-skomatineni@nvidia.com>
 <1617758731-12380-2-git-send-email-skomatineni@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="5mb2SXUnzjXTbYRb"
Content-Disposition: inline
In-Reply-To: <1617758731-12380-2-git-send-email-skomatineni@nvidia.com>
User-Agent: Mutt/2.0.6 (98f8cb83) (2021-03-06)
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org


--5mb2SXUnzjXTbYRb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 06, 2021 at 06:25:29PM -0700, Sowjanya Komatineni wrote:
> This patch converts text based dt-binding document to YAML based
> dt-binding document.
>=20
> Reviewed-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
> ---
>  .../devicetree/bindings/ata/nvidia,tegra-ahci.yaml | 138 +++++++++++++++=
++++++
>  .../bindings/ata/nvidia,tegra124-ahci.txt          |  44 -------
>  2 files changed, 138 insertions(+), 44 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/ata/nvidia,tegra-ah=
ci.yaml
>  delete mode 100644 Documentation/devicetree/bindings/ata/nvidia,tegra124=
-ahci.txt

Acked-by: Thierry Reding <treding@nvidia.com>

--5mb2SXUnzjXTbYRb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmBtygYACgkQ3SOs138+
s6H6hw//c3uqroCC9lbnly0fq8JL13Z8EsOwQuwqSkQqXGuCjNg1zbxHd9d8viFq
NKbXyluX/5Pycwtkfh9BDusg3N+nz2BnmWEE7mp8Ly4Xr3uWSg7EzrIwuVNoLn2J
4ZN8j0YgIjiksYf5nvSEcn3zOtwIrAf/3l5tRDuqWQI7d6ZLApjBjwjNmkU6CWg2
dxK/1v2hnMuVO6Lg85NmjhlMHZy/V+NiTb8doqL5ufMYIL4pcxpOQLPBe7IBRZw2
ViEioKTV2RdMrFAYlf8xKoe+/rQDXxr2BzjTpS1L0+usLcQi8L7P+O1XlhxG6HXY
VYSlz8cRNxcO+aQZoIWfatpgkdjiy5VTHUYiaQa8PiT6b+uXJ0PduoWLlXFCgoMo
TCqj8mYyBwipNpNuU2KkBNSBo/tahEn+WQIdad/IbDwXnjRdUjNXv9np+QMOyPJa
p1qGz9b5zF0M9u1UreDGqYQ4eXT8lTYf4x/6y376YWN/2zKtVJ6tc+ExcLIIcXHU
ReD1wtJb/+vLcz3Mu41bSGRVXBJui/P52XlILahqkqVVYOcOpfdyZxuCdFlUNdNZ
TSqlyI9rN3moHTUOgsyi9m/1SVezQLWGj27/N/vw/cht00zUrCHRTnTlm7jUrbNl
/Q4KL5Y35mSCnLM8xAiGIxIWhIQ1USyLyM8LLcONhj1lJv0bwUw=
=K5hz
-----END PGP SIGNATURE-----

--5mb2SXUnzjXTbYRb--
