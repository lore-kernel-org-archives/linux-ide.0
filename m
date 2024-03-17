Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87C8FDF5B
	for <linux-ide@vger.kernel.org>; Sun, 17 Mar 2024 09:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710668176; cv=none; b=Z1B+gq2hwcRRTLqv4Hh8Kj5D63SJUsy+aCZicRtzQ01zaW2MYGFB3M9m0O1pn2ci+ex8ZZ5k4cU1ENadKBRcJYQDDls3VQiZZ9zpLmCMh+UgJvGQzdZ12pNmZkNMKQT9FDzwJHwmU9xHEpEuS/mbaO2pwB+qdfHvbwYIIgBSBc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710668176; c=relaxed/simple;
	bh=6Fm8Osmhm2BoH/WOqWmIyxnJRcBxThUjWrLV8kYsYYo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yh2ofdZ2ha5oX4m6PJXaWSuOfK3tNw6ySqDJPp3NwzGIBUCv14O99ahffqZw2oPU3Rd9GEMSwPrGQbcaV1n3uu0LijW/r/irxydzpdKGPzS2Vx+IInBk4OMunesFsQ5OdqrFpm6xVn1JsezYijxG5aRtVXAOVbXBYvz5Zx/tMC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MbMjS2WR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MbMjS2WR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3645C433C7;
	Sun, 17 Mar 2024 09:36:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710668175;
	bh=6Fm8Osmhm2BoH/WOqWmIyxnJRcBxThUjWrLV8kYsYYo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MbMjS2WRk+Xw9e0FP0zi+QzgnacegBCe7boP9XWgVNpi5cteF7EtcjcQVcDWXQUkD
	 7Fneb9b0VorkP1W4lzThmk/w7Bv3LkIw1zIFqBmliJVJTZdpbBmBEwMZjmjtwjWRJx
	 4SMB9+dim8LMIAGLbIVIOSUVQKymxkDaia/OqWuIiLB1NGijdhe2pk05gY6BAw4TkE
	 9lODkozPNB96UOhyBXBs6vRPRux7Du1Uv7sAlcJV2dEpEZSdyE+5vCv22STmB50w6h
	 qhDRfpblkz9fa+PmGEXlOjFEJ0LhIeY2ge6yroKC69XJKdcHr9gX5/uCKaT4pTc+fs
	 7mgrF4hK12Eag==
Date: Sun, 17 Mar 2024 10:36:11 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Hans de Goede <hdegoede@redhat.com>
Cc: Cryptearth <cryptearth@googlemail.com>,
	Andrey Melnikov <temnota.am@gmail.com>, linux-ide@vger.kernel.org,
	conikost@gentoo.org
Subject: Re: ASMedia ASM1166/ASM1064 port restrictions will break cards with
 port-multipliers
Message-ID: <Zfa5iylgKrtrKH8H@ryzen>
References: <CAFDm6W19R3KHDO09c94Uwry9mdG+whAVy=u4Sdpt30A2MK1KPA@mail.gmail.com>
 <CA+PODjqxYcBMc=R792uOava1u0EYZtrWTOw9HvKUBG4=zYbzcg@mail.gmail.com>
 <CAFDm6W2dWu5+Dz2DiWG_9L-VatM6Wj=pMHM2th74Wh144kvqvg@mail.gmail.com>
 <ZfMerqAmWoyu66/5@x1-carbon>
 <2e471c2b-8432-4501-b093-4295529a4d38@redhat.com>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2e471c2b-8432-4501-b093-4295529a4d38@redhat.com>

Hello Hans,

On Fri, Mar 15, 2024 at 04:01:07PM +0100, Hans de Goede wrote:
> > 
> > If they only claimed that the HBA supported PMP, the Linux device
> > driver would try to enumerate the devices behind the PMP according
> > to the standard.
> > 
> > See AHCI 1.3.1, section 9.2 Port Multiplier Enumeration.
> > Or
> > SATA-IO - Port Multiplier 1.0, 7.4.2 Device Enumeration.
> > 
> > The PMP standard also describes how you read the device and vendor
> > ID of the PMP.
> > 
> > 
> > Right now, they AMedia? seem to have their own home-made PMP implementation.
> 
> Ah, ok so I think you did see my reply? Checking if we can ignore
> the builtin PMP support and uses Linux PMP support instead is
> indeed an option.

Yes, I saw your reply.

I wouldn't call it "Linux PMP support", I would simply call it "PMP",
since how you enumerate a PMP is decribed in AHCI and SATA-IO specs.

The "builtin PMP support" is not PMP, since it doesn't follow the specs.
I would rather call it "non-standard vendor extension" or "pseudo-PMP".


> I think we should still merge the revert / dropping of the quirk
> while we figure this out though, because not finding people's disks
> anymore is a clear regression.

I was hoping that someone could try the patch I sent out on Thursday,
which sets the PMP supported bit in the CAP register, as that could
potentially solve both problems here.

I guess if no one has tested it by Monday or Tuesday, we will have
no choice but to revert.


Kind regards,
Niklas
