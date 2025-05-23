Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6104145B27
	for <linux-ide@vger.kernel.org>; Fri, 23 May 2025 14:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748009123; cv=none; b=P5TKNQ1F2YX+mH1f0A7dIFMhrcSmEHAcvT1rmvi5qt7jfjTpUYQYifnPXOML05srp9UJwq7rsur28CX/4tvL/PdIubmyX97qTIsrr//YLkTQaBfa6prQ7NW5XHm6V43DSOr2stHVy0FpNXLxWm+L+GcSIJ8167G0MrfFDIKGY00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748009123; c=relaxed/simple;
	bh=wOWmrsSb86wNlQzROKuigvM52BtFcZJCie/q/B1W2MI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fq1tMYb6L9Twjkmvu94SgGQZU2SXoXzNvDj8HL+qpmhgaqCXD8TLzzRwQ+8CaqDVZDSgIVMIMqKcinrBJh5HG9PoC06zpTpru2fkhrD+bVQMYxOg6lZ90JbmFkGP3jnC6jFg2ovZuoaU6Tda9osgZUqdowTmWGjL1BfGs7sWQWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PPe+GeLw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PPe+GeLw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FD24C4CEE9;
	Fri, 23 May 2025 14:05:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748009123;
	bh=wOWmrsSb86wNlQzROKuigvM52BtFcZJCie/q/B1W2MI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PPe+GeLwpg77wBrcSKOrp4cPs8goEm0wDePsOSixMi7tfT4cSMnsIUI1KR6knVeLf
	 Vp1aTkEwtETyiBnjC/9bxrYYtcibf1zwv71cKgawi4WElxkbguAUxAmNqnJ27X9rB/
	 fTD1BxaqmdQfSRinkfANTDV1ALk5WjGWopzypzpSVOD8r1sqwjDEBAOZQg5f09PCAV
	 ta0FLV9vr5JKvHNvYp1M2mUUiqDKzdVSXkXmZOScrv2chAkRVe8qrYmk1/xwUAp8mV
	 Lrr0nMmQYNXi/Ede+hZrev8dF8dZrTK8aQYvRpeRNYtaiNc9N/giFFtnEYhXpYLbs1
	 Ns/TC+40kfroQ==
Date: Fri, 23 May 2025 16:05:19 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Mikko Juhani Korhonen <mjkorhon@gmail.com>
Cc: Damien Le Moal <dlemoal@kernel.org>, Ioannis Barkas <jnyb.de@gmail.com>,
	linux-ide@vger.kernel.org
Subject: Re: [PATCH v4] ata: libata: disable LPM for WDC WD20EFAX-68FB5N0
 hard drives
Message-ID: <aDCAn4PVlicQXuhi@ryzen>
References: <98E34F63-CCAE-48C4-9584-9053C3D1A7FD@kernel.org>
 <CAAZ0mTdcAazi=133Dz0+OgSGOERe7WmCTr27ePudEVhkJj6VbA@mail.gmail.com>
 <48F49924-F5FE-4A91-8323-E2C789D1BEFB@kernel.org>
 <CAAZ0mTdtOVSidMeC76X9oZyHCtJdgyiu44+UEKqP5tSUaD9ZsQ@mail.gmail.com>
 <aCG-gS2f3uXKaQPj@ryzen>
 <CAAZ0mTfqE+w8BBCyVSg0KKQ6fYZwKaqvh_ND8dLCANg-oMaphA@mail.gmail.com>
 <aCHZg4tj6YwS9vph@ryzen>
 <CAAZ0mTeiVqZQvkWzJ8aFH4FUPCZwy5O+9hPBgDPhSgNNz+t6HA@mail.gmail.com>
 <aCTZkV5mRjDsYyeE@ryzen>
 <CAAZ0mTdZEd6n+tDvqbqzMQS2W+3efpYOeHupYcj3rDSVeuHFBA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAZ0mTdZEd6n+tDvqbqzMQS2W+3efpYOeHupYcj3rDSVeuHFBA@mail.gmail.com>

Mikko,

On Fri, May 23, 2025 at 04:27:23PM +0300, Mikko Juhani Korhonen wrote:
> > I would add some debug prints around:
> >
> > https://github.com/torvalds/linux/blob/v6.15-rc6/drivers/ata/libata-eh.c#L3512-L3520
> >
> > To
> > 1) Make sure that we actually send down the SET FEATURES command for
> > to the drive.
> >
> > 2) Check the return code (err_mask). This code looks a bit sketchy,
> > if (err_mask && err_mask != AC_ERR_DEV) {
> >
> > It seems that if err_mask == AC_ERR_DEV, the error would get silently
> > discarded...
> 
> 
> Hello Niklas,
> I did add debug print here and checked that at least there is no silently
> ignored errors here, err_mask is zero even for my problem case
> sata ports 5,6 -> WDC WD20EFAX-68FB5N0
> and also for some others I tested.

Thanks a lot for testing!


Kind regards,
Niklas
