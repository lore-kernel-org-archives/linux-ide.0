Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EA0E23183C
	for <linux-ide@vger.kernel.org>; Thu,  2 Jul 2026 00:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782952089; cv=pass; b=GXvVPo7+PUQSc+QGyhyhRLLawKq+STzPaFuLCna350Jr0z1TU4o2x+OWCjQ9BrsbKGIp9DCAjwiOzU6l8xPqB+ejjlzbOIGr1NglEMfdBdga9R8CJ2QSh33sNyKo12ci0xTBlWEH0d24gZvZdxEx0qsgdYN3TPN2cz3LgTMOJLo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782952089; c=relaxed/simple;
	bh=PRpLlpspsJW+v9bAkQLyB59Dz43JAAtvI4RiutteAHs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ifZXeATGnkXD9iyZ65Pb0OCaQTf2Q1zbaFaNQvMUrwfxCJV5g8AdqakZVIKzfnVdFJldjAPTBlTLBY+m+fJMJobPwWlvL+Y2Pel9iDo50dUVyqvRaInCj3/Vj0aW/GGWCkHjA2Lwr/rQtFOCH6uC23ZYc0w0SgB3gnZ0Q7RzNUw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EhTpi//J; arc=pass smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EhTpi//J"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-6986287534eso2065794a12.3
        for <linux-ide@vger.kernel.org>; Wed, 01 Jul 2026 17:28:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782952086; cv=none;
        d=google.com; s=arc-20260327;
        b=N1L1dgjV5qCcCortfhWdQzDeSpVsmYxVMcglGJvROq7YluYN0IjSl2wAROzFhp/y80
         9Nnt/rxSz7zxyYc6X2aaEESRKfVbVsUWmOI1c8K3in2G2GVctczSMsMvMirHr2wCWQON
         jpf1WX5empVF8alzWpkVYmAOYgKXQ4Nf5L+WU0CXtCHmm7CQ1fK/oOlCwC0tM51SGI+C
         OIMZSySP2HhxAE8e+CViuRLS/pTuDWZr/nDae0fucbxiuRgebl2N+NaDUlV8HSTUyYLF
         2fj68uxi/MITwMh7cQSzP9bfc25YSBDZhOJJyBqnn9NhfgwU/RF+AcBhAY8gQXf4KTAd
         KYig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=We1bG2+WbAmOyWnbL+0rX50B3Kc6N+qu5xoD/0ufFUI=;
        fh=eAclegJd5/9JZgcjAF4JAuzGkts5iGJ+OyWCxlO0gLY=;
        b=MzjXb7WmWfSBLQvUP9RmaFoiA2Cwpo2wdDGt3LNXhvfBXAud6B8Lwf36E+Z3k5rPcA
         +F/ttw20baG66GMQlsPOMHvdlrqMc9LMtuN2s9CcZtgV8GE0e7GM+Uqn7CdVv4Efb8Li
         I4cVsEjToZpeMonW8mMUxY7/P7Yeu/HnTl5H/ezobp62lkxA4OAUe0qYUlwx+wT6Boiv
         jXv/WbGW8+edQGw4m9+DGPIskS6GE+ijq/GPIZgPIGOHlYt/3fMj2bgyN+GShNRoGig/
         b3+Sp+670CkKy3wReUWaiwopiSA+ghKSSbrkw+DPjzUZ5+OAE2CTP3cyvksdJdQet51a
         otvQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782952086; x=1783556886; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=We1bG2+WbAmOyWnbL+0rX50B3Kc6N+qu5xoD/0ufFUI=;
        b=EhTpi//Jqg09uvxqao1RD+SooLny1oKTdbByDsMFPwxYW4bM+hUl/s39nI9j30BqQx
         oFoxHzuHLyLSNFf0W7DXa2n43h3EVB5oXhPZaea8cICm89qW7CVTOXYa0Z75oMqf7mJX
         8y3mMI1wJxotsxYpTl4UMifkb8yUybWmofscK3/e0LdHDO3AJWsUICSaxg6dbx3LtpDe
         tWoxSeP3MCmaybxKGMUy/1Md+P0a8S099k9e8/iD6TqsrLeuHKZkxSjdW4Y7j/yTfPiD
         +gICQhRmp+THCFLkaXjH9IK8dXy5sdphJMrqHkN95xO0HQ4HxtKBjo5gpkwd2YYejW0H
         BYnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782952086; x=1783556886;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=We1bG2+WbAmOyWnbL+0rX50B3Kc6N+qu5xoD/0ufFUI=;
        b=GVe6zI3jiCl3a+BebD6yTp6xkZTgRIfJAV3rR9b23H3aRQnXNOmOaCOiU7XIiSSz5W
         HsCpRKCP5jKEL4OW6xoO5BT7U7Ypo9g9nUcTlWDKTaGOc6k40AJqh2c2313l6yjgtU/G
         jRjjluuybaUFws0PlllXxTKZz+mtPa3pBgL17fzFV/eh1KFZEVwCwtkJitpCEc/YX6oq
         RlRu9ShxNu8M6QDI02e2VzICMb2oaW8tQs5EhlARv2LNEyuREm4OF6y3y7Er602m2+l7
         otdF3KusDA9It4HP4J1sRzKljDUnZw684sU9HKRuCmuZV+vawacgSz/UrMCBsRNV/yTt
         WQeg==
