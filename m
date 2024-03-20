Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90FB18564F
	for <linux-ide@vger.kernel.org>; Wed, 20 Mar 2024 19:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710963353; cv=none; b=i89UIWCrtln5O6LH3MXmWZBjoIzM0QrMMS9ODN9u7QE/y0VtNykE4dcwlVyng2W5q2EWGSuN67mvFOq+U44wnaVrd6Omhh+htHcVvdtHtyaPGk4TFjT2RfiEQegUvpvJTN8lttvztjQpu74QA7TPtFFmHCYJD5I7N9gQroHvLtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710963353; c=relaxed/simple;
	bh=NcLf08k6VGnmwzm369I3UVj+8pZ9CShbrgOVWDPyyXA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tveKC7rT2pKfTkCW6JlVzG9l5b/z85x3QTrHgnGAg7U0l0WLuzr1639aLxfaTznOMrizLq6hBTzLnkBFVk2DcRmcEqSGLeocmdq4OkOOSizY8hFGQsfIPYzWtj6/8fYitRaPVrVrK1my3cTWRozU3FftNSmBoBPOjYk7msjAhns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=N+tGtNVY; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="N+tGtNVY"
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-dd10ebcd702so144836276.2
        for <linux-ide@vger.kernel.org>; Wed, 20 Mar 2024 12:35:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1710963350; x=1711568150; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=NcLf08k6VGnmwzm369I3UVj+8pZ9CShbrgOVWDPyyXA=;
        b=N+tGtNVYYYmYuG+UWayLgqGXaYPeSqLeaQ/moHFTNhRb0eSiRl2gaTZgAeOlB0ntsf
         IKEmGZ3/R6o7Y6D608gaAV5P7ZKEHpcM2NBowo8oxDR7Ua3FVDEPOfS+tn9Z4IFkIwoz
         XPd7pFgqtu+dWLqFnqaUVJk1pl2ZryJAdQ25FL/wNZ4FsF/07ob1K+zm9mVCc08ogP+D
         mNbAv724z2x1iK/8pd2JNU9RUGdTlFjExPmyvNOzrK6WnVHv1EXz0zO5plLwKYIlP+NT
         eslTsFF5lQbEBHRsStQuFvtV/P0UKWlEm6ABesoYzySmvMZ7BQpXRXfxus2UKApzsXy3
         DXYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710963350; x=1711568150;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NcLf08k6VGnmwzm369I3UVj+8pZ9CShbrgOVWDPyyXA=;
        b=Kqqoe446PE+7R61FX3BkqbxqEn0WwMgBgakBG1vRs3fMfMURs4NdQiP3S2mMNFhlYS
         gjX2M2flWa5Jq+83OxYW3E4TTENcxzLNwiDI9A5vh+s1fOrLe4Q8goKwqY8O3uu4Uw73
         ja5DmUbMfLwkeqVdAdFTb681W3Vt5yZ9vv+hvez2KU6lnaTRVlua+mI8g12JztBIfPTp
         l6bhRRnLsW+FvubnEPXHLuYBmlbReyN7eZOjDLgqkSGVs3Exk6NElvPZJr+7qeADronQ
         p5yz8+kYJTvi2S4nLUS8yprKXEqG++zi7oN7/q+t4LGXTs9sdgxIVCEVf2y6qpQvyudq
         X99w==
X-Forwarded-Encrypted: i=1; AJvYcCW01oNSdl79kbqIyy+IABhro9qF195WqHw6qHp2rUkJMbI/SMASbhw9MuRcpKGr7nUdoycPAFv7oCQsOpP2gMLJW/DA1x7GVyt2
X-Gm-Message-State: AOJu0YxGs76wVUZQtdUyiMqcD9bzWY0ZqOOx8tg76natR0KLfgWSHnPX
	6rMrjoH0kKQg47fPVRIkSfstt16xfZ4gCXh2PpE2UO+OEaszuhrawW2s6KyV6GGFoetFG8yNZ0t
	zhh2md43sjYQmj4Dl87PhcrldQuo=
X-Google-Smtp-Source: AGHT+IHtqnsSPCnABXnqXPdk+AxmLHKg70KQ9FWHMmTBUgMWgeX/65e5/2weCYMNdlxVzQhbm0setvOjonr/HD06Ob8=
X-Received: by 2002:a25:ac50:0:b0:dcb:b41c:77ef with SMTP id
 r16-20020a25ac50000000b00dcbb41c77efmr2530453ybd.24.1710963350381; Wed, 20
 Mar 2024 12:35:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240319091322.10909-1-Chloe_Chen@asmedia.com.tw> <ZflnYu5W5WnnzDio@ryzen>
