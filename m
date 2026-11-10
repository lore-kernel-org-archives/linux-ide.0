Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794307612;
	b=JzWeXfL7ey9Hx6e9GlRADeIilgkG3iJG5gebxLT7eJ48Rx9ELmlCI7FkOYc/J+ObVfoi
	 7HD1zinXKGNotUhbVFoMJuwR99XJ7iYSQxufeDPXM5KtNq6uIckSe90SKf2aT2PQrGx4T
	 IyUxHjyKtFAbmWE8FDrErbqVr1Zm5FPJ+xMuc4kDkXz/nMSvqQYvpA1hktKchRAgnNyE4
	 uHGujDQd0vusK4GljNL8jYYFXh1HgcxO76Zxk7dnAEb7UZvlzPs1TlWZjoDudfo/Neosu
	 IlIajqUk2OC6RYgEt+nW7EKoF/adRa88Zjg+M/9MpgbjF45RAblUPcauMpwqFTt79rw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794307612;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=nODhUAwhKWYqEgyldjAn3rBqShEs7DVtSuNflrkrxUM=;
	b=RGUlVnJKsh9rwdSsC7/4wLoQDOSMwZP3BNETil0pMtiw20IYoNrs+TKu0DSVOOnqpCKT
	 sRs4cNWJ2OL1frf7x9yOMdob8oh8u58+flnb38SwfyGUPEHKZy+4FOAhOyjp15UaIsYlz
	 FyjdNC5CcLuwtmgRM7qkIfRiOkH71Bq06slJFmj23+UpSxEoOyuXHxvRUEALuovUtMnsB
	 g1z6zsrdbMiN8IOWdcyCVwwzwtVM2PSscuypCwuGBYgxeJ0adzVjWVehA90Xmjd0qhQK4
	 ATJ5PEADbjShPby8AZtFTj/yTTqXm6APCXZa7r+ykOngTgMux769Rj9TV7CxNfttGVA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bg0Fzj6O;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54FAD606A325
	for <linux-ide@vger.kernel.org>; Tue, 10 Nov 2026 10:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bg0Fzj6O
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6E6E1F008A1;
	Tue, 10 Nov 2026 10:46:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794307611;
	bh=nODhUAwhKWYqEgyldjAn3rBqShEs7DVtSuNflrkrxUM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=bg0Fzj6OYfvWvWWHikH+DFQLk4sTfxEeeACYhYHw08aM8DAhj0Sv4BnBACuxbT/n2
	 HmHiAlzsXwjF5c8UqgN8jMEWTp9++S483ZDIPjoiGxeyi3Qmkar1Fc9/qWTghx9nR8
	 soiHDLLI+eDt365JJf7vcl51KrKHirM+Tu80Hp7zdBD+X7MHL1zqQuieoACBImKRvA
	 FajYbjrZm+Tlz4d1TrPqMo7DWUui4E//EtsxkpfNC7ls5RCUDkd3U7ar4hKfKx1t7G
	 f4vqGDOvjbnAd8O7W5/u/ZI9dP0BfYa7E3P13MUv2BKja9yluodqKaDga97/+iAG/K
	 UCxNZxMOCznnQ==
Date: Tue, 10 Nov 2026 11:46:48 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Tobias Kriebisch <tobias.kriebisch@tecbeast.gmbh>
Cc: Damien Le Moal <dlemoal@kernel.org>, linux-ide@vger.kernel.org
Subject: Re: [PATCH] ata: libata-core: Add NO_NCQ_TRIM quirk for Samsung
 PM893 (MZ7L3)
Message-ID: <avL2GHf5tXhiXmPb@ryzen>
References: <20261109134541.3766394-1-tobias.kriebisch@tecbeast.gmbh>
 <avHfKaY-skamodEr@ryzen>
 <71332274-ae9d-4d2d-bbc6-22c559102c4c@tecbeast.gmbh>
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
In-Reply-To: <71332274-ae9d-4d2d-bbc6-22c559102c4c@tecbeast.gmbh>

Hello Tobias,

On Tue, Nov 10, 2026 at 09:19:58AM +0100, Tobias Kriebisch wrote:
> On Mon, Nov 09, 2026 at 03:56:41PM +0100, Niklas Cassel wrote:
> > Please boot the latest kernel, 7.4-rc2, and verify that the problem still
> > exists.
> 
> The three drives hold a ZFS pool on a production server. OpenZFS does
> not support 7.4 yet (the latest release supports up to 6.19), so I
> cannot run 7.4-rc2 on that machine, and I don't have a spare machine
> with this drive and controller.
> 
> Would results from the newest kernel that a released OpenZFS supports
> be acceptable? On that kernel I can test noncqtrim and nolpm separately,
> and then boot a kernel with only the needed quirks and no libata.force.

Normally, any problem where OpenZFS is involved is ignored, because the
CDDL license is incompatible with the GPL...


> > If the problem still exist on the latest kernel, apply the minimal set of
> > quirks needed to fix the problem.
> 
> Understood, the v2 will only contain the quirks that are actually needed.
> 
> > And yes, build and boot a kernel with your patch to verify that the
> problem
> > is actually solved.
> 
> If testing on 6.19 is helpful here, I will build and boot 6.19 with the
> patch, verify that the problem is solved, and send a v2 with the results.

... however, since it seems like almost all Samsung drives already have:

ATA_QUIRK_ZERO_AFTER_TRIM and ATA_QUIRK_NO_NCQ_TRIM

(ATA_QUIRK_ZERO_AFTER_TRIM is actually a whitelist, saying that the data
after trim is guaranteed to be zero, so this one tells the upper layers
about the FW behavior, so that it can use the most optimal commands.)

I think it is reasonable to accept quirk(s) for this device if you test
with 6.19 and actually verify that the patch solves your problem.


Kind regards,
Niklas
