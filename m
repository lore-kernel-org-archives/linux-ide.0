Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ED5A3E1716
	for <linux-ide@vger.kernel.org>; Mon,  1 Jun 2026 18:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780337568; cv=pass; b=n9OA7LukDCRQ9ua6/zRrw1jkfhpJdayFC72gKI86SVf80ceELfmaP+bwWR91n1U3HPcljZ2YLIvWcJWMH7+ORMoAZqqKJ89ONHX39rPg5+GijkPwKyBXZURyFw+zhogJRDaotujd1EyvLAP0KG2kJGI88m5/GygsSplfZNfhfzc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780337568; c=relaxed/simple;
	bh=iN4/oyZ7jo+cocupSf3mDv767ryncfM/pM8vp8vwPig=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pJmxn8NFFWjyzljK5+rb3DLijU+GbjlJmlBPiNYfQ1jA4QyANBSxny7rvtvj4tS3P9066KTVePST+UHEVtXjaEAAfQ1bck5nCuAxIihnBsKONpPcpkpBCMQqh5kNfTrG4OY6ihVRg3D+ViB1D4qf6JhGT/AM3F5jEdk3FZVzdUU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HOozD7dG; arc=pass smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HOozD7dG"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-68bd9fce347so6024808a12.2
        for <linux-ide@vger.kernel.org>; Mon, 01 Jun 2026 11:12:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780337566; cv=none;
        d=google.com; s=arc-20240605;
        b=G0IiC1WgK6AHtLk/Aqyb6vQHFNiv76oEws8vjaeJYrPeu7GYZVXEdPWldXYB5hbVLe
         X+x10SbdvqvOO/cFVNg+tsx/Sc3Uc5QyRYxe3LpoUGFozb4rENdul+McYC21h3a8kqwz
         6YeAXGtFXMHa1KaZwp23N2TUtlItqrUZduSIRxwBLUGMliN90a4Q9E5ron7HR/RYeIl9
         J/knRHZ+Xh3lrRyHAsccFbPLqfjm0ed03yweHQA64yAWEoKnABCptfOrp9Ez72fJ9d2h
         y6m4K1zZRe4JdFbRt3wioFzAb2XMtoTJZDXUFrDv745ekTZePyGtFEkRlu7DH0DIG83r
         EnGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=sa1TynJU+/d+IvbBhmYu73ubAldgvMTykpuED9x+nd8=;
        fh=O7mbwfcfAPqIbqghEptK4VdMc9DVZG4juwrhLX6Zq8I=;
        b=h+icPkIQQn9bMpw8R4yjnVzsuXgG1Z//CUouuf7qr4FkNb1oOAUlzKgNPJiyPO0Imc
         MxeXgoU/t8ox8UtLQrg7KKO4E6jM1JC71SQ3XeDrb/pyxP6+jibk3CVyhBR5cnwDIKBI
         hY1WzrMwI+gzkIpkYewMhP7WEPJa662622hHTTyitbSZ9qsY+HnY++b8YZR3j+gdSTUf
         IcQnUoJM9L1yBW0zJyd06cIZII50CSuBsr2fibI+QastMYCkMzSKqPcspSWPp1ijBqXw
         htKCtKOamNhbHgmuT2XQ7uiQjtk77lB0u+oigwwAD3f9UUDfWC35rr13TGekpjjdNbhp
         6Q2g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780337566; x=1780942366; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sa1TynJU+/d+IvbBhmYu73ubAldgvMTykpuED9x+nd8=;
        b=HOozD7dGe4RLFeic+D/emF13DGzqHe5jcROueLEpPznuJ5u2EDlopiteUv/wEMFLHg
         a/bHCd2jgKCJnx1knMJrYynZd/NX7SJqP/mRWt6Art0Y4bqNXVumkUNGAOC9FRufBQjy
         6gFeOTvt5r6V829DeGlpCNCTSyk8mJyTpJ4x/j5Ho5Yy1cErGTtC1ISLRwMef3cM/1yW
         czbGNuuqTWCIW7uOUbIGJsJW/qXrS6OboWeSQmwghrI9o7/uwSraE78pCqfu7ktDek0U
         qh+71/sKjG/1vPNkJMjKm2wEXCbiKgVa/NNLoI+n7TJMTyB5VoWAmmBhN77Q9+x7bdWj
         EvKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780337566; x=1780942366;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sa1TynJU+/d+IvbBhmYu73ubAldgvMTykpuED9x+nd8=;
        b=jJYXn4Rn3tek50bNflVrXOCNkjalp/GjL40IlLrVq/9gXH/lxRKpD83vldnQ6ZT6SL
         G8ed+la0zNXz90TTPLEscTJsPpVYqlJYYudV/f9zqw4EMBgOkUQgg9veAKhohRJhkvDg
         Fqm+C6BP9MtI8c0ljC7MoVv8muo8aHjxko3qyQLF7StV4rIKDt+SXGThrTKcEaH86Khz
         lBxXx3XyEtQPw9vIRad6GB5zL7lqXtB5B00eDIdRX2BPI+jeE7s9xTUFlshga0mPSp+C
         Kbg675IPTRyFChluh4JatAX9AV2RUyDiYeZ2HxEy2GRYvJM4+vslmN6Nxv2wVnf5t6Qe
         +7Ig==
