Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.219.41
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795805242;
	b=l+VvCCQcTFy7Eq82qryTZI4THiy1fpBQh+a74RmO/MF6mKtvEjXFSML8KjPpZli5/g/s
	 JFgVjFiN3LjOEbls2ErvMqz1LEWhNdQ0xxIQyiby+fV2q8y62SzbfCVTSuH2ukr+3+s4b
	 e08tDST5H5VM1UNwG3RtbTmL0DlVH4VWegmx3xLkIA7zmG+JIS968YtaOPt01KcNoqDmL
	 YjbQ254QioKyZer8Q7ykPXaI4aInOz8yy3KmKdNVKT6zvDE1RUqtxKGWT7SrMGRO/ZPGi
	 aXoUk2/jvzrqP6MlAMLf91vbAjQs+R06olmU25IXaIwBzV/FAjaSpDhfXVSbRjW2+yQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795805242;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=1RumGYNdKuYpuJjrf2vnXsyRvJ8ZqCg2nrdCsD4Uzig=;
	b=JSlVHFZ7OxSxo3XNqsf9tItwL/9QQHoc2Nx9/uFsBZC+aKL0hDPIgvzz1z53ez2S1XvA
	 5VWMyEV3BUiGoEKtZvBVV5WHhirQfy2E0dbn/x4NLDQ2L2EIhhshkuDcK96MRAQbPAYN+
	 ohvA6MFu5ykmi6wprrU45RNBzrMlMUolpxhMi6r9X0NcJU6T/xfLxkvhJ0SFZBsnMtDdY
	 kSfym+wLKyscLguzwJYLCSohfj/G78VflX6WmYa1hIqv9mCYM4yPGnHkyXTcKRXZ7Ncno
	 9ftMbFQj+j+zH3Fp+oF12S12Hq+9fDKAXu15/4+6Kw0dG+Uonvw7VJiqQrEcfhCI1zg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JhYQWZ3q;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.219.41
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F622606A31E
	for <linux-ide@vger.kernel.org>; Fri, 27 Nov 2026 18:47:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5F622606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JhYQWZ3q
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-9212dac247aso83783046d6.1
        for <linux-ide@vger.kernel.org>; Fri, 27 Nov 2026 10:47:22 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795805241; cv=none;
        d=google.com; s=arc-20260327;
        b=hRKk/etQ4VM41E0wMmhcL+TXs5WG6ZsGjlMBEuRYbd9WVque8KKl8xVRbwBn7ppP//
         jK+yFwxeKUr3xb75GjGoFchqbS5dFd3uwXkMwIj6e65kmNhPJ6fFUZUu0sgUFuKRZLpb
         +L8XX4IJMXDVPERkcaIay/zjZLOrm7L/BnlZd4Q61qiDghVslJ7jCYRjG6TWFf3zhGMf
         ATtL8bQ5TA0uZRtFNABH2fjhFC/sX0C3dVldFJUVyjvqimPCo0we1kdakhS0zZOzDr6M
         w86l904+HNU4u4iGswCCUSocno+k15zCxzxTNzp8hxNyhXeL8kLDgJumb+WHs5NuDtwQ
         BN/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=1RumGYNdKuYpuJjrf2vnXsyRvJ8ZqCg2nrdCsD4Uzig=;
        fh=tEhQF8ZXslIIwN6dNpPuk6+RFy4A9xXBpnIKM7G7qto=;
        b=SdG3dGq+Wq4CkWZBEOz3DkErq4k50JjgQZWepCUmxA5t15wuBNIVNvRwHjD2l2Fd/+
         UlCJtwxPQMCKyE/q7VeTTp7qX6W6+BNqwV7YOFntTTr39GQWXPPdqGNS98FlDh3VOMMY
         ZAkeVZXmwX9hOUUVS/pu20io2UjJfhjkaAOOW43J2ctkDblDCGSD5LAMVjlnubQbI0gj
         0Rc3pnMUyOZJs/qTaRECfcv3TNxI4SsY0+1MifvBONc7eJb+MOLu5zyroLjaoWp+W7jQ
         cUxuvC7OXTMwqW6Q0kA6CmcQSX9VWz0kxuCkvsEGs2zx2k+Ye2Y582Fjh51zoDLpR3da
         OBNg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795805241; x=1796410041; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=1RumGYNdKuYpuJjrf2vnXsyRvJ8ZqCg2nrdCsD4Uzig=;
        b=JhYQWZ3qfHz/JrDdY82CcI1EEk3+UJs4oFxgLx4pjlewbMRNhpkAZv9ZktCnWrTvXl
         /7LiWrbz+ROZkqAIaMvgwlvOZTCfrvLFfQ/FiIj7u+V5yMQaaZBCx8DdZh0TX1aVPcfL
         m1olOT8PXThpVaTAb3XgJ/2bW2DnHoflvRGn5olOI7I/Nnc2olY1TkAWBV8Y1qZj4isA
         U/jmX08oZ72UhBf3mjVZTq3C6lbSUKqozV29fVxC+sMz648LrZeaUjlbPBpT4rgXF3hl
         trELRtgs4boNjYzU4oSGi3PaQbb2PDsIbc7VNRkT8XBl2PML2uinEHpFnwuYblQXAo6p
         wPqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795805241; x=1796410041;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1RumGYNdKuYpuJjrf2vnXsyRvJ8ZqCg2nrdCsD4Uzig=;
        b=nszVz7elJZttQx6IdxLTXV+3gkVjDnw+BmMnctkYO5oSAmvZ2O9i3n/hgP2aZ/Occ0
         H8qNmJwSlrztEyGB2YQ61+f6pmBuN3El5YbjzomgEZHKHPt4PvmXSccnnld9bCHjIotV
         XbUN6s9zoe1xNpDXWPGK4v9+h7boGWNd/vVR+x9bdwnVe4Ssd8DLPmrohqHqxSvcA81c
         IXcmdysdFNVwDm1rCozmXVdgD0RN+JJH1TfaCFM7q4KlfLY1jRGNiLfv4J7ccy5iB92/
         BXc1vrf99Z/IyQ4Nlf5k0F6cuU9wTbcBSQ0tCPiS5A6lf3Uk8SX7w6wHiRuhyWRiOp/0
         AcKw==