X-Gm-Message-State: AOJu0Yy5Az8LmHQZYcOcC/p5JMaIlrFd0YbN/zwRRBZoOmcliR8+U0Ma
	ssGAR74bKKWonpq/T1sdqpNbNfsoK4tEl9Y8X9BBfdQMw5POyoriZkIzOW0PbjkRUf/XZqgE5Cd
	IV+6D0ZsjTCjgheY0H0JQ3eHxu76nZelkPw==
X-Gm-Gg: AfdE7clL7iTPqB54obcXWnBNscCrsbtYhlOjU2UvoAZW8xhYXCIXdtQMzarvghU3RKS
	GzHhm9TPRIdWzkjrJ2Wvh4JgKW1x60DtboxLlaSgjqFtHmLtAhwRsolVzqDNaq4bJ+6Uu/qR5Ou
	gc+Uhk9TVxmiLiGifxrOOSsbhxFm/TQHqPTJKkW9cIgSSBEWBQvFnI0AsL5OGQrihMsUjZ4ryTH
	g0q6ONyU8/ezfAlODxPd80FFQ1zjOWKuwwKJbujjXs5ndP88V1I503xB01mkZPwXHbsmHU9bRui
	6EvYSLofSaREy2YlcB19zhVCrOyHL27GtzwbEuO5dVpvQJzyI6mVovGi6P+m9qMBfOvGVt5Lqo2
	1fO1E6Y7REht+gkU06Y0nURKrzG0=
X-Received: by 2002:a17:907:e143:b0:c12:3590:2bcd with SMTP id
 a640c23a62f3a-c12a9db678cmr131155866b.29.1782952086416; Wed, 01 Jul 2026
 17:28:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260702000350.68331-1-rosenp@gmail.com> <20260702000350.68331-5-rosenp@gmail.com>
 <20260702001341.AD7041F000E9@smtp.kernel.org>