In-Reply-To: <ZflnYu5W5WnnzDio@ryzen>
From: Cryptearth <cryptearth@googlemail.com>
Date: Wed, 20 Mar 2024 20:35:39 +0100
Message-ID: <CAFDm6W3Q0u-uQ=EiOs4N5goi5-He7brRKK5xV3Jz9Z47NV--UQ@mail.gmail.com>
Subject: Re: ASMedia PMP inquiry
To: Niklas Cassel <cassel@kernel.org>
Cc: Szuying Chen <chensiying21@gmail.com>, dlemoal@kernel.org, linux-ide@vger.kernel.org, 
	Jesse1_Chang@asmedia.com.tw, Richard_Hsu@asmedia.com.tw, 
	Chloe_Chen@asmedia.com.tw, conikost@gentoo.org, temnota.am@gmail.com, 
	hdegoede@redhat.com, jnyb.de@gmail.com
Content-Type: text/plain; charset="UTF-8"

>
> Hello Chloe,
>
> On Tue, Mar 19, 2024 at 05:13:22PM +0800, Szuying Chen wrote:
> > Signed-off-by: Szuying Chen <Chloe_Chen@asmedia.com.tw>
> > ---
> >
> > On 3/18/24 19:32, Niklas Cassel wrote:
> > > A user plugging in an external PMP (so not a PMP embedded on the PCIe card).
> > > We need to be able to read the PMP device and vendor ID, in order to apply
> > > the correct PMP quirks, see sata_pmp_quirks(). So trying to hide which PMP
> > > that is connected is bad, not only because it violates the specs, but also
> > > because it stops us from providing the proper quirks for the connected PMP.
> > >
> > > Could you please tell us how we can communicate with the PMPs directly?
> > > (Regardless if they are external PMPs or PMPs embedded on the PCIe card.)
> > >
> > Hello Niklas,
> >
> > Unfortunately, our design does not provide interface to communicate with
> > the PMPs directly.
> > When ASM1064 plugging in an external PMP, we will hide the PMP and map to
> > the virtual port to run.
>
> Thank you for your reply!
>
> If you have any idea on how those users with a ASM1064 card that does not
> have any PMPs on the PCIe cards, e.g. Delock 90073, can avoid the extra
> 2-3 minutes delay during boot, we are open to suggestions.
>
> I guess you could send a new firmware to Delock that sets the PI register
> (Ports Implemented) register to 0xf.
>
> However, from what I've understood from how you have decided to implement
> PMP support on your HBAs, I assume that setting the PI register to 0xf
> would also stop Delock 90073 from working with an externally connected
> port multiplier, so that it probably not a good approach after all.
>
>
> Kind regards,
> Niklas

So, I guess the current conclusion is that there's no optimal solution
due to hardware not following the standards?
I also thought about the option to use override parameters like
setting the port mask. But then I also thought about: How to handle a
system with different HBAs?
Like a system using one card with a pci-e multiplexer but also a card
like mine with port multipliers. The result would be either the
current behaviour - all ports working but long timeouts - or like with
the change - no timeouts but not all ports working.
An optimal solution would requite a per-HBA setting. To keep a
consistent order the address path could be used, like "the first HBA
is on pci-e_3, the second on pci-e_5". It would still be up to the
user to correctly identify the correct ports and set up a working
kernel command but at least it would be an option for mixed systems to
set parameters per controller instead of applying the same setting
global.

I searched for both host controllers as well as port multipliers.
Although most solutions end up with controllers from ASMedia, JMicron
or even SLI there seem also way more lesser known chips out there.
I also searched for more details around all that topic - and was able
to find older forum threads from 2008 to 2013. So this seem to already
going on for several years (hence I not really understood the initial
report about the long boot timeout as I thought "well, people deal
with it for over a decade now").

Aside from the revert is in my favour I also see that there're some
deeper issues that either have to be ignored potentially breaking
hardware, tried to worked around with (would a separate driver be
possible?) or to get in contact with major controller manufactures to
get them to come up with changes for newer chips/firmware - this way
at least new hardware can have a chance to work out of the box by
following the standards.

Quite a complicated topic.

Matt