X-Forwarded-Encrypted: i=1; AL+hErFVrjpSpFzBAoHy3Y+Oamqc2ODqgbCkcoysuIU3DZB8i/iblfoxRCjI4NHXxTXRDJXPfJl3fQEC6Nw=@vger.kernel.org
X-Gm-Message-State: APuU4Z++H1Yzmu5LW39nOfIURdXNwqhtoLBfSysZBzqneMS8mEo1lz03
	pI+tZegWLJ4owVGTuh0avNfuYqij2zkB7vc6L5PCdldF9msd9b3KQdhbca6GBKv209qZNb6+GGp
	KFFANvZ720cyt7DudYudjwG18rZM6MYI=
X-Gm-Gg: AZFdTZe2xLX6lu/4eJoEOuSIwavwt3E/0+n9405vUwHNH48v4RJJ8pDMECYu2DEHvxz
	gVBhKY/fmbSBzddQ0HKaHuQ1h2pj9X4o34TQsZyqvYVoZCZMpYvvgLkvw7F3Giya8nuWxpUndgE
	bniFzQH5RG/nbt+ar2YgH427EyhpekI42jQzvxgCwKperNk0qVdBqo7gNJDOklnkZK201mvWwmL
	IMc3l0SFzk96MsdbqtHbVAt2geSNyi2KUSSc28QhqmJScdIyTUoWTNlcyi40cdqlTxGLB/4zHwo
	5GoUM/Xsexrgt+9nF5o4RxiSGMXvg97w5azwqTeIOvDE7uOdEDtaROcPGY//z0poaxOJKGqOjgM
	2GIO9UcV9NDip9eVcbtcx8IV9CJgBzR3hi6QhpB9Hh54MU9DRASmpKYzzFQ==
