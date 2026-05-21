Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3FF537EFF6
	for <linux-ide@vger.kernel.org>; Thu, 21 May 2026 19:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779390877; cv=none; b=LIssWv/x7Bk7BNjGzOnzjplHCsNL6FqmDTAL9GkhrtyQQvk4zbgG3bs9NKRszjQ8TwHiCW2F728N1MV/PPbnldLLl01qXYWDXePO5439boA+T18/IO6qIv/h/iHsq0qkcz9SK/uhuFb/hE8sOg1m6ZVCrY4Xt6S38mCmkwyM29Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779390877; c=relaxed/simple;
	bh=vTviAb8XiBSxXL/YRMz+UZ6CLwUNqJIBsoaitrqqpKs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=EjMtp3sl90o3Lc+A69tB1WQ6ViQy/TUTAtZ8naskthW6gLc927eKXTtWP+Q7bYlrjKsyE7yruGwOQsWjQsWm/ddumfNqISv/lEGqVVb1abFUb/NwV4fR/UD0ah07KAlUF56YiStk+KQhfs4XaYC5HOBOeutOWdii6aC4jtsTMAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jnaZ1PGN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jnaZ1PGN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42F3E1F000E9;
	Thu, 21 May 2026 19:14:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779390876;
	bh=ElAT7/aNF8w/3PUbiwU56H/UwJ8NrairOh+piJbgtQU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jnaZ1PGNJeFMOJ81YHbdRyLT865VJJWze+RVPA8COIiDzXihkCMWoFwYcIG2ZlUMX
	 ORnhYA4eZPJYgD8LwpETop5LOqr6a9BdYpFluEUq0oVrCYhohP2fYM9xmm/SdVKm44
	 wMI6EQJB9z0hPLMKAbePj3r0bLNrA6EX0D3zdsNFev8ywtzJ6By507EHpVcYuvUWVg
	 wrT2EyeUj5/adinBRiZ/3sFYSK18ZfMd2vHUCC4Z2Ybx3n1+21egJ41ESkm8oSdQW5
	 IkidwsoV/E0S6nknaK8tlDbQOgMHB1hmeeEoRsvkKmQ/J22apoBPWet6NoIPN+qolQ
	 e82ECy+kg4K0A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 7/9] ata: libata: Pass the ATA port argument directly
 to ata_link_abort()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Bart Van Assche" <bvanassche@acm.org>
Cc: dlemoal@kernel.org, cassel@kernel.org, linux-ide@vger.kernel.org
In-Reply-To: <20260521173347.2079560-8-bvanassche@acm.org>
References: <20260521173347.2079560-8-bvanassche@acm.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 21 May 2026 19:14:35 +0000
Message-Id: <20260521191436.42F3E1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Missing kernel-doc parameter documentation for the newly added 'ap'=
 argument in ata_link_abort().
--

commit f5db400cd9dab3479ff54c3d92701ede91c3836c
Author: Bart Van Assche <bvanassche@acm.org>

ata: libata: Pass the ATA port argument directly to ata_link_abort()

This patch modifies ata_link_abort() to take the ATA port as a direct
argument, preparing for future lock context annotations. No functional
changes are introduced.

> diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
> index fb790e8b6b57b..7528831bb59a4 100644
> --- a/drivers/ata/libata-eh.c
> +++ b/drivers/ata/libata-eh.c
[ ... ]
> @@ -1081,9 +1081,9 @@ static int ata_do_link_abort(struct ata_port *ap, s=
truct ata_link *link)
>   *	RETURNS:
>   *	Number of aborted qc's.
>   */
> -int ata_link_abort(struct ata_link *link)
> +int ata_link_abort(struct ata_port *ap, struct ata_link *link)

[Severity: Low]
Does this kernel-doc block need an update to document the new ap parameter?
Adding the parameter to the function signature without adding it to the
documentation will trigger a kernel-doc warning.

>  {
> -	return ata_do_link_abort(link->ap, link);
> +	return ata_do_link_abort(ap, link);
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260521173347.2079=
560-1-bvanassche@acm.org?part=3D7
