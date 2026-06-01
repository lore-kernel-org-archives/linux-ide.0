Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DCE4360EC2
	for <linux-ide@vger.kernel.org>; Mon,  1 Jun 2026 19:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780340767; cv=pass; b=HrTVRYaX4p3cZmlTt4JXPlXpm4DXDDi0I8GGn9vL2a06baE4lDfW5xqIoKYBHui4mWYyQxbhlUA2mZ1FrRPB3QP8hgEmz0kfBygdJFZ197sh35TU6KQHnvT9hCLy0frNAlYodRal6s+hplQYeC/XoPSUhbp6konZK9SYqaagVHo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780340767; c=relaxed/simple;
	bh=dsNHqGMwTUPlrUfe55QMxdZJILtC75BjFNl1GeWCT5w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cC8ZMJIsiyZpQoPQ8+jajpBaiJGX7pfaQERly9X1DkBsrqHplN4LslaMoy6t/kRgVC+XPcJ1MzSkPHwQUmkH51ZtJMVf6sFRKozWIOAfcSbydXVtPayGtF2O2+gsJB6uoyO0hrMk14Qv/lx/O+qm04M+n5yHfJmu2BhyLPCVK8I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gZI+FUg7; arc=pass smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gZI+FUg7"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-68ae265815aso7690135a12.1
        for <linux-ide@vger.kernel.org>; Mon, 01 Jun 2026 12:06:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780340763; cv=none;
        d=google.com; s=arc-20240605;
        b=YPWHmWxiYZPXPfpEEolLYXBUlPx9kCUtNnXrevf86uzTWMe0E/UJcyrBIZYSiUALMk
         tCHbbqJuos3gkSJs6FFBKaX1TJCfrB6fVXZNH1coBYmBxgcLNszu7sK6NOeH/8WKW54l
         ge9fnkLnL/0BSBcw2OELaaaUFOvdWIY/GrQ5RS3EAb/uxbDdfBVWCMYbz3RyNtFoyW+n
         6zuALK7/awKhe+eGk+G7LnJGrCyXcbn84mCJ1FW3wS2oQW4GAQ61gLdCXNvvpVD9tPXm
         XA3J8F2c6TgAXjMES9edsZYVX5iyBxLcrOZvcavEWTBSkFPbGiIn99wZ48Yf0DxuWI1Q
         Gg8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=8ToRh5cKTPUe+pKq487HFcup2FxYOsRDUpBYxyNWwsg=;
        fh=CevGES2AFLxh77zkXsdBdBroN5O9WERkcETXwr7159A=;
        b=TGdMQdOO3LOfuZOpMIcKrZK0qfWxXb4yYNvrZCuonfL+qGpZB2eDcMzmwmm5L053OK
         jx6O6TKFMZJgWn8nphtOIuVYbYVpyxmsiVI5V47PQUnWiRLpXIfI/MEq4KsAOFSRgXeI
         nCxn03UrdwgBy69YUCluVq4fKGRK6qEvaTdoNvX3xapbZf2ye03Z+eDoj7IGo2pku9vi
         m6Xz0i0p0Wh6enyGRn5nLo4Z2H4twdOcS5iksVOr6rip3SYUtpiwwxrB+aQVdq+BAQY2
         kWYznLD/4UtYsNF0AuYrRYE9lTpiGajGYvDpqM13bmKq94iudI+GYdYNGP3Oum0IcGtm
         akMg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780340763; x=1780945563; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8ToRh5cKTPUe+pKq487HFcup2FxYOsRDUpBYxyNWwsg=;
        b=gZI+FUg7rK8AaJB+rgXBO9SRTzIKc84BdHXVxhnrO8F1CibsxftDXfnUFvI8mGC7FT
         09mZhaxJru0uJ5wd9waHgNhsoy3cnJSmq4S/ryAQic+EjMaITEREYNbZFp5ZDYCaCWgK
         7BbP/BWfsHBhJccrNHHzgsiW+kA2Ey/w3ph5DGoobit+mJv+DobOaCDKr8ETY7VwMT51
         x0XV7bfo6MGOd8ru8YEs2n41dw+dP5ebEOep5oo70aZMjflIWYaNBcpUanBOCqhds2xy
         cTkgFKprNREjfCBPbE5AcyifLB3tAoRfTFxgBzNGTfQUsRH7DbfrNdzyor3C/EWZKAEM
         FAnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780340763; x=1780945563;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8ToRh5cKTPUe+pKq487HFcup2FxYOsRDUpBYxyNWwsg=;
        b=arAjQBq1ozuLxWhUyZ93oN0PqNAOYIp9IrQar231ArPnYW2nIHU60S1twSss+Eh7rc
         hd3LIsU/3mfnsB8xlJoHRoaWyzmt7UWP32PIFp3uK2NyMkLUxKS3UKl79IJ2aXLVN7kq
         XO/u2UiO6TckNyhmCBgkdGQramwcr4qwllZnubObEdBZ7MW+ZcfMWvSQIGyECyPbT2g3
         4+gzgAmRtSdv73r//9wuw0yOnJPU56fBkisRBgQyb3uFqV8atW22eOEUF3Qfxm0tfkUt
         oXfeaCtaoM5OByvgEz6no1p7azcrU4KnA4XSJcimL3hU1Nlu7LxA8fKtxsd2EkQNdw4Z
         Eq7Q==
