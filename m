Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57B85158DCF
	for <linux-ide@vger.kernel.org>; Thu,  9 Jul 2026 01:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783561823; cv=none; b=YA99BvCapjMqwN7d1pf+1oIiiLYvv79/bMWTIDo46DHdpLfuMJpFVJTuM1OI9D47A42KGOXFBppS7htkyhi55d9h2hGhMfl9a25UgrVhQlO3pu+U4dJLktp0qfDsSgeJO6DNnwKb9NKpm/RhBbdUBg39HaUd1r5tj0sDJ/ubhI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783561823; c=relaxed/simple;
	bh=lEDgSRrXNevBJZN8UYWNrBxCB6nJcEOWjcsLXJObKHo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=H8gIKD8yWvcsHh7jiJYZ53xnfrNMCuzxEDFxbafhWQavE2AEu0iI49K18DmvGuinpcbMQh05Ny273NKMYyze6D8aTupah5dZj6a9ymj+T4S7VgBGpt/hnTrhWUOphrlpSGXKc6KjZ5G3hi8nmyywa2l0uc3+gwa7M39j/TZpKwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MXvN0Qzp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MXvN0Qzp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC6D91F000E9;
	Thu,  9 Jul 2026 01:50:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783561822;
	bh=kb72yXmmSJAx2TRP8ou6znx0uum6wAEPfecDt9YcIwA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MXvN0QzpxMgpifx18Zb+xWrkTyHpkOX3zuSp9natFTJxi9dokyAeU6UMT26vMSQeL
	 BuRS/cU8HnYNEf//00c9foq1A8wN9uUE6yR85fao9zBqAj9uLQxeN/lnCocUnLLSuT
	 tQTcVpWurUkW2m82jtcHQWvc5mfCs0Tuu+eqR3N5YdsWg+uoK43/LFKWP9PszYAS9E
	 IpiU2HRfIiqLlR+6eNPO+mTmyGH59v/df+jVoxejU9sZQpSt2rSkTuaR2jisps5EqI
	 RvXqvgXpSIMr8qn2hgJKmZzLfdyAC1PucDRCniEqX6F6AWYyMiQoJVYOGTjzJdVmXp
	 vaFRMv2MntxYQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] ata: libahci_platform: use of_platform_device_create()
 return value
Reply-To: sashiko-reviews@lists.linux.dev
To: "Rosen Penev" <rosenp@gmail.com>
Cc: cassel@kernel.org, linux-ide@vger.kernel.org, dlemoal@kernel.org
In-Reply-To: <20260709014230.1905756-1-rosenp@gmail.com>
References: <20260709014230.1905756-1-rosenp@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 09 Jul 2026 01:50:21 +0000
Message-Id: <20260709015021.BC6D91F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Using the return value of `of_platform_device_create()` breaks tar=
get regulator fetching during driver rebind or probe deferral, leading to u=
npowered SATA ports.
--

--- Patch [1]: [PATCH] ata: libahci_platform: use of_platform_device_create=
() return value ---
commit b10e7693c196a90e6a36f9889202414e7cb20fc9
Author: Rosen Penev <rosenp@gmail.com>

ata: libahci_platform: use of_platform_device_create() return value

This commit updates ahci_platform_get_resources() to use the return value
of of_platform_device_create() directly, removing the subsequent call to
of_find_device_by_node() to avoid needing to free the reference.

> --- a/drivers/ata/libahci_platform.c
> +++ b/drivers/ata/libahci_platform.c
> @@ -617,10 +617,7 @@ struct ahci_host_priv *ahci_platform_get_resources(s=
truct platform_device *pdev,
>  			mask_port_map |=3D BIT(port);
> =20
>  #ifdef CONFIG_OF_ADDRESS
> -			of_platform_device_create(child, NULL, NULL);
> -
> -			port_dev =3D of_find_device_by_node(child);
> -
> +			port_dev =3D of_platform_device_create(child, NULL, NULL);
>  			if (port_dev) {
>  				rc =3D ahci_platform_get_regulator(hpriv, port,
>  								&port_dev->dev);

[Severity: High]
Does this change break regulator fetching during a probe deferral?

When of_platform_device_create() successfully creates the device on the fir=
st
probe attempt, it sets the OF_POPULATED flag on the child device node.

If a subsequent initialization step triggers a probe deferral (for instance,
returning -EPROBE_DEFER), the probe is aborted. However, the driver's clean=
up
path does not depopulate the platform device, so the OF_POPULATED flag rema=
ins
set on the child node.

During the second probe attempt, of_platform_device_create() sees the
OF_POPULATED flag and returns NULL.

Because port_dev is now NULL, the block above is bypassed, and
ahci_platform_get_regulator() is silently skipped. This leaves the SATA port
without its required target power regulator.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260709014230.1905=
756-1-rosenp@gmail.com?part=3D1
