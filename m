Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AD4626ED3A
	for <linux-ide@vger.kernel.org>; Thu,  9 Jul 2026 05:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783574616; cv=pass; b=WGlHpHIS/Ukkk9mfI8ist5/JpHdBG+uCg7Yyx7F6wAkgDNxXkxgLeNLa6od5nyPBPR5SgiyssXbDv7c/3nndQ7bLYAbBpDqoAlSRXpGIwqLX0E2Mtxo+GiNBVz2PrtxEcHVA9SPEtFMX5dic7kLpWteFbunJq/BDIsNBIMTckhk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783574616; c=relaxed/simple;
	bh=N4IaFh4irsPi9G/nPjxoICQH42HqckBrZkiXKWwClDo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Wo3dNnBycO0PzYO+VMi0PYxtUeK6ZW4sz5RsmOkkVYfWK5Sbh5NHElrod5Awkt89xHsuP3fN23heWPhzOtR7PzU/31t9/CfyDih/WmlkNUnQpLZBw8gZpVp4cEAdEmxGNERD9troe2F/Jd17thC/9Z5O4demHgxiszjmVq0xMyM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ycf4rv7+; arc=pass smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ycf4rv7+"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-698bf053053so2469098a12.3
        for <linux-ide@vger.kernel.org>; Wed, 08 Jul 2026 22:23:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783574613; cv=none;
        d=google.com; s=arc-20260327;
        b=FTSZ7VJ/pn4aIyodvM9QF/KCEeFPu6/sxs4K7klu2Ir75ppFl4QAQNRC1sjb26/kDY
         nDFFwTYmcZXS0Uvk7klSYdTj98B+ihQbYWqRxOkpuN1IGC3hO2PN6hrxvliRh1W674aj
         UWaAnR/M1HzS0m1PUSr41co4mOG1X8aPwIVbKDOYwfUvIXj5XuLdiXZZFllz4S0G69In
         AZ8tqRfuHPvr2PbqBCUmwSusIGwq1+M+Zfoh+9SGwJS7qKXB3I2/K4JUYo3cC/BA7CR4
         lt11G1fMwVHNrq9Z8kQ1DvnjeltcbBc8qBzvkCaiND2dt0pAVJ1D3mhTS0DoJowDq1pN
         hQtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=3jYMuHN3mp22w1LNXaX78paFZMrbcZqtJQFGUwmQCoc=;
        fh=auVoQHEGSnzUss1Bb8UIwBAdpNHqUnX0mKWe35mvJ04=;
        b=Z5oey6pdZ6ZYMYhd39291kaGvSbDkY0uuhd5Zg6JmMS2enCrip86wcvuyRScljDuCu
         xBuo6CXuYV3a/Egv9hU0O0rfckS2LAAh9xGtjeKX1xho/3/lOiwrXmG/jv3vR4WBbnX6
         lczYc2cEVaP8QfegYvBwn6eZe+m4j8vYSj3xgpphlODm7IC1tilkihlVAFRpT2IEwj8N
         B+SE7lzcWE1C3UcL9tKnlwdReMLWDHAtTO3utbxE0pZh0X6Xc4dbHGPNBr8SmdJidKuA
         Xe6QM43jthy/dGOM9P8VIqkJaN9cp/hWJREtoVAww/LD2dvpAuRs8OzSZ6pnqZUDqORb
         kvNA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783574613; x=1784179413; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=3jYMuHN3mp22w1LNXaX78paFZMrbcZqtJQFGUwmQCoc=;
        b=Ycf4rv7+Ex2GD5m4poJ+yI45JAdxAWCNaJzZ1LhadtHlORtiEmLr2TZmgJX6qtd9EW
         ro4ppIQK8Gazx0J0q+ElKf0DwuLGptyttCjcPKcHlPL3rDJ4XgzUQFXzZZkqM/v+dviz
         RHza9jwF+DUvBZMmcKVP/R3kfSnNi/bg1rQgH47yWWm0f65nlZ9TGx8OdFSr8yHRAuZz
         SRw7rI2haN3c5JbqxB6BSP63RP2mbNF15ixmsKNxlHPmS6OH1+K45PmJJnrYUBMqt/a4
         WsWerRPQaMd/uK5C610wI6nomZtlj2V406DAs3P3Nh0ZIlsI97nM7KJPjEKqeoVfxWxU
         s9pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783574613; x=1784179413;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3jYMuHN3mp22w1LNXaX78paFZMrbcZqtJQFGUwmQCoc=;
        b=X/GfO2uj+zWbQ7iD18l7CqHLqJRl0nBWWx5xPPwAHZTbUJxal2eEwOn9Z8MXiZiz+D
         deWV14V8iszKsaVv6h2NVNaNH6JKAtTnNtDASmVcHC5ZOzLPcWEKTdDa407zzhWhChuO
         fWGUIEwmXzmtfKOnVLCsVxNuUZNL3sRmqWm4Gq8bFBEI4ofA7HAhiuCJEbgEy1K9VhJ1
         ZcuvdSR3ZSFFQzu1lg/0EamAHb5B1xJyOKnexEVdeySj9RCI97RIV+XJETQZmOnNbVUN
         uCvVQTnO9Ls+BOHVbB4Nw1MWzrcJjgxsKRYQZTnpjD3+q9NQTP82D/VmfYV6sxw6zYg2
         //Bg==
