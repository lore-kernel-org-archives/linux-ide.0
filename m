Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BF5736F901
	for <linux-ide@vger.kernel.org>; Tue, 30 Jun 2026 20:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782850288; cv=pass; b=b1+inAXA7DqSwoyAS+inqHwyLBGc0F09rbdy0G4SZwpnQCZjj/vXGe0zDeiPcPOQGvlXnkqsBEoTVarqn/re6V3i2XrGf95J+VcW8lwejQqiBwEcIq8+z/+l2ayPWYS5vq+S0zB5UhtE3eS4VJiaIf+wpUGRMuPTwsXn5zynV8Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782850288; c=relaxed/simple;
	bh=cBA4fqz2FxFfdtm7tbbh/FhO2DWfhJfoNBxENdxggE0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=icxGk0Ukwr0N7DrHwJzUn8R2hWejOUgT10evZhjsIPghbnAL/4koe8OmLZtmtpjDpBefT19qrvY3UldpojmBrSmrzk4o9kRiJCdaMjpLxoVrRcrf44ETLxugkuSbK0gCfreXRD6VFvU5Up7cmpJPD6Tx+NUn46w1pCFJBNauj1U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dTSBhVpL; arc=pass smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dTSBhVpL"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-698562f10e7so4873150a12.0
        for <linux-ide@vger.kernel.org>; Tue, 30 Jun 2026 13:11:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782850286; cv=none;
        d=google.com; s=arc-20260327;
        b=Vptq2ggPArnN/nKPbO9Krm7BznZkr5Kw0hWOkj9mQOMKezs1w4DEXfM1ehabDAA7tm
         GN/HgWDHXijuFNGKEWjy0JB7BwbvF8G+hM4644oF8TjBvBemaw0W3AgSKEo+T1f0kCGm
         sT3fkH9507L5WzSTjycwgdhQK5FWYimzlczVxgP7kVonMsn6uVp4km5iuf3HnAI4KvdY
         /Qas2p0ePx1QhFwC6Md5DjoAHHydqcE4MZl7fEpwh+oVHZ3Hy4tSaWa7G3iTKhKygWYY
         DpxeCetMOFXWeQ4BTwLXn8g8+TaMqeobJBWc9Sjft9kqm9VGdpXdNgkkyBBoES0+6g/U
         v1qA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=cBA4fqz2FxFfdtm7tbbh/FhO2DWfhJfoNBxENdxggE0=;
        fh=Sypleop44cIlk3oP/KajpS6wnvrY1XW0sO3gHPVc9ZE=;
        b=q3hcHXBVpLydmEwXbMXIllfPJGfd2nb0KO+31AEUAG86vNCDE8s1OTwp8GaAsQ8Xkx
         oRfs2G1WBYlTvblcecz4T4vrlpXsSRj/Sb+c3IdrMGFYtsJg4AlS3iQNZ8eiooq3GXq6
         1kT7uy2BD6GNiy7VBIailMVOqfz8jfPdsi1ZZf8+/VW1uZcjwQZDPp0EdpaVAtSE/wO2
         uIJT13JezFuzMFkRITqavE3YMua0upgqEhJ73hmKnW6/U1UAukCmbeqYTqaf0ruG+fIy
         vkkZrZWHwCslhRsB2lTEyJ1fq3AIuAkzHQIIuhVxF2OCRryuKI0ED7vnNx/NOf9QcMwa
         FgUA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782850286; x=1783455086; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cBA4fqz2FxFfdtm7tbbh/FhO2DWfhJfoNBxENdxggE0=;
        b=dTSBhVpLq16/iMlOGPpyNjqD7tlzHFOJy+6EC1m5ZmyqOJNrttO3R8jAC436W3AOlE
         dK641WN/cO+vACnt6v4gAF85A4VzSgBhufmQZqnaO3p1T1tqXJBdVryu2Moh7pXEPvqU
         jQa+4BIjMWkeqaFH9q/hAfBFjfHVTP7ZwqS0eAAmwQXlAqWy274XPjwG1vEpv0hvleIH
         2hSMwzD5Oc7pPqmutRV2loL5Td0ubitz2NwfBFTkZ9q6LZJU7HXrIgBdkMqlP47XVT/I
         ZcMu6Q3tzGRmuwP36NIx9y6qa2v0RC3ufIRQKaRnFP1dN9pWGQvI7syNJaBrDiCTvj5u
         GGQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782850286; x=1783455086;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cBA4fqz2FxFfdtm7tbbh/FhO2DWfhJfoNBxENdxggE0=;
        b=sYCOp73aSZoMZ7AAZ5A1FNnlL7LIpaKFYE6v3mCtTxq3reztcqAAziJIVcwKtG91Sw
         1leZ2FPg0tjb9SXx02J8/C0LHGrQtiVqMc9l7PDkkRiLwLAKt2C0VM5sdWgn9tMlJoek
         GI87fZx3Lxhch1CJ7ITdZinCS3qhSTZ2TgYjEhuQqvBlAa78zkpfDjZuE9Gd75w3LUgb
         lrkZUqkcpl9Gxk6l4GFOizsu019+uoa6r5tnzUb62yc2Qb+woM6c/kLNL4wwiP7JeN2W
         uHNr9eHYQBjQDLPYTYPsbfrjdtzpR6vczEAmoBH96Tdrf1sxMjYU/mpWgreAf0P7KquV
         3yRA==
