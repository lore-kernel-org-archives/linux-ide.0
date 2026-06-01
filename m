Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AB1A3ED136;
	Mon,  1 Jun 2026 18:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780338890; cv=none; b=OfnAdByGtDxLHPPRLG2bC8m0I7HhPJ1KoEsdTqMs+G/bBOBGA1tNLo9nuBkYIZu5qdhP/1lgJvMnPc44ehHLMC5/OwZEkRxWO6S/fWaF5k1WWggdQAgfRXzQobM27vk4kLCrAzoPm1vCLTWmqr/yqSr1lcFsZE9W+hqPH17HLIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780338890; c=relaxed/simple;
	bh=z9gFbOXXZU5R0/7Sbeg1PwsHjMc/hsSgdMCyTQk+ju0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aGuNBgsyn2qqTJIHpOR0z6pKHehps2/BWe07p4J9FO3At5TR+buAnMxvDYlWsSFM961/ubffSsYzcQyvICearqoZB4tVh9ELbNqblTgrFctjUKI2nWqvplTrqALoyQ6hEI6xUBMew/NOpjKhhU1tvE7MZWLoAzN8S6ixasYxHAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YePznIpz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YePznIpz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B584F1F00893;
	Mon,  1 Jun 2026 18:34:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780338888;
	bh=1N0NDo6dqObjllGbiXpyTxMSy/Qy7HPH2WJFTFdLB04=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=YePznIpzzqTEFRrXrlZYCYl87OAMKpFox1L+2b7tfVG+Uxc1dgyyE6/sGhhKfY1rX
	 eBDVBplZTVtB0PB0MUOZU/YZ9qH0A5YWqRxdq37llHr2+wCf2Ykp+Tu97As48qMbjO
	 o8heoghTn9gkPXJvXoYTmPMxhCP8KvdnX/0EXACMQDn3JB6l5ehzYZhWHimnl0C0hg
	 xN+Zsu1FScofv5+lhL5Cgp1XFN3fwIKoubqr+9K5VzJJ5a7nbkvet2uOQbwAvvmgMx
	 5jQikn2uf4totw2Y8qvclQBF6aTs0ualkbLpaWlOMInE1I4yCiEWqHDU7xCvCA1tLO
	 zHpheSic7ro7A==
Date: Mon, 1 Jun 2026 20:34:44 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Rosen Penev <rosenp@gmail.com>
Cc: linux-ide@vger.kernel.org, Damien Le Moal <dlemoal@kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/3] ata: pata_ep93xx: COMPILE_TEST and ARM fixups
Message-ID: <ah3QxLXvWw0fXRcy@ryzen>
References: <20260530003627.42473-1-rosenp@gmail.com>
 <ah1Iv88PGkU54T65@ryzen>
 <CAKxU2N_hQu-MsHQTiCSrPvk5BB=bKnktUUvFPGBNvOsoZN+93g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKxU2N_hQu-MsHQTiCSrPvk5BB=bKnktUUvFPGBNvOsoZN+93g@mail.gmail.com>

On Mon, Jun 01, 2026 at 11:12:33AM -0700, Rosen Penev wrote:
> On Mon, Jun 1, 2026 at 1:54 AM Niklas Cassel <cassel@kernel.org> wrote:
> >
> > Hello Rosen,
> >
> > On Fri, May 29, 2026 at 05:36:24PM -0700, Rosen Penev wrote:
> > > This small series cleans up pata_ep93xx to allow COMPILE_TEST on
> > > non-ARM platforms. Patch 1 avoids including ARM-specific asm headers,
> > > patch 2 switches to unsigned long for the data variable, and patch 3
> > > enables COMPILE_TEST.
> > >
> > > Rosen Penev (3):
> > >   ata: pata_ep93xx: avoid asm on non ARM
> > >   ata: pata_ep93xx: use unsigned long for data
> > >   ata: pata_ep93xx: add COMPILE_TEST support
> > >
> > >  drivers/ata/Kconfig       | 2 +-
> > >  drivers/ata/pata_ep93xx.c | 7 ++++++-
> > >  2 files changed, 7 insertions(+), 2 deletions(-)
> >
> > Your series looks good to me.
> >
> > I do not think that you need to address the pre-existing issues reported
> > by Sashiko.
> In retrospect, it might make sense to do so such that those fixes get
> backported to stable kernels.

Oh, don't get me wrong.

If you want to fix up the pre-existing issues, we are happy to accept
patches :)

I just meant that it is not a prerequisite to get this series merged.


Kind regards,
Niklas
