Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D9CC449B17;
	Thu, 15 Oct 2026 07:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792048878; cv=none; b=YFLPAHuR1QT29rcAwjrkYC99NOpaHLZU2VFccNXr8NHtkv9vF1U08r3X4jZ/13cwJkPOHcg0s5XcG5PkvyIiDZprMKK4FZOG57UPmPSTb/msuEkKJw07sKKmb1m74K70QEG8xXU9HJlq2n9afXAh45dBm7h4yci8KCU+AxuzFzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792048878; c=relaxed/simple;
	bh=UnElEGL6a9K+KIwKMbc7bCLJ4t2PlJBsCdavuUdiOlo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PfiloLqXZy/CtKXISa3jKuqB67bNe38jOfuvjCz+BZEp9f+hQfutUKlFg8DnFUZ8O8AJnGgb1l6EstGbZg+munNFmoWBzjGEu4PhJ+/VdakEMnwjAHl7n4HHG+8WbhjfZNowVOo5pBNg5f2kT/im17y49AWJ+2HUgTq1qg+j7tA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hmq21l6n; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hmq21l6n"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACAF01F000C4;
	Thu, 15 Oct 2026 07:21:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792048869;
	bh=YxcC0x778Ab3bAH3PuAHJ3L1E9EsN/37DGAWFayiun4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Hmq21l6nNuAx9qwOf426Vd/0ZVKeHlw0Z7f3JlSZStncwrXpTerjJY/2IVjDxFOpP
	 5XYFr9a+JHfQhNAnuEq2B9GSI0DjZz2CP5AzfWBVldBbaOTOdGZ1f1fcyvviZhcNnW
	 VJEK6NYXoSUbe1HQLa8dGA+d3Y0Yv35kw7PP6cD8rUXNsiVYadBdPsT8X0pZpTsb7X
	 tnOG+Qv5ldOIHYhglr2nkqy7ZH5gnV8us5zV2+80xoCmrd3i9Y1z+laIo878J7uFI6
	 JJEzkNL7d21zqVZXvU5y7f8vzKK+FTU2pHmWgeM6ISasRmacppuGACB3FObfUCEd9M
	 5ayC9LoddGIDQ==
Date: Thu, 15 Oct 2026 09:21:06 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Kyrylo Biryuk <illofspeed@gmail.com>, linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] ata: libahci: re-enable FBS after error handling on a
 port multiplier
Message-ID: <atB-4s_ffWEr6yDP@ryzen>
References: <20261012103917.389-1-illofspeed@gmail.com>
 <eb21b333-3047-4f8c-a1d7-9d390d935abb@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eb21b333-3047-4f8c-a1d7-9d390d935abb@kernel.org>

On Thu, Oct 15, 2026 at 07:37:45AM +0200, Damien Le Moal wrote:
> On 2026/10/12 12:39, Kyrylo Biryuk wrote:
> > ahci_do_softreset() disables FBS before resetting a device behind a port
> > multiplier, as required by AHCI 1.2 section 9.3.9, and re-enables it only
> > when that softreset succeeds. If it fails, for example because a
> > hot-plugged drive is still spinning up ("softreset failed (device not
> > ready)"), EH escalates to a hardreset of the PMP link, and nothing turns
> > FBS back on: only ahci_pmp_attach() does, which runs at the next boot.
> > The port keeps working with command-based switching until then.
> > 
> > Seen on a Marvell 88SE9235 (1b4b:9235) with Marvell 88SM9705 port
> > multipliers (1b4b:9705, in a Synology DX1222 expansion unit): after
> > hot-plugging a drive, the kernel logged "FBS is disabled" followed by
> > "softreset failed (device not ready)" and a PMP hardreset, and never
> > "FBS is enabled" again (twice, on two different ports).
> > 
> > At the end of ahci_error_handler(), re-enable FBS if a PMP is still
> > attached and FBS is supported but disabled.
> > 
> > Fixes: 89dafa20f3da ("ahci: disabled FBS prior to issuing software reset")
> > Assisted-by: LLM
> > Signed-off-by: Kyrylo Biryuk <illofspeed@gmail.com>
> 
> Looks good.
> 
> Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

Commit was updated to pick up Damien's tag:
https://git.kernel.org/pub/scm/linux/kernel/git/libata/linux.git/commit/?id=23eab9e877497397a0e2394ee9174d576816209e


Kind regards,
Niklas
