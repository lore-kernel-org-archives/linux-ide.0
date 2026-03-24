Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A93453AB27F
	for <linux-ide@vger.kernel.org>; Tue, 24 Mar 2026 22:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774392698; cv=pass; b=c+YhTvFqPgJxfAlHY6z9NF0EZq1O/OiwjmUTVXbd+Ga7wd4i7Mglb4V/IOI6V+SbXIrZQsMfaReAGMcWEWRwsQRXMo5P5WnUWKpbmKf+1jhSlDDBMabugUxk3kdR//aGcLzdCn++fyBYEejaoB6NIBHKQ34JVufV01FRXpQL7ZU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774392698; c=relaxed/simple;
	bh=+qXP9sVKYUOKuJIDu7AMgVkUE6R3DEV9njuXFICjCso=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LiwgYO2uuP0l0rrlD7JdyWnyqd7/OBLx++xoHfRsIq9hbVFxJcWULp32Ucp3aBqmWZH7mmcL8qSncS+rfAjHsBser44TEXgZGfR2znCMpa7I8QhBGilIWxa1yLniIrEpuWcEDq/V6TY3fXDcyLrI55wJXxaCn8udu+Ucakgu/Vo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CwFHLGZC; arc=pass smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CwFHLGZC"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-b979d16dd0cso875628766b.1
        for <linux-ide@vger.kernel.org>; Tue, 24 Mar 2026 15:51:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774392695; cv=none;
        d=google.com; s=arc-20240605;
        b=klvwKuKKkWL2wdDSnrGZNghTmQw6ulE2Z1bzVJgsOYZMvPTbIbDS0YbbbXst4EVh3f
         mxb5n3P3L5cJn51ogp+m3l9o45UfLICwegCxbHYzORc8PpFgiCu25Mfm4EBk7/MbLluT
         j8eTEmWOcmvxeCo8hTRmzloEFTgViKC2jAIr3EjsGFIRprilblix0QQA6iF5bF5t4l9m
         d2IuqsWfDJvaMXlDX4UjC/vyHxNvWZu5+At9Ee+0k51YmWi53MGlmZ9W9KPKUGr7jY6+
         tDxiwRbFhyF7Lh2EbO2BZgA1DRb1UGoLJRWDrtaLdS0LWIe9Iq+l/nXjCkrv4rtv52S+
         vv9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=WctkEVUbtVnkK6Q8WGc9tEDZcZ0w4yuEbEhi4SlKtQ8=;
        fh=m41wtxscQeZ20atCrDQDEH1LsyXBAqZahhuPQTKb6D0=;
        b=PnhnrhTLGws3rs8lctJyin/PXmaAEMnPrLuOZFSiBdi6E13hMbgBtF8RAPZujrzltE
         fHD+auyh8H2Ers5OVQpHcizsD8cGl3+on5DLaA3ltiX0QGLfxq3ttR78Pb7d00jj0neZ
         aUHRSdljoAUtgd12qkt3ifrwooAM4DzLMD9m7LohcyINfQTiifIGsTvDNiFGuL56sTj4
         cZJbSSMeJHz9lebt37DVrWB6Jgyw8IbznPQAt3dvhDQvwvHTRN54yOzApJb6LLWKW0O7
         1fRzoUE87lBQDBPXJs2VENgf9mgqd7gbhxzV1/16oagCT4VgPcDtCK73RzocHG/pytLv
         Ju/w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774392695; x=1774997495; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WctkEVUbtVnkK6Q8WGc9tEDZcZ0w4yuEbEhi4SlKtQ8=;
        b=CwFHLGZCkJ1e03UPuiX5krsGaPLFQL7sxz4MEAMJgj0iehiDXizYP8ozliqrsuNn/T
         5guAt015LPCwQ9a2NVs3YloEX4mMEYor/XhcTXvOWZYJOPaDeDUydu71sri/uvlbv/cO
         Iq22vNQ/0ycpJwkmZdyMMb6Ss18k4vv41QXEDTcKxTlsSd+RRIW63vxAYbgcJfkKIR1Q
         Dzx3sa97fTCcRgEZhZD4/Y5jWJ0UcG3tWdqFz9NPPwGirVVvbf8im4A1EULwutNcRpdP
         mcEDSxHeq0Qnh+bxD79k0VIfqjceVhNHxCVXEr8DTkSIV8SrPa4kQX82UaQhhmQBudCV
         oMAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774392695; x=1774997495;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WctkEVUbtVnkK6Q8WGc9tEDZcZ0w4yuEbEhi4SlKtQ8=;
        b=i7RKTBYg45OK+vMgoNoJPnI/IaI4ys++b4Sru7p0UEjENzqxyX1sbFY861WBRe2nJg
         2PEBBRDVZnugRklTujLkfbV0eBFlAaTf/o50kJNxEROEbYSeErb2IaiSp0vbCRvrOJMJ
         QuDYosn3oJReWXnec8ohGdW3jB82AkVXVCmmfYkAYoMv3vzv9+hTWGpvMxzCa5nEXcvK
         YcxvpOT2uRW9KwDxzEBM60W8xZMT3RjyucGX9WWPQaQxoTt52jSWC7nrBfQ9Pt+IIfB6
         m2XM3DaIxU3ToQntzMxfcBJYPYaB40rsxaRy77LflOrCtHdd9guM5nH6ELsv/Z8XJMF0
         7ujA==
