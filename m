Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FCEB28C017
	for <linux-ide@vger.kernel.org>; Wed, 11 Jun 2025 13:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749648831; cv=none; b=bjWMQGJAsnzFmx1yWhm8wVZRn/FRDsf05eeNq1wCDusNuxD+Hod5ICJtoXnvEfFJH8JBb178hLeWU6COjEnEbrnHDeFbYcFYRykPhDgHbhTzbiYFypy232MDw02R9EcsEbpxcfnWOV3Y6xKWVkY3wm14+r2lPMfiJtBFgskvVFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749648831; c=relaxed/simple;
	bh=YZG/dBFDoQw3NZN+zkRnfQocEn7C0gbK8Wrh8f3O+8o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A0/4X37kX89ClmAmnGkmd/TMI4vqeNOj+oKYloH6gjiYCKQeStsUOzMLXBMRx+M24O6nkCOeq7XvvsthhtZ0fkskeRELKm6ZbRj3bHavxuFoKbL+N1M5G8KsEPZbkwkIFe2MU7irBtXDkzNTa/18RA1OAuCLZ3Fymv+PG840Yq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UIlvuD0y; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UIlvuD0y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94D6CC4CEF6;
	Wed, 11 Jun 2025 13:33:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749648830;
	bh=YZG/dBFDoQw3NZN+zkRnfQocEn7C0gbK8Wrh8f3O+8o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UIlvuD0yZwinUoF5vRxBr5sMo9X0xwmEOijKtVo+UrQd+NMifHHJ6TWrOJApbBlsN
	 KtfF5t9Ww1Oa2kyPKH4eXTh6/dAD2hNMnC1A09b29D5TVv+iSmnvqblYIo1IuHe+BZ
	 upmqoCMqiIj5oS54t4g9foIESXKHShfCMNQsEEmoyOLxBDO6LWZuVmIWpWE0dyAMWg
	 dAc8kwCE/Vq8lwndfJJ7MdvQVyIpLLsWoMB9hQlSvfXRVPwSmUHk7gIGiPdG0CfpPH
	 Dx6hGUeeYWQa/HETqrvjFzP6zqnYt5W2r814FnTt3V08q/7Yu5hAkOSQUk2IiwLKoF
	 MVNQiiLg1GajA==
Date: Wed, 11 Jun 2025 15:33:46 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Mikko Juhani Korhonen <mjkorhon@gmail.com>
Cc: Damien Le Moal <dlemoal@kernel.org>, Ioannis Barkas <jnyb.de@gmail.com>,
	linux-ide@vger.kernel.org, Hans de Goede <hansg@kernel.org>
Subject: Re: [PATCH v4] ata: libata: disable LPM for WDC WD20EFAX-68FB5N0
 hard drives
Message-ID: <aEmFuqA5kNhMD41Z@ryzen>
References: <CAAZ0mTdtOVSidMeC76X9oZyHCtJdgyiu44+UEKqP5tSUaD9ZsQ@mail.gmail.com>
 <aCG-gS2f3uXKaQPj@ryzen>
 <CAAZ0mTfqE+w8BBCyVSg0KKQ6fYZwKaqvh_ND8dLCANg-oMaphA@mail.gmail.com>
 <aCHZg4tj6YwS9vph@ryzen>
 <CAAZ0mTeiVqZQvkWzJ8aFH4FUPCZwy5O+9hPBgDPhSgNNz+t6HA@mail.gmail.com>
 <aCTZkV5mRjDsYyeE@ryzen>
 <CAAZ0mTcge55H4Ow0JG8PE5Wpgtz6TG60uvGxRUXrq-aVH4k9aQ@mail.gmail.com>
 <aEGLCBnh_PSON3Sx@ryzen>
 <aEbmg4wqqMaetxzd@ryzen>
 <CAAZ0mTdBgeedcF3gE6bKm=+qFj8Sfuc0xVc-kDb2=nhMS3F_3Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAZ0mTdBgeedcF3gE6bKm=+qFj8Sfuc0xVc-kDb2=nhMS3F_3Q@mail.gmail.com>

On Wed, Jun 11, 2025 at 04:14:44PM +0300, Mikko Juhani Korhonen wrote:
> ma 9.6.2025 klo 16.49 Niklas Cassel (cassel@kernel.org) kirjoitti:
> > > It is unfortunate that the BIOS manufacturer has managed to mess this up,
> > > but since this is the first motherboard where I've heard about the problem
> > > of LPM only working on certain ports, even though it is a per controller
> > > thing, just not having good power saving for this motherboard seems fine.
> > >
> > > I suggest that we simply add the DMI name of your motherboard to
> > > ahci_broken_lpm().
> >
> > (As without that series, it is not possible to add an entry
> > where there is no good BIOS version that has been released.)
> 
> Hello Niklas,
> 
> thanks - ok we are assuming that this is something that happens only
> on this motherboard for this AMD 0x43EB controller at least for now.

From what AMD people told us, this controller is not the same as the ancient
ATI based AHCI controller that had a bunch of problems with LPM.

Also, LPM works on some ports, but not others. That suggests that the AHCI
controller actually supports LPM and that this is a BIOS / integration issue.


> Was your thought also that we restrict disabling lpm only up to the
> current BIOS version, and if there are BIOS updates which don't fix
> the issue we just bump version number here?

The table in ahci_broken_lpm() previously included BIOS versions that were
good. (There has been a new version released that has fixed the LPM problem
that existed in older BIOSes.)


I recently added the "ASUSPRO D840MB_M840SA", which does not have any good
version.

I was thinking that they probably won't release any new BIOS versions for
"ASUSPRO D840MB_M840SA" and your motherboard, so most likely we will never
need to bump these. But perhaps that is a silly assumption.

Perhaps a better solution would have been to have two tables?

One table that looks like before. (Anything older than the "good" version
gets LPM disabled.) And then a new table for boards that we quirk
unconditionally (because there is no new version that fixes the LPM problems).

Because like you say, perhaps the manufacturer will release a new BIOS with
simply a small hotfix, and will thus have a newer build date, but will still
have broken LPM.

Perhaps I should throw out some of the commits from for-6.16-fixes, and
implement it using two tables instead.

(Commit 6f29d393061c ("ata: ahci: Use correct BIOS build date for ThinkPad
W541 quirk") can still be kept.)


> And I guess there are not going to be any firmware updates to the WDC
> WD20EFAX-68FB5N0 drive, I understood that you or Damien might know
> something about this? This would of course not help if the problem is
> in the motherboard.

I don't think this drive will get any new FW.


Kind regards,
Niklas