X-Forwarded-Encrypted: i=1; AHgh+RoFjXiHSjXxEs23jPOLifYKcGsuQYytFR9bWTsDh8ACEMAeokyXOG7Z1WhSOKN0fnFdMsQOO8qJ2oI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIxtYx+HJutwUskKdPmQ9lvrRaXmUHCn/iM2oFwOHcpM6rztiN
	g4zR/clfbXbohpbO7imo/d6h/KFor9wufl3JDXtEPUL8MG0lZI3KkIoYg4izv1mI2pwZPymeq4N
	p6+FlmgMgSTJOywhVoUjfs7aYb/7TgH4=
X-Gm-Gg: AfdE7cmpVvEBAyfxyR+QBAr6QGtjcFcJ7LlvYWitCwbiLHSjAC1Xd/bWVd4OxBlFr1V
	b51oPDANS2oEwG8vAW81kSuBxQg20NbMXvXjWX71VsFf9CK2ZShVp0YxWxeKlLzJ0CE89Zk0pcb
	gFrUJm8M1CgRCHmBXoNC2gGM00srTDoBr8PFhLX7jjykzl4VJLKj+jSS3jBSg5c0IjIGXg4jrLH
	YRoB4MhoZ4kXRfxKtja3JG5Jl8dSBjcckoWBNVjAypOBohDN8OM/3aXxelp0djVKttWk5TE0+hW
	asiGwVn5nDV42o8vnLkLdQeG6xhaJ6qmCo6AZtePoM0p+4YRTUhDVjakFZWv0KmtHRZxO5SqfG7
	wcSnv0jvOVxct+CjWht0W/6oOQUQ=
X-Received: by 2002:a05:6402:40d2:b0:698:1504:e3e1 with SMTP id
 4fb4d7f45d1cf-69879e0d921mr2656506a12.30.1782850285812; Tue, 30 Jun 2026
 13:11:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <akNzEGgiYC5V3rtc@ryzen> <9327f32a-5037-477c-80dc-f99b97ed9740@kernel.org>
 <DF85BCA7-B344-4AD6-8F6B-22CB3A3DF823@kernel.org> <CAKxU2N8uWY3k3nHTmdxEn86zEZ_hGJgyPvHWuHt=zRaPk-29kg@mail.gmail.com>
 <CAKxU2N_2N0YWBrF1k82qXCYYyvZxa26GYi09xiyKbBAtUoC_mA@mail.gmail.com>
 <743a2748-a458-4e65-a1d2-f54a6657e7a6@kernel.org> <akOHEDdu3zw9Uhph@ryzen>
 <2865750f-9bab-47d8-b4c9-9cf1cbef7834@kernel.org> <akOSrMbpFIO_VLul@ryzen>
 <d691ff29-6712-478f-90f0-467394d6e84e@kernel.org> <akOlisttYmSoyRsl@ryzen>
In-Reply-To: <akOlisttYmSoyRsl@ryzen>
From: Rosen Penev <rosenp@gmail.com>
Date: Tue, 30 Jun 2026 13:11:14 -0700
X-Gm-Features: AVVi8CeUQwi6nae5W9wIj4nJM9OsNXUJUqplOl3smH2HvnZwk4mznbEaPGNhjG0
Message-ID: <CAKxU2N9n5xhbvqknPbSF_Fr3Vw-9XauhMp+vZ2+CUB9OVAqHLg@mail.gmail.com>
Subject: Re: [PATCH] ata: sata_dwc_460ex: use platform_get_irq()
To: Niklas Cassel <cassel@kernel.org>
Cc: Damien Le Moal <dlemoal@kernel.org>, linux-ide@vger.kernel.org, 
	open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 30, 2026 at 4:16=E2=80=AFAM Niklas Cassel <cassel@kernel.org> w=
rote:
>
> On Tue, Jun 30, 2026 at 07:06:55PM +0900, Damien Le Moal wrote:
> > On 6/30/26 18:55, Niklas Cassel wrote:
> > > Sure, we could create a dummy / stub for that function, but to be hon=
est,
> > > I think my earlier suggestion of just using dev->of_node directly wit=
hin
> > > the ifdef, and drop the local np variable would be the smallest chang=
e.
> >
> > Yes. But I am not against replacing that ifdef with IS_ENABLED().
> > That's prettier :)
>
> That is possible if we create a dummy / stub for sata_dwc_dma_init_old()
> (since that function is currently defined within #ifdef).
Yeah for that reason I'll keep it as it.
>
>
> Kind regards,
> Niklas
