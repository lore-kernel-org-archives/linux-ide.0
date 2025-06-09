Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40B7A263F38
	for <linux-ide@vger.kernel.org>; Mon,  9 Jun 2025 13:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749476999; cv=none; b=UCP1mw9/8YOEUllf9FspWooiEqdqlW1aD2tJJJ6U0vtSE2sOfUEB0qx+dLp4D1X2OeYIXGNUsN9aF/f8JbpofxRekGC6CPbmw5ZdYA0Mx8uWV2sOVDeLX+XcPlyHhcJxR2tQoHc5TboQL2TvYtU2UaVSljovVxM7oeKEd6wH9QE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749476999; c=relaxed/simple;
	bh=2uA3ReNa1CsOaWvykg12CYjX4+HCOFzkEWaPSpTidrM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aX+wSgAp67ZXOpJUN7RTc227n0OuvfC8qkQon85hjHebkA2ErBVQK5XpFAJxfZFSh4+TT0g7UhcgST4ppCxLGXgfY2YtUV4tDa1MM2CsE2r9rVkAHk4LGzMwTyyi34MUnKAv2aIhCPwidbwe1aV3UiSZ4JzbXYFdRfJ4OpbowO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FgmI9svN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FgmI9svN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD205C4CEEB;
	Mon,  9 Jun 2025 13:49:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749476998;
	bh=2uA3ReNa1CsOaWvykg12CYjX4+HCOFzkEWaPSpTidrM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FgmI9svNSrst5jn2lJbRwcWqEOJ4gcXJ9VkeXt5Pj81ncecgY1iR/FMrYm1IpanbJ
	 fOg9u32GzTjnFTymphI2u3bAwBwqJcJ/Y5kyJddyRVzAlw/9fvic69eD0hd8gkoKet
	 DSzF3M3DFKM6hAiCLm1aoZVCxa66l9p9HrRRpNLSbJ0MHGQvRVjX8szGUGnjokf8Oq
	 D6Js/S8xV+HiSXhgz43uOlW+I18V+CjFSsH3Kr3V/esFV/N87AwnapAlz0Z6HrTOK1
	 Z82hrDcfQK2qVqmxhZGSqV7dUTCGBZGVUKs+h7iyN+IdyEQHZrfekJ8lsILgS/71qn
	 Q4KHbvoCjzRqQ==
Date: Mon, 9 Jun 2025 15:49:55 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Mikko Juhani Korhonen <mjkorhon@gmail.com>
Cc: Damien Le Moal <dlemoal@kernel.org>, Ioannis Barkas <jnyb.de@gmail.com>,
	linux-ide@vger.kernel.org
Subject: Re: [PATCH v4] ata: libata: disable LPM for WDC WD20EFAX-68FB5N0
 hard drives
Message-ID: <aEbmg4wqqMaetxzd@ryzen>
References: <CAAZ0mTdcAazi=133Dz0+OgSGOERe7WmCTr27ePudEVhkJj6VbA@mail.gmail.com>
 <48F49924-F5FE-4A91-8323-E2C789D1BEFB@kernel.org>
 <CAAZ0mTdtOVSidMeC76X9oZyHCtJdgyiu44+UEKqP5tSUaD9ZsQ@mail.gmail.com>
 <aCG-gS2f3uXKaQPj@ryzen>
 <CAAZ0mTfqE+w8BBCyVSg0KKQ6fYZwKaqvh_ND8dLCANg-oMaphA@mail.gmail.com>
 <aCHZg4tj6YwS9vph@ryzen>
 <CAAZ0mTeiVqZQvkWzJ8aFH4FUPCZwy5O+9hPBgDPhSgNNz+t6HA@mail.gmail.com>
 <aCTZkV5mRjDsYyeE@ryzen>
 <CAAZ0mTcge55H4Ow0JG8PE5Wpgtz6TG60uvGxRUXrq-aVH4k9aQ@mail.gmail.com>
 <aEGLCBnh_PSON3Sx@ryzen>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aEGLCBnh_PSON3Sx@ryzen>

Hello Mikko,

On Thu, Jun 05, 2025 at 02:18:16PM +0200, Niklas Cassel wrote:
> 
> Personally, I think that checking for certain port numbers, for a specific
> motherboard makes the code very ugly, and will not scale very well if some
> other motherboard has a different subset of ports where LPM does not work,
> so I would rather avoid a quirk handling port numbers.
> 
> It is unfortunate that the BIOS manufacturer has managed to mess this up,
> but since this is the first motherboard where I've heard about the problem
> of LPM only working on certain ports, even though it is a per controller
> thing, just not having good power saving for this motherboard seems fine.
> 
> I suggest that we simply add the DMI name of your motherboard to
> ahci_broken_lpm().

I just sent out a series which refactors ahci_broken_lpm():
https://lore.kernel.org/linux-ide/20250609134539.943587-3-cassel@kernel.org/T/#u

When sending your patch, please base it on top of that series.

(As without that series, it is not possible to add an entry
where there is no good BIOS version that has been released.)


Kind regards,
Niklas
