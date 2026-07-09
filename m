Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30F8F54723
	for <linux-ide@vger.kernel.org>; Thu,  9 Jul 2026 01:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783562355; cv=pass; b=JY+giUijvB6RkB9OpBwtlyoj/fy61ysRIRLzcOC7bLCJQsm39Vx1ynLfmUNlfwAhytrtID59ABFBK6fiv8TW6fhDtTXPPzlP5djxm7NeCq3FbHG4DDiYCKRKAhz726YlUMBzmOkWoCCzdp8GifmMuEtNG0QRzZzzvrNlWk+mPTY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783562355; c=relaxed/simple;
	bh=bZidKjtxL4+Dk7nsbUlia6m3IlfmzcQcCH9FUJEM3zc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eYjT7PwJZxm+5wT+H2LulgKSYSi/Yw1Bs6/bOcQp75PUAfGlhUjZnmfGCjbSKGuTOx2nWZsRGISGgBZXUPI2TwsHNo5WmJjcXMvtKig4UshbEYC1mxYahVhnnRflVRFtbtAbWajTQmgcyOUK75EX1JNyVb/7tF91OIcNCT1AqvE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j7pPjuSi; arc=pass smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j7pPjuSi"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-c15cb6f5c12so260826366b.0
        for <linux-ide@vger.kernel.org>; Wed, 08 Jul 2026 18:59:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783562352; cv=none;
        d=google.com; s=arc-20260327;
        b=qpQDGlD4be6BmKYsM+Vd8rt5dPhg32o6xKREVU+VvMVQmjJ8JKBN2x2OtCMCo85MTZ
         b+hAML3QMNMz5YrPmv8FGSauXwSEl8laUq/VivlV+Y783ybg/Vt6qInndgpOumBsfJCK
         Gllbhdl9FVcjkccdQeexVghwymny6g/DZUSZFhpRAUvBkdCUWODJIxCy6bmg6Er0jszi
         t6z5a0eZbT3R5TMcOTm9HYsRQauZd+udIj3/yIcRiLuWIHv9QmMiYRrArpSPMNiMOKPp
         0D5Xpz8PHaW5cn0h9eiPmrI0x6s91rpdHWUlFv6AMgzB69O0kvf7kdlERbHaJTM9AkGO
         xOqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=opR+W6IiptwymG2eHcIlT5mq4Q9PG/6DwjJu8XQd8s0=;
        fh=wwfM8cMTjYJSUEB0IDjqtbbQZ45drqg27BU9XgmCz7U=;
        b=QWfPT7WNuddeevB26vWrMD2ZC93fKlk3vSZfu4KFAoE+/j3YIc8bblgWdK4omR/Iw2
         r6NjixZ+B2YNdzU99d8M9HryFESi8H4K57vqZFf/5pLEIcm6icK9COa6Z6iJ9qegvEOS
         ip9EJJ5MXCihN54p/ZHoq/lhFatUwKoV6zydOHOXWv0h50pK61GC0Yr1SdI16cVWlxbq
         faW9WU3hzflSloep3/I/wRjDRxeFoP0K36/ylSRpK0sFJvJpG3tDu5AHbf9K/JSjM88R
         Xdwb8shAWXfU5aL6HFK5p1MuEGd4VaVGLHCpQiwjxYoBl7A90knkt+dar0Mr10tXSzN5
         z5qw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783562352; x=1784167152; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=opR+W6IiptwymG2eHcIlT5mq4Q9PG/6DwjJu8XQd8s0=;
        b=j7pPjuSisZmf790x/VPNqbKijYpEIn01b5/cviqGivhqqBK3CVIywvEfO0Ee+P0Q5t
         GdnPrYoKkrVXCgYku+ldKI1rVQwUzrefL2xQdO9wMRGC9ypp4RToKPxWaam8VwYaxpgx
         e10BpZtjrzQupmGS7/6BH/TtCvGH63i9dkEmHXQ5enyv6jV4KT9ccjopUQs1nsKpS+t/
         iuZzCaS5FPEe0JLN8qH9Ij3QmWYI1VAv7OQvxBJ032csNW2kSgFfUMQj/GijqdnnELdW
         NYlHr1HozNSiVvpnhJVZsVunReE/apFbRIfLm+ubb+sSwdW1QekVpRVpqsCIdAq2nrhj
         NQwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783562352; x=1784167152;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=opR+W6IiptwymG2eHcIlT5mq4Q9PG/6DwjJu8XQd8s0=;
        b=GePJn2z04Qz/jeOB0MXl7/TKabFszCkmc2uBiLyD6AbSk7bh/1cIgbi6A0j/RWqes2
         gLSTFpEyEfXKNBDA+ctnx1jhB4tOqF4n/L0F+WbpjaYFVdAOk43Avm8wR7qTujcbtIK2
         27xyxrd7juuyYPyDmocvAc4KsqlOOiqtQKmW6AA/+hq5lm69xWvb/XUhL9bE7Ipn8ZzA
         TxoNH4Jm0T7IZejVZwbKmQMhEShJWwYm8n7QBnGuIUslQRkr5vYZayNYaxQ89jB5E/30
         Xen9zcQ1rYarVSmDFbRmHJljyZuUvEEDstylprSUNKH6R63NA555mB0znqE+1A4Ld2Lp
         CGGw==
