Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794496869;
	b=qKT+/BfNEZdcV2E0w0xYMjeQeweLwZt8FVI/7DSJ7k4p5+37mVb7KNEBVU6cBGeOknuB
	 sFvfqHkWAqobwYdTJBcB19r4w9iNeTJej58kaJ8ZEd2pclUpP8oZKXz+9sP6tURG3H22Y
	 fjfXL3iTTaHJGXBAQrdW4vk2nVdc0bp2/nT7gy3wnSjQD0z60wgHP9sY41wjEl9V6Eiv+
	 OHCC/MWwtAkriofjheo21AsXGYuIDHpZnC5eP2eFMZPJFaIralCdtYt032zYYwUlGXLbA
	 R5rpFBktMvTw0+DDM+EfaKVZOiXRWh12BfyamfB+L7qZtXoQCIRYGBNrHObl1MJGPPQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794496869;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=qVYK4aF8DnlATPdvPW4rrz584ZowV56FwmQpG+kYD1c=;
	b=kHKxG0bmzBc+pBn3B2CLzRHOPrlH9OYCDMW0m3qtpLmT2VWYy3PFQxEImgmoPsZalcEx
	 YWLbg1NtHZKtvGw0/1u5y9TiBqYwmm0F089YIbc4QpiJT6JMwBGL/TqmAmS32kjmWVNyH
	 yyNlcQPhEe7fNvFRWnZO5F1fB930qVfltvQDhyYPFaxMYxwsjKyqqjAMzamOVR4P7iO6C
	 QAQ8KyMPGzlTprcX01EkqTDTFI3dAi7z1DeKZchWce81+Tfk+PsDVUyrk3vRb3jZgk9T+
	 LGSc80hBnyX47xC7gcHXVG3hASKhf4pLROlbcFB04XF7IeAN4CQwKPaQ/smJhj0HSvw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ojrAJsQ+;
	arc=none smtp.remote-ip=209.85.218.44
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EE9B60A6F55
	for <linux-ide@vger.kernel.org>; Thu, 12 Nov 2026 15:21:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5EE9B60A6F55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ojrAJsQ+
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-c4d427836e9so580187466b.1
        for <linux-ide@vger.kernel.org>; Thu, 12 Nov 2026 07:21:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794496867; x=1795101667; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=qVYK4aF8DnlATPdvPW4rrz584ZowV56FwmQpG+kYD1c=;
        b=ojrAJsQ+er+qdKfS3kg2Lrs0YL46fXV6i2SK3zA34q4VWel1VXMiLVPEIRv2EFGHP5
         B9yARF4NKXd4ewR32xHUy+m1lZt0mnZkD8Ngy8EIr1wIv5C2L68G1/kOa4b8i1zb99pU
         q8m8JyHGgDrdQEomPhIRhCbnV6bGddji8rOziG/VnqWqHjk1U1o8GZ1BB1Gqmv0fItB+
         sUhbdYnZjj4Ohqsk6vr28eudeCokiGG5XP+TvDMxld0CMM+NeEzp2+ouX/dZZAkDXJYL
         oW6OEA+oPCFfpLdpfXMAu5+H2eKTGeVBaFrnCeEtBA1R69926pmur1LiLN/+UbdUmLct
         SAqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794496867; x=1795101667;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qVYK4aF8DnlATPdvPW4rrz584ZowV56FwmQpG+kYD1c=;
        b=mZ8xGeTQL1q1ikLk1xJYBc82OZOAjTVrrsEiI4R1S+0LvTiWMzARhPIy8N9jABw1tx
         fP1ixkfzaRfFjE4g7NLMD4xuiJm8Z6w7OyFFHRsHOnrRxIRBVEsLMORnYrxMHiqx32li
         MRkm/IfbxLitNnoLdefNFCirEClRtZlZ/2eNJPK/cGV2ZsY09380hVFXw9cTgso49wwv
         2+aS6mOsrYykqLgCzT4aSJe/wlwljrg1udmLP6EBoGuEU/sBS067wHoOYCJtjmzL+66j
         tFSZCFFobkBIp6lpp/ozLOYsPI8FWi6S8g6SsOLKlDSdpgSyFybaGnLWOvpgR7+x+Zki
         +ZOQ==
X-Forwarded-Encrypted: i=1; AL+hErEwGUiT5GstrPLezfSLpRpmCSyWxbkzqgPe6DLHNtYz26qKLsdev2Vq4lkjzJQq2226S21fK/B6BFg=@vger.kernel.org
X-Gm-Message-State: APuU4Z9XNpkoHQPAp/m9+y3GR43JXxOUB+2rzJjyeocCh0yOIN2q/5+l
	OaSPf738/0bfgAaVLy+qKYTc6Z1gkyed8MHpN4X9WVV3XcNJ5gRciPkwyAWX2FAo
