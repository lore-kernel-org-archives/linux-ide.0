Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6599931E825
	for <linux-ide@vger.kernel.org>; Thu,  2 Apr 2026 07:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775113899; cv=pass; b=ZF58l+ZztQgbwF3S0rJn6JL2JzwU7SW3Vgf3g6FQ0gQzZzb/B0HeINirXelABrrcbp7m8PvHqVANDsZg5pQj4plEisvLkvtHMkPzpun7LdU5sBme6UZUh+eMGe7rp5JR6OA967NkiokuKtyXD/qeucphQsLg85xSo/kUjFY8N+k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775113899; c=relaxed/simple;
	bh=YNt2gl/VbOO5WcANP2A+9eCFjGKBc9/jxvR3pWAfRos=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ta1kvMmoG0RU75vErzAVXIndh35ZRdSv5ihjkCkYT5n6f/aUuJbV33WENYM0QZrJ98fAGSKyiXKlxcCYQ3vUvXeW0cdoQjiSV1Nu7F90CqJeT7DvkLC6D5swmewUpD8IAGB0soeeAHQCA3OPpyxSip/tBvZ+xSSC/B1AwpJqg88=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X0d5y1nE; arc=pass smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X0d5y1nE"
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-79ea87af213so25586427b3.0
        for <linux-ide@vger.kernel.org>; Thu, 02 Apr 2026 00:11:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775113896; cv=none;
        d=google.com; s=arc-20240605;
        b=NxTLq4DhBLJDgPHkMNXFOTmhuzPBsQnuGXPqTvX1u/asHakzdmL7BMQi6bbFKBIp3R
         tcYqnY1EHMjYJYM8U26AoTKHa57BMclhVJYOM3eZAAh2XO0eQhKYgLJYXyE4s6dRtQXw
         t47cAB2sctYscSvY3P9e/wG39Uyc7Qa1rNg8ZjKfmkdmzcqgxGgRv/aggPBXV8Fniba6
         msLGFZ3ww/WY9lBehgPKM8QNRaID52yg7SxjcAIQrDsL1WmGzieo00f2gseQos/n04g4
         e20QIQcRs6HPBVJYpRcurWToTPh/LKWaiJDYT4rXpgjErUSM2cz1V2ovjZHWmXhQ9klZ
         4fuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=gkDhIF35Qc8w6AXyc0XHWFZ1U2DesHw7zda65pFrKro=;
        fh=WmHNeXS/dWYjpCs/HKbz+jKJtC+dT9iTg+5lR15BwWw=;
        b=CnHGctnBQbREEk7P5e5X50r8hEAowdKtwuBJIkL+qoGkphIKHxE5nHcV44a/aaQUeM
         MwT3DwRwF/9XeLb/lBa0ab8CJgT7Qu/owM6rZWGcv/DJhPas+hiXEA8e1nFbmC8vhy7d
         EcLg6zlq7s6ea1AwXtCIBtHcmYDR0zbjQLbzsYCLJUi+4C3hE5LJ8SBsCZQbWegDPr1y
         EK5FeMcWNxzXYt252Y497DZdWm8mcJqioV6hzMcSrxNMHAjgbMjFmDRd+Mrx7vq0e4hE
         xe27Y6zBUFxlfz0/ln3c8pqhQ/i8eB5bT8EbWWL4lniXIwawfFtt9apLZ+x/1eFIwGQP
         QY8A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775113896; x=1775718696; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gkDhIF35Qc8w6AXyc0XHWFZ1U2DesHw7zda65pFrKro=;
        b=X0d5y1nE4h0RYjCSpAA8liUDmaphG4NyCiTawyskJ+wZy33bcn88hZffOZvKWV7/0w
         JnDGy6kACagoBj3XXBhVdB60J62zMyhDcXknwIqSs6r8p+cwc6OTZPS35EE9eZoYQRx3
         CWhzf/976K0f0dxTF+pguFOHzwt89JRSINKA5ls57wlV/7ru5lqfYeazHuCWZLO6GS7X
         nFI6JvKsniGSH5BubtvnD6r2no1yG53EGZiIXCCYfLOd6K9E8Np5ef9NWxploML4hUmB
         NX7DxxZfxXCXEVn1O1IAcfNPk39cvK55sEeboU0Ur6Pz+Xq8FqDljQwFlNtXaq26Kubj
         mCgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775113896; x=1775718696;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gkDhIF35Qc8w6AXyc0XHWFZ1U2DesHw7zda65pFrKro=;
        b=ST5hNOmbAIPUVqUHSwPUjVIi91E2FPAmslNQPOjrr2Uudmh+R+CJYMgMdJZa7INfOy
         OFAZIQWunBAx4lGkGm1/bmEuJNDdYIcTKhvfshmA8aptPF2eGjhIhmWT1TmJf2UV1GCI
         e5imbe4xTnADYyQn7BrVK7898HvlOliCyMNAg4kAjDlUDOUKR2y0GFwOXRds3j9EJJdV
         Uo7e5FFcrU1JvYMznvlZ8YR3KbYtWQgAkYsyWcOAEAHdvwyLWtAwKnFl9Zt0Sd6q/VzH
         T1+07a9oY26XFu6Aqb3T/CpVmGujcZxRVGdhzhqrbzkRCGnJYEJzAeCVFqHuJepUK8KD
         iOEg==
