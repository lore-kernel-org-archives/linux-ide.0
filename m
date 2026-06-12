Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2325E1F5842;
	Fri, 12 Jun 2026 10:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781261937; cv=none; b=XPglIxFgczV0eTYTJOpcL7Z/1oy/QLooCbcbjNxj6e0FRw87aeNsMCIeCNpRHozIo54OzdZciReslS9R4DCFvjka83jfzLX7WyCfFyckgsqRLws5e8sFdSHrW62LpYXq53YBuTwnNSiXyMg7DUlsF+bR8Adz6TgJ07VqdYUlUks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781261937; c=relaxed/simple;
	bh=PhAhAbmVSnflVmmGtbGQG9qaN6YfwhOJeyzG4td2VqQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lhJ+YKJqb9FmDolZYDFkZcebneQbZ3AQku7RBpaBBPvjsePjI4SUsDMfFDGN4aTDc6WdpWdyv9BA3ROTxMMMuXsNP1NiBsbtaSdrR+kmPWqjs6D+8SQCaFxFnWb/IDPn/2L9TJEY21VTG94slSdxXUuHrqVMqKJvu/5eqcmYNF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OMpjNq/W; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OMpjNq/W"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 848991F000E9;
	Fri, 12 Jun 2026 10:58:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781261935;
	bh=GrWt1Bfj0yDt5RcNtfr6UctAQGbbt4VqhNH5Of4/ASo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=OMpjNq/WqmgBEHS4AGAOfYqkKaB0AgmRzNOIeyTEY/+KV+PR6nHNMKSCZckC4DAuy
	 DSQTP6ZIAZLdwvuOAE+gD9KMLjf4n7HeyZrddazrcuJCOkaF7xZKc0mYoE0x0NogxN
	 1+UuZsE9n6BX0uC21zGC1K418pEq6JNefD8/x8So/ad/M5yrz1EGAYvSWnlX79N7f3
	 j6DheCJpEw1qF+fYnvjAvJqLpX+tmOSEdDnCqwnfDn0CGH3oU78h2BT8L8GyIBPTcG
	 1ifX4mlj9KwiOOBmETXwvWKFcv8Tc3lhnd6dW6MNe3Z4Haywa7y6JTlNJ8SXPQf0Sh
	 mieXA4eFmAu7Q==
Date: Fri, 12 Jun 2026 12:58:51 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Uwe =?utf-8?Q?Kleine-K=C3=B6nig_=28The_Capable_Hub=29?= <u.kleine-koenig@baylibre.com>,
	Mikael Pettersson <mikpelinux@gmail.com>, linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] ata: Consistently define pci_device_ids using
 named initializers
Message-ID: <aivmazTaUB73ZX3n@ryzen>
References: <cover.1781248922.git.ukleinek@kernel.org>
 <bc1234d8-c202-4418-b85f-7672c667ceb1@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bc1234d8-c202-4418-b85f-7672c667ceb1@kernel.org>

On Fri, Jun 12, 2026 at 04:42:03PM +0900, Damien Le Moal wrote:
> On 6/12/26 16:35, Uwe Kleine-König (The Capable Hub) wrote:
> > Hello,
> > 
> > (implicit) v1 of this series can be found at
> > https://lore.kernel.org/linux-ide/20260430170612.510869-2-u.kleine-koenig@baylibre.com
> > 
> > Damien asked to rework the patch adding more line breaks to make the
> > resulting lines shorter. I didn't rewrap all arrays, only those that
> > appeared too long to me; the longest line I kept is:
> > 
> > +	{ PCI_VDEVICE(NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE_MCP61_SATA3), .driver_data = GENERIC },
> > 
> > which is short enough to not trigger a checkpatch warning.
> 
> Yeah. But we tend to stick with the old 80-char max lines.
> But no big deal as this was already a long line anyway.
> That said, it is a chance to rewrap that too. If you are willing to send a v3,
> we'll take it :)
> 
> Nevertheless, overall, very nice cleanup. Thanks for doing it.
> 
> For the series:
> 
> Reviewed-by: Damien Le Moal <dlemoal@wdc.com>

This email does not appear valid according to internal company (wdc.com)
address book.

I will replace it with:
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

when applying.


Kind regards,
Niklas
