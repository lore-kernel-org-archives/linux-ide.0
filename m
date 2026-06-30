Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0225B3C09F4;
	Tue, 30 Jun 2026 09:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782813360; cv=none; b=OgxmAYI9ZTjGFe5YPiQCDkeKFMkgd6jM8LG1cIZlvGh4Alhzn1AyCxMF1nPfq1E7OE2WPLU5W63Lp7MYX+LHuVbt/hfcKO61aQ3utdcn3S/CArRp6F4D6AzeMs8YimtA/aWTJCjosIACr+Y/KE4ibwYkyUsgKyEmRbn8DLGJlAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782813360; c=relaxed/simple;
	bh=Sz7hho/kU1h2AfpIxOBT/4p4P6sF0W1KHp6+0qHX0/c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G53XuQiHjObRsE8VWTroXP4OV3pIgSFTWo7/VjhPiJyYVUFWzJzOLO7GkGQaKHMWSjJHOMByDCaPXxY6vjAJSqFf7OB5+A1gO+3afQObKtqGbEB4KFghPj8M3BJGHK/Kx2gT7hCp+FmEdMVUVXhDwguBMKcdSbnubNlnOMTNNpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GKqIW+og; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GKqIW+og"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB66E1F000E9;
	Tue, 30 Jun 2026 09:55:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782813359;
	bh=JZ0/ekMBuwVFkwXV66QJO+UZ67wdSd4Z15SXZWnvMVY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=GKqIW+ogdG17disS7GU06YVOgBkiuT52esFjt6viyPve1NH4AvVoXJtpjxfd2CONS
	 QK/6v8PMmHminmSH2LJUmIhjn2fvDZ36V+sJmJr063P40aPbsE4tsWVposyJ4OgvfI
	 VOvuIV+7RRrg6Twlbx6zsYLkxsavBGRDurlJZZkTZNBoIIkhnYUD6Vd5ZnGesBgDdl
	 wT69TLjeRXZPcwqBMZ265Bk04RCHCL5nfwvv6M/47yozGeFyPhUi8dLDqJ8YPAcy3u
	 26axCk27J4jCAsAagoSKrD2WlpgpY9hA8WgbHjZ7QgP2uAOQJIw4gR2iKWzl+Z+Nv2
	 7raGW9FD9yHkQ==
Date: Tue, 30 Jun 2026 11:55:56 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Rosen Penev <rosenp@gmail.com>, linux-ide@vger.kernel.org,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ata: sata_dwc_460ex: use platform_get_irq()
Message-ID: <akOSrMbpFIO_VLul@ryzen>
References: <20260628230310.1214770-1-rosenp@gmail.com>
 <akNzEGgiYC5V3rtc@ryzen>
 <9327f32a-5037-477c-80dc-f99b97ed9740@kernel.org>
 <DF85BCA7-B344-4AD6-8F6B-22CB3A3DF823@kernel.org>
 <CAKxU2N8uWY3k3nHTmdxEn86zEZ_hGJgyPvHWuHt=zRaPk-29kg@mail.gmail.com>
 <CAKxU2N_2N0YWBrF1k82qXCYYyvZxa26GYi09xiyKbBAtUoC_mA@mail.gmail.com>
 <743a2748-a458-4e65-a1d2-f54a6657e7a6@kernel.org>
 <akOHEDdu3zw9Uhph@ryzen>
 <2865750f-9bab-47d8-b4c9-9cf1cbef7834@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2865750f-9bab-47d8-b4c9-9cf1cbef7834@kernel.org>

On Tue, Jun 30, 2026 at 06:22:52PM +0900, Damien Le Moal wrote:
> On 6/30/26 18:06, Niklas Cassel wrote:
> > On Tue, Jun 30, 2026 at 06:00:46PM +0900, Damien Le Moal wrote:
> >> On 6/30/26 17:52, Rosen Penev wrote:
> >>>>> Inside ifdef, that is probably why Sashiko did not catch this new warning.
> >>>>>
> >>>>> Rosen, I suggest that you use dev->of_node directly within the ifdef, and drop the local np variable.
> >>>> device_property_present is probably better. But yeah. I'll whip up a v2.
> >>> thinking about this some more. Should use IS_ENABLED to prevent hiding
> >>> this code from the compiler.
> >>
> >> What code are you talking about ?
> >> What is in the #ifdef CONFIG_SATA_DWC_OLD_DMA ?
> >> CONFIG_SATA_DWC_OLD_DMA is determined automatically by Kconfig. So this is not
> >> hidding anything and why I did not see the warning in my compile tests
> >> (CONFIG_SATA_DWC_OLD_DMA was enabled for me). The report was for Sparc, and
> >> CONFIG_SATA_DWC_OLD_DMA was disabled so the unused variable warning showed up.
> > 
> > I think he means: keep the local np variable,
> > and replace the #ifdef with
> > if (IS_ENABLED(CONFIG_SATA_DWC_OLD_DMA) && !of_property_present(np, "dmas")) {
> > 
> > 
> > I think it will work for both CONFIG_SATA_DWC_OLD_DMA=y and
> > CONFIG_SATA_DWC_OLD_DMA=n without giving any warnings.
> 
> I do not think it will. The if() will be compiled out if IS_ENABLED() is false,
> but the variable declaration will remain and so will the warning. Unless that
> declaration also goes away, IS_ENABLED() will not solve the issue. But if the
> variable is removed, I gree is is a lot cleaner !

The point of using IS_ENABLED, is that the compiler will see the code
(that is what Rosen meant), and the code that is not used will be
eliminated using dead code elimination from the compiler.

The statement:
if (0 && !of_property_present(np, "dmas")) {

Will not make the compiler consider np as unused.


I even verified it using:

if (IS_ENABLED(CONFIG_SATA_DWC_OLD_DMA) && !of_property_present(np, "dmas")) {

and if did not give my any warning when CONFIG_SATA_DWC_OLD_DMA=n.

However, I had to comment out the call to sata_dwc_dma_init_old()
since sata_dwc_dma_init_old() is only defined inside #ifdef...

Sure, we could create a dummy / stub for that function, but to be honest,
I think my earlier suggestion of just using dev->of_node directly within
the ifdef, and drop the local np variable would be the smallest change.


Kind regards,
Niklas