X-Gm-Message-State: AOJu0YwCMoSe9I+nNiT0+OX1W/vp+Z9m61IyoAieXmWcQPvuHR679Mqn
	C7uTb00Ax4c3lorJRripIa1N+1hF1p/VtkWP4FLs7QXoYOIsB/atu+DOjkLl2NcbGhXkucgxiLE
	V1sAl3p5xdcny4OFzbyulOqhR0m0JoSc=
X-Gm-Gg: ATEYQzwU/NkA2QIUyf4+DfV5JOvoa/OPbJiF7IisMDLZunifQD/yeF1LcI3Z/7iAfbz
	JdD2Q43XDxRglk/d6/WjQ1oZqOjyz5SURgQSDCmSPLMq5QIGHCivXaxWDXdSzOaeQ91AGJhft74
	EXDc09eO8aMyvDKzvruxouSpu/wDwhoEVN4vddtP1+kgZMfA2tRVScv1qiKaCgA9evcLZpooDK+
	Z1KBkk5L18F4qqEW8KIJAgmRzFzBkYSxCeRn6KH2Y8kU/V2MWMzsqVWcjaHls3ARcZTrRpeg8ih
	c7xmvAkt6fY36ia6eJMk7nxhFM5C0sPe3hI9Tcd6YI7DnFN3pQvG52FrMtpgvHzaJrHpG/xTIqD
	32Y2O+g==
X-Received: by 2002:a17:907:1b1a:b0:b94:858:5807 with SMTP id
 a640c23a62f3a-b9a3f1bfacdmr71915366b.25.1774392694712; Tue, 24 Mar 2026
 15:51:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260324211629.26924-1-rosenp@gmail.com> <a27f4314-f7dc-445d-ae24-909ac6b45b5e@kernel.org>
In-Reply-To: <a27f4314-f7dc-445d-ae24-909ac6b45b5e@kernel.org>
From: Rosen Penev <rosenp@gmail.com>
Date: Tue, 24 Mar 2026 15:51:22 -0700
X-Gm-Features: AQROBzDG9HLcy6ZZFtAcMMsz4Ap-uzTwEmXmIP_QB0BxHWCJBnLwKSo3zzcgR9s
Message-ID: <CAKxU2N8XTYbWBnuYe336PfXvKEYhmz3VN8k8Z3=E4p9-rt5YwQ@mail.gmail.com>
Subject: Re: [PATCH] ata: ahci_tegra: remove kcalloc
To: Damien Le Moal <dlemoal@kernel.org>
Cc: linux-ide@vger.kernel.org, Niklas Cassel <cassel@kernel.org>, 
	Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, 
	"open list:TEGRA ARCHITECTURE SUPPORT" <linux-tegra@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 24, 2026 at 3:10=E2=80=AFPM Damien Le Moal <dlemoal@kernel.org>=
 wrote:
