Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24FF1293459
	for <linux-ide@vger.kernel.org>; Fri, 23 May 2025 14:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748011663; cv=none; b=Hi/A79VsaKRV7bU+0YcemtNbbJ7CQzoRPL282jTEMsdqGNzYK7n5rZxS1IWmV8Oiogl86lmUPcnY+iDBnC254C15r0/NxlhapssiMLd/umGGuUgwtUp8ozwUSioQLwjI79leYoGclV4RIK1+a+sxGfYM6iUgC8pS5nFuVBxrimc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748011663; c=relaxed/simple;
	bh=860OTUTdOMKQjC5u3nopBp17irOa6Lgc+9evevv1v9I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g9s8hnq5injEps7vXavBRmpvnkrRlUfZVHyxAOokDz2VBsdrTMM/XXOuJV3XFOkF8YEq0HahvmD8S90ku7Bzt5TlBDmj51+W/55EjrFPMxISvy7DttnX876lVXmIaWDziHwxmsktt1HDHh+qbVlzrxDUVOYlTbBrfBwG3LqhqiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kwmX2hEn; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kwmX2hEn"
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-e733e25bfc7so8071578276.3
        for <linux-ide@vger.kernel.org>; Fri, 23 May 2025 07:47:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748011659; x=1748616459; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6o3fXr2zgAz/ex+oIUFTmHDIIvzKZn7kCr+wlPcg7f0=;
        b=kwmX2hEnHObDxJtP8s1e8e/NnEKjhyDDnCVpL2D5eEVSf1DRixHJ2sPskmoH6pzROK
         iFxgE3p04TxNZ2JGmeuS5UG1w1s5CEmq4OjLZYg8A2OHMkDreFd8rUXLkHjCzKuZWK6L
         iOAnS7mdkQ5oh6KfEWRD5/lzAsDmPIyDrvXungaUaQQBGVrFEOGmO5IIqv2+WNwljD+g
         TX2bogVj87gz+MdnVW+ayQjAuvihMFjMImVLMxPUYu1OqWvvZBby571q4LoEOyx6bkmQ
         i+28cJ+B8zOrdACbfw3T/bzPO7VlRv2mDIVIP1FXZm87/x/GmzyZmqttLXXhxbsoslym
         8GSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748011659; x=1748616459;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6o3fXr2zgAz/ex+oIUFTmHDIIvzKZn7kCr+wlPcg7f0=;
        b=MtnPrpAeprsCQqNHO3m786HXmfoI/jBkUJElWGwydWTWgPaCLkxD4VaR6bydSIpc4K
         mMM/vdjHiG80ag7X8rIq1h1OvCQn4OVofhjSl9JITWABNw3yx9MO9m2seSBQzAGLR5Tg
         1c3SV1ENPNT0uqZbLju2/9/hhxCL6KYg1hVhj2Nc4lFWlz+ZRCm9sS7yI91QNyTSoJWU
         erpho3jiVWteQQNB/nMHKiRMuYsm+PPMozFVXLUGGJMLd55HHjsyb4Fdc0j6+nl4FJwE
         /qgkRD9Tihd89FUV5KZSVhvzDP6WgH8huM+KhNSa+kYRsJ1R1BenLkQZHtmkvO2zbAP9
         5Yng==
X-Forwarded-Encrypted: i=1; AJvYcCVs+uJ+B09oP4wTVbXSYuZDhPdv/jg3oNx0FBORPrCCw4Gj16mCq7+dLEwip/fQc+yyV7/ljSVweuc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxivxBm6KjO6UV7YcpyQUptKsk2wXewfUur7f8Nj+h9ejyJ+GFq
	kffdhDez5CYPhyENhYfID8tvFC3EpA13PzYRi9Dqka435FP3MHYTamYOAsTOWSJJQvlol4C7Czn
	R98oTm7gEkON/BXlfTHBvOUFQsqkMJ60=