X-Forwarded-Encrypted: i=1; AHgh+RoeZXY+Qg85UqBAdAngZSiXT46gbLF9fTGakGY2SCG9DhfaLM03O+Y+aE1Sn/9lbN0NRM/ZZuCetnM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcSV9JyrrdUnvlEuDoZ/ObfMSyDQPhQ6coLYX1mmQ/oF4so8kt
	nRLd35aS+yoh1pUSmOMrkYrPNTFdWWeYa8GTr14jFQedmnOlA36JsLRI3CG4aDmXokGiLMzRtn+
	eXsU9bVlMfOXiJ/UxBd9zME9i/aTaj4k=
X-Gm-Gg: AfdE7cnauTRnh0+5Z1ety+ZAiCKRW9iJGs+wJhOLk0p5JC5VE58apqhQIXDVqC9px0b
	TousBdH7W1F7tgpN4tmAGdCmBDQW6Gw3ZR+/Rs75gRbS9CEFmj34q9yR9R1jyC2rePD9yVobUez
	E5PYKOeH3/llJoR8PVa2pZ/WB8es1Vl69H5CqPbkT9uZyvsCs/vLZCO15REtgGdaIY8cbxR2LzV
	n24+nd5ED0ZAj7gH6jrg7ZPmwssu0TxsAyPaeCES9NCkMckrB+vycyrglGW6hLYz5JglkLuilBl
	o98RPHXr2Jb/7vSySUASJuqgJWH2CkmgN4IUZmGjLx6rrTQcEE6F5x3eV1bQS/wJ4QnhhU/R0vU
	57q5V0m/ruIWrrO/qi2GOOXALffpat4DPyBitnZ/bVRHYVWHQUg96QA0djF0GECp7cuwKiqjIVV
	PJimigwwI=
X-Received: by 2002:a17:906:ee8c:b0:c12:516d:3ab4 with SMTP id
 a640c23a62f3a-c15cde7185bmr205785566b.7.1783562352464; Wed, 08 Jul 2026
 18:59:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260709014230.1905756-1-rosenp@gmail.com> <20260709015021.BC6D91F000E9@smtp.kernel.org>
In-Reply-To: <20260709015021.BC6D91F000E9@smtp.kernel.org>
From: Rosen Penev <rosenp@gmail.com>
Date: Wed, 8 Jul 2026 18:59:00 -0700
X-Gm-Features: AVVi8CfMoq7S46JmXr3i7UOgwTfBlWcPUZQHMulb3HkET17hbLYxiazlCxHP40U
Message-ID: <CAKxU2N9B6xndc8GT+KrRAPjtafGzrEBjJXFWguw61KmAjUzsKQ@mail.gmail.com>
Subject: Re: [PATCH] ata: libahci_platform: use of_platform_device_create()
 return value
To: sashiko-reviews@lists.linux.dev
Cc: cassel@kernel.org, linux-ide@vger.kernel.org, dlemoal@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 8, 2026 at 6:50=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [High] Using the return value of `of_platform_device_create()` breaks t=
arget regulator fetching during driver rebind or probe deferral, leading to=
 unpowered SATA ports.
> --
>
> --- Patch [1]: [PATCH] ata: libahci_platform: use of_platform_device_crea=
te() return value ---
> commit b10e7693c196a90e6a36f9889202414e7cb20fc9
> Author: Rosen Penev <rosenp@gmail.com>
>
> ata: libahci_platform: use of_platform_device_create() return value
>
> This commit updates ahci_platform_get_resources() to use the return value
> of of_platform_device_create() directly, removing the subsequent call to
> of_find_device_by_node() to avoid needing to free the reference.
>
> > --- a/drivers/ata/libahci_platform.c
> > +++ b/drivers/ata/libahci_platform.c
> > @@ -617,10 +617,7 @@ struct ahci_host_priv *ahci_platform_get_resources=
(struct platform_device *pdev,
> >                       mask_port_map |=3D BIT(port);
> >
> >  #ifdef CONFIG_OF_ADDRESS
> > -                     of_platform_device_create(child, NULL, NULL);
> > -
> > -                     port_dev =3D of_find_device_by_node(child);
> > -
> > +                     port_dev =3D of_platform_device_create(child, NUL=
L, NULL);
> >                       if (port_dev) {
> >                               rc =3D ahci_platform_get_regulator(hpriv,=
 port,
> >                                                               &port_dev=
->dev);
>
> [Severity: High]
> Does this change break regulator fetching during a probe deferral?
>
> When of_platform_device_create() successfully creates the device on the f=
irst
> probe attempt, it sets the OF_POPULATED flag on the child device node.
>
> If a subsequent initialization step triggers a probe deferral (for instan=
ce,
> returning -EPROBE_DEFER), the probe is aborted. However, the driver's cle=
anup
> path does not depopulate the platform device, so the OF_POPULATED flag re=
mains
> set on the child node.
>
> During the second probe attempt, of_platform_device_create() sees the
> OF_POPULATED flag and returns NULL.
>
> Because port_dev is now NULL, the block above is bypassed, and
> ahci_platform_get_regulator() is silently skipped. This leaves the SATA p=
ort
> without its required target power regulator.
Welp. So much for that.
>
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260709014230.19=
05756-1-rosenp@gmail.com?part=3D1
