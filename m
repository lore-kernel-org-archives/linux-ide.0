Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 065E529BDAA
	for <linux-ide@vger.kernel.org>; Mon,  3 Aug 2026 15:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785770059; cv=none; b=QutXm/O4TX269CiNr8THtGjQkiWVilOiRmxF4koNGVKFI4fYKOs4p14ALe6B1QLKDqVhGuSLEfhD+OkaoFseZJAzBjkMAMdaBFLBq2kHYTvVlrnSQtd6Qc9vA8iMoQBkRZGVGbxhxJ+BiKW6Gxuu9GvqDvrDzPR11T94qY+HsA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785770059; c=relaxed/simple;
	bh=/1ycsp/z08N2XQXsk6ctOY8+n6ZYmHM2bKECsXS1nzo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=aGKBHLAN1jCimjSz5grT3ooR0ijQ9zB7oYXIldwCJsbBTAtBPygqTUNKjlZj5j7xYcDadv7swMAnUZw0UZKsRYfd91IX3OG2mrfiTF6JpWWX6s698zpquMFjz+gYNkTXR7fdMpY5IPtWNUwYxt44Tniux921M1XQQsDYVyjZLCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mwqNpCv6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mwqNpCv6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DB001F000E9;
	Mon,  3 Aug 2026 15:14:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785770057;
	bh=2m1jcugCO5n7TLp071cMOd8Sr1mT0IINu0lKnrjyQz0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mwqNpCv6lzRwzw/JxFsxebk/oFiic+s8/VI/DiDXtrnLxgGlhZtOr3hZXiGmbmrhd
	 UYJObp52mHekz3BptB3GIthOyzKVYwSE5stPsg2n6wfwckAz0gdVVbZqa6ku0XrLtu
	 vDR2MWBVasx+N7omOWNnvTQpQ0+ZmxzJye5qm097TlnebfYEeJVLv09CnqE6eNJbDR
	 7NQcM2sWH8P53TTqAafxKDMvmG9cf6Gr1Piy+ziBVRzV6X4X+9Y+aFF6KqypJ+GN3m
	 tViuqi/BuLzaOH/EDySJ2VcGMfdbfFjPl9YRNXgvvBZZ1/w5RY71Z5ZTlN2+VhrT/v
	 DFSznnMjU7UCg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] ata: use named initializers for acpi_device_id
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?UGF3ZWwgWmFsZXdza2kgKFRoZSBDYXBhYmxlIEh1Yik=?= <pzalewski@thegoodpenguin.co.uk>
Cc: cassel@kernel.org, linux-ide@vger.kernel.org, dlemoal@kernel.org
In-Reply-To: <20260803-ata-acpi-v1-1-f606afaacad1@thegoodpenguin.co.uk>
References: <20260803-ata-acpi-v1-0-f606afaacad1@thegoodpenguin.co.uk>
 <20260803-ata-acpi-v1-1-f606afaacad1@thegoodpenguin.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 03 Aug 2026 15:14:16 +0000
Message-Id: <20260803151417.3DB001F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Incomplete refactoring: ahci_seattle.c was missed when unifying acp=
i_device_id initialization.
--

--- Patch [1]: [PATCH 1/2] ata: use named initializers for acpi_device_id -=
--
commit f6b3d365ff5924969c9b77b57308411fcb82b7e1
Author: Pawel Zalewski (The Capable Hub) <pzalewski@thegoodpenguin.co.uk>

ata: use named initializers for acpi_device_id

This commit updates acpi_device_id initializers in the ATA subsystem
to use named fields. It also unifies the list terminators across these
files to have a single space between the brackets.

> ata: use named initializers for acpi_device_id
>=20
> Use a named initializer for the acpi_device_id fields which
> makes the code more readable and consistent with how lists
> are initialized in the rest of the kernel code base.
>=20
> While we are at it - unify the list terminator to have
> a single space between the brackets and no trailing
> comma.

[Severity: Low]
Was ahci_seattle.c missed during this refactoring?=20

It appears drivers/ata/ahci_seattle.c still contains an old style
initializer and a list terminator without a space:

drivers/ata/ahci_seattle.c:ahci_acpi_match() {
static const struct acpi_device_id ahci_acpi_match[] =3D {
	{ "AMDI0600", 0 },
	{}
};

>=20
> Signed-off-by: Pawel Zalewski (The Capable Hub) <pzalewski@thegoodpenguin=
.co.uk>
>=20
> diff --git a/drivers/ata/ahci_platform.c b/drivers/ata/ahci_platform.c
> index c18054333f7c9..d97f0ad3b4cd7 100644
> --- a/drivers/ata/ahci_platform.c
> +++ b/drivers/ata/ahci_platform.c

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260803-ata-acpi-v=
1-0-f606afaacad1@thegoodpenguin.co.uk?part=3D1
