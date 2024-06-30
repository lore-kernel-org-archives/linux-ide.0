Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 536EC8F72
	for <linux-ide@vger.kernel.org>; Sun, 30 Jun 2024 22:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719787572; cv=none; b=hXdNYH1N3apYhOHK1DXoPxKEvZq2yUVe5MfWpXOe+AVv5L611VKk8rFKHp+smjB3Nw6akrg+vIckJZA8VlemsqlPmw5uW4SIFJBaRUUdViDSuLe7x+s+fENePxOuriSga1WsV7bvKv+kbKvKyn6Hqe36qJ7hVuFxYGcBSOIcXvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719787572; c=relaxed/simple;
	bh=sxt72j9Pl8IOZ8jtwwa2G9/Gcrbrj0j2xG30XUjSa5Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sBsQXZV/anyIeViQeNBfiTpliUpTJVTn88nFufReMZLBBTfZgbS13jmv3rFPi8L58lIjmfdqkoGKyQdq5u5dHFKf5ASR+vKhY/EwFUQbgWFy8hujbO4g7naHVV9DRa7QYeMBHgRDmPGxCW1sFMwDobERP/RXsZ2p70zxMNZSLHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s+1tzEwJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s+1tzEwJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3977C2BD10;
	Sun, 30 Jun 2024 22:46:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719787571;
	bh=sxt72j9Pl8IOZ8jtwwa2G9/Gcrbrj0j2xG30XUjSa5Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=s+1tzEwJ8uihLMjD/HQcS0pqtbWOg4RewOWomVh21o8fKBHWzih000hkdYDGgZoLc
	 HOQddrP5U653J+e7JmS/bh75SaSF1gip5u479wlD7kvPzlRCmDJl/GZJH9zp21GZ1K
	 CBeaNXwWKiEVe2xof4HvskJ2jh0I9pdOLhniS9OSzArt5r7qgOHJ78ZcLFvwbvAKQT
	 f/8QknjV1xDtRfX84RINNC4u7d1dZ57oNcB8cZFaGI9JLiOeia4KMBAITlbITFuUcl
	 0lUIyotTm0Kepk/sGoHxye3uvWtfOwEAcYaUh+lP9csjXpjQkSupG9qJngTf1xdNyy
	 jRIFXVsIj6FJA==
Date: Mon, 1 Jul 2024 00:46:07 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-ide@vger.kernel.org, Damien Le Moal <dlemoal@kernel.org>
Subject: Re: [GIT PULL] ata fixes for 6.10-rc6
Message-ID: <ZoHgLxu-RLVnSEO0@ryzen.lan>
References: <20240630212754.207691-1-cassel@kernel.org>
 <CAHk-=wjj18++AvGeHRGSVA_sH07gBGSuCkGbcCTwDOVcgS+rwg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjj18++AvGeHRGSVA_sH07gBGSuCkGbcCTwDOVcgS+rwg@mail.gmail.com>

On Sun, Jun 30, 2024 at 02:40:07PM -0700, Linus Torvalds wrote:
> On Sun, 30 Jun 2024 at 14:28, Niklas Cassel <cassel@kernel.org> wrote:
> >
> >   git://git.kernel.org/pub/scm/linux/kernel/git/libata/linux tags/ata-6.10-rc6
> 
> So I've pulled these, but I'm not happy with how they seem to be _very_ recent.
> 
> Yes, they all look trivial, but even trivial commits have bugs, and it
> looks like they have had absolutely zero testing. Four out of five
> commits were committed about an hour ago.

The four out of five patches were originally part of a larger series,
sent out on Wednesday:
https://lore.kernel.org/linux-ide/20240626180031.4050226-15-cassel@kernel.org/

They have been tested using:
rmmod + modprobe + rmmod + modprobe on:
-AMD AHCI controller
-QEMU AHCI controller
-pm8001 SAS (libsas) controller

Both with a debug patch that forced an error,
and without any additional debug patch.

Ensuring that:
-The error/crash was fixed (in case of forced error)
-That all devices show up as intended (in case of no forced error)

So it probably looks worse than it is.


> So please - don't do this. I was close to just unpulling it all again,
> and if this had been some final -rc, that's what I would have done.
> This kind of "last-minute commits in last-minute pull request" is not
> ok.

Understood!

FWIW, even with the testing done, I would never even have considered
doing the same if we were later in the release cycle.


Kind regards,
Niklas