X-Gm-Message-State: AOJu0Ywkb9VqR/em6UsPYHFSbZhwVphqZbIk6+Q2J8sKWMviOrozbWkr
	cUdu1u6nDpvJ/7HajXZ1VqGj3AwhdVQJ+zuaEPkKlq4nJGJxxV8g9usn4NWfvInVuZjoc9to62i
	0pj8IECY04WOk7GeqasqEw6euwwTaP+Y=
X-Gm-Gg: Acq92OG92BqGz67thdARvKtIPJGzpiZe8nqKmNKCEo17xyUhl7Vi6Y347PZWO7ZTAl7
	uQzRb3eVF8Wxvmsc758EikQM7TqSjeae36BYHccXsQpVk6mYMlVBzUjo9ifIjzGM5Ceq1nlzRTi
	gc4YuoAX8u3aTcTF8f823vPTri4AtxXVDwrfA3RJW+ekr/rGTDB8EJYp8z1iU1q4aDa5HYxZaqf
	zCwpSd3CWMpf+ZybDk6QV8hS33oyD80txcckUqtZWivkuNVSkFyHgPKbSxt9vvrFMMAHRP1fWjV
	KJ3KK1zvx3VRKbJnojE3P565EVtvArOwmnsx2mtXpiwngeg+cNAIKC6kavga/i+Jm7L10k8gjyF
	EHd/b1/rsUwIzxZJyf+jdW1Y11VQEa/emINR71OiQzKVdYLDnToWmy4uRHvBr5raR5Kxq
X-Received: by 2002:a05:6402:321a:b0:683:75ec:c17c with SMTP id
 4fb4d7f45d1cf-68c8b1eddcfmr6022796a12.10.1780340762242; Mon, 01 Jun 2026
 12:06:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260601183359.11343-1-rosenp@gmail.com> <20260601184409.C1CF21F00893@smtp.kernel.org>
In-Reply-To: <20260601184409.C1CF21F00893@smtp.kernel.org>
From: Rosen Penev <rosenp@gmail.com>
Date: Mon, 1 Jun 2026 12:05:49 -0700
X-Gm-Features: AVHnY4KnIMcoYyn6BxHK4-bEmZR9C9G0FfA-ZjB3cx_hF-FLZ-By-coC51D4ZXA
Message-ID: <CAKxU2N_8V9A5fcp7JWQWorPsU2PdKj=uiCV+rs9BAs-to_DctA@mail.gmail.com>
Subject: Re: [PATCH] ata: pata_ep93xx: fix double free and ERR_PTR dereference
 on DMA error path
