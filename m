Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EB8A1DE4FB
	for <linux-ide@vger.kernel.org>; Tue, 20 May 2025 09:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747733608; cv=none; b=IO3tEWYzETmMxkceb+QhH9hOUxdUX+V1QJKhgrB/0QvekWw3FlyTb9s6juv/1XGuCoiE2nrpqOOK767qUj/2QCRl90Bo7geoq34PnTfF2Nfmm6reZgDeU0SJMn9e3TfJ7GbRNb4YTpAO2K6EDhqP5/GkJT5SSOL2j3gdh8FunBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747733608; c=relaxed/simple;
	bh=VVSZbeQRzCu6L6ztGsQ4eM27E5gZfPYrQrPzaDR3jJE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hZfw4yJeoO7ZD1i3xQs6KrcXf5xVuNyACoJY5BITzZYPVaaHJRKYEECHZ5yTSexet0hwbJG+61dF7heXr8/2jMLoS0YWX7MidJvK4jRR7duglJ/WbU5UIAtTLB9mbH1HrrBgpLEcdAZ9gUpxP8+PEllV0Q46Pk7sLwQc+YzK+nA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UXeqfooV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UXeqfooV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EED1AC4CEEB;
	Tue, 20 May 2025 09:33:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747733607;
	bh=VVSZbeQRzCu6L6ztGsQ4eM27E5gZfPYrQrPzaDR3jJE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UXeqfooVTQD1S5nXw2corXB+ov0Y7tcaLbCd7mc/epGc+ZBwBhOyJO5V58zCRAXQM
	 mpvBmGIUV0563FTisHuHO9zmRYWn9kmLTflnWaAjofV5TlypWRPiaIO8YMuh6PZtcJ
	 3NCaMxrxy2dCmLZqeg4CExXHSINfy+x4Zz8roM7oY6IeC0qNGUn/mKmIPfI2Xt2ZkG
	 7y70IMJH/v3N0+5Y4A6w2nEDB5i6k8EGEbj7UJHYL+SzhWmeA28Sc6+zkazZUW7jOI
	 fSqw+47wUn7U5Sa0unMuDs+KbpaMUWoIalQoj356vL97/BQx3lwqTF3SZ0h64rEHCq
	 fFIdZ1o6ceyyQ==
Date: Tue, 20 May 2025 11:33:24 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Mikko Juhani Korhonen <mjkorhon@gmail.com>
Cc: Damien Le Moal <dlemoal@kernel.org>, linux-ide@vger.kernel.org
Subject: Re: [PATCH v2 0/5] ata_eh_set_lpm() cleanups
Message-ID: <aCxMZLEr9taGR2HT@ryzen>
References: <20250515135622.720623-7-cassel@kernel.org>
 <CAAZ0mTfgYMQE2xBgmUE4Asx5X7ssth0L7AYQkLmjnT=+bG35vw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAZ0mTfgYMQE2xBgmUE4Asx5X7ssth0L7AYQkLmjnT=+bG35vw@mail.gmail.com>

On Tue, May 20, 2025 at 07:36:34AM +0300, Mikko Juhani Korhonen wrote:
> to 15.5.2025 klo 16.56 Niklas Cassel (cassel@kernel.org) kirjoitti:
> >
> > Hello all,
> >
> > I was trying to understand ata_eh_set_lpm(), and decided that
> > it needed some cleanups to make the code more understandable.
> >
> > Please have a look.
> >
> >
> > Changes since v1:
> > -Squashed patches 3 and 4 as requested by Damien.
> > -Squashed patches 6 and 7 as requested by Damien.
> > -Changed WARN_ON to WARN_ON_ONCE.
> > -Changed patch 1 to remove parts of a comment that is no longer true.
> >
> >
> > Niklas Cassel (5):
> >   ata: libata-eh: Update DIPM comments to reflect reality
> >   ata: libata-eh: Add ata_eh_set_lpm() WARN_ON_ONCE
> >   ata: libata-eh: Rename hipm and dipm variables
> >   ata: libata-eh: Rename no_dipm variable to be more clear
> >   ata: libata-eh: Keep DIPM disabled while modifying the allowed LPM
> >     states
> >
> >  drivers/ata/libata-eh.c | 39 ++++++++++++++++++++++++++-------------
> >  1 file changed, 26 insertions(+), 13 deletions(-)
> >
> > --
> > 2.49.0
> >
> 
> Hello Niklas!
> 
> just tried this patch set for the non working case of my
> sata ports 5,6 -> WDC WD20EFAX-68FB5N0
> but as was kind of expected there was not any change.

Hello Mikko,


Thank you for testing!


Yes, it was expected to not make any difference for your problem.

I'm not sure if you are able to workaround your problem by simply
using ports other than ports 5,6.

If you feel that the problem has to be addressed, then I think that
we would need to introduce a quirk for your motherboard name that
disables LPM for ports 5,6 only.


Kind regards,
Niklas
