Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56B48395AF8
	for <linux-ide@vger.kernel.org>; Mon, 29 Jun 2026 06:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782714242; cv=none; b=DDhQ8ga/KcwDz/cgnHaTCs9l4hGLsDKmPUCDoZo7xHWixqpjySkWsyUvJtOzjHzGAP8e6EctFim+Fe073EjFYIpycq8hZHTA/02SnWF40QVdKLULrhYwISwM5Inzh856gLKr/rXhrmNHJc4ABN60EE01gedoQRGxi6bnkU6tMdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782714242; c=relaxed/simple;
	bh=bMVwvsUyPE+hfI0MGm+csXPMTHYQaUT6BZErZbk//rs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=g85dG+L2y4Xu87noRuMv9dVZu8rGRjQ57Lc8nxawndZ2eC/L1oeM3P9CPL2+BGeOwmKhy0y3CTZH4NCxxoY/cBuaoU8Qr2dD1wBxBZTlZZGmdT/Ym+1Cru0QFjDDF86lnSU2SsSkbKtgkOBn2bA0EUN2Icncb/Jn+bDTCGVnGf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61A821F000E9;
	Mon, 29 Jun 2026 06:23:59 +0000 (UTC)
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 20/32] drivers/ata: Stop using 32-bit MSR interfaces
Reply-To: sashiko-reviews@lists.linux.dev
To: "Juergen Gross" <jgross@suse.com>
Cc: linux-ide@vger.kernel.org, dlemoal@kernel.org, cassel@kernel.org
In-Reply-To: <20260629060526.3638272-21-jgross@suse.com>
References: <20260629060526.3638272-1-jgross@suse.com>
 <20260629060526.3638272-21-jgross@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 29 Jun 2026 06:23:57 +0000
Message-Id: <20260629062359.61A821F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Critical] The change to `wrmsrq()` in `cs5535_set_piomode` introduces a =
critical sign-extension bug, writing `0xFFFFFFFF` to the upper 32 bits of t=
he MSR.
- [Low] The commit message is incomplete and truncated mid-sentence.
--

commit 9a4c6821b4ef60316ec2b36e0f505f4148809966
Author: Juergen Gross <jgross@suse.com>

drivers/ata: Stop using 32-bit MSR interfaces

The 32-bit MSR interfaces rdmsr() and wrmsr() are planned to be removed.
This patch switches the pata_cs5535 and pata_cs5536 drivers to use the
64-bit variants instead.

>     In drivers/ata/pata_cs5536.c don't redefine rdmsr() and wrmsr() as
>     empty macros for avoiding misuse, but guard the affected code via

[Severity: Low]
This isn't a bug, but the commit message appears to be truncated mid-senten=
ce.

> diff --git a/drivers/ata/pata_cs5535.c b/drivers/ata/pata_cs5535.c
> index d793fc441b467..da98390cc49e8 100644
> --- a/drivers/ata/pata_cs5535.c
> +++ b/drivers/ata/pata_cs5535.c
> @@ -102,16 +102,16 @@ static void cs5535_set_piomode(struct ata_port *ap,=
 struct ata_device *adev)
>  		cmdmode =3D min(mode, pairmode);
>  		/* Write the other drive timing register if it changed */
>  		if (cmdmode < pairmode)
> -			wrmsr(ATAC_CH0D0_PIO + 2 * pair->devno,
> -				pio_cmd_timings[cmdmode] << 16 | pio_timings[pairmode], 0);
> +			wrmsrq(ATAC_CH0D0_PIO + 2 * pair->devno,
> +				pio_cmd_timings[cmdmode] << 16 | pio_timings[pairmode]);
>  	}
>  	/* Write the drive timing register */
> -	wrmsr(ATAC_CH0D0_PIO + 2 * adev->devno,
> -		pio_cmd_timings[cmdmode] << 16 | pio_timings[mode], 0);
> +	wrmsrq(ATAC_CH0D0_PIO + 2 * adev->devno,
> +		pio_cmd_timings[cmdmode] << 16 | pio_timings[mode]);

[Severity: Critical]
Will these wrmsrq() calls write 0xFFFFFFFF into the upper 32 bits of the
MSR for PIO mode 0?

Because pio_cmd_timings contains u16 values, C integer promotion rules will
promote pio_cmd_timings[cmdmode] to a signed 32-bit int before the shift.

For PIO mode 0 (0xF7F4), the shift results in a negative 32-bit integer
(0xF7F40000).

Since wrmsrq() takes a u64 parameter, this negative 32-bit int is implicitly
sign-extended to 64 bits (0xFFFFFFFFF7F4XXXX). This corrupts the upper
32 bits of the timing registers, which could trigger a General Protection
Fault.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260629060526.3638=
272-1-jgross@suse.com?part=3D20
