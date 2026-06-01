Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD1033EEAEB
	for <linux-ide@vger.kernel.org>; Mon,  1 Jun 2026 18:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780339202; cv=pass; b=rly0gvXHTwvW+H+7sYIbEPj9Ep5Lg7Mh9h84ZoySHfXXRhxAj2FwmNHebp5uTQnp4jSnq4Hg223BxDvsP/hHkdI/W+IuPd3tgElSIDGpJ8UsRmuoM+2JW4DHXuhuP9O+VMGktuQLYhFY6pJ2NmTn5qm5efRoYf3CXpCCrsNpw2A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780339202; c=relaxed/simple;
	bh=o0L5elnLUsLIp4wpIsxq3kSiG5bWnQEIm2QqKiVsTcs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qggqddBGPPwxoRXL4N2x62pJaLQDkkJbYM/mEkWLbEIa7NF+VOyyKZXYFFrjhwysllAToz/1Bi/yTeW3EzxyDNSvEM4wbii+9QYgzynQT7Qdf23I2OUMvg0W20xST1Dxq9BEKpvSlB7+hA9x2Sb+ttw2gG+cKEqHU/X5wsO4FTg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sm0P5hV3; arc=pass smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sm0P5hV3"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-68c19f1f3ceso5102543a12.2
        for <linux-ide@vger.kernel.org>; Mon, 01 Jun 2026 11:39:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780339198; cv=none;
        d=google.com; s=arc-20240605;
        b=CghTNxiSMqMS5loRwJyXBtUJIcy4+bbEP6suFFnBkLAPvMbfXpuAEJJH93MskkCdDs
         fVqoxlwy69A0st07YaI2RguRoJFHHZbMYaDlaz61AzbNWvAL5UVEj/i5ex4hpF3H7vCe
         Zr9dF/QZ44xdcac0WVGfC5bPldn+EUJX/s8yfpXxA1OMi4tJEWC9V6SoOwHCn5zG8QOV
         NkJW/2mKDUjtHXIsyoYgg/Wuew8FE0wq1Qoyv2NDEYidiVqh748sRnu/ZD0OG0kWj1Ra
         WtXcjK5Wxqtt2ZF0r5jVBBiitmO1MjBXn+DUiAI2YJhIF6JLiqjM7S2czoWEfldSWLam
         FSMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=LK/ehbm9/8BeGQ6wKS0ooN/Z8mwx4mZuYvXbxm5eV4c=;
        fh=O7mbwfcfAPqIbqghEptK4VdMc9DVZG4juwrhLX6Zq8I=;
        b=esf8p8sBp/hHnFy4hNCWILbASiudU9UOKQhKz2QoITEqch6cdEh2Yr+yTc02qt9D73
         mJtgbBAetbjJjtCIs0dJpxrwapW6sJHSu3shpu9q94J06CA6eDxildKiU4YxfIzpsqLg
         S9J29hVBrZQ8UoZXk4AorMnhNsxaqrWEK/Eir9xnl2iIjrFrDZvclr50bIabN9m9xPv0
         WE+Yi5V0npCATaTahFIGAH2XLrsArRfOTxoDBKLuWiZE8jeCy4/FVz7x8CvmIP0So+MQ
         KY4ZfX1D5l+IjD4OCtZvuh5xcP4pzxyFDyc7BWeUM0qwTlE1CEi2Uas+WF/86rx0/U6+
         CAeg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780339198; x=1780943998; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LK/ehbm9/8BeGQ6wKS0ooN/Z8mwx4mZuYvXbxm5eV4c=;
        b=sm0P5hV3I1YIjgD7fYxnuQSRHAEaCvUzmuf0BPHyB07jYzGcN9jBN+B+GSz7dwQBcg
         4KcLhQ4I+wLOyAJwyg3GkeN3ryYQG7sX8tEBGAXwG4jKmzhTd9oOWVnqQYtuuiXDuZYK
         9o+CQnn+AjkpnzK8nwHyhZBk7EBb5zBZLU7C1qcYNKzND7E/j4+03oCqLV2eEz3Je52T
         xwKYCu1Av/RMbIKjy5SX9l4NZtX8mvb+xCoCMhfmYTeCDLmUyflxiu1PiJimou9UQm2R
         DgN+5TOmuEbLdW8wmEOLrK+/D2rNJq5DvZ5bg73Ikd9T40weV8ocYrKq+c0PLGBiGLJ+
         OVXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780339198; x=1780943998;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LK/ehbm9/8BeGQ6wKS0ooN/Z8mwx4mZuYvXbxm5eV4c=;
        b=khGmYjcsIrzQ6N+yoEcKBksl87OoEEd/9HDQi2q7bxb3z+QJjCC+HIU2jSV+2q42zE
         SeYMPsYF2z6OqB0ZXWCmggVJfdYFnvvbVPR1teGHgIF6EUp/3vWxx95mntbvKcC5HTya
         HJYPmGsYUHEDM8azlzXyuYHOvOqOrjcksEW3rAb48LxTX0fq4S/mc8qtPoz1RJR+V9Xs
         n9QzMV0yuZ7Y2tHARv38BkozEL7R5vf0gjen7+c++3CzeuiJZxD4GDFOH+3F8aV1z3v3
         yw9NZQTEZz+rFVkqbCVCaRWyIyia9OA6BvEkeScyEzVHuTGLs14blP7WGFo+Lts/f3eE
         T4jQ==
