Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE825382F35
	for <linux-ide@vger.kernel.org>; Wed,  4 Mar 2026 08:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772613222; cv=none; b=IX3VByI5rztpmqVA8g3oXlis3ZNfzKYNysVxuAatTdzIa1mt87BGEhoaaMt2h4ZO4GxJSh4pfn8gWFG7npgzDCJ6lXFA4ATMDhbGajaChrHJ9yoIQ13HjYsYTeadWu4dZ35NLDM+q92BfdP9DIxqVvKRElTvcIW+LrkMeN7/aZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772613222; c=relaxed/simple;
	bh=HPh3MhgeDtEDBhzP4bfUp8Bs90Ofmv5jm+NQ6gYS6PQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YBPKI/v7OcaZjoyiHNRcVfocYxWjSPAiE6owd9Cev+NdY0pZLQpMuNJ0PFgMSjkJCj3H1zQP3S92EW5BzRrPVKxqmOUrKHbtDlztCkFbvATSeC7QKP1oewlX+6HMZteeFS9Ate2y+NPlICmERa59eKaSlSO5/N16hJ+Bjs0cSy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Uu/tDKew; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Uu/tDKew"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E64DC19423;
	Wed,  4 Mar 2026 08:33:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772613222;
	bh=HPh3MhgeDtEDBhzP4bfUp8Bs90Ofmv5jm+NQ6gYS6PQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Uu/tDKewmfz+5PYsTHyD4N5ekwWopoKjsdbY6WMTDKe68uZ2VjdrNz/F/ZmorMp7v
	 sTrmkpZlllkHdQf6pc7FxUHyXM1SEpjF760mdFSh/YR1D5GqOXGrBo12y0pfYjxiRa
	 4ZtgdTyloTEyJaFHTMmDjqJaIZbDHAvFJYDeikLpTMKSxpAXShfD+dQrgWlguIneCb
	 nsNmlZ5jkTe1fzyHLJD3VEOWukQTzSK3WhVLfGvJ3zX1Lhs3VMsvSA2iX4AqYN8wyV
	 3HqsSnC2XvnfIx8Jhfeb+ubGNpQo5Nsa4aWzp9mOsZPM8gy30qbZUdEJUP+oGb/HDJ
	 FmbOLNYofwMrw==
Date: Wed, 4 Mar 2026 09:33:39 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: maximilianpezzullo@gmail.com, linux-ide@vger.kernel.org,
	Filippo Baiamonte <filippo.ba03@bugzilla.kernel.org>
Subject: Re: [PATCH v2] ata: libata-core: Disable LPM on ST1000DM010-2EP102
Message-ID: <aafuY69V-HBjA9GE@ryzen>
References: <20260304-ata-libata-core-disable-lpm-on-st1000dm010-2ep102-v2-1-607f8e157ad2@gmail.com>
 <d46a083a-9c6e-45a5-9e52-b5d94d265411@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d46a083a-9c6e-45a5-9e52-b5d94d265411@kernel.org>

On Wed, Mar 04, 2026 at 04:29:38PM +0900, Damien Le Moal wrote:
> On 3/4/26 16:22, Maximilian Pezzullo via B4 Relay wrote:
> > From: Maximilian Pezzullo <maximilianpezzullo@gmail.com>
> > 
> > According to a user report, the ST1000DM010-2EP102 has problems with LPM,
> > causing random system freezes since kernel 6.15. The drive belongs to the
> > same BarraCuda family as the ST2000DM008-2FR102 which has the same issue.
> > 
> > Reported-by: Filippo Baiamonte <filippo.ba03@bugzilla.kernel.org>
> > Closes: https://bugzilla.kernel.org/show_bug.cgi?id=221163
> > Signed-off-by: Maximilian Pezzullo <maximilianpezzullo@gmail.com>
> 
> Beside removing the copilot related tag, no changes here. Still looks good.
> 
> Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
> 
> Niklas,
> 
> This I think needs a CC-stable. Can you add that when applying ?

CC-stable added.

Also dropped reference to 6.15, since if this drive has LPM problems the
fix should be backported as far back as possible, not only to 6.15.

We've had mobile platforms with LPM support for a very long time.
We enabled LPM for non-mobile platforms in v6.9, so to be pragmatic,
that is the Fixes tag I chose, even though in reality mobile platforms
would have seen issues with this drive even before then:
https://git.kernel.org/pub/scm/linux/kernel/git/libata/linux.git/commit/?h=libata-for-7.0-fixes


Kind regards,
Niklas
