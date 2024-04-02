Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B7A0158D7D
	for <linux-ide@vger.kernel.org>; Tue,  2 Apr 2024 18:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712083938; cv=none; b=g9o7GOwC3v4zZeIf4uELEuzmDOOt92FBCIgh4KMO9NV2x4cdMCh+yHku5wWVsyu0tLM23MfFQawAVzAelnTb7bcLF0fmAMeUr0SGbiPV0D8QFz1qoKSMDELe4NhAfCxDV/o5B2AExpyH3pLHyMh7PbJHYbx4hmKq1zTCgQWXMXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712083938; c=relaxed/simple;
	bh=BNZH8W9xdUdbdGJ20lk3iKQg9Wgqy5OW+j5RG8dplWA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QD/NQ60aj7XaWPR8q/1bnBHISyrMXNBJjAdam78RKjzd9ZTmYNAzByTIxwzkhCWK0f6MiwCLUX1p8IfltcJCAOymyvN/xgj9Gi5vkuCRk6De6+cdIHRAGiGekj86CR+pjp8MbaDekVW/D3CLuwZjuqRT9l02VELw0S7DMc5gTZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IC5+ZmT2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IC5+ZmT2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1537C433F1;
	Tue,  2 Apr 2024 18:52:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712083937;
	bh=BNZH8W9xdUdbdGJ20lk3iKQg9Wgqy5OW+j5RG8dplWA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IC5+ZmT2SEXpkqIrS/zwJxDTwHbjm/fE0V9xliA/oK7s4mVIwglO5Q+0IaRkegBq9
	 VgUtL/dcqR3qHhwvzz3DH45KpAL51dLIiekEibxfwp+cZU7zGXGgc254ptuTO5nzqY
	 jXBznSxSQ5mNX4uiI+LaLDHsy8dS4zp4xMq0uyPnUKA20i+y+izaTbTlFXJ/CZzL/2
	 iTRwgxElA2cMqIka618fzmT6wbJ9+d9ejCERxwsMjSoZ1d8nCX6N66dwfnF5Fc/SHW
	 wS3INObCGIjEP/IUIsdoAn2BqMkcuWpb3hn/4GeZrMZk945CcUvlcGtYd3NyHcU8Jv
	 +ttQZVAK4GFzg==
Date: Tue, 2 Apr 2024 20:52:13 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Ruben Van Boxem <vanboxem.ruben@gmail.com>
Cc: dlemoal@kernel.org, linux-ide@vger.kernel.org
Subject: Re: ahci module throws "Internal error: synchronous external abort:
 0000000096000210 [#1] SMP"
Message-ID: <ZgxT3QqHJ6rq9nqq@ryzen>
References: <CALc40c8rRV-mYyXj=a_+j92WKKmdib6Dbw+11i_Y9OYXWBCmwg@mail.gmail.com>
 <Zdz3f4KgAaPKp7m_@fedora>
 <CALc40c9+ZFnimQ_KP7YpCGgP=iQBeDSS-xPAwwiraeX42yK30g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALc40c9+ZFnimQ_KP7YpCGgP=iQBeDSS-xPAwwiraeX42yK30g@mail.gmail.com>

On Tue, Apr 02, 2024 at 08:15:05PM +0200, Ruben Van Boxem wrote:
> Hi Niklas and others,
> 
> Op ma 26 feb 2024 om 21:41 schreef Niklas Cassel <cassel@kernel.org>:
> >
> > Hello Ruben,
> >
> > I would recommend you to test with the latest kernel, v6.8-rc6.
> >
> > I don't know which device tree you are using, but very often custom
> > add on cards/HATs require specific device tree overlays to enable
> > certain regulators etc.
> >
> > I suspect that this is something not related to AHCI, but rather
> > some regulator or similar that is not enabled.
> >
> > How does your kernel command line look on both kernels?
> >
> > Perhaps try to supply:
> > " clk_ignore_unused pd_ignore_unused regulator_ignore_unused"
> > on the kernel command line.
> >
> > (regulator_ignore_unused requires v6.8-rc1 or newer.)
> 
> I tried v6.8-rc6 and it wouldn't boot at the time.
> 
> It seems I ran into an old issue which may have started in version 6.5:
> https://patchwork.kernel.org/project/linux-rockchip/patch/20230509153912.515218-1-vincenzopalazzodev@gmail.com/
> 
> This describes pretty much what I see.
> I understand the solution presented there isn't ideal, but as some
> major ARM distributions are using it, I assume it will do for me for
> now.
> I'll try to use the variant that goes through the device tree flag and
> see if I can get a recent kernel working.
> I'm also unsure if this mailing list is still the relevant place for
> this, as I can't readily find where I found the e-mail address
> anymore.
> Guess I was born in a different age :).
> 
> If you have any more pointers given the above or an alternative
> solution that has more merit, I'm all ears.

rk3399 should boot fine on recent kernels (not sure which kernel I used,
but surely newer than v6.8-rc1).
If it doesn't boot for you, then there is probably something wrong with
your kernel config.

If you still have issues with a recent kernel, I guess you could try the
patch that you linked to, but you could also try:
https://lore.kernel.org/linux-pci/20240330035043.1546087-1-dlemoal@kernel.org/


Kind regards,
Niklas