X-Gm-Message-State: AOJu0YxqqYrKqEwg18ZMdddm4KxgeaI3ajJEj9K3F+GLmNrW8sv9pPdK
	+VZkfI0nNulbClRGkbHDQ5snyO6tucOB8lzJCM60FHgXdBXKPu3+TMZ5zjLYeSRHAjkZiNKG2Ou
	hPpmWxBUkoKrNvaTQ4kMqEtiscukyAA8=
X-Gm-Gg: Acq92OGtT7AWmTxbDUAGQy16eNWjalkjw50kgh4x9L2t2oS7OqpmBkiZe6Y9zzM9N17
	vPJuP5o8r264n0ArBoBWAVSsgnYyyFinwlstwhuUb+bYopo2y4Hp1x6O47QXZHRFAXVcldvpZg5
	t936aSLl85iziQu6H68Pm6wEQxqrYjQqFDcdlmtQjk+Ia4yBtpHZiNCo8qq3SneKdPeEB10eYd9
	7CCvM6IqWAfx4UYR3uOUSJzKxklkxUUy5U4IOlAf5/KZss66iP2G9dzuGIA7dHp1UMaLyRlSF5m
	ZOIPd9MEOpR2Hc/OiFOiX5xpcskqRIC0ZNF6M0NjX9/EedYLo5HBD+m34RXQIhM5cUFChbIE+c2
	+I5ZIhnnqQYOg0zdjRYUyov3+OOqJHE2CUva4WDhvadM8ZQ1SZF2OmIPTxM38RyYRc7QIcs/jWb
	LQf8E=
X-Received: by 2002:a17:907:97d5:b0:bdd:3c8:3348 with SMTP id
 a640c23a62f3a-beab334d1b5mr763668066b.40.1780337565691; Mon, 01 Jun 2026
 11:12:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260530003627.42473-1-rosenp@gmail.com> <ah1Iv88PGkU54T65@ryzen>
In-Reply-To: <ah1Iv88PGkU54T65@ryzen>
From: Rosen Penev <rosenp@gmail.com>
Date: Mon, 1 Jun 2026 11:12:33 -0700
X-Gm-Features: AVHnY4JkguHHMZ5JIl9dk36A7vOKlHR5KrXiTNXIDrCJdD_HmJ3vt_XxVWPukSM
Message-ID: <CAKxU2N_hQu-MsHQTiCSrPvk5BB=bKnktUUvFPGBNvOsoZN+93g@mail.gmail.com>
Subject: Re: [PATCH 0/3] ata: pata_ep93xx: COMPILE_TEST and ARM fixups
To: Niklas Cassel <cassel@kernel.org>
Cc: linux-ide@vger.kernel.org, Damien Le Moal <dlemoal@kernel.org>, 
	open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 1, 2026 at 1:54=E2=80=AFAM Niklas Cassel <cassel@kernel.org> wr=
ote:
>
> Hello Rosen,
>
> On Fri, May 29, 2026 at 05:36:24PM -0700, Rosen Penev wrote:
> > This small series cleans up pata_ep93xx to allow COMPILE_TEST on
> > non-ARM platforms. Patch 1 avoids including ARM-specific asm headers,
> > patch 2 switches to unsigned long for the data variable, and patch 3
> > enables COMPILE_TEST.
> >
> > Rosen Penev (3):
> >   ata: pata_ep93xx: avoid asm on non ARM
> >   ata: pata_ep93xx: use unsigned long for data
> >   ata: pata_ep93xx: add COMPILE_TEST support
> >
> >  drivers/ata/Kconfig       | 2 +-
> >  drivers/ata/pata_ep93xx.c | 7 ++++++-
> >  2 files changed, 7 insertions(+), 2 deletions(-)
>
> Your series looks good to me.
>
> I do not think that you need to address the pre-existing issues reported
> by Sashiko.
In retrospect, it might make sense to do so such that those fixes get
backported to stable kernels.
>
> Intend to wait 1-2 days before picking this up, to hopefully get R-b tag
> or two.
>
>
> Kind regards,
> Niklas
