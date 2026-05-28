Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09712260580
	for <linux-ide@vger.kernel.org>; Thu, 28 May 2026 06:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779949136; cv=none; b=qSfJu8zi5FLfGeqaIy+UlA15sg8Ywwe/wOO+IqJ8krTgZfy1VZjSUfhpqwu/nDLfbv6fHJtFNjxSGxTNqsKYbwlBgam99Pe+2IZ46GLrud1qb2GyamKkqpX/AkrWF+tn7nfP/eIhEVMpKI9RjzsbboG8k+IOLXBcVf/MDTCaAvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779949136; c=relaxed/simple;
	bh=sqT5kQ5QR1KXniaPIA/cfHDcicCoqjAr1Pm3vzmtFLU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=M2U5SJvmxhyy8bvEKhbJ0YJXwGH0T0WRsR3a6I5Fq1LMTboHcMRQ1cRZLeHa2pows3NhG/6T6Xm6BZyGOuTRqqeJYuGljdqs0IEASghfXwpXqH7Y6v+wxK1hyMcO+4kdrSH8zNOVCRtEl9VO/BFf5xtxCr30yZ+K6L2xLyG8f8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K6sRVpDU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K6sRVpDU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 170FF1F000E9;
	Thu, 28 May 2026 06:18:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779949134;
	bh=NkT0hTphguRtUjeizuQ4x8AiKZ6ApDxPrgJDOR5gpgY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=K6sRVpDU6oF0FjXc5t0qhh3X3o1KlNscr/2q882/uuDoxheFzXSSnmKMlIWffkUbN
	 IaMuua8V2wp9ZgZLQOt7JwYurJar75CRSgIuJOFO55EjMx7NGROtB1/CPABAhKV3wL
	 7yGhcMaPica+9elOpQu6osjqg4Sik7u1193YfATCFo+rXqh18pyoD343Zmj+ejyZbf
	 brTEslE6wHJMVYxX7sdMnpq/w1Xh8do7eJK0ECFCnxFuy6XZBrzSZHZevsgVgxj72/
	 83uM05DbDHIcTJ07yStzPBvWGKWeR8HM4+iVWBPDgTL8xPVqgoXP0GimVAXHV5xihQ
	 sfpgkwZUWA11g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] ata: ahci: use hweight_long() to count port_map bits
Reply-To: sashiko-reviews@lists.linux.dev
To: kensanya@163.com
Cc: linux-ide@vger.kernel.org, dlemoal@kernel.org, cassel@kernel.org
In-Reply-To: <20260528060050.743599-1-kensanya@163.com>
References: <20260528060050.743599-1-kensanya@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 28 May 2026 06:18:53 +0000
Message-Id: <20260528061854.170FF1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Signed integer overflow and undefined behavior in bit shift operat=
ions.
- [High] Strict validation zeroes out `port_map` for non-compliant devices =
without fallback for AHCI 1.3+, completely disabling the controller.
--

commit 3665ac64e718a0f079a1778f11d8d96122c49025
Author: TanZheng <tanzheng@kylinos.cn>

ata: ahci: use hweight_long() to count port_map bits

This commit simplifies the calculation of set bits in the port mapping
by replacing an open loop with the hweight_long() function.

> diff --git a/drivers/ata/libahci.c b/drivers/ata/libahci.c
> index c79abdfcd7a9b..15d44266c9df8 100644
> --- a/drivers/ata/libahci.c
> +++ b/drivers/ata/libahci.c
> @@ -552,11 +552,7 @@ void ahci_save_initial_config(struct device *dev, st=
ruct ahci_host_priv *hpriv)
> =20
>  	/* cross check port_map and cap.n_ports */
>  	if (port_map) {
> -		int map_ports =3D 0;
> -
> -		for (i =3D 0; i < AHCI_MAX_PORTS; i++)
> -			if (port_map & (1 << i))
> -				map_ports++;
> +		int map_ports =3D hweight_long(port_map);
> =20
>  		/* If PI has more ports than n_ports, whine, clear
>  		 * port_map and let it be generated from n_ports.

[Severity: High]
This is a pre-existing issue, but zeroing out the port map based on this
check can permanently disable the controller for newer devices.

If a device reports extra unimplemented ports in its port map, the code
zeroes out port_map. The inline comment indicates it will let it be generat=
ed
from n_ports. However, the subsequent fallback logic that regenerates
port_map is conditionally guarded for older versions:

ahci_save_initial_config() {
    ...
    if (!port_map && vers < 0x10300) {
        port_map =3D (1 << ahci_nr_ports(cap)) - 1;
    ...
}

For AHCI 1.3+ devices, port_map is never regenerated and remains 0.

Does this cause all legitimate ports to be assigned ata_dummy_port_ops,
breaking otherwise functional devices?

[Severity: High]
This isn't a bug introduced by this patch, but there is a pre-existing
undefined behavior regression with the port mask generation nearby.

When regenerating the port map for devices prior to AHCI 1.3, the fallback
logic uses a signed 32-bit integer:

ahci_save_initial_config() {
    ...
    if (!port_map && vers < 0x10300) {
        port_map =3D (1 << ahci_nr_ports(cap)) - 1;
    ...
}

Since ahci_nr_ports(cap) can return up to 32, shifting a 32-bit integer by =
32
is undefined behavior. On architectures like x86, the shift count is masked
to 5 bits, so 1 << 32 evaluates to 1 << 0 =3D 1.

This results in 1 - 1 =3D 0, causing port_map to be incorrectly cleared to =
0.

Could this unintentionally disable all ports on a fully populated 32-port
AHCI controller? Is it possible to use 1UL instead of 1 to prevent this?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260528060050.7435=
99-1-kensanya@163.com?part=3D1