To: sashiko-reviews@lists.linux.dev
Cc: linux-ide@vger.kernel.org, dlemoal@kernel.org, cassel@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 1, 2026 at 11:44=E2=80=AFAM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 2 potential issu=
e(s) to consider:
>
> Pre-existing issues:
> - [High] The PATA driver fails to initialize if DMA channels are not avai=
lable, breaking the PIO-only fallback mode.
Yep. Makes this patch completely pointless.
> - [High] Trailing byte transfer logic in PIO data transfer truncates 16-b=
it values, leading to data corruption on big-endian systems.
> --
>
> commit 01fbd237d0698dff8591ae6c458732b482391c35
> Author: Rosen Penev <rosenp@gmail.com>
>
> ata: pata_ep93xx: fix double free and ERR_PTR dereference on DMA error pa=
th
>
> This commit fixes a double free of the rx channel and an invalid pointer
> dereference of the tx channel on the DMA initialization error path. By
> NULLing the tx channel before calling the release function, the cleanup
> is handled correctly.
>
> > diff --git a/drivers/ata/pata_ep93xx.c b/drivers/ata/pata_ep93xx.c
> > index b2b9e0058333e..aa6f8172925d5 100644
> > --- a/drivers/ata/pata_ep93xx.c
> > +++ b/drivers/ata/pata_ep93xx.c
> > @@ -688,7 +688,7 @@ static int ep93xx_pata_dma_init(struct ep93xx_pata_=
data *drv_data)
> >       return 0;
> >
> >  fail_release_rx:
> > -     dma_release_channel(drv_data->dma_rx_channel);
> > +     drv_data->dma_tx_channel =3D NULL;
>
> [Severity: High]
> This isn't a bug introduced by this patch, but since we are modifying the
> error paths in ep93xx_pata_dma_init(), does this initialization failure
> unintentionally break the PIO-only fallback?
>
> Looking at the start of ep93xx_pata_dma_init(), if dma_request_chan()
> returns -ENODEV because no DMA channels are available in the device tree:
>
>         drv_data->dma_rx_channel =3D dma_request_chan(dev, "rx");
>         if (IS_ERR(drv_data->dma_rx_channel))
>                 return dev_err_probe(dev, PTR_ERR(drv_data->dma_rx_channe=
l),
>                                      "rx DMA setup failed\n");
>
> This error propagates directly back to ep93xx_pata_probe():
>
>         err =3D ep93xx_pata_dma_init(drv_data);
>         if (err)
>                 return err;
>
> Does this abort the probe entirely on systems without DMA, rather than cl=
eanly
> dropping DMA support and allowing the driver to fall back to PIO mode?
>
> >  fail_release_dma:
> >       ep93xx_pata_release_dma(drv_data);
> >
>
> [Severity: High]
> This is a pre-existing issue, but could the trailing byte transfer logic =
in
> ep93xx_pata_data_xfer() truncate 16-bit values and cause data corruption =
on
> big-endian systems?
>
> In ep93xx_pata_data_xfer(), the pad variable is an array of 2 bytes:
>
>         unsigned char pad[2] =3D { };
>
> On the READ path, a 16-bit value is assigned directly to *pad:
>
>         if (rw =3D=3D READ) {
>                 *pad =3D cpu_to_le16(
>                         ep93xx_pata_read_data(
>                                 drv_data, IDECTRL_ADDR_DATA));
>                 *buf =3D pad[0];
>
> Doesn't this truncate the 16-bit integer to its lowest 8 bits? On a
> little-endian CPU this evaluates to the correct first byte, but on a
> big-endian CPU, cpu_to_le16() places the first byte into the upper 8 bits=
,
> which are lost during truncation.
>
> Similarly, on the WRITE path:
>
>         } else {
>                 pad[0] =3D *buf;
>                 ep93xx_pata_write_data(drv_data, le16_to_cpu(*pad),
>                                   IDECTRL_ADDR_DATA);
>         }
>
> Will le16_to_cpu(*pad) zero-extend the 8-bit pad[0] value to a 16-bit
> integer, resulting in 0x00BB instead of 0xBB00 before byte swapping,
> ultimately writing 0x00 as the first byte of the transfer? Would casting
> to a 16-bit pointer better manage memory across endianness boundaries her=
e?
>
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260601183359.11=
343-1-rosenp@gmail.com?part=3D1