X-Gm-Message-State: AOJu0YxyFDonDYi3bAMOroD9ErzYcYFgf1bn31HG+c1u2X9jDgeM6/gY
	LPp/mgv6k/ZSpa7wufZf8mRD23kB8iGzmPcvEZ/btR1Z4dqrn+7gMuqRaoBo6EvRbJvivrvGYdG
	qAn9UmK0YxcqNjVGRjmWIi4YMGaipy2s=
X-Gm-Gg: Acq92OGSqPbYxO/4nxuI0G+NsrAH7M6grZLtTwsXHBVsI/47g+OMCeIcSsxIAYCdcze
	cDYC9PeH6N6CnQ1lwUdzUlq9qMtUF3DJBUjpnQnT8KBtyw0AswCO9hBpYMiyqutUmRwjjdz0B/i
	/kWw1Djb8SvxEbg+81D3P90a8yBuSxWLZuDU4XZO/YHJxVxvx1bHuwuDG21FJr08o/1TYgDgjyC
	DvFVRKiNwV5wh15CxJ7nQRXTFEvmgDnVcUjjVwMe8o2Q4fFVGoLAQS5tVPzIKTle91DQFSftFT7
	m6zfiRnJZa3wg/aZn0xzK8vmBQW4N28r8dKghIB8tWYQGKHIaJJtSBZjfVumBKtlXV3nWSxNwsj
	XJvE1R9L393poku+SQu0TfLYUyFW4dz7AbBDsnVSvIslJ/MPAmi3Vx2K8wfbMSbgGonUl
X-Received: by 2002:a05:6402:30a1:b0:68c:33f6:22f with SMTP id
 4fb4d7f45d1cf-68c8c4633e7mr4351348a12.13.1780339197604; Mon, 01 Jun 2026
 11:39:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260530003627.42473-1-rosenp@gmail.com> <ah1Iv88PGkU54T65@ryzen>
 <CAKxU2N_hQu-MsHQTiCSrPvk5BB=bKnktUUvFPGBNvOsoZN+93g@mail.gmail.com> <ah3QxLXvWw0fXRcy@ryzen>
In-Reply-To: <ah3QxLXvWw0fXRcy@ryzen>
From: Rosen Penev <rosenp@gmail.com>
Date: Mon, 1 Jun 2026 11:39:45 -0700
X-Gm-Features: AVHnY4JcAGc7zAqsyEBoe2TUbiWCusBhE_gXjMf5L2XsQPU1bSYyc65jm9lCT50
Message-ID: <CAKxU2N_E-rF64yY63bTRBT+nhF0XpTOpQ-FZCHEPAAk+bgBTSw@mail.gmail.com>
Subject: Re: [PATCH 0/3] ata: pata_ep93xx: COMPILE_TEST and ARM fixups
To: Niklas Cassel <cassel@kernel.org>
Cc: linux-ide@vger.kernel.org, Damien Le Moal <dlemoal@kernel.org>, 
	open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 1, 2026 at 11:34=E2=80=AFAM Niklas Cassel <cassel@kernel.org> w=
rote:
>
> On Mon, Jun 01, 2026 at 11:12:33AM -0700, Rosen Penev wrote:
> > On Mon, Jun 1, 2026 at 1:54=E2=80=AFAM Niklas Cassel <cassel@kernel.org=
> wrote:
> > >
> > > Hello Rosen,
> > >
> > > On Fri, May 29, 2026 at 05:36:24PM -0700, Rosen Penev wrote:
> > > > This small series cleans up pata_ep93xx to allow COMPILE_TEST on
> > > > non-ARM platforms. Patch 1 avoids including ARM-specific asm header=
s,
> > > > patch 2 switches to unsigned long for the data variable, and patch =
3
> > > > enables COMPILE_TEST.
> > > >
> > > > Rosen Penev (3):
> > > >   ata: pata_ep93xx: avoid asm on non ARM
> > > >   ata: pata_ep93xx: use unsigned long for data
> > > >   ata: pata_ep93xx: add COMPILE_TEST support
> > > >
> > > >  drivers/ata/Kconfig       | 2 +-
> > > >  drivers/ata/pata_ep93xx.c | 7 ++++++-
> > > >  2 files changed, 7 insertions(+), 2 deletions(-)
> > >
> > > Your series looks good to me.
> > >
> > > I do not think that you need to address the pre-existing issues repor=
ted
> > > by Sashiko.
> > In retrospect, it might make sense to do so such that those fixes get
> > backported to stable kernels.
>
> Oh, don't get me wrong.
>
> If you want to fix up the pre-existing issues, we are happy to accept
> patches :)
Just sent. Hopefully no issues this time.
>
> I just meant that it is not a prerequisite to get this series merged.
One of those patches conflicts with the first here.
>
>
> Kind regards,
> Niklas
