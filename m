Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE48F1B86C7
	for <linux-ide@vger.kernel.org>; Sat, 18 Jul 2026 06:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784354925; cv=none; b=kUEUtV5xpQVybpO5UyQ4eUphdmLJnIDbqz3/GcxEqB0cmDvTtjnLsJaY0C4eo5qyhz9Y5WCshWMo4NcdsjFy/Mn59TZ09Gy8B48vCswRgAl4ZRaB+9eLvI4UGIPxb8UA1KfEBpq8GzFgBHihPtP2l1hB3H0ean93SJ1D+nGYTdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784354925; c=relaxed/simple;
	bh=46hI9KqY8QUsvdXkoEkh4sqB4dmMaYsn9CLoa2Fy72U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hiADhGnXwM2uQhJw88OeELOWzMhYZlxcAS2fPwRyIpoHgNkr6rBzGmH/aFgQNGYDNxiVQF87ejsp4tXlfughawpw18oJ2d+EORwjDynT06xZUEe/twQLfxyibpSamo7h+DNeTTg+TrmlfkgV6CzmEzV4zULgNjlCpt+4Gj9dh6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sigma-star.at; spf=pass smtp.mailfrom=sigma-star.at; dkim=pass (2048-bit key) header.d=sigma-star.at header.i=@sigma-star.at header.b=BCD07hmL; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sigma-star.at
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sigma-star.at
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sigma-star.at header.i=@sigma-star.at header.b="BCD07hmL"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4954c0833b4so6825465e9.1
        for <linux-ide@vger.kernel.org>; Fri, 17 Jul 2026 23:08:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sigma-star.at; s=google; t=1784354921; x=1784959721; darn=vger.kernel.org;
        h=content-type:content-transfer-encoding:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=46hI9KqY8QUsvdXkoEkh4sqB4dmMaYsn9CLoa2Fy72U=;
        b=BCD07hmLCvqDaCicV798lKg04laAopjAvPsFBBSs0fbf77N3/Jj8U1XDwCMA4sGLEl
         nL8CvB0kT+yC/rFxLZperdq8gSXaSzhzUKwKg0X7CiJzJ/GhVcESgi62YA81W5g5DH8g
         fQgaNuOnDbwHyHDyrZ+DSGBOoSKX4wG6AR+WUrYaIKxxVOy/btHZr1A295kvPyVV+7Sg
         qNgncBNVJ0qEUBXrVlPHdQ339cZuR/ylAGEWk+K40ZydpPUCPGpr6UaoZdbk7z6FBCcr
         FAiOuNVBBMWJyW2UtDw7JtR+EiMt8PamBGCGmOhuvXxiUw87c08/qc++RKCvfoHgqUiM
         3BTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784354921; x=1784959721;
        h=content-type:content-transfer-encoding:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=46hI9KqY8QUsvdXkoEkh4sqB4dmMaYsn9CLoa2Fy72U=;
        b=Kdos6GVY9vahVowx/6VFn/Gmi88UQ7BgX7bco9ND+bhgf3SJbu1KuF3R+ggoQmH7EZ
         r/BuGZrVHLHEpPNsBTuzf+WWYaVFsLKd5P5isrNlrKBFS8V3HC0TdudRrHMpTVouQA9T
         Zp4a4o140R015gq5ZJX6O9D+1DJ3Z9Fu0jj09e46VPPnfsJrekdbixYS3Y2IfTp9PMg0
         //u+DRDBdObsRq6QKTveQEQxKpBiBDlwRf3Wk6MPKqMYAGDN+KbDu20bABo+KIXbvYlJ
         5T42unRfWFc+mVxdx6XIinXr+8PlSqPmBUAyWvSPqoPjvUhJ+vjRWOW9Pjej+Ap5/eGe
         Vmhw==
X-Forwarded-Encrypted: i=1; AHgh+Rpm0RcTmvESCcx1tLptGZY4RqYUZx4DorvRvX7Ms9fuOVEAHHHiv4vWMrzoo6jSRD1efvlhbJH3F+8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJXpGr0q1dj2KsAFFJB28pnFKB/K+Dw/RAH6Ye4CFrC6YBMOtO
	Bd59ma/GQ6Z9TMeNkvajX/0CL1NWOt4h+NvMwrGAHRR7Dt7++fJDcQhwRjGCIQx+vhw=
X-Gm-Gg: AfdE7ckQTu8UZyTfgVOR0uKeqj0tTCx70S9H4mjqBOx49ckWtpYo8Y/6m8H4K5u7lDx
	Zy7D79J9M3eB/SW7HV+Tk4TdaqJ/8bzIff8AjBgKveFfNJs07lcwzni9tYpOHRwKCpdslWyJU/g
	jdEwA7Rj4QH0EyEZny7hwIN2NMte0dxle/y5tIYwtqyPCtyhgbo0bh8qQLU9Q9r+ksO0apw9SL7
	DnGF7L3gSpNxXQk09q2JgNEAB2FwOhhiLfjm1yBzxJvmcuP7VyCvFsTATU7XoigDy1xCDC8Dyya
	yFjBeN7umNZ97IGccpxw4e2UT/+UrNR7k+hnucYLWbx7pFxckL+aMgZEaabTgmkjqYbkT2cJUhO
	/Dj1k7L1QbJ174eE/qXfE4UxlfboHLRggCk6Oto0NS3/6d+/DEzxddCnCjr5SNANjSjqIv7dPc3
	JAjxOPxmfRVDvwH5HSagx0WT92tNEYHiiJ0aS6RFHoG5E=
X-Received: by 2002:a05:600c:4ec9:b0:495:4589:707 with SMTP id 5b1f17b1804b1-4954a3ec5ecmr65770775e9.5.1784354920264;
        Fri, 17 Jul 2026 23:08:40 -0700 (PDT)
Received: from somecomputer (85-127-105-26.dsl.dynamic.surfer.at. [85.127.105.26])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49549a47e64sm112460885e9.8.2026.07.17.23.08.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2026 23:08:39 -0700 (PDT)
From: Richard Weinberger <richard@sigma-star.at>
To: Richard Weinberger <richard@nod.at>, linux-ide@vger.kernel.org,
 upstream@sigma-star.at
Cc: linux-kernel@vger.kernel.org, upstream+linux@sigma-star.at,
 cassel@kernel.org, Damien Le Moal <dlemoal@kernel.org>
Subject:
 Re: [PATCH] [RFC] libata: Don't busy-wait for PIO data-in command completion
Date: Sat, 18 Jul 2026 08:08:38 +0200
Message-ID: <4283624.7xKEaPZgy9@nailgun>
In-Reply-To: <49f67374-7c55-4aad-999d-3a74ffefe7ae@kernel.org>
References:
 <20260717090404.857078-1-richard@nod.at>
 <49f67374-7c55-4aad-999d-3a74ffefe7ae@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

On Samstag, 18. Juli 2026 04:52 'Damien Le Moal' via upstream wrote:
> > Signed-off-by: Richard Weinberger <richard@nod.at>
>=20
> Looks OK to me, but the patch title should be:
>=20
> ata: libata-sff: Don't busy-wait for PIO data-in command completion
>=20
> I can change that when applying if you want.

That would be great!

Thanks,
//richard

=2D-=20
=E2=80=8B=E2=80=8B=E2=80=8B=E2=80=8B=E2=80=8Bsigma star gmbh | Eduard-Bodem=
=2DGasse 6, 6020 Innsbruck, AUT UID/VAT Nr:
ATU 66964118 | FN: 374287y


