Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFA2CC433ED
	for <linux-ide@archiver.kernel.org>; Wed,  7 Apr 2021 16:17:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B9E5F61130
	for <linux-ide@archiver.kernel.org>; Wed,  7 Apr 2021 16:17:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354183AbhDGQRr (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 7 Apr 2021 12:17:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354182AbhDGQRl (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 7 Apr 2021 12:17:41 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 327E0C06175F;
        Wed,  7 Apr 2021 09:17:31 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id e14so28582662ejz.11;
        Wed, 07 Apr 2021 09:17:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=E8zFxr7NTo5CVZvglNHBf+7krWpX2RzvWzJMpcR4yQU=;
        b=nTdujkw1uKq0S+SGJxBR8r4B714AbaSBM0uux059cqF/rz53V7JLDV2iDWvUCb/tCQ
         5Y1mY69mbqp9i9TJDomEL8v4pXcWgPLxaBZw0XZgvW4V5hCsk8WNAdQl1oq2BcLv4I2P
         +sCgF7GEU+dgun4r4vaLg7LpGk4QmVZec/7un2SmsUOu+8txNhiav4ux1K7bDB6PYbBu
         1rEInprdjhMmOcqFjfiFR0jGe8WHBfTGC7FrQvOBBvhvEAOQAvOWIQzTHRsmR156zcda
         snPrUYPi2vlrfh86+D0fS1GRrdTzp6txhxunoeAmNOZmhmN9MxIMbb5dM42FQZiFdFjz
         oQ5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=E8zFxr7NTo5CVZvglNHBf+7krWpX2RzvWzJMpcR4yQU=;
        b=WRUAshukbHdyJp63tqFT9kmAsr2CpwqdBBfD5XTXwyk7RCkL+/a4OSXX5d/4gSRHyP
         Dz5wXlCFgWHXs6zjsZ7VSp3G985eYUxf18hYf6NMix/JFecR0VdneSw2IXvjmAJsVO0/
         46UFeGZS42MgS1TWWpWuXiLuIajwISrV5bVFSWH3V4HCN4/7cIH8TO+IfxmHMosO8/ZK
         9uGJSZF6CD3wqtr9qBUEdIUztoo4GWEbtfD5gEHZfnPSnE6nr7D67hvcEVuf+mjVYzM6
         1gLSpEInC0JQEb7tnRROr5DbE255w16c1lejM3vsX1Z5nlY4iCWql7LFQbl77/yZXsqG
         w6BA==
X-Gm-Message-State: AOAM5315IxKY2Qt4eu/T0XU0u9VT3x8kmkySg2X8p70/LG0LiVXBRcBc
        +6g5jdpW8X581bu+q1UytbQ=
X-Google-Smtp-Source: ABdhPJzibXBuHU2/Tw83MRchlZG+MGW5RIuCWWBmiEydazdb5ErzQqiWilYI8nC8rrxaSzXhlg/ykw==
X-Received: by 2002:a17:906:2793:: with SMTP id j19mr4733929ejc.205.1617812249930;
        Wed, 07 Apr 2021 09:17:29 -0700 (PDT)
Received: from localhost ([62.96.65.119])
        by smtp.gmail.com with ESMTPSA id t14sm12841163ejc.121.2021.04.07.09.17.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Apr 2021 09:17:28 -0700 (PDT)
Date:   Wed, 7 Apr 2021 18:18:02 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Sowjanya Komatineni <skomatineni@nvidia.com>, jonathanh@nvidia.com,
        robh+dt@kernel.org, pchandru@nvidia.com,
        devicetree@vger.kernel.org, linux-ide@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/3] Add AHCI support for Tegra186
Message-ID: <YG3bOn97gryKOmec@orome.fritz.box>
References: <1617758731-12380-1-git-send-email-skomatineni@nvidia.com>
 <2cf9a0ee-034c-7d31-1fa4-66e6ad3ceb43@kernel.dk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="NR+2S+88HvHbjOWn"
Content-Disposition: inline
In-Reply-To: <2cf9a0ee-034c-7d31-1fa4-66e6ad3ceb43@kernel.dk>
User-Agent: Mutt/2.0.6 (98f8cb83) (2021-03-06)
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org


--NR+2S+88HvHbjOWn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 07, 2021 at 09:44:58AM -0600, Jens Axboe wrote:
> On 4/6/21 7:25 PM, Sowjanya Komatineni wrote:
> > Re-sending dt-binding and ahci_tegra driver patches as v4 as device
> > tree patches from v3 are merged but not the AHCI Tegra driver.
> >=20
> > Missed to add Jens Axboe to mailing list in v3. Adding for v4.
> >=20
> > This series adds support for AHCI-compliant SATA to Tegra186 SoC.
> >=20
> > This series includes patches for
> > - Converting text based dt-binding document to YAML.
> > - Adding dt-bindings for Tegra186.
> > - Adding Tegra186 support to Tegra AHCI driver.
> >=20
> > Delta between patch versions:
> > [v4]:	Same as v3 except removed device tree patches as they are
> > 	merged.
> > [v3]:	fixed yaml example to pass dt_binding_check
> > [v2]:	v1 feedback related to yaml dt-binding.
> > 	Removed conditional reset order in yaml and updated dts files
> > 	to maintain same order for commonly available resets across
> > 	Tegra124 thru Tegra186.
>=20
> Assuming the libata tree is the best way for this to go in, so I applied
> it for 5.13.

Perfect! Thanks Jens.

Thierry

--NR+2S+88HvHbjOWn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmBt2zgACgkQ3SOs138+
s6HiwhAAib4j7/WG24WBtUVkrErzlRsDdYMKySHqLxp2k8MZZLzSlItK3rZ77zT6
oPPPBAnxQiM2HLF4Ca+fSo13xO7qnn+5FKX8WtapcG+CUuim0z/eKif+N3SoXAx9
VZmfQsLJeJfGcTpE5Wvi35eU8mzH1QK7q6Jfk1duD5ITTv+zA8Qx1vHNAmVC0Ali
QGKBmOUzdGDnkOu23ZwlV+J0Z4PF1iwxQExiy2MBgjKBSpK+Ba+aZyfWdiv7hC6b
XD8bYC+5KKKJlGfHiF8Z9CeIeiUUsH8GhHIYgcfmERJkhdbGJEGHNe7ZfJwyqC0M
fvG4UW5gM42Cvg9kEO9DQnv9YNl76W/k8hZYACjmRFoD5s+3ZZltmYNa07evFWld
ypcO75ZlhIK1Lzckl72pIctQyaINIeTzkvvPBZsPiqEG4f8DsSjipbtqHP2V/2Fg
vTr0qU38hX+S0MflqlyvxsfCtJ6FqknnxxqDsA/6Sx3vC9ul7gt2nlj72MGuhqSe
290rjC5jjI0pl76j5/P581Ci01TNHgnwTAg07h7LQkU7h1xV3Ycfaaoi+soCapLW
Q9xAoCqrGVPZVBMHH7+eR+pkZDbSr36MAnIuZWrbpSBMlT7dx4r8WnMGaf8Zy9np
xv9ukSGWOVCgIvY13MSsGUpzu2HDoP+zQuefe0m/FlTKMksUbuY=
=MTYu
-----END PGP SIGNATURE-----

--NR+2S+88HvHbjOWn--
