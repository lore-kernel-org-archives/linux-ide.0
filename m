Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8367617C211
	for <linux-ide@vger.kernel.org>; Mon, 22 Jun 2026 18:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782153660; cv=none; b=ILJf7vriBLU465/NsfyK9HPvzkRB4aJxSl8Lv/3la/JBfXaV6u4wqtCcFOV9dImh/dgvz6Hm4ZLqCqaixEhQ66rQ0tXzyQM93FCk5SVDqhKbDjv8JU8+OZR0m0LU/xOoaBKiT8CkmeAKsefwoZVfjgE7C6SHKzMQV23FCpbZ65g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782153660; c=relaxed/simple;
	bh=pUKR56UMVA+X+Vyn9nYKNUkMfuse8tFBTc0sX41datY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=s6Kj8MUEdsy+QKfo4foBQ7Ie894hBkzefLW4uFB9kPOrar07HEdyGgGXWqsrAj0/GJLY4on7lqjAyCnmRRGXE9oa//wqWcVm5xUO7nATXOGHprSMg3bxAgI/5AgRHPKmA3J6xCm9fNt5v3J13+WI6sThPfZnxUVHZdo4I5+Ia14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gQDkDHkW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gQDkDHkW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE58B1F000E9;
	Mon, 22 Jun 2026 18:40:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782153659;
	bh=A/1yg98zthJsQ/eDKgPsyX1sIavm061kz18nbXgSo04=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gQDkDHkWI+Z2GAxKSNy2H8FIfXK4OkIY7jDpKBWZYbBvhwWxX+skmdegNYABsmdQV
	 c2mqX3KDWKkO/LSlzNx64tA7QC0IbuCtQSw2jwW6AbNgPSTKys1a4U1Dcb7wNlDDyc
	 i7mmbwpVtcsKD2/boOutMAI1QipBKW2tH9oL+Hf+yf+qFjo03RkyBQPKt43kdb6uiX
	 KdsaxPBTnWZ1lFc9kNDCdDn1Aecz09b4MDSJNJE2WiMqCRyx3mfssPdy+f9LzUAZtJ
	 Ix0Qy6mSFFQX24H5fdFBy7cV50f3guKNUMAjkYaU7WMtf3m7pgOZBFpg1nS3DGO7PE
	 T89uCwIHSxGNw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] ata: libata-core: Allow capacity transition to zero for
 locked drives
Reply-To: sashiko-reviews@lists.linux.dev
To: "TJ Adams" <tadamsjr@google.com>
Cc: dlemoal@kernel.org, cassel@kernel.org, linux-ide@vger.kernel.org
In-Reply-To: <20260622182844.2795777-1-tadamsjr@google.com>
References: <20260622182844.2795777-1-tadamsjr@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 22 Jun 2026 18:40:58 +0000
Message-Id: <20260622184058.EE58B1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] HPA resizing is permanently disabled (quirked) when a drive is ini=
tialized or revalidated while security-locked.
--

commit 2df5e6f4cdff68089316d7932aeee91f9d6633ae
Author: TJ Adams <tadamsjr@google.com>
ata: libata-core: Allow capacity transition to zero for locked drives

This commit fixes a revalidation failure that occurs when a security-locked
drive transitions its capacity to zero during Error Handling. It allows this
transition in ata_dev_revalidate() if the drive is reported as locked.

> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
> index e76d15411e2ae..4241a71d1b5d1 100644
> --- a/drivers/ata/libata-core.c
> +++ b/drivers/ata/libata-core.c
> @@ -3959,7 +3959,8 @@ int ata_dev_revalidate(struct ata_device *dev, unsi=
gned int new_class,
> =20
>  	/* verify n_sectors hasn't changed */
>  	if (dev->class !=3D ATA_DEV_ATA || !n_sectors ||
> -	    dev->n_sectors =3D=3D n_sectors)
> +	    dev->n_sectors =3D=3D n_sectors ||
> +	    (dev->n_sectors =3D=3D 0 && ata_id_is_locked(dev->id)))

[Severity: High]
This is a pre-existing issue, but since this patch deals with revalidating
locked drives, is there a risk that ata_hpa_resize() permanently disables
HPA resizing for these drives?

Earlier in ata_dev_revalidate(), ata_dev_configure() is called, which then
calls ata_hpa_resize(). If the drive is locked, the command to read the
native max address fails with -EACCES, causing a sticky quirk to be set:

drivers/ata/libata-core.c:ata_hpa_resize() {
        ...
        rc =3D ata_read_native_max_address(dev, &native_sectors);
        if (rc) {
                ...
                } else if (rc =3D=3D -EACCES || rc =3D=3D -EPERM) {
                        ata_dev_warn(dev, "HPA support seems broken ...\n");
                        dev->quirks |=3D ATA_QUIRK_BROKEN_HPA;
                        return 0;
                }
        ...
}

Because the ATA_QUIRK_BROKEN_HPA quirk is sticky on the device, subsequent
revalidations after the drive is unlocked will silently bypass HPA checks:

drivers/ata/libata-core.c:ata_hpa_resize() {
        if (... || (dev->quirks & ATA_QUIRK_BROKEN_HPA))
                return 0;
        ...
}

Does this functionally prevent the unlocked drive from ever exposing its
full native capacity without a reboot or device removal?

>  		return 0;
> =20
>  	/* n_sectors has changed */

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260622182844.2795=
777-1-tadamsjr@google.com?part=3D1