X-Forwarded-Encrypted: i=1; AHgh+Rps3Qx5fzkC/38gQJar+3nuybA6VI45ujhSUK5OqpfR1KXj02o5ydUzP+A0g+5tm8e0NQeTNshyl+k=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXTRQT+6qSWGX1UmOXKuIvywoBGiw9ugHuVdy0xMjrGQFH1Kvf
	8jL00iNuS1QBJPuZEmpU/UVowaXx44IXyvmoxDZnpTJsdwls05i/BszA3Jhbrwbdvc0/e4fVRA5
	GX2pMi3LuB/Hgup2IYNTA0o9meZvE1Us=
X-Gm-Gg: AfdE7cmF4Qs/5VhtGGYX668OTFHwWtnR8hu84K2vaHqINKB9w4s3UI0pFmmpDfAS5ZZ
	ZA2RVHWVCmo2vnIale+8+HjEPwfgjeO9G/SKppTK7tA7RiobTBhaoo0vPKMtNsO2jDcII/rl9PU
	05Si0YIZkZlwuUYy5iuFevL/pQLamqs/AgdPO0k7ds3WpwEUOjGUXse9sUluYGNTHYORdUujXWB
	M+W43SODO5qgu34fHamhiMrd5DQycWguh9HIdQheEvPrQpTazyRzK1S1FzckevbiMul3vY/5Ofo
	snNXPYsxsiStM9uAPRG2Dvrnctobt3m8xkQ6PGP8IuCA4T7xu4kWEzN7Sj8IuAlJKC0WBQa4Rvp
	QKAV2mVV7nL8znZQAGOW06x25VZy3OJgavb+S2eQR+fM886JnFUpg0IAHOcY83V7eTibvYFB9rj
	fNxQ9tvvaLHP+Fs5TJW7Or7z0y2MChi0xnPhSBVw==
X-Received: by 2002:a05:6402:2691:b0:698:3365:f94a with SMTP id
 4fb4d7f45d1cf-69ab4460df3mr2297290a12.15.1783574612726; Wed, 08 Jul 2026
 22:23:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260709023202.2132165-1-rosenp@gmail.com> <20260709023202.2132165-2-rosenp@gmail.com>
 <20260709024713.58EC71F000E9@smtp.kernel.org>
In-Reply-To: <20260709024713.58EC71F000E9@smtp.kernel.org>
From: Rosen Penev <rosenp@gmail.com>
Date: Wed, 8 Jul 2026 22:23:21 -0700
X-Gm-Features: AUfX_mxUsrbMf_vMjOrBztQg0DDni59xq5EgO9N7xFeXpzk-Tve9U0tz1DayLso
Message-ID: <CAKxU2N-S33sLoJc1M5idCx7ma1aw=LcBdjtyaMaKHMo-ci17Eg@mail.gmail.com>
Subject: Re: [PATCHv3 1/5] ata: sata_dwc_460ex: use platform_get_irq()
To: sashiko-reviews@lists.linux.dev
Cc: cassel@kernel.org, linux-ide@vger.kernel.org, dlemoal@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 8, 2026 at 7:47=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [Low] The patch removes the local variable `np` from `sata_dwc_probe()`=
, causing a build failure when `CONFIG_SATA_DWC_OLD_DMA` is enabled.
Rebasing error. Will fix.
> --
>
> --- Patch [1]: [PATCHv3 1/5] ata: sata_dwc_460ex: use platform_get_irq() =
---
> commit 74bc1be9c4385029a4079d000bf78ff4452fc266
> Author: Rosen Penev <rosenp@gmail.com>
>
> ata: sata_dwc_460ex: use platform_get_irq()
>
> This commit replaces irq_of_parse_and_map() with platform_get_irq() in bo=
th
> sata_dwc_dma_init_old() and sata_dwc_probe(). It improves error handling =
for
> IRQs and removes the unnecessary include of of_irq.h.
>
> > diff --git a/drivers/ata/sata_dwc_460ex.c b/drivers/ata/sata_dwc_460ex.=
c
> > index 4fc22ce4bd9aa..442c6e9d06e0a 100644
> > --- a/drivers/ata/sata_dwc_460ex.c
> > +++ b/drivers/ata/sata_dwc_460ex.c
>
> [ ... ]
>
> > @@ -1126,7 +1122,6 @@ static const struct ata_port_info sata_dwc_port_i=
nfo[] =3D {
> >  static int sata_dwc_probe(struct platform_device *ofdev)
> >  {
> >       struct device *dev =3D &ofdev->dev;
> > -     struct device_node *np =3D dev->of_node;
> >       struct sata_dwc_device *hsdev;
> >       u32 idr, versionr;
> >       char *ver =3D (char *)&versionr;
>
> [ ... ]
>
> > @@ -1173,11 +1168,9 @@ static int sata_dwc_probe(struct platform_device=
 *ofdev)
> >       sata_dwc_enable_interrupts(hsdev);
> >
> >       /* Get SATA interrupt number */
> > -     irq =3D irq_of_parse_and_map(np, 0);
> > -     if (!irq) {
> > -             dev_err(dev, "no SATA DMA irq\n");
> > -             return -ENODEV;
> > -     }
> > +     irq =3D platform_get_irq(ofdev, 0);
> > +     if (irq < 0)
> > +             return irq;
> >
> >  #ifdef CONFIG_SATA_DWC_OLD_DMA
> >       if (!of_property_present(np, "dmas")) {
>
> [Severity: Low]
> Will this cause a build failure when compiling with CONFIG_SATA_DWC_OLD_D=
MA
> enabled?
>
> The earlier hunk removes the declaration of the np variable, but it appea=
rs
> to still be referenced here in sata_dwc_probe(). Could dev->of_node be pa=
ssed
> to of_property_present() instead to avoid an undeclared identifier error?
>
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260709023202.21=
32165-2-rosenp@gmail.com?part=3D1