>
> On 2026/03/24 14:16, Rosen Penev wrote:
> > Combine allocations into one by using a flexible array member.
> >
> > Signed-off-by: Rosen Penev <rosenp@gmail.com>
> > ---
> >  drivers/ata/ahci_tegra.c | 15 ++++++---------
> >  1 file changed, 6 insertions(+), 9 deletions(-)
> >
> > diff --git a/drivers/ata/ahci_tegra.c b/drivers/ata/ahci_tegra.c
> > index 44584eed6374..5972fe04ff3f 100644
> > --- a/drivers/ata/ahci_tegra.c
> > +++ b/drivers/ata/ahci_tegra.c
> > @@ -175,8 +175,9 @@ struct tegra_ahci_priv {
> >       struct reset_control       *sata_cold_rst;
> >       /* Needs special handling, cannot use ahci_platform */
> >       struct clk                 *sata_clk;
> > -     struct regulator_bulk_data *supplies;
> >       const struct tegra_ahci_soc *soc;
> > +
> > +     struct regulator_bulk_data supplies[];
>
> I think this needs a __counted_by() annotation, but not sure if that is p=
ossible
> given that soc->num_supplies is not in this structure. Might need a copy =
of it.
Is it really worth it to make a copy?
>
> >  };
> >
> >  static void tegra_ahci_handle_quirks(struct ahci_host_priv *hpriv)
> > @@ -512,6 +513,7 @@ static const struct scsi_host_template ahci_platfor=
m_sht =3D {
> >
> >  static int tegra_ahci_probe(struct platform_device *pdev)
> >  {
> > +     const struct tegra_ahci_soc *soc;
> >       struct ahci_host_priv *hpriv;
> >       struct tegra_ahci_priv *tegra;
> >       struct resource *res;
> > @@ -521,14 +523,15 @@ static int tegra_ahci_probe(struct platform_devic=
e *pdev)
> >       if (IS_ERR(hpriv))
> >               return PTR_ERR(hpriv);
> >
> > -     tegra =3D devm_kzalloc(&pdev->dev, sizeof(*tegra), GFP_KERNEL);
> > +     soc =3D of_device_get_match_data(&pdev->dev);
> > +     tegra =3D devm_kzalloc(&pdev->dev, struct_size(tegra, supplies, s=
oc->num_supplies), GFP_KERNEL);
> >       if (!tegra)
> >               return -ENOMEM;
> >
> >       hpriv->plat_data =3D tegra;
> >
> >       tegra->pdev =3D pdev;
> > -     tegra->soc =3D of_device_get_match_data(&pdev->dev);
> > +     tegra->soc =3D soc;
> >
> >       tegra->sata_regs =3D devm_platform_ioremap_resource(pdev, 1);
> >       if (IS_ERR(tegra->sata_regs))
> > @@ -571,12 +574,6 @@ static int tegra_ahci_probe(struct platform_device=
 *pdev)
> >               return PTR_ERR(tegra->sata_clk);
> >       }
> >
> > -     tegra->supplies =3D devm_kcalloc(&pdev->dev,
> > -                                    tegra->soc->num_supplies,
> > -                                    sizeof(*tegra->supplies), GFP_KERN=
EL);
> > -     if (!tegra->supplies)
> > -             return -ENOMEM;
> > -
> >       regulator_bulk_set_supply_names(tegra->supplies,
> >                                       tegra->soc->supply_names,
> >                                       tegra->soc->num_supplies);
>
>
> --
> Damien Le Moal
> Western Digital Research
