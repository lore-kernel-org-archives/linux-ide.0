Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59CA02BFC8F
	for <linux-ide@vger.kernel.org>; Sun, 14 Dec 2025 22:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765753170; cv=none; b=Yq5mvr5jXGP0eG+6LRXj+mnvJkPlmPLobo/4DA8Bls02JocHBa6MWN+xO2wG8J7hLA1EtGP8x2CjRJhrrxsV+M0WcBylQ/saSrFk3v1zQt8RhZFheJGPWzrMkGU/npbsbPbrzYCe+3gTM1KXiw6koJ3F/5pnt47oFGkoFtUnK1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765753170; c=relaxed/simple;
	bh=kHxCWagRmwBlvQFsd474yzwKmMi6H/wIgp3Fyu5zlB8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i96QoWC+uuWRc7oMA+V4lh3m0DXfatEKALGbXf6NPPpSLUDIsrYxqMAl8OvjT4cLYQpzrAKDYLPBpHQgf/o13xmYAy7mRWPirrP6oC8tuqKUh/P6FjM53sBqeCytqE5C+ehgomHEikZake61CBzSwsm4CkuBgXtXvbYzwjgnoR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
Received: from doudna.orbis-terrarum.net (doudna.orbis-terrarum.net [135.181.113.253])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: relay-lists.gentoo.org@gentoo.org)
	by smtp.gentoo.org (Postfix) with ESMTPSA id 9C202335D7F;
	Sun, 14 Dec 2025 22:59:28 +0000 (UTC)
Received: by doudna.orbis-terrarum.net (Postfix, from userid 10000)
	id 4dTzCd0Hn2zB6WN; Sun, 14 Dec 2025 22:59:24 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.10.3 doudna.orbis-terrarum.net 4dTzCd0Hn2zB6WN
Authentication-Results: OpenDKIM@doudna/4dTzCd0Hn2zB6WN; dkim=none;
	dkim-atps=neutral
Date: Sun, 14 Dec 2025 14:59:24 -0800
From: "Robin H. Johnson" <robbat2@gentoo.org>
To: Niklas Cassel <cassel@kernel.org>, linux-ide@vger.kernel.org
Cc: =?utf-8?B?UmVuw6k=?= Rebe <rene@exactco.de>, 
	Damien Le Moal <dlemoal@kernel.org>
Subject: Re: [PATCH V2] ata: pata_pcmcia: Add Iomega Clik! PCMCIA ATA/ATAPI
 Adapter
Message-ID: <robbat2-20251214T225827-228528801Z@orbis-terrarum.net>
References: <20251118.174654.1384716262322584447.rene@exactco.de>
 <aRzSMYp-i4RDYl-l@ryzen>
 <87550962-6A64-4F07-AD72-001D85824B83@exactco.de>
 <aRzdh6Q8xuu6OL7G@ryzen>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aRzdh6Q8xuu6OL7G@ryzen>

On Tue, Nov 18, 2025 at 09:56:39PM +0100, Niklas Cassel wrote:
> > >> +	PCMCIA_DEVICE_PROD_ID2("PCMCIA ATA/ATAPI Adapter", 0x888d7b73),
> > > Don't we want Iomega somewhere in the name here?
> > IIRC this string came out of some pcmcia tool. I thought it came out of the device.
> > Is it not used for matching or should match what comes out of the device IDENTIFY
> > or so command?
> 
> Looking at drivers/pcmcia/ds.c, you are right,
> the string is used for matching.
> 
> So we are stuck with this quite generic name :)
Generic name for the matching - but what about adding a comment that
describes where the ID & String come from as "Iomega Clik!"?

-- 
Robin Hugh Johnson (they/he)
Gentoo Linux: Dev, Infra Lead, Foundation Treasurer
E-Mail   : robbat2@gentoo.org
GnuPG FP : 11ACBA4F 4778E3F6 E4EDF38E B27B944E 34884E85
GnuPG FP : 7D0B3CEB E9B85B1F 825BCECF EE05E6F6 A48F6136