X-Gm-Gg: ASbGnctTfVwpxmJ/GcQ3xvzh1oiXQFkdDrGsrT9p7gF/6uSOC9SiKLTlEaGYfycuW5c
	Tq/rw/qEiq1zKrBvzPhKrFLS3VUzgg24FFQbd2qqWxUXSo19lvlnhgZVehaar+kMyl9eHYPfCQ8
	wmjcOAKnMnEX90j0p3bRIHrbHUMtkIPEjGOQ==
X-Google-Smtp-Source: AGHT+IE0mPBNVdH7PJpMhIIo3PZoB0cUe+CNzKW/fbVDDCAjkLIPYF87flzMuslIM84ZS43mucvjcb8EP6cfkbNkX90=
X-Received: by 2002:a05:6902:1242:b0:e7d:6962:d813 with SMTP id
 3f1490d57ef6-e7d6962dd7cmr9857000276.23.1748011658960; Fri, 23 May 2025
 07:47:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250515135622.720623-7-cassel@kernel.org> <CAAZ0mTfgYMQE2xBgmUE4Asx5X7ssth0L7AYQkLmjnT=+bG35vw@mail.gmail.com>
 <aCxMZLEr9taGR2HT@ryzen>
In-Reply-To: <aCxMZLEr9taGR2HT@ryzen>
From: Mikko Juhani Korhonen <mjkorhon@gmail.com>
Date: Fri, 23 May 2025 17:47:03 +0300
X-Gm-Features: AX0GCFs5R1DFfReT5Ffiw1BWnRO0BbnbUoDo7DI01JktRyTraWRs3LyCPkIPfG4
Message-ID: <CAAZ0mTd4pxYnCnxwgPu6JoZA9MVc2dXj-f36YqDXVMGi-bkw1A@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] ata_eh_set_lpm() cleanups
To: Niklas Cassel <cassel@kernel.org>
Cc: Damien Le Moal <dlemoal@kernel.org>, linux-ide@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

ti 20.5.2025 klo 12.33 Niklas Cassel (cassel@kernel.org) kirjoitti:
>
> On Tue, May 20, 2025 at 07:36:34AM +0300, Mikko Juhani Korhonen wrote:
> > to 15.5.2025 klo 16.56 Niklas Cassel (cassel@kernel.org) kirjoitti:
> > >
> > > Hello all,
> > >
> > > I was trying to understand ata_eh_set_lpm(), and decided that
> > > it needed some cleanups to make the code more understandable.
> > >
> > > Please have a look.
> > >
> > >
> > > Changes since v1:
> > > -Squashed patches 3 and 4 as requested by Damien.
> > > -Squashed patches 6 and 7 as requested by Damien.
> > > -Changed WARN_ON to WARN_ON_ONCE.
> > > -Changed patch 1 to remove parts of a comment that is no longer true.
> > >
> > >
> > > Niklas Cassel (5):
> > >   ata: libata-eh: Update DIPM comments to reflect reality
> > >   ata: libata-eh: Add ata_eh_set_lpm() WARN_ON_ONCE
> > >   ata: libata-eh: Rename hipm and dipm variables
> > >   ata: libata-eh: Rename no_dipm variable to be more clear
> > >   ata: libata-eh: Keep DIPM disabled while modifying the allowed LPM
> > >     states
> > >
> > >  drivers/ata/libata-eh.c | 39 ++++++++++++++++++++++++++-------------
> > >  1 file changed, 26 insertions(+), 13 deletions(-)
> > >
> > > --
> > > 2.49.0
> > >
> >
> > Hello Niklas!
> >
> > just tried this patch set for the non working case of my
> > sata ports 5,6 -> WDC WD20EFAX-68FB5N0
> > but as was kind of expected there was not any change.
>
> Hello Mikko,
>
>
> Thank you for testing!
>
>
> Yes, it was expected to not make any difference for your problem.
>
> I'm not sure if you are able to workaround your problem by simply
> using ports other than ports 5,6.
>
> If you feel that the problem has to be addressed, then I think that
> we would need to introduce a quirk for your motherboard name that
> disables LPM for ports 5,6 only.

Well yes even if we don't have other bug reports?, to me it seems
quite unlikely that this motherboard would work for others with even
with other dipm capable drives on ports 5 and 6, so I'm for the quirk.

best regards,
Mikko
