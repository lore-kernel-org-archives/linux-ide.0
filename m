Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795699916;
	b=Hf7p4QFbwRy8IJIaTx4g2TjsQV7KVzI2ahXBW+RHK7spzw062XTLdPx286woA91z2mVx
	 lEDTSXJJSG/eEQ4WyqLKB0dJX5TMNH6Fyk/8BPMMuRh3hooZ492VOZ3MAta+PH+Z0qyam
	 756ifqb3/zc80VgFtkWwexmzfS1w8GS9j3ZaQ6FD4DW9vig02VI9PXMXHkgRzT/epr/oD
	 1OIyyQu0AyI/m5xAEYnkf5WK8peextSRJJIU1yiSp/4ugMsexmnsgFUoNrtD+t0DaiXCQ
	 zLkgnJt2Sg8GBpF7Oe6396Fu93Mw8ZzJhYq95wHSgS0t1SkIqlaDtLP8sV3nCA8QlNA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795699916;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
	 References:Content-Type:Content-Transfer-Encoding:User-Agent:
	 MIME-Version;
	bh=3B43kyyzUUTLVNXK4AN+mljA56km2Ewzy7V4dK6lZDs=;
	b=BIHIGQt2DJkp0ePfn5HCzVF+r8Qol/f55Sqaz3QO3cnjVi4MKksGg7vY7yH/YN8HpEJN
	 NJI9Amqk5yRHWvJNLMI2EPW4eriiJMNINezu5GSaOjEzAQbQk5jVlNdTq6vX/f0TIUcfH
	 GSfEzBr/AZPBU/HS6v3Jiqc194kQYqnbhzT8fzxJysIeOZKKX/DfgUDBZXiP/KU5XRbp4
	 6prfQY/Zwhoq8FV++edLCHbt2Q4f0R+WNHmCzY+k90bxCwKkkBOUGivG1SRhnWKiBXkq7
	 XAvbnbR5E3pr+2RN8kWcQaptwJxzzZ8omNdcduXTRaTdh3thUJEq9NUBUgzzPYfp97Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=f7EDdOir;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=gXmjozeG;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38E3A606A31C
	for <linux-ide@vger.kernel.org>; Thu, 26 Nov 2026 13:31:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 38E3A606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=f7EDdOir;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=gXmjozeG
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795699915;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3B43kyyzUUTLVNXK4AN+mljA56km2Ewzy7V4dK6lZDs=;
	b=f7EDdOirMWXC8akAqM9hNUNbt67exkg4w3GR3ZxjimjvLhVh0pYAcCTqRTE+ih/EONmbc2
	LWmfgyO226ldZNKYd4m8ksWnOlp37kk8jH6L1AezJHweNA1QH9uegt6DCeg4hLebfG0jyB
	ON/7vw0OJJKYkKFRXFjRMVTsQGz8zQI=
