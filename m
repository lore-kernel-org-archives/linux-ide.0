Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 549324718D3
	for <linux-ide@vger.kernel.org>; Tue, 13 Oct 2026 04:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791866663; cv=none; b=BOvakry0NB1Y/Y2vCdZTWZdaMfOwyk20AqA/r8Ko5cNWkgZRgR/hEodVUUWWVV19/S99wePfPHI+DP8H7q+8XU/WGt6Ow1iKqk7mV0S8WkJoQbYa97eHVdnL4TFWmzZe12vm6b+vRjMoEevhJ9I/9mDjs2gtnIlqnmYLGQFhvIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791866663; c=relaxed/simple;
	bh=E7FrLfQGFRp9ufnWcWGrtqhuj3jRJzDBnbfdBAZb9Fo=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=UoKGZBv1QpdsClYWuKezC/DTs/AbOsvH1UDiB9daxBsqcZofeCd2aXlG2099DfNTKmp1sIWsDWO8LPdCvZyRGx56Qh7PnRtrO2U68p3XX+IewGNaHRBTmVQyCk0neMdHBdfdMe0Asi5qnn4szc7xLN0QcjUvRA+a1hjDWpSF8p4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nj9fEr8k; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nj9fEr8k"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B11BD1F000FF;
	Tue, 13 Oct 2026 04:44:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791866661;
	bh=uqWJDYjlUMVTYzVrLl3LmICf+e2CMTgeBzvbv+gj+xE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nj9fEr8kfsCBSWQFSm6OQIh50c7+jTTgOSLysOA8v5ncZhT8PEhfcMD9w9UC/FF5s
	 8SUWKHhOVsrq6iee+Zx2ETtifriYmnnechTqR4xdKjfRln4orwID3kRKwtiMzti3Um
	 vhAN3MmFlSP9+FXuceGlOH3+jZVlHggToecKxnTraZj5BA/Khy3ujQHJIzEpya1gcR
	 hD3kssy/aiP1Ezhk7NVf2rT7eK+ScrNyX3J5EYOom8uDA5fUOI8jipaIy83nma/NaI
	 RJLhlae1sV8MvsKUZ3WeqvGYlFUI/7fvfMBh7FjtO11ZKQ8y4Ra9cY9O9UDUpcqVnt
	 MjNFOAViL7N6g==
Message-ID: <sashiko-outbox-168986@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] ata: pata_atiixp trivial fix
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ioannis Barkas" <jnyb.de@gmail.com>, linux-ide@vger.kernel.org
Cc: dlemoal@kernel.org, cassel@kernel.org
In-Reply-To: <20261013043106.77115-1-jnyb.de@gmail.com>
References: <20261013043106.77115-1-jnyb.de@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 13 Oct 2026 04:44:21 +0000
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] ata: out-of-bounds read in atiixp_set_dmamode() via libata.force
--

commit 6cef46d304d8efc0941f3fea452622301931fdb7
Author: Ioannis Barkas <jnyb.de@gmail.com>

ata: pata_atiixp trivial fix

Reduce mwdma_timings to match its members.

> diff --git a/drivers/ata/pata_atiixp.c b/drivers/ata/pata_atiixp.c
> index 4c612f9543f6c..50f2c9077af05 100644
> --- a/drivers/ata/pata_atiixp.c
> +++ b/drivers/ata/pata_atiixp.c
> @@ -149,7 +149,7 @@ static void atiixp_set_piomode(struct ata_port *ap, s=
truct ata_device *adev)
> =20
>  static void atiixp_set_dmamode(struct ata_port *ap, struct ata_device *a=
dev)
>  {
> -	static const u8 mwdma_timings[5] =3D { 0x77, 0x21, 0x20 };
> +	static const u8 mwdma_timings[3] =3D { 0x77, 0x21, 0x20 };

[Severity: Medium]
Does this code introduce an out-of-bounds read when libata.force is used?

If a user specifies libata.force=3Dmwdma3 or mwdma4, ata_force_xfermask() c=
an
override the hardware port limits and force adev->dma_mode to XFER_MW_DMA_3
or XFER_MW_DMA_4.

When atiixp_set_dmamode() is subsequently called, dma -=3D XFER_MW_DMA_0
evaluates to 3 or 4:

		dma -=3D XFER_MW_DMA_0;
		...
		mwdma_timing_data |=3D (mwdma_timings[dma] << timing_shift);

This would cause an out-of-bounds memory read since mwdma_timings was reduc=
ed
to 3 elements. The previous 5-element array provided safe zero-padding for
these forced modes.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261013043106.7711=
5-1-jnyb.de@gmail.com?part=3D1
