Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC9F0326959
	for <linux-ide@vger.kernel.org>; Tue, 17 Feb 2026 10:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771324655; cv=pass; b=ePkigznrqTmL6bTSAx4nJLWL97af5RU9sVVTXjVYoPd2QudM9kpTLsR/16g6wDAD74M1kEitUTBjUlZMJa5r2SIpBUoc+KV7RWaKJHT7sSXbZ/gFMMYbjb+EFE3pMX4IrbAHKLq4AQI2uF7t+HYFnyTJoiMnBSM2g1fQPP2iTwc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771324655; c=relaxed/simple;
	bh=dPjtly+ZxqrcgnTcKSIFDHsF1hA5MWE73lwPbiR8+3U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C0fsjCO/bTjm3LZvTGfvj3RKqYnrmk93+fOmtDoV5chHdOxDkU0OzIlBKc9pwtC+wzDgIEuxSxqXZ/zGT6iKpoorpe+1hm+VLco9LHFNwYSmclbKavNRccoZy1GQo63mW7fyRyb/n/Qq/1QUjbNMIYSeR//Q2nT41Ua1KYfAmGo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=dmYLmGrQ; arc=pass smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="dmYLmGrQ"
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-387097ae2e3so31770471fa.2
        for <linux-ide@vger.kernel.org>; Tue, 17 Feb 2026 02:37:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771324652; cv=none;
        d=google.com; s=arc-20240605;
        b=itpPCin4ca9Za9OSEp/NK5mUuGnuDUI/Xm0+mmFWZ6jAlqd2uWIZoBVTJcJ3Bcq7Um
         q/HPwj3cVihKq1fUNxjjJPR/DhGLONU0d7XSItCdWwG6UUt69X866Cdh17M30Pw7V0yV
         AZ5kNC6+myVUpLd1u9OZWhdzuhWTwi/CaqKDosiwqOqlbS8wPIRBVQs7Tz+AExcEh3Cb
         tCmSX5ml8Emtpz3AnYewADStzX2je1Y48VV5+bfrxxNhyVIhFd8p3qaFgW69sjwtD4uh
         OXQygEj+WlD4loSpYzXuOJKK2eWARixCAs/D8gHGJVSawqnNYqir5mW4RZ/SeAXAkoKN
         K9CA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=NZMo/PtOIzSJeD+bvKh62aH9xtqgsP4XaPk4C2v4d9E=;
        fh=2zt/qG+iAIWwXdG1v5puZUvPlnZIhzK37EYCU6vk/tE=;
        b=HwVQnQhfyi6MkS3WypDzpCYKy1yBLhKDePgIOR439FuL7AJShxBxW2lkM+BgV70oMd
         KvgNtNNJ2ZQCE1J/QnDSYM5z6e+pBhG9ur4M8giESCvrY9i6c4WUfhq+0fov+uN88WEa
         1TMHRUne0wBSc/JakILp3fe0RcXa8Oo/bvOk1QxCC4bZ1uPkwamorjYMzFeusFWC8IQd
         7IMq8FFDR7JDffCNX6u/8mYBADKdCwmoaTT4RjxEvi6Tu0l1KXoPFjiY91Qhr1sn4uNH
         PxIL7uJ3+nHJ1qAzy48hW/Pv+xqCaVeOcl4kwRt/0CVFyfaPPijOcPHBT0Df18dOBw/1
         abWw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1771324652; x=1771929452; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NZMo/PtOIzSJeD+bvKh62aH9xtqgsP4XaPk4C2v4d9E=;
        b=dmYLmGrQL6EpWGinGmazJYZO2mJYS/9YAtjKAkQYVsYcu67/5AA8mkj764LmfULiGy
         Bq1tyIlasq5pw9UoS4Sr+XCwvWTBbwX8s+hIVYntsZPYoiwNa3nVU4Db6qMzN0KObR5u
         +szP0cw+XNRlcTzTNf4B5GXh2CK1xmRAFYDmrGhbKeZ1DNZbm24/fY6wlyVWhzNOgLOX
         /tZInKxJH3v+wzSCU2v2Mk1DEhlRMMh0/0h0X+K4aDFEi0cYkMFereA5+SHXhdwt9Ejn
         m9++REQio3HlLCp4R4ZiLcPl3WV10drQ7hxCz+iw3pxBnEx/RC6cNykCWYgpsliYzvIg
         1YKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771324652; x=1771929452;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NZMo/PtOIzSJeD+bvKh62aH9xtqgsP4XaPk4C2v4d9E=;
        b=IQDTZARh63m1XeA+8xz9h6QWMxyppDkcd1w4wxJaYEgYx6eICynpWuvTfFik+UVkxI
         8p050E+UBYgiiTJUFmlYo1kAclnLFbe9DW5IIGMaH6Voo/6YxyYr39KrTqo2Wm0OFgPz
         dtKbZg6uwO/yc/5+uZ5cYbUJT4T/NdCGxsAcUDSyaQySAOFXGae9a3iuhlpAaYc79SDP
         qBld3GXcN/aug/HMQfJI/b4naY/yFMXUJ8gfjgkdvBQliRInrb7tw9vEjjgMSWBWY5/8
         Ma+Rwbh7M0U3RUUgCc5S3anglZPCFo79VvnZOQTzyOx62k9vapE5OX6IM1Fjj3++RXqC
         px1A==
