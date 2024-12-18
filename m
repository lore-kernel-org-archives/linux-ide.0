Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 440CE17625C
	for <linux-ide@vger.kernel.org>; Wed, 18 Dec 2024 09:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734512645; cv=none; b=pVLKHgXxooQsQ6ePC2/tp2rFAVGskGwVO9oJRnkQku3DTnIFu0agyvlc3R94p8Zh6yb/Egjhg831UtFextwukcVkAkTP2bIhjLNDYIEBZF+rEjVIYMC+NlXnoNr1OOLG+IhN13Eha5OHkd4R8lO/7oBYtusj4y8YXt1TZHFpw3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734512645; c=relaxed/simple;
	bh=A21/Wi3Y0CStNCCJ1vUXHGXr2MUHMfIP5KM2tpw8eFw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m0NBoOoxTQgEAWkispRVECj7BTcSEdCejrFXHt/0UMNm9BuzCl0wenvKL2ic0jbSAP+HdfkXrIl+yF6t7hci35aJa+tAz6Q+05+pKKmgjxrftrntdaml1gsWMDVRlpTrSNeTW8sHdabwKf/49gpe2y7aA53kbEFuMnkmCt9Lykk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=psnQ3QqQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="psnQ3QqQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91839C4CECE;
	Wed, 18 Dec 2024 09:04:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734512644;
	bh=A21/Wi3Y0CStNCCJ1vUXHGXr2MUHMfIP5KM2tpw8eFw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=psnQ3QqQT0MO2nagUw9Vf+IS53IktM7Mc5II3L2SeuJmFgTsxiLBchZaJGNscfIAU
	 KcnDJTOJDeF9Tj1nfdGUIssbqYGvMzWdXK09PWiINSCCXg3a+94+b7YWmW6V5KYymh
	 FCLfpAFBR42L8H/Ptf6nUKV+pDshvcT8LZt9Wbd70mvo/gsBRvO3tQ+eBTLtci/wHr
	 Onje6m9oXdwyGKJYrXdfdtVlkv+vmsIsgFGvGeW3UhPPet4wS8MLF+CWnool1Wzkwz
	 NVRUT6XMPSiIVHNTNg0PJUtFPhJv401u6GLO4JW0oM8GKuR60vUHGsCS7g3rm9eU9e
	 pilFQsZi9A3YQ==
Date: Wed, 18 Dec 2024 10:04:00 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Damien Le Moal <dlemoal@kernel.org>,
	Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>, linux-ide@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] ata: sata_highbank: fix OF node reference leak in
 highbank_initialize_phys()
Message-ID: <Z2KQAPY0B0i6JJS_@ryzen>
References: <20241205103014.1625375-1-joe@pf.is.s.u-tokyo.ac.jp>
 <5d847931-218a-4bdb-b225-a5fb4a09c096@kernel.org>
 <66ceb32b-a719-420b-a79c-35b509580edd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <66ceb32b-a719-420b-a79c-35b509580edd@kernel.org>

On Tue, Dec 17, 2024 at 12:15:35PM +0100, Krzysztof Kozlowski wrote:
> On 09/12/2024 01:14, Damien Le Moal wrote:
> > On 12/5/24 19:30, Joe Hattori wrote:
> >> The OF node reference obtained by of_parse_phandle_with_args() is not
> >> released on early return. Add a of_node_put() call before returning.
> >>
> >> Fixes: 8996b89d6bc9 ("ata: add platform driver for Calxeda AHCI controller")
> >> Signed-off-by: Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>
> > 
> > Applied to for-6.13-fixes. Thanks !
> Considering that:
> 1. Few other fixes reported by this static analysis were bogus and never
> tested,
> 2. Missing of_node_put is entirely harmless, absolutely 0 effect, no
> leak of anything, nothing to worry, no-op code currently,
> 3. But a mistakenly added incorrect of_node_put is a use-after-free bug,
> 4. This was in the kernel for long time, like 12 years (!!!),
> 
> then I really do not understand how it could be a 6.13-current-rc-fixes
> material.
> 
> That's just wrong and possibly causing more harm. Really, please stop
> sending trivial static analyzer fixes for 12 year old bug to current RC.
> 
> This was brought several times, last quote:
> 
> "I'm definitely not reverting a patch from almost a decade ago as a
> regression.
> If it took that long to find, it can't be that critical of a regression.
> So yes, let's treat it as a regular bug."

For reference:
https://lore.kernel.org/lkml/CAHk-=wgFuoHpMk_Z_R3qMXVDgq0N1592+bABkyGjwwSL4zBtHA@mail.gmail.com/


Kind regards,
Niklas
