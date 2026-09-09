Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D59844AFE2A;
	Wed,  9 Sep 2026 10:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788948505; cv=none; b=EPAeup5Qunys6yRNlAnZxANBQXfY8zp5Fb1X1Xqv0WlpK1xZAE4smiyu0kFelPXcYL6ZCK9nWiNebEOPhcWbFcew0yqvIR8YBRW29uftLjg7KtZN32MRe/x6EV3H0xpXSyPZwt56fEv2XUYkd+FieMdVuy8ljOS0SkE8xxt850k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788948505; c=relaxed/simple;
	bh=4+xbcgCkU9A4sJQJ7e9sMkIGFj390PkIV4I3xP3HbYE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uPUa/Z4rsvKZL+p5mzhtdGFmU//BgOzMx6s6zF+QjgKyiz3BKEtVoJFLOANHNJVR2E4q9zIneQE8OJVXHVseFRiZI4nFU91XXrSdyK/OfDQvhuVMUCbDtCCRKGlPwN7NKHGbHwqhzjxzTpZBh3WOO4lgLJBU6uUS1oGTqPHnk2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JPgc/EIM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JPgc/EIM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 465E91F00A3A;
	Wed,  9 Sep 2026 10:08:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788948503;
	bh=gEf/ZWVDOaeipIRgqVf0Va+c8f/46psLsVtWRf7RTo0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=JPgc/EIMjDbKjmtQ2ZLcUWDwvQuTh9HXZGlF0Rd+fEwB0EzdbSkJN7Wg2nmTPj3UF
	 OSX0DWw/A5pSVKMk/J2y/EjAFjworzHH4PGgYg3BguAZ6wftP6O1sf8sSEY1MzYdhK
	 Wx2+nEX895I3t35kVJ+jXuV4TmTwFJ6Lf9q1zikI7lf2kHp+DXGw9GS3v89afhNYrq
	 PQCmFRSfJ3GPnjK8kLsC7fXBupvHnKvx+egr//n5fTGxVoHefZSt1hL677Bu7R6JIj
	 6aL7eGPOxfpbfG12a/dHikCXwmg7OZKlgvRis2wwArU8rBS+5npKoxXsBlGw90e6WN
	 1p6OJKn2CeA1w==
Date: Wed, 9 Sep 2026 12:08:19 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Rosen Penev <rosenp@gmail.com>
Cc: linux-ide@vger.kernel.org, Damien Le Moal <dlemoal@kernel.org>,
	Tejun Heo <tj@kernel.org>, Mans Rullgard <mans@mansr.com>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCHv2] ata: sata_dwc_460ex: preserve sactive_issued state
 across ISR invocations
Message-ID: <aqEwEwoEwv7ybf8q@ryzen>
References: <20260908214536.598823-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260908214536.598823-1-rosenp@gmail.com>

Hello Rosen,

On Tue, Sep 08, 2026 at 02:45:36PM -0700, Rosen Penev wrote:
> Zeroing hsdev->sactive_issued on every ISR entry destroys the NCQ tag
> tracking that must persist across interrupts.  This field is populated
> in the NEWFP (DMA Setup FIS) handler and used in subsequent DMAT (DMA
> Transfer Complete) interrupts to determine which tags have completed
> via the formula tag_mask = (sactive_issued | sactive) ^ sactive.
> 
> With the zeroing in place, sactive_issued is always cleared before a
> DMAT interrupt can read it, so the NCQ completion path never identifies
> completed tags correctly.  The command completion then falls back to
> the non-NCQ path using ap->link.active_tag, which works for a single
> outstanding command but produces wrong results when multiple NCQ tags
> are in flight.
> 
> Remove the spurious zeroing and fix the NCQ/non-NCQ discrimination:
> when tag_mask is zero but the active command is NCQ, all tracked tags
> are still in SCR_ACTIVE and no completion processing is needed.
> 
> Fixes: 2d20da00c324b ("ata: sata_dwc_460ex: get rid of global data")
> Assisted-by: opencode:big-pickle
> Signed-off-by: Rosen Penev <rosenp@gmail.com>

With all due respect, you've already said that you don't have any hardware
that uses the sata_dwc_460ex driver.

So you have not encountered a problem in the real world, and you have not
been able to test that your LLM-assisted patch solves that real world
problem.

The risk of accepting LLM-assisted patches for problems that no one has
been able to reproduce on real hardware, is that the fix itself might
introduce another problem, and then we just trade one problem for another.

AFAICT, this seems to have been the problem at least twice so far:
https://lore.kernel.org/linux-ide/anw-k62wK-GhkHSI@monoceros/
https://lore.kernel.org/linux-ide/20260908141538.731237-1-nik.borisov@suse.com/

It was years since I saw anyone with a Synopsys email contribute to their
PCIe controller driver, or their Ethernet controller drivers.

sata_dwc_460ex is an older DWC (Synopsys) SATA controller, newer DWC SATA
controllers are AHCI compliant and is using drivers/ata/ahci_dwc.c.

So that probably leaves us with the company who submitted this driver.
They don't seem to have sent anything since 2011, so I doubt that they
care about this driver either.

That said, we are happy to accept any patch for any driver for which you
actually have the hardware to test.


Kind regards,
Niklas
