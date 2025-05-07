Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 266E2149C64
	for <linux-ide@vger.kernel.org>; Wed,  7 May 2025 08:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746608357; cv=none; b=pGvtvvfHGmr3Krbi3n1h/2FsjGvJLHFgciTygN3CH51/1w95FJCocGwLm4vlKinIpWZ8gJ9jlGXLHOSOv2qkMxJX9uoAWmUnRqDx6Wj+9HjeMbGxbkOfYUWD9okEz31yeCT9+Q2mtcORJsWZ/rWpIh05IR0+IeGwzP5yDyeZ7J4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746608357; c=relaxed/simple;
	bh=70M0msSvAxm3yxsQ9cSAlQVy2e6S9f5elCCynLytvzw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tOM/U1a5aTGBArkzfsA4imWVDq0GrZE/kvM9SreaDcEsbJ9Jdkm1WtmRCgNPLJhPewzHYVBv4C4wJA8+r/j8lDKXwlogV6uEr3ucnsj3k5kV4et01EjhTinQTjoW8R7ceMSO/WcwDk6L3GKkE5Xe8H6QQ4LAgmOYpq3Wqca3Lm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U9NmpZri; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U9NmpZri"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89556C4CEE7;
	Wed,  7 May 2025 08:59:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746608356;
	bh=70M0msSvAxm3yxsQ9cSAlQVy2e6S9f5elCCynLytvzw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=U9NmpZriQ52FlV8OqLVOK19vTeeat8K/yl641H/EqBN0v4yGbPtILADsgWA4tHKHv
	 aIplCOqV7EWf7uneS8huXvBbCp49sfB5WQwFa7Pq0862wH2cEqWorwBVIMZOOlQqy9
	 ofGSaKe06J7P9BHWD+U4wJBWHHaI8Cog0NsYglpSMbTIHVtcyLwRB47bYS7IoonALO
	 mFbbkerro023U9NkJwsK92ndBpcq4a6n6cSq3Z+5iWeSi1ry7mL8ejTEW9YsnsvBTn
	 4dWiekpH/KrQIeJGSbv1rxLs0/DOqPJVx2tCsggp3VNgizwkdYvrz8wf6CwAJNgQbG
	 MFo//t4haLUEw==
Date: Wed, 7 May 2025 10:59:13 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: Damien Le Moal <dlemoal@kernel.org>, Ioannis Barkas <jnyb.de@gmail.com>,
	linux-ide@vger.kernel.org
Subject: Re: [PATCH v4] ata: libata: disable LPM for WDC WD20EFAX-68FB5N0
 hard drives
Message-ID: <aBsg4aKYK3lfGASx@ryzen>
References: <CADUzMVbneDW06V4vd8si8k=NN_6df3JeejaF3fVk2U=LVC1UHA@mail.gmail.com>
 <fe406980-f230-4060-9b1a-16295b6cfa48@kernel.org>
 <88a6fb5f-dc85-41e0-a65d-92704b4c8499@kernel.org>
 <CAAZ0mTeepp7G9CtLFq+U_n0h2+SF8V8j2K=0hkNAp0Fzdc7TAQ@mail.gmail.com>
 <aBjbSt5hTaUP_JhG@ryzen>
 <CAAZ0mTctoC5UCsDVH56x5OS_500URheBU66USNuq+rwktLrEiw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAZ0mTctoC5UCsDVH56x5OS_500URheBU66USNuq+rwktLrEiw@mail.gmail.com>

On Mon, May 05, 2025 at 08:09:44PM +0300, Mikko Juhani Korhonen wrote:
> ma 5.5.2025 klo 18.37 Niklas Cassel (cassel@kernel.org) kirjoitti:
> 
> > On Mon, May 05, 2025 at 10:58:22AM +0300, Mikko Juhani Korhonen wrote:
> > > > > On 5/1/25 05:36, Ioannis Barkas wrote:
> > > > >> It would be better to have more details on this since only the 2TB
> > > > >> model is targeted.
> > > I have two WD20EFAX-68FB5N0 and both behave consistently, unusable
> > > from 6.9.0 on as they just keep resetting the SATA link , but they
> > > have worked flawlessly with 6.8.x for a year and also now with the
> > > quirk applied.
> > > I have also tested a different WDC model with med_power_with_dipm on
> > > the same SATA port and there are no problems.
> > > But after you guys got suspicious I found there is in fact a SATA port
> > > on my motherboard where the WD20EFAX-68FB5N0 works with LPM on
> > This motherboard looks to be AMD chipset, so I assume AMD AHCI controller.
> >
> > Could you send the output of:
> > $ lspci -nn | grep -E "SATA|AHCI"
> 
> mjkorhon@taavi:~$ sudo lspci -nn | grep -E "SATA|AHCI"
> 01:00.1 SATA controller [0106]: Advanced Micro Devices, Inc. [AMD] 500
> Series Chipset SATA Controller [1022:43eb]


Hello Mario,

We are seeing some LPM issues with an AMD AHCI controller when using a
(fairly recent) WD drive (so I would be slightly surprised if LPM wasn't)
implemented correctly.

The AMD AHCI controller is however something that I haven't seen before:
AMD 500 Series Chipset SATA Controller [1022:43eb]

For AMD, I have mostly seen:

PCI_VDEVICE(AMD, 0x7800)
PCI_VDEVICE(AMD, 0x7801)
PCI_VDEVICE(AMD, 0x7900)
PCI_VDEVICE(AMD, 0x7901)


I have never seen any 0x43eb before.
Is this AHCI chip less common than the others?


We did add a quirk that disables LPM (when used with Samsung drives) for
ATI AHCI controllers recently:
https://lore.kernel.org/linux-ide/20250317170348.1748671-2-cassel@kernel.org/


Could perhaps this 0x43eb be a rebranded ATI AHCI controller?


If we had LPM problems with AMD 0x78XX/0x79XX AHCI controllers,
I'm quite sure that we would have seen way more bug reports by now.


Kind regards,
Niklas