X-Forwarded-Encrypted: i=1; AJvYcCXIK/2TC/i9uIic+E60VDGrOH1pMyIa3fdxG2+SQtEIt5nTnk6mBQKd1+vo9zXMmn3hl745OdjPyQw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXVTirhRMIo3pBIzwEdmTmgNLHlTojx6qRXI2rnWoXeG95CygO
	Sq7HyH8c8iKONMKK9qLRXsljCvXAme7w62wvQlmznb72oPmJUvL+1yjAJUrJv1c0nNU1sv8R0L0
	99PcsdVe/tI+0XN6gEEGTSZH5i3LxiY+Jee5X6CzqRWzt7M3sb4XO
X-Gm-Gg: AZuq6aIF50prurbTFbPuKW5ENKdBXZQX9D3DiaAiYvkl3bG8jZIs/2r1CX0CEfEF0+w
	qzjJ19y44LVOJMVshpJkQtoLIAKGQCDRAxt64DlcJHAxoIIRjrNE4l1pvGviz7Z89sa4ucLJl/Q
	58pZJR9JyD2dU6eMJr0N14igHKvqW0styG5vOJ+GsHxYa1Di8WFxcrXIseHl9XErfBE+HSkuxWK
	4bxGtPMMgll7yEQNhSAYgURZzc3k4COhpGpOhXsQMY4Dm51q0MRhCcz6ukNw/9RWeGafHSxh4f0
	T3dqsIc4tvvKPKjlbKO0ONuWRm95IegfVwrk7t6Jhr1nSXDnLwyai+GHmJowuDpjqokG
X-Received: by 2002:a05:651c:1ca:b0:386:ec21:c87f with SMTP id
 38308e7fff4ca-3881b99cc9cmr30135731fa.42.1771324651832; Tue, 17 Feb 2026
 02:37:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260110-lsfmm-2026-cfp-ae970765d60e@brauner> <20260119-bagger-desaster-e11c27458c49@brauner>
 <20260129-beidseitig-unwohl-9ae543e9f9f5@brauner> <20260216-ruhelosigkeit-umlegen-548e2a107686@brauner>
In-Reply-To: <20260216-ruhelosigkeit-umlegen-548e2a107686@brauner>
From: Haris Iqbal <haris.iqbal@ionos.com>
Date: Tue, 17 Feb 2026 11:37:19 +0100
X-Gm-Features: AaiRm52ye33PKO28CcExseV6coNOG-rZ2nBeMP78z80h8Dwp-N455yQLK7UlhmY
Message-ID: <CAJpMwyg-3-Z=ZDC60Vn0s-8Z78VOPKYmvX9s=Nnvcoao4T5zbg@mail.gmail.com>
Subject: Re: LSF/MM/BPF: 2026: Call for Proposals
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-block@vger.kernel.org, linux-ide@vger.kernel.org, 
	linux-scsi@vger.kernel.org, linux-nvme@lists.infradead.org, 
	bpf@vger.kernel.org, lsf-pc@lists.linux-foundation.org, 
	linux-kernel@vger.kernel.org, lwn@lwn.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 16, 2026 at 3:28=E2=80=AFPM Christian Brauner <brauner@kernel.o=
rg> wrote:
>
> On Thu, Jan 29, 2026 at 05:13:52PM +0100, Christian Brauner wrote:
> > On Mon, Jan 19, 2026 at 03:26:39PM +0100, Christian Brauner wrote:
> > > > (1) Fill out the following Google form to request attendance and
> > > >     suggest any topics for discussion:
> > > >
> > > >           https://forms.gle/hUgiEksr8CA1migCA
> > > >
> > > >     If advance notice is required for visa applications, please poi=
nt
> > > >     that out in your proposal or request to attend, and submit the =
topic
> > > >     as soon as possible.
>
> This is (likely) the final reminder to put in your invitation request!
> The invitation request form closes this Friday, 20th February.

Hello,

What is the announcement date for accepted topics and invitations?

>
> Fever has struck me down so all you get is a bad limerick:
>
> There's a conference called LSFMM,
> Where maintainers debate and condemn,
> They argue till dawn
> What's merged or withdrawn,
> Then next year do it over again!
>
> Don't forget to pester^wask^wremind your respective organizations to
> sponsor LSF/MM/BPF 2026! If it helps, you can tell them that we're
> considering renaming it LSF/MM/BPF/AI.
>
> Thanks!
> Christian
>