Received: from mail-ua1-f71.google.com (mail-ua1-f71.google.com
 [209.85.222.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-70-Jew3lB8VMQCPad_XnV8kvA-1; Thu, 26 Nov 2026 13:31:53 +0000
X-MC-Unique: Jew3lB8VMQCPad_XnV8kvA-1
X-Mimecast-MFC-AGG-ID: Jew3lB8VMQCPad_XnV8kvA_1795699913
Received: by mail-ua1-f71.google.com with SMTP id a1e0cc1a2514c-99077a0be0bso1908818241.2
        for <linux-ide@vger.kernel.org>; Thu, 26 Nov 2026 05:31:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1795699913; x=1796304713; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=3B43kyyzUUTLVNXK4AN+mljA56km2Ewzy7V4dK6lZDs=;
        b=gXmjozeGPFHpqQkhh6paKW+BLsLZqi9D3GPfbRy/jjmop7qwRAxk+iVDhxCnKqzKer
         YGxnRPiy2cmB9Fz5IuN/2o7oBos/kQudQquoJMqj8Sf+KoNTpc+/N5ocV5qBWHHRoe8t
         8/kZx2r9FQ7KrwwEzWX9UxTWNZpPdzetlALtPqQPi3frvHwNYOR8sVbw1zT+jw6sZ7t7
         CeC5SEn2pZ36+drmmtbY7whwpELMwifNZVL90ZfKcKWNwmVKkxT/svvvBFs8LEWqiUdW
         mxHrHc1yJyk++X2g8ZoG+7gKimfX2r9lfM6/3j2v1DpvV2cZ9fF5Y7+l/dcX1Slpca3n
         Vi5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795699913; x=1796304713;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3B43kyyzUUTLVNXK4AN+mljA56km2Ewzy7V4dK6lZDs=;
        b=KOK4xQnhHk6vi8zs/U5zw6CMPuzjlyFqGooLJm6Mkul6jJT03U0QXgZY9ZuCPnVjvA
         2HP1tteDy2X3Zha9pdgU8a9s06KC84x7h1Qhv1CbOtgSVmriIn95aZfopvxe6FL8q/HL
         yLYXODkrH1z/fPbCAqb1WK9RtXSiqTKkmLWTwnvyQV6EJW6EhFN5BgdHKBIp23TZCf0w
         OIuq5WtTZT2PmISwB8p0j256MK/f19YmwYvOXJKNyTbqoiKf1bOlHxx1tC63NddFlUwK
         3LvJGpkgHKKWrrNBPa93K8+4JWHOvqscEVeNYgmoI2+5Ye49+GX73oVvPytPeQS3bz4y
         aNrw==
X-Forwarded-Encrypted: i=1; AL+hErGjDozhx62P5hcC0A0SJkaRgvKLvTuzSpUqfBLuKMqYpSqAj26otC6cqJxsRc+EBzRW97kf+gr1/+U=@vger.kernel.org
X-Gm-Message-State: APuU4Z8/GhtLtLgvZGyo9GgZJI9f+RZum1iL6/fO0fBoZjP67/xCSXOd
	6bG9xBSbNQNzhoNSDaYRdfe5eOzI3AFZwFDr1CqkfyyEh9goi5vHHCEPDFJNMWAqPiEixZUOQU1
	v/nGvUgvPhd7ePNROY/LnqX1kEl5+OrCL1Rd227CGc9/qw9i06xygggPglIY23A==
X-Gm-Gg: AZFdTZerDq4nc+hUyzQ6nzmMJkHQTWH4XBlobeCj5eSYzWn6okUSyLStl9faANgGCkv
	YVRz9MePOCa4+IITKputfiWWec3pISj2cthMn/3bleiV/yHEPHuC+ZM3lC26B94UmuJYPR62kEF
	WjtR6jtpR/MoZ0xcngacHgPZ1EfCk0tjtDQLdBsniazACDvTf/lrpQB88hFgkx7ag7vNuFGR1hY
	3qL09vsAdG3S9epbGAoCIrtUfLCVhiVCs+1loyPygxxFyj0Rfu3UKfmmyvR3wUvQOI7xtVJ+AF4
	n+bHQfsnKHXqmYT/Z8gVoQeZqqw2wzSxwrwSIU9NTyGLp/NY2uWvrHsbepBCV9WN7mZm5BHdUD3
	tKqXcS/wHE00G8+p03K+4U0UI72SGbmc9YEb0Oyyv7UWlh+v5p4HyfTFbym1a6FXZsyi1LOFFyv
	OLaQQ5OYbIqF7SvnuPZUBok/lLUd1RUQEXGm/n7Nx8R0uSjm6275H3cH/drkuhUeGHUs+bMg==
X-Received: by 2002:a05:6122:29cd:b0:5ec:d751:a18e with SMTP id 71dfb90a1353d-5ee8af5d5c6mr11288527e0c.19.1795699911911;
        Thu, 26 Nov 2026 05:31:51 -0800 (PST)
X-Received: by 2002:a05:6122:29cd:b0:5ec:d751:a18e with SMTP id 71dfb90a1353d-5ee8af5d5c6mr11288267e0c.19.1795699910439;
        Thu, 26 Nov 2026 05:31:50 -0800 (PST)
Received: from loberman-thinkpadp1gen5.rmtusma.csb ([2600:6c65:2440:d8c:929c:b769:6def:faa3])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-55d788506b0sm180018331cf.17.2026.11.26.05.31.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2026 05:31:49 -0800 (PST)
Message-ID: <f323c3d62265dfe90fa71514028af4d35f6e2420.camel@redhat.com>
Subject: Re: [REGRESSION] DMAR fault by Intel H97 SATA controller since
 "block: Increase BLK_DEF_MAX_SECTORS_CAP" (6.17-rc1)
From: Laurence Oberman <loberman@redhat.com>
To: Bart Van Assche <bvanassche@acm.org>, Lu Baolu
 <baolu.lu@linux.intel.com>,  Jason Gunthorpe	 <jgg@ziepe.ca>, Joerg Roedel
 <joro@8bytes.org>
Cc: 70sp <70sp@protonmail.com>, Thorsten Leemhuis
 <regressions@leemhuis.info>,  Tobias Laas <tobias.laas@posteo.de>, Damien
 Le Moal <dlemoal@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
	regressions@lists.linux.dev, linux-block@vger.kernel.org, 
	linux-ide@vger.kernel.org, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org,  David Woodhouse <dwmw2@infradead.org>, Will
 Deacon <will@kernel.org>, Niklas Cassel <cassel@kernel.org>
Date: Thu, 26 Nov 2026 08:31:48 -0500
In-Reply-To: <0edb9525-5068-42e6-b6c3-a1dcebcbcea7@acm.org>
References: <5ad27a97aafbc08a8702d5b90d09cd59@posteo.de>
	 <awSs5Cw3hFkf4O4T@ryzen>
	 <ec36d13e-e4c2-4bfb-8b50-69d4a1628839@leemhuis.info>
	 <87b1bbd8-8113-4890-8623-738b19a9cc7b@leemhuis.info>
	 <a0ff3156-add0-4f7d-8373-09f95bd7036b@acm.org>
	 <2adaf0ef9e1a2fa18590f7d8dbf203c0f7de2be7.camel@redhat.com>
	 <uJluFNYGCCrdvnYT3MatN_4Om8UczTJX_dzxumJxyCAC7F-Ubrekb7LPwlRxhCW0J91UBf-TqeRoJQfgYIYBRvMsPmE-Qs1eAg5zbDP0s58=@protonmail.com>
	 <0edb9525-5068-42e6-b6c3-a1dcebcbcea7@acm.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-3.fc44) 
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Post: <mailto:linux-ide@vger.kernel.org>
List-Help: <mailto:linux-ide+help@vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-ide+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Wed, 2026-11-25 at 15:27 -0800, Bart Van Assche wrote:
> On 11/25/26 2:51 PM, 70sp wrote:
> > as I mentioned in the referenced regression thread I reported, the
> > patch I sent out was basically an example to show that it works for
> > my use case. I wrote that I don't think the patch is ideal (in
> > fact,
> > I think it's an absolutely terrible solution to fix this). This is
> > also the reason, why I just sent it as a snippet of code.
> >=20
> > Please take a look at the code before the regression started to
> > occur. It was implemented universally. These vibe coded patches are
> > horrible compared to the original code. We are literally making an
> > exemption for a specific CPU in a place where it shouldn't be. The
> > actual correct solution would be to make a patch which works
> > similarly to the pre-regression state.
> >=20
> > If we are going to merge something that is made by a LLM we should
> > at least make it good. Ideally made by an actual human.
> (+Lu, Jason and Joerg, signers/reviewers of the patch mentioned in
> the
> Fixes: tag)
>=20
> Is a better solution possible than the patch "iommu/vt-d: Disable
> superpages on Haswell with integrated graphics" I posted here:
> https://lore.kernel.org/linux-block/uJluFNYGCCrdvnYT3MatN_4Om8UczTJX_dzxu=
mJxyCAC7F-Ubrekb7LPwlRxhCW0J91UBf-TqeRoJQfgYIYBRvMsPmE-Qs1eAg5zbDP0s58=3D@p=
rotonmail.com/T/#mc147f250c5356e3742ab3d30ccf6b4a3a8c4196b
> =C2=A0
> ?
>=20
> Thanks,
>=20
> Bart.

@Simon,
To be clear, What I tested was the patch Bart suggested. Not your
original suggestion. We will still need a test from Tobias to make
sure.

Thanks
Laurence
