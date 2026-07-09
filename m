Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 959E4155C97
	for <linux-ide@vger.kernel.org>; Thu,  9 Jul 2026 02:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783562516; cv=pass; b=EuMdw7FjYpN9/NgG2H1+0lCfU8M583VIQkf8TCR8z8KhLStaFfp9cPc/kU7cO+Ym7VR4z4WgP4LX4Y6JMPB/UsmZxkpXU98ESO+qSlZSXI+kTnc1h9nBp77U1WH1Z1wOFxn7N0Yi8n2xyvCHga42V/WfP8gcf6wAMMQlYsGYIgA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783562516; c=relaxed/simple;
	bh=XfpCYXjGQIQ4ZKfpYTby/RzckVAT88UE+bsRt9jwIbM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fS3Oxrd0gHIyX5DZ0RUovwQUHNeFZzBCW5tEWouMsFWlx5O1dLAHLGW8F/pwJQlfbj4fT9jS4c34WtDQlxP2gmpbRJNBE4ey4Co/T8JiLzPUC6eUOBbWvY0bPJZiZHMUMUKtazH53XC1CdTMVnhhmc5mpcEF+a72m3WV9Mo7cGM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FWqysJo/; arc=pass smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FWqysJo/"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-6989c0ec3c5so2424984a12.2
        for <linux-ide@vger.kernel.org>; Wed, 08 Jul 2026 19:01:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783562513; cv=none;
        d=google.com; s=arc-20260327;
        b=rL6DXQnRBHHQSOA/yM54HOgColuL6Ukv+y5sM0ZiTkuwWV/mWKoziMH0IwrXQV7vq6
         GFOoIaOGeS/URJ6vSYpZMKLwgh/Kk3SlDjPcNVQpKlKPx/Eqobe2Id8toTTth/pchpK9
         yK44TDE3owq3XkJE6uleG6WlhAgGHTSroNG9QAF8eQvrBfjWl8yVZTOp2nF4vQqkTB4c
         cPajBr/GA1AAl7YZ2pilbX0DFMgtK77W+Mm3319v9vhtuF1DZJ+JtSkc5LBXIY1RZ7/7
         J2276oOcQx4/1Q/mRi/7s6KTCPxbT9DzmEXZ/+ulmSm/MYHlR+0vRpypue3S2GpVT+Pz
         EIlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=QdNlXu6B+SEAjg6icZJUM11FE2x5PgJHKlcl7V3FAgs=;
        fh=nkk5VH4aI72XvAF9uNN9hEdDtsyI2GFAepK1K+OtVPQ=;
        b=sBfhCVayeujXva3kUmAaStJI+eolAJKZC3a7KuUsqEhAQK5VgAy2ZlN7B7/z7fj3e3
         PTPd1YaMI/8b+oQYC4C3BtqbKSs82ZgMj7iCwgyltrHENMu49BCqLVn6RElOuQq3DSBd
         VYzmeUpTtMhtdLNlaIsCj00aRcAxqB7DNpu7siaXUTwmpSekBUmToZ1aINjhas1UKZte
         fK7NKd91hClAAQJJOkuxLzvuKy2ILLjB2smKOjmWRqusPW/Cd0D+nxg399poiH8RJ/6q
         muBFnCQ42Z1SxfDnBP9wFQrgIANg5QALRHwiHbuawVnOL78kDALOFF64wqsdQ1jIB3f9
         XTlQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783562513; x=1784167313; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=QdNlXu6B+SEAjg6icZJUM11FE2x5PgJHKlcl7V3FAgs=;
        b=FWqysJo/aDbnZPLzHXaM/3X1rfUk7ZMlEm+IHk2XBNoDb5EO0xCqAF/2P9LouV/54U
         m+jm4fz95vs7VllGGJggvn06cBGQ+gIKHp6aLakxUdQwD0G2VmlfMBu6d4krSItLnMta
         dtqm8nnHJ3wnvGRDf8+JNO3vXVnH8gMUGS5c1UXs/P4BGO/TbjtWPy7wwLYZQJJdFJZW
         LaG2KcAJ6FwGPWAilqLrsR3nRhOKyPzc57oKEcLXHUYioT6DMu3v4sMe+4RIvmBUhW25
         9sSMdMoP+S1aR3XaGrQvWW8X1nQoZ9ArJ1w5GDGwoX2Pz+8CwerNTw7hI108MHDiWdP7
         MgpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783562513; x=1784167313;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QdNlXu6B+SEAjg6icZJUM11FE2x5PgJHKlcl7V3FAgs=;
        b=L0QwBbYJ2GqXIKsQ/vW2CEbVxItuWjYygHmkbTotDzgnrLLhkF3kltwVBntZchGjFT
         poe8Mv7/1Y/JvP9cqBj2Tlhv3gY57jupuHIx4toWrgEzGlNrsBt3gZDc+Efg7GOregyB
         cznvu7yS020cCmVg687IH4w3Igl///2oCBgm2hz3YxTR1ejDjvwdhoiNI5ijAdU0CwbK
         Mm9A/Cd9RPQsnx95hqWBmXWscoafYH6bSA7XC/Fnr/aRtzTd3gNMTRlsI8JR9aMVCltm
         YrbFkesLDLdWW87sctksbzN/ZwoPNbGzBp+wSFW2MWVIHU28LKGB1nZ07M2ksiuTvtjQ
         428w==