In-Reply-To: <20260702001341.AD7041F000E9@smtp.kernel.org>
From: Rosen Penev <rosenp@gmail.com>
Date: Wed, 1 Jul 2026 17:27:54 -0700
X-Gm-Features: AVVi8Ce_zg8-2_VISqacBAZy-gMgVLc16q43Xb__VdoFqDMMrz88Vcz3wwROn4g
Message-ID: <CAKxU2N9iNu+FhsRVgNW6dqzymoN5hYfHfyBu4E7UN+WNzv3kaA@mail.gmail.com>
Subject: Re: [PATCHv2 4/8] ata: sata_dwc_460ex: drop redundant struct copy of port_info
To: sashiko-reviews@lists.linux.dev
Cc: linux-ide@vger.kernel.org, cassel@kernel.org, dlemoal@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 1, 2026 at 5:13=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 2 potential issu=
e(s) to consider:
>
> Pre-existing issues:
> - [High] Returning success (0) on `ata_host_activate()` failure causes a =
kernel panic on device removal.
> - [High] Missing cleanup of DMA resources on probe error paths leads to U=
se-After-Free.
Both fixed later in the series. This thing is still broken when
changing [PATCH] to something else.
> --
>
> commit 1231cd1ac0d6ac3ad6a4b61a9f9cf20df21198d9
> Author: Rosen Penev <rosenp@gmail.com>
> Subject: ata: sata_dwc_460ex: drop redundant struct copy of port_info
>
> This patch optimizes sata_dwc_probe() by dropping an unnecessary local
> copy of sata_dwc_port_info[0]. It directly points to the static data
> instead, saving stack space and correcting the const qualification.
>
> > diff --git a/drivers/ata/sata_dwc_460ex.c b/drivers/ata/sata_dwc_460ex.=
c
> > index 4fc22ce4bd9aa..f262b00384ac4 100644
> > --- a/drivers/ata/sata_dwc_460ex.c
> > +++ b/drivers/ata/sata_dwc_460ex.c
> > @@ -1134,8 +1134,8 @@ static int sata_dwc_probe(struct platform_device =
*ofdev)
> >       int err =3D 0;
> >       int irq;
> >       struct ata_host *host;
> > -     struct ata_port_info pi =3D sata_dwc_port_info[0];
> > -     const struct ata_port_info *ppi[] =3D { &pi, NULL };
> > +     const struct ata_port_info *pi =3D &sata_dwc_port_info[0];
> > +     const struct ata_port_info *ppi[] =3D { pi, NULL };
> >       struct resource *res;
> >
> >       /* Allocate DWC SATA device */
>
> [Severity: High]
> This is a pre-existing issue, but does sata_dwc_probe() correctly handle
> ata_host_activate() failures?
>
> Looking further down in drivers/ata/sata_dwc_460ex.c:sata_dwc_probe(), th=
e
> driver logs an error but returns 0 if activation fails:
>
>         err =3D ata_host_activate(host, irq, sata_dwc_isr, 0, &sata_dwc_s=
ht);
>         if (err)
>                 dev_err(dev, "failed to activate host");
>
>         return 0;
>
> If ata_host_activate() fails (for example, if devm_request_irq() or
> scsi_host_alloc() fails), returning 0 falsely reports successful
> initialization to the driver core.
>
> When the device is later unbound or removed, sata_dwc_remove() is invoked
> and calls ata_host_detach() which calls ata_port_detach(). Since the
> scsi_host was never properly allocated or was freed, scsi_remove_host()
> will dereference a null pointer and cause a kernel panic.
>
> Could the return statement be updated to return the error code instead?
>
>
> [Severity: High]
> This is a pre-existing issue, but does sata_dwc_probe() leak dma resource=
s
> on error paths?
>
> If CONFIG_SATA_DWC_OLD_DMA is enabled and no "dmas" property is present,
> sata_dwc_dma_init_old() is called:
>
>         err =3D sata_dwc_dma_init_old(ofdev, hsdev);
>         if (err)
>                 return err;
>
> This allocates a dma controller via devm_kzalloc, requests an interrupt, =
and
> registers it with the dma engine subsystem.
>
> If a subsequent probe step fails, such as the phy retrieval:
>
>         if (IS_ERR(hsdev->phy))
>                 return PTR_ERR(hsdev->phy);
>
> or later in the main error path:
>
> error_out:
>         phy_exit(hsdev->phy);
>         return err;
>
> The function returns without calling sata_dwc_dma_exit_old(). The driver =
core
> will free the devm-managed memory, including the dma controller structure=
s.
> However, because explicit teardown was bypassed, the dma engine subsystem=
 and
> the interrupt layer will retain pointers to this freed memory. This can l=
ead
> to a use-after-free if the shared interrupt fires or the dma subsystem
> accesses the controller.
>
> Should the error paths be updated to call sata_dwc_dma_exit_old() instead=
?
>
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260702000350.68=
331-5-rosenp@gmail.com?part=3D1
