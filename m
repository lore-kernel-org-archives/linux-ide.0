Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CE964C9B
	for <linux-ide@vger.kernel.org>; Sun, 17 Mar 2024 09:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710668807; cv=none; b=GScrR8ANN4NDFc0XZxEQ/l/cK3Ky7RjK6cYaG42/l/GhKbIpCcHZ1YP2lU9mHZFobHPgaHO5bDI6Fm2Jbbvd5xtaOIOvKQ6aP9wArKsKIzhcEI1+wUuwLk8qKNFmuqMYEMpv5sA7vx9WRRfBeK6yVkahWrW+N1xZTOiEn3hblS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710668807; c=relaxed/simple;
	bh=mUNFDAXa309UZ/Y80F/DEIIQ6TLF3uYpUC80kOHPyww=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qw2rouHsUPu2Vn6l5aZNN1MUWCIXW2pgFgklcfNlZ+1MOtJ1m+ywnf+ai1Q5UAbY2JVl/HEWg8bSHscpqUao3G5/ZJOLIslDxkTlsVsap6Re6etH0D6Wo1FCdtfzfZMxfOmFZblduSp56IhOEYlUUjDhUDhgAESCN7+yVQsNK/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MUlBW3M3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MUlBW3M3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AEE3C433F1;
	Sun, 17 Mar 2024 09:46:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710668806;
	bh=mUNFDAXa309UZ/Y80F/DEIIQ6TLF3uYpUC80kOHPyww=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MUlBW3M3WJ8aKBzcffyMUO7hB7i74Qxap3s0gxByntk+STDPNIE0REKMXp2X+IhQG
	 uLmG3LXmSsTc8FlAjKSeLyhpTMUHoULsqA7pG5XWwRUg56WUKBJIOL7mKQAKkBf4Lu
	 2a8EmCUFH/uQaHrF8jpS0IitsrxwjbQp+mX/zt7b9KQUNVmfG8gL12n55bWZ2jQYR/
	 U7hZmruqctKqegfO/qmNxgpL0Om3itVqow9McvFPf8W0334+HVvvcFhhjAYNKDuZNC
	 I9KrQAFA+lYuxZsbG2hSCIyrTkIAzQ6Jbw3W1PHAW3DI8/83of2clEcI1cUgD2mZ+c
	 TV3WU7i5MLD7w==
Date: Sun, 17 Mar 2024 10:46:43 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Ioannis Barkas <jnyb.de@gmail.com>
Cc: linux-ide@vger.kernel.org
Subject: Re: ASMedia ASM1166/ASM1064 port restrictions will break cards with
 port-multipliers
Message-ID: <Zfa8AxoEJKvVRE4q@ryzen>
References: <CADUzMVaFcD26QiBK_eKCbtC5Ot-+hAruNbUx+2pQNTKtMhDGRA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADUzMVaFcD26QiBK_eKCbtC5Ot-+hAruNbUx+2pQNTKtMhDGRA@mail.gmail.com>

Hello Ioannis,

On Fri, Mar 15, 2024 at 11:19:54PM +0200, Ioannis Barkas wrote:
> Hello there,
> 
> This issue came to surface when I used my ASM1166 card with an
> external SATA II JMB393 RAID PMP module.
> 
> In kernel 6.8 I get:
> ahci 0000:02:00.0: AHCI 0001.0301 32 slots 32 ports 6 Gbps 0x3f impl SATA mode
> ahci 0000:02:00.0: flags: 64bit ncq sntf stag pm led only pio slum
> part deso sadm sds apst
> 
> In kernel 6.6 I get:
> ahci 0000:02:00.0: AHCI 0001.0301 32 slots 32 ports 6 Gbps 0xffffff3f
> impl SATA mode
> ahci 0000:02:00.0: flags: 64bit ncq sntf stag pm led only pio slum
> part deso sadm sds apst
> 
> PMP is attached at port #1 of the ASM116. Two SSDs are at port A and B
> of the PMP.
> 
> In kernel 6.8 I can only see one SSD:
> ata7: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
> 
> In kernel 6.6 I can see both SSDs:
> ata7: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
> ata15: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
> 
> ASM1166 is not declaring PMP compliance at its capabilities but it
> works on its own way if it is not touched. Upon touching it PMP
> support is effectively disabled so only the first attached device is
> visible. I believe the hflag is needed here.

I'm not sure what you mean by "I believe the hflag is needed here".

Did you check if this patch (applied on top of v6.8),
which sets the PMP supported bit in the CAP register:
https://lore.kernel.org/linux-ide/ZfMerqAmWoyu66%2F5@x1-carbon/2-0001-add-hflag-to-force-PMP-cap-on.patch

Solves your problem?


Kind regards,
Niklas