X-Forwarded-Encrypted: i=1; AHgh+RrObLjs7gUoeGm9qu9zvmVM8oOhO3wbJl33jgDvQ8rcFJuXDOGnITRJpfahvp1hqxaZX8v29zgeviM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsOmUigNmoJhkKwiKpnmzNvfQcBg+CKSRFd8pZYsdp5CaoNwMm
	Kx+S0vVM44FbbKwXqL8xtK8k8vA+nkOxGuE3ish3IDPJ86nR/iF7FwvHnAJdl49qYu+s4XA0K8Q
	NeLKNd4ZQsK6XQLeeZR1Jvmn6Kxv8O/0=
X-Gm-Gg: AfdE7ckgOcziHdS+FOCmrF2pu2Ogsez0qZ4PjoR2GrG6qe0P99KouBfx6QPh1gOqdjG
	Y3X3/Wb1/qYdYIzaEjutwsjanyWhLsKrdJy+5PyQB7cZra2elWA97jN8dSks5U13O3oU/+NDco9
	JdV0sztUOCcfnOVWwHOdl0YG1yWBTvKIhefO7io7tRWVaOBPIsw7TNgWROn80MC2O8CE5mMbram
	vc0CsFQS3U48UzvOhjkrvcNXaJcMYy1zRT+luP9d4YYzjPoPomkfkG5KMT4lOEcN+QmRVmXe6Um
	ymigsO0M9XIttjrc1owL3kytJY8yvFs+OpsyZdwNCir19CI31ksZg/0PqLhjupM8OKrIydHRO/U
	ZLRzBXkY70F4ixB6zOHNA2L7e5YsczzIFxcIPgB1SQSUy1yG7NCm7+AjgcshHhiIabZ5/BuegBe
	4eHUDdjBQ=
X-Received: by 2002:a17:907:9282:b0:c12:9a13:47c with SMTP id
 a640c23a62f3a-c15cde722a5mr197212266b.2.1783562512782; Wed, 08 Jul 2026
 19:01:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260709014230.1905756-1-rosenp@gmail.com> <20260709015021.BC6D91F000E9@smtp.kernel.org>
 <CAKxU2N9B6xndc8GT+KrRAPjtafGzrEBjJXFWguw61KmAjUzsKQ@mail.gmail.com> <13da36c1-f123-4490-ac3c-d72b278c289c@kernel.org>