X-Gm-Gg: AYBFou1C9pOt9/fN00lr0eDmkbPcaCBirZ7OqsxHVkeb1mNqgzlYR9xpvEH98TqHdHc
	YfIQZ8VdPP/Km8gg5/alS3n/jIq4wCOxs671VG9Yk+mb3QqqyE86fPA/mkk2vel+K4xQ6/HIc94
	fyQgwylHd0ti+ShKSL6qLOlZc1g1uF0vfWhUdYH5/pSI134pDKT92RluL2GHkPhQI+FikprDmPb
	4dWUzLNBazZE8Hmb1Gm7K0dldnv4fVO2o//mKsfLqzoWSHg0vjmI4zBxf2Mab+GPjpF+CzAt9wb
	tYVR1l4fnzZb9oepnCYJodvkGWN21M1PvqUxKu/HaenYYwD86xlKdRlA383VK1Ek6de5H4QbTm4
	vWTZZTFxqqxcehd+gkJdBJT5GGd8ugD9waueq7Z2HftcpLzSkhVQAP02l5Av75+fl8kCXnHrCVZ
	GngtAtYdw/O+3DeucBQpawpfgMj3bZef864fzzLvpq4oJF/LEN5gbnUt1VLiaq5AFE0wtmskr1J
	QSwWbLjY4ix1d4xuTIcUxNx5tUzFWc0zL999UUWE7e621LDaaJcJMCVAXZEFsbwMNrgCkQXtu3u
	RbbTdyGHY6OZybTeklqzuPeN5NuClLBHmOt6llPGHHWeWlOmfaF5xnkJY9IQ06k80HNnpNaMG/H
	a9j7rxt4X5FBu
X-Received: by 2002:a17:907:3f11:b0:c4d:212a:192a with SMTP id a640c23a62f3a-c5066db88a8mr468170266b.48.1794496866215;
        Thu, 12 Nov 2026 07:21:06 -0800 (PST)
Received: from gmail.com ([2a01:e11:1403:8620:5984:fa71:7b11:41c5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4983600bc8fsm16385724f8f.30.2026.11.12.07.21.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 07:21:05 -0800 (PST)
Date: Thu, 12 Nov 2026 16:21:04 +0100
From: Paolo Pisati <p.pisati@gmail.com>
To: Lee Jones <lee@kernel.org>
Cc: sashiko-reviews@lists.linux.dev, Paolo Pisati <p.pisati@gmail.com>, 
	linux-ide@vger.kernel.org, mfd@lists.linux.dev, dlemoal@kernel.org, cassel@kernel.org
Subject: Re: [PATCH v1 1/7] zorro: warp mfd: add the CS-Lab Warp
 multifunction parent
Message-ID: <wxsfjhxzk4zrmaf3ykjgwj6sulyylqfak24xhrwa3pqroxtwgw@w66gfa7yi7jb>
References: <20261111163735.227286-1-p.pisati@gmail.com>
 <20261111163735.227286-2-p.pisati@gmail.com>
 <sashiko-outbox-209365@kernel.org>
 <20261111180442.GE6323@joneslee-macbookpro.roam.internal>
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Post: <mailto:linux-ide@vger.kernel.org>
List-Help: <mailto:linux-ide+help@vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-ide+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261111180442.GE6323@joneslee-macbookpro.roam.internal>

On Wed, Nov 11, 2026 at 06:04:42PM +0000, Lee Jones wrote:
> On Wed, 11 Nov 2026, sashiko-bot@kernel.org wrote:
> 
> > Thank you for your contribution! Sashiko AI review found 4 potential
> > issues to consider:
> > - [Low] mfd: warp_mfd_probe() places new MFD core driver in
> >   drivers/zorro/
> > - [Low] mfd: warp_mfd_driver hard-codes mfd in names and uses wrong
> >   subject prefix
> > - [Low] mfd: warp_mfd_cells registers only a single child cell and
> >   Kconfig mismatches code
> > - [Low] mfd: warp_mfd_probe() passes z->dev.id instead of
> >   PLATFORM_DEVID_AUTO
> 
> All of these are hard blockers.
> 
> Why are you adding a whole new subsystem for your device?

No hard reason: I took inspiration from Geert's Zorro MFD experiments[1], hence the
weird location.

> 
> This clearly lives in drivers/mfd.

Ack, I'll address Sashiko's comments and i'll resubmit.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/geert/linux-m68k.git/commit/?id=0417ac04d4357f5c1bd2bd43bb188624a85149f5
-- 
bye,
p.