X-Received: by 2002:ad4:4eaf:0:b0:921:1e23:3e9c with SMTP id
 6a1803df08f44-92134a3730emr461759176d6.18.1795805241448; Fri, 27 Nov 2026
 10:47:21 -0800 (PST)
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Post: <mailto:linux-ide@vger.kernel.org>
List-Help: <mailto:linux-ide+help@vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-ide+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261126214756.39027-1-artem122novak@gmail.com>
 <awk74XffmMjYTJ2j@ryzen> <CAPufuhYk8dZP6JOgmhqDOa1JXpY5w-GCLnPkeLe_+brxNb9utA@mail.gmail.com>
In-Reply-To: <CAPufuhYk8dZP6JOgmhqDOa1JXpY5w-GCLnPkeLe_+brxNb9utA@mail.gmail.com>
From: Artem Novak <artem122novak@gmail.com>
Date: Fri, 27 Nov 2026 12:47:10 -0600
X-Gm-Features: Aa3M54ocrif2-nlp6L1ZbWdVZtjDYZrhku2GvGRi8hy0fGvYgjXP6jDE0B5fT0A
Message-ID: <CAPufuhaHHhBWZcB=9hGag7n6oGFKe2MC0_9JjGH4hin+WW_idw@mail.gmail.com>
Subject: Re: [PATCH v3 0/4] ata: add missing newlines to error messages
To: Niklas Cassel <cassel@kernel.org>
Cc: dlemoal@kernel.org, linus.walleij@linaro.org, viresh.kumar@linaro.org, 
	linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Actually, v5 I meant...

On Fri, Nov 27, 2026 at 12:18=E2=80=AFPM Artem Novak <artem122novak@gmail.c=
om> wrote:
>
> Hey Niklas,
>
> On Fri, Nov 27, 2026 at 2:14=E2=80=AFAM Niklas Cassel <cassel@kernel.org>=
 wrote:
> >
> > This series does not apply.
> >
> > Please base it on:
> > https://git.kernel.org/pub/scm/linux/kernel/git/libata/linux.git/log/?h=
=3Dfor-next
> >
> > or linux-next.
> >
>
> I've rebased the series onto libata for-next for v4.
> Thanks.
>
> Artem
>
> >
> > Hello Artem,
> >
> > On Thu, Nov 26, 2026 at 03:47:52PM -0600, Artem Novak wrote:
> > > This series adds missing trailing newlines to error and warning messa=
ges
> > > in four ATA drivers.
> > >
> > > The changes are formatting-only and do not alter driver behaviour.
> > >
> > > Changes in v3:
> > > - Carry Damien's Reviewed-by tag on all four patches; it was
> > >   inadvertently included only on the sata_dwc_460ex patch in v2.
> > >
> > > Changes in v2:
> > > - Fix an additional missing newline in sata_dwc_error_intr(), as poin=
ted
> > >   out by Damien Le Moal.
> > > - Add Damien's Reviewed-by tag to the sata_dwc_460ex patch.
> > >
> > > Artem Novak (4):
> > >   ata: pata_arasan_cf: add missing newline to warning
> > >   ata: pata_pxa: add missing newline to DMA warning
> > >   ata: sata_dwc_460ex: add missing newlines to error messages
> > >   ata: sata_gemini: add missing newlines to error messages
> > >
> > >  drivers/ata/pata_arasan_cf.c |  2 +-
> > >  drivers/ata/pata_pxa.c       |  2 +-
> > >  drivers/ata/sata_dwc_460ex.c | 10 +++++-----
> > >  drivers/ata/sata_gemini.c    |  4 ++--
> > >  4 files changed, 9 insertions(+), 9 deletions(-)
>
> >
> > Kind regards,
> > Niklas

Artem
