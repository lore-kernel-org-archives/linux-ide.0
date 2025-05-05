Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 816FF25E44D
	for <linux-ide@vger.kernel.org>; Mon,  5 May 2025 15:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746459470; cv=none; b=E7XFlmX4E2aumX3U4gGXtC9y0bJfWQr1IxvsibCyRsoLSAIJCf5uJDc9aWNdud7Tqtb663hxYqDyr8aSjqs6ZBl2Db99HGNj9uP1oEURBXtTDN2St2HYmPmzddFVp3NrX6PJmdfNbXuPWoma3jB9iPLpIyPzUaR6T71m7LMcBXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746459470; c=relaxed/simple;
	bh=YFpaVIf1Ccfqz0of51a91T92S1sB1jkKdFY0cWgThig=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IpUvETOycQhyF6jJCUjHBzh4kvpkK9DZnHFH8tSSQE53rTFSP4WsTqyXgqBsrCVhyGMA+E49oONi1gXm7KLDuFT9vpnpRfVr1DMeobw6/j0GAPwDIC5ho8koLxuNEY0eAJiZIxd9JuiFOlkMwKaVGT/ZTiwRJS3ZmzSu7zDzJ58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WHydxrW1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WHydxrW1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEEC0C4CEE4;
	Mon,  5 May 2025 15:37:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746459469;
	bh=YFpaVIf1Ccfqz0of51a91T92S1sB1jkKdFY0cWgThig=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WHydxrW1jZDxoXhgOMmbLJIl44324wge0XKSX1b7WZpuELKngkdJ03jyD4VfVAClS
	 pXX0RO+xvZtbqB7kghwA0/05wEPWhiF4yxqYIRhaRwpdoRWYUcPgKEFYaawW/7WmrR
	 35W001mz6Wpr7w6S8kaUO7krTarx3GFf1gFaTkq4tkyBYTZxdcLYoyqWZnl38325kL
	 9Ii3Qoi/ot/WmA3oAvlkQv4Q1aa4Heni1QRw4gXJnY5yC0A7TpmVNacbB8bzhp/Jcp
	 VWLiEv0EBCl0SQGu0IciknBSDI/DKNCEk/rMKtpywj8sUuHKq66B7r3SKJeOJDhRlY
	 qFmixyxIEijcg==
Date: Mon, 5 May 2025 17:37:46 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Mikko Juhani Korhonen <mjkorhon@gmail.com>
Cc: Damien Le Moal <dlemoal@kernel.org>, Ioannis Barkas <jnyb.de@gmail.com>,
	linux-ide@vger.kernel.org, Niklas Cassel <Niklas.Cassel@wdc.com>
Subject: Re: [PATCH v4] ata: libata: disable LPM for WDC WD20EFAX-68FB5N0
 hard drives
Message-ID: <aBjbSt5hTaUP_JhG@ryzen>
References: <CADUzMVbneDW06V4vd8si8k=NN_6df3JeejaF3fVk2U=LVC1UHA@mail.gmail.com>
 <fe406980-f230-4060-9b1a-16295b6cfa48@kernel.org>
 <88a6fb5f-dc85-41e0-a65d-92704b4c8499@kernel.org>
 <CAAZ0mTeepp7G9CtLFq+U_n0h2+SF8V8j2K=0hkNAp0Fzdc7TAQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAZ0mTeepp7G9CtLFq+U_n0h2+SF8V8j2K=0hkNAp0Fzdc7TAQ@mail.gmail.com>

Hello Mikko,

On Mon, May 05, 2025 at 10:58:22AM +0300, Mikko Juhani Korhonen wrote:
> > > On 5/1/25 05:36, Ioannis Barkas wrote:
> > >> It would be better to have more details on this since only the 2TB
> > >> model is targeted.
> 
> Hello guys,
> first of all thanks for helping me with git format-patch, I should
> have read instructions about not using gmail text mode. The last patch
> I sent (or not can't remember for sure) was a dot matrix printer
> driver for something like 1.1.95 :)
> 
> I have two WD20EFAX-68FB5N0 and both behave consistently, unusable
> from 6.9.0 on as they just keep resetting the SATA link , but they
> have worked flawlessly with 6.8.x for a year and also now with the
> quirk applied.
> 
> I have also tested a different WDC model with med_power_with_dipm on
> the same SATA port and there are no problems.
> 
> But after you guys got suspicious I found there is in fact a SATA port
> on my motherboard where the WD20EFAX-68FB5N0 works with LPM on. So I
> guess it's entirely possible that this is after all some kind of
> interoperating issue between a certain SATA port of a ASUS B550 F
> Gaming WiFi and the WDC, either unique to my items or in a larger
> production batch.

This motherboard looks to be AMD chipset, so I assume AMD AHCI controller.

Could you send the output of:

$ lspci -nn | grep -E "SATA|AHCI"

From your logs, it looks like you have a single AHCI controller,
so it is very surprising if LPM works by simply moving the drive to
another port (on the same controller).


Sure, AHCI does allow supporting DevSleep only on certain ports,
but AFAICT all other LPM supported bits are in the CAP register,
which is the same for all ports.

But

1) If there was a port that didn't support it, we would have seen
a "port does not support device sleep" print.

2) The prints from dmesg shows lpm-pol 3, so DevSleep is not enabled.

So the settings should be the same for all ports.


Kind regards,
Niklas