In-Reply-To: <13da36c1-f123-4490-ac3c-d72b278c289c@kernel.org>
From: Rosen Penev <rosenp@gmail.com>
Date: Wed, 8 Jul 2026 19:01:41 -0700
X-Gm-Features: AVVi8CfzZqGuRZGyElrhLn4y4jz9EIQGR5EkDRvzmytTW46cI8dkR8O-WkR2H8Q
Message-ID: <CAKxU2N9OYCSiX6CcP8BWgog5ap7J5H-EJSLmB0PZ2HdwZ-5qXA@mail.gmail.com>
Subject: Re: [PATCH] ata: libahci_platform: use of_platform_device_create()
 return value
To: Damien Le Moal <dlemoal@kernel.org>
Cc: sashiko-reviews@lists.linux.dev, cassel@kernel.org, 
	linux-ide@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 8, 2026 at 7:00=E2=80=AFPM Damien Le Moal <dlemoal@kernel.org> =
wrote:
>
> On 7/9/26 10:59, Rosen Penev wrote:
> > On Wed, Jul 8, 2026 at 6:50=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
> >>
> >> Thank you for your contribution! Sashiko AI review found 1 potential i=
ssue(s) to consider:
> >> - [High] Using the return value of `of_platform_device_create()` break=
s target regulator fetching during driver rebind or probe deferral, leading=
 to unpowered SATA ports.
> >> --
> >>
> >> --- Patch [1]: [PATCH] ata: libahci_platform: use of_platform_device_c=
reate() return value ---
> >> commit b10e7693c196a90e6a36f9889202414e7cb20fc9
> >> Author: Rosen Penev <rosenp@gmail.com>
> >>
> >> ata: libahci_platform: use of_platform_device_create() return value
> >>
> >> This commit updates ahci_platform_get_resources() to use the return va=
lue
> >> of of_platform_device_create() directly, removing the subsequent call =
to
> >> of_find_device_by_node() to avoid needing to free the reference.
> >>
> >>> --- a/drivers/ata/libahci_platform.c
> >>> +++ b/drivers/ata/libahci_platform.c
> >>> @@ -617,10 +617,7 @@ struct ahci_host_priv *ahci_platform_get_resourc=
es(struct platform_device *pdev,
> >>>                       mask_port_map |=3D BIT(port);
> >>>
> >>>  #ifdef CONFIG_OF_ADDRESS
> >>> -                     of_platform_device_create(child, NULL, NULL);
> >>> -
> >>> -                     port_dev =3D of_find_device_by_node(child);
> >>> -
> >>> +                     port_dev =3D of_platform_device_create(child, N=
ULL, NULL);
> >>>                       if (port_dev) {
> >>>                               rc =3D ahci_platform_get_regulator(hpri=
v, port,
> >>>                                                               &port_d=
ev->dev);
> >>
> >> [Severity: High]
> >> Does this change break regulator fetching during a probe deferral?
> >>
> >> When of_platform_device_create() successfully creates the device on th=
e first
> >> probe attempt, it sets the OF_POPULATED flag on the child device node.
> >>
> >> If a subsequent initialization step triggers a probe deferral (for ins=
tance,
> >> returning -EPROBE_DEFER), the probe is aborted. However, the driver's =
cleanup
> >> path does not depopulate the platform device, so the OF_POPULATED flag=
 remains
> >> set on the child node.
> >>
> >> During the second probe attempt, of_platform_device_create() sees the
> >> OF_POPULATED flag and returns NULL.
> >>
> >> Because port_dev is now NULL, the block above is bypassed, and
> >> ahci_platform_get_regulator() is silently skipped. This leaves the SAT=
A port
> >> without its required target power regulator.
> > Welp. So much for that.
>
> Indeed. Not a great API... So we would need a pattern like:
>
>                 if (of_node_check_flag(child, OF_POPULATED))
>                         port_dev =3D of_find_device_by_node(child);
>                 else
>                         port_dev =3D of_platform_device_create(child, NUL=
L, NULL);
>
> Which kind of makes the patch not needed. Let's drop it ?
Yes.
>
> --
> Damien Le Moal
> Western Digital Research
