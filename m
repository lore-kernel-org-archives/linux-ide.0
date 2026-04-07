Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B38E3A257B;
	Tue,  7 Apr 2026 07:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775548122; cv=none; b=gFsfFYep2/AgnvyneNQ7dPLc2bIMd0fugvGImR6xXTpJUyK4WmzsZWMFTH8niz5lPSFlaDJ4jypGyKh9S+n5qCF980VsIt8OsZQBgDSp5foptNxo1ehzDDNsYDmNUOteLcHNWhdOOftt/rh4idftu6KXkgpJRZIN+O8YPCbmLIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775548122; c=relaxed/simple;
	bh=u8A/0wl66hEXs4y1JwuOL9yEKLY5qPVcdw+rfTMfYkU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JdmRX4iT27JA0A0W8Xg9Yt3PL07oFIplCw3/RxuYj6dGHgSxumYVlGmx6AzJYxccPKIBfyQAzshC37zyW6OyWTGddgWe6Kqvn4NVFsV9qMaCeuQrvpnhC1aEaXU5XXH4O/4CXupEoWtlHk5iZkYQ/x7v2L0uKhf3W6gJNaIcqvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NP1GFMQI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NP1GFMQI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DD2DC116C6;
	Tue,  7 Apr 2026 07:48:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775548122;
	bh=u8A/0wl66hEXs4y1JwuOL9yEKLY5qPVcdw+rfTMfYkU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NP1GFMQI9QfaREo2Xn6HcxXYDCvU4I7EpgfRiUSgLjpy5Oe1sVhplXPPkXKvUVqWv
	 QT42pLMxJgTb3WnFFHK/am2hlh0QIccSq06mrUr5pBa4zZjj0XoeqOh/tAOTJK4By5
	 NNqyUJY735kfXDfUNCfOXSlnWVS+29mTL+VuFAHvIu4FavUoyp4r+FCyWQ5AG2n0qO
	 HB23w+rbT6Br/AJ2mpc3sUF6xrEfvyesiG4EW3DRh6y0ByfTI5AzlB/79cC3ewASV1
	 ylddT3HbGMdLHAcknht2JmAZwjanEQUesdlgS0Y4OsfGEtft1ywCrBsPIrZCrcatVP
	 HvtN08d2VNMCQ==
Date: Tue, 7 Apr 2026 09:48:38 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Patrick Zima <pz.102010@gmail.com>
Cc: Damien Le Moal <dlemoal@kernel.org>, linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [BUG] ata: ahci: regression in f7870e8d345c disables DevSleep
 for ACS-5 drives on PSC=0/SSC=0/SDS=1 controllers
Message-ID: <adS21s5NGLIc0H3G@ryzen>
References: <1350BE53-13DB-4250-B323-7FBA335583BB@gmail.com>
 <73386b55-933f-42b3-b566-e9f4e3ea001d@kernel.org>
 <adNoXbieRl5DGbgA@ryzen>
 <F13D8AEB-E819-4322-AD3E-6AD7ECD7EBF0@gmail.com>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <F13D8AEB-E819-4322-AD3E-6AD7ECD7EBF0@gmail.com>

Hello Patrick,

On Mon, Apr 06, 2026 at 05:51:39PM +0200, Patrick Zima wrote:
> You are right, (and yes to Damien, I had AI consolidate my findings)
> I need to investigate further - my drives definitely hibernate with kernel -18 and remain sleeping only with -20 
> 
> but ...
> - the commit doesn't really seem to affect my controller ASM1164 (AHCI_HFLAG_USE_LPM_POLICY) as it seems to fire for Intel mobile chipsets only                                             
> - still, the libata.ko and libahci.ko are identical between my two kernel versions — no LPM code changed for this controller
> - I initially followed the path: link_power_management_policy reverting to keep_firmware_settings after afirst reboot after -20 kernel installed
> 
> To sum it up, my initial result, leading me to file the bug was wrong
> 
> Sorry

No need to say sorry, it sounds like you have a regression on real hardware
(which was not clear from your previous mail).

Please provide as much information as possible, so we can help you find the
root cause.

Can you please test with the latest upstream kernel? 7.0-rc7 to see if the
problem still exists there? (Your distro usually provides the config it is
using in /boot/config-*, and it makes sense to use the same config as your
distro.)


Kind regards,
Niklas