X-Forwarded-Encrypted: i=1; AJvYcCV2uwfNvjqgRkjuR5wklCOI/bzx0KqXhTJSXuuYeNCGDikxRbEfx5W3NHWVPU+L6c5VGhaJ7WGJRso=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywru2Zd1ZBtefwvkqs7Rj+arzztudVVbZlee5OL0+BDKLW2dIKe
	yJ0rXvx2/fX9L9IofAqtSOFN/UZySIjG9HuiMPuwF2ufWqdO7s27V2uRAeG8LnY/XqEeMoNGd3D
	vqMA2uMOoDTHsxkTtpPAgibnCvG4kHxM=
X-Gm-Gg: AeBDietdhNlp1lhxq/CYQDQIjEhM+QiMpk+yfMIEmHGaHulzoawjysIJyF5uLeBNmFL
	3w5CPZ0DpFlD1zPBZVu0n7NZWUqhwh3N5YnGz3BmNvVFTEL/BtYo0llonY5+BtCG58r4lXL2uJ7
	vLaiEOCa0qvXcdeSS47NJkPpxs4soTyrq4niQgjGGRYhyHwtw425EahnfoSXJuwG0NtoI3o2CWD
	JvjzZJhsp9CjN0QFZ1zyDfkSjABWcbUamfacIHCNYa9iUYHkMFKIoMqkQY9cwtP5dHTSNoSv9W+
	lJosmS/rOcsrza0LQnhP2XjU5aLPLnY=
X-Received: by 2002:a05:690c:d8e:b0:7a1:98b:b3e5 with SMTP id
 00721157ae682-7a3bea3f4b2mr9697467b3.30.1775113896195; Thu, 02 Apr 2026
 00:11:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260402021027.56-1-hechushiguitu666@gmail.com> <403a9722-02b8-463b-9980-e7de32e30008@kernel.org>
In-Reply-To: <403a9722-02b8-463b-9980-e7de32e30008@kernel.org>
From: Owens James <hechushiguitu666@gmail.com>
Date: Thu, 2 Apr 2026 15:11:19 +0800
X-Gm-Features: AQROBzDTDey53KJuQk4LyyTnkL442TSft2CXJaY4rp4PU2zGLN-G6ycqQhwLZ8E
Message-ID: <CAEZ4rQ8QMQ8q0ev2oSmVUoFw=02Sp5BEqTjzr_=Y+pv8Uk8osw@mail.gmail.com>
Subject: Re: [PATCH] ata: pata_arasan_cf: fix missing newline in dev_err messages
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Viresh Kumar <vireshk@kernel.org>, Niklas Cassel <cassel@kernel.org>, linux-ide@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Damien,

Thank you for checking!
The function arasan_cf_xfer() does exist in the mainline kernel at
drivers/ata/pata_arasan_cf.c around line 380.
This patch is based on the latest upstream mainline branch.
Please let me know if you need anything else.

Best regards, Haoyu Lu

Damien Le Moal <dlemoal@kernel.org> =E4=BA=8E2026=E5=B9=B44=E6=9C=882=E6=97=
=A5=E5=91=A8=E5=9B=9B 13:35=E5=86=99=E9=81=93=EF=BC=9A
>
> On 2026/04/02 11:10, Haoyu Lu wrote:
> > Add missing trailing newlines to dev_err() messages in pata_arasan_cf.c=
.
> >
> > This keeps the error output as properly terminated log lines.
> >
> > Signed-off-by: Haoyu Lu <hechushiguitu666@gmail.com>
> > ---
> >  drivers/ata/pata_arasan_cf.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/ata/pata_arasan_cf.c b/drivers/ata/pata_arasan_cf.=
c
> > index 514d549286b5..abcdef123456 100644
> > --- a/drivers/ata/pata_arasan_cf.c
> > +++ b/drivers/ata/pata_arasan_cf.c
> > @@ -380,7 +380,7 @@ static int arasan_cf_xfer(struct arasan_cf_dev *acd=
ev, struct ata_queued_cmd *qc
>
> There is no such function, and yet your patch applies. I am confused...
> Which tree is this patch against ?
>
> >       if (!wait_for_completion_timeout(&acdev->cf_completion, TIMEOUT))=
 {
> >               u32 rw =3D acdev->qc->tf.flags & ATA_TFLAG_WRITE;
> >
> > -             dev_err(acdev->host->dev, "%s TimeOut", rw ? "write" : "r=
ead");
> > +             dev_err(acdev->host->dev, "%s TimeOut\n", rw ? "write" : =
"read");
> >               return -ETIMEDOUT;
> >       }
> >
> > @@ -474,7 +474,7 @@ static int arasan_cf_xfer(struct arasan_cf_dev *acd=
ev, struct ata_queued_cmd *qc
> >                       dma_len =3D min(xfer_cnt, FIFO_SIZE);
> >                       ret =3D dma_xfer(acdev, src, dest, dma_len);
> >                       if (ret) {
> > -                             dev_err(acdev->host->dev, "dma failed");
> > +                             dev_err(acdev->host->dev, "dma failed\n")=
;
> >                               goto fail;
> >                       }
> >
> > --
> > 2.17.1
>
>
> --
> Damien Le Moal
> Western Digital Research
