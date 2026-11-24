Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795555190;
	b=LZcNgAe6g3QKyBGuNGseCsKLIQVXQN1xFhf64033TRaJN9hHVHK5/VnXxLiosVBLu9VX
	 Yza9rECJZm8blZkJJvXeGrUpy7bTuOj5a9FEVCFZ3dEgRNHp3BBsKqM+R8jM7EeEePbCc
	 hP5Hpd9uLVbLYLLkyfv8MoVSyXP+QQPAvYP1cYuNfU4R3jIOXfX27fydS8mVVeTM+qHI7
	 stIjtzzZHYdvk7b+pGWLme+dFW7m/ALKDGiCpWP8NCh8gPObtki+pkmsqYK1XWCEqOmZR
	 yzGNk9+/yvGtU1HHdhKQB8+KZ2VHV7kMkZ4bwWM23Uv4oSnDV4Zm+a9QtYK0ZraRtsA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795555190;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=yP2Jf7p62HpfYDPZadRkgPH8LenRpsmrc7XEWJA1Ykc=;
	b=xbeLPLpPXZpYe9qLcVnZaweHAIhtOupIr3+dhW7wCY9ITy/iko8uOWrLiRUEva8gTYLo
	 sB2VdpBsOm8QeuP9VsIlYuSmJiEgDob58YXs+3ROupb1ogZEki74X7qNyM9HH4GR21BNn
	 kHzIFtD0Ds/wCkGwdRZMEqDBLKPtXFMtA5iUVtUvAaQ/AreuJHuXUNSMrcDPNao11eSd9
	 PsTemZNYdIBaj3SXPifhXUcy4ItRyuVczNVGC+RjOY22Ko+Kcmn/JStFaiSe7blB/+cEM
	 o30zzvfAsWcZlckAUcQ3PqdaTTo5d2tL8QoM79ELTAka7AZMpa0HDlzDtFtcPC4dYOQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LsM1mkYf;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02140606A31E;
	Tue, 24 Nov 2026 21:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LsM1mkYf
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D6541F000C0;
	Tue, 24 Nov 2026 21:19:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795555189;
	bh=yP2Jf7p62HpfYDPZadRkgPH8LenRpsmrc7XEWJA1Ykc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=LsM1mkYfLGyoxgNkHBXl5cfM8qH7A8lZ4L90Ma66qemnJD2BQnY86Y2hWoy3dHsGQ
	 IXT8I6hzldmcPIBGkfQaeZhk3F10EBwgzBKEY1pqPWA2YJEbVCW3W9PPgq21zFWq2D
	 wi847+dVJhf7P6ZcEfW6DYfQqYVpMPz2BiqrggEaf6aFNeTnqumT8RTxjImDedy7eJ
	 AHwXRLrgIXcNavtPyv5vWNCA1mALv0UUkBMNf+xPTDZA5kMhFTd1QvLEdGDN6TQJbM
	 /pEOlmtqXPjg5MAAEO3M3blE/3kSXSiK+CdduxMLuG8EGVmArXmhq0ZR5j45ht28Kl
	 lMRWiyoqARLdw==
Date: Tue, 24 Nov 2026 22:19:44 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Pe3k <pe3cek@gmail.com>
Cc: iommu@lists.linux.dev, Lu Baolu <baolu.lu@linux.intel.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Damien Le Moal <dlemoal@kernel.org>, linux-ide@vger.kernel.org
Subject: Re: iommu/vt-d: data corruption, AHCI gets IOVAs inside its RMRR (HP
 Gen8)
Message-ID: <awX_cNOqtTjAP33a@ryzen>
References: <CAGvcwsDdKSZe0reeuT0eQabaSbM6+KAfwFimxiqhvKrjD2nQeg@mail.gmail.com>
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
In-Reply-To: <CAGvcwsDdKSZe0reeuT0eQabaSbM6+KAfwFimxiqhvKrjD2nQeg@mail.gmail.com>

Hello Peter,

On Tue, Nov 24, 2026 at 07:08:13PM +0100, Pe3k wrote:
> Hi,
> 
> On the HP ProLiant MicroServer Gen8 (Xeon E3-1265L V2, C204, BIOS J06
> 04/04/2019) the AHCI controller is handed IOVAs inside an RMRR that the
> firmware declares for it. With the default translated DMA domain this
> corrupts disk data on every boot under write load. iommu=pt avoids it.
> Seen on two machines of this model, on 6.12.118, 7.3.4 and 7.4-rc4.

You are not the only person who is having problems with HP ProLiant
MicroServer Gen8, see:
https://bugzilla.kernel.org/show_bug.cgi?id=221713#c16

There is also:
https://lore.kernel.org/linux-ide/5ad27a97aafbc08a8702d5b90d09cd59@posteo.de/T/#u
which I'm not sure if it is the same or a different IOMMU issue.

Does:
intel_iommu=on,sp_off
on the kernel command line workaround the problem?


Kind regards,
Niklas
