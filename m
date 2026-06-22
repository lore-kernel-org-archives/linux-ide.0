Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73B3A326945
	for <linux-ide@vger.kernel.org>; Mon, 22 Jun 2026 15:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782140542; cv=none; b=TD1yuevV8kR+kZBFtNfei/gT7D1O6UzS3fTV936pFF1beTZbfr2CY2v+Q+Xn/qhQyOS5wG87bW4kdO22MATFrT0RuUgv1zHf5T1eHHENAbEBFborScWJE99Bxd020hd/HDK4lHaN0RYOgf19uJwkkV04waN+o73yGcN/PY3kpmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782140542; c=relaxed/simple;
	bh=KoNuMnYjZxo9L6sYPKq9XfiPNioLs5qyXCONHaXw5rU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ElBahMLm+sJJAYNrVXGb1Gug3CBnqj5qYpj2qZaf39uBM94JzAEv9bB6YRDmZ39IxaKd1LCVf+31A3LrDA5c5WcSHn7ugGF8+ERAANO5YIokv8j4Py3RFDSa067NoU2xwalMzSbPnHnVjMUJlFrEPSOdZXDcVobIGh5g/P0CoAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TUoGK2dc; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TUoGK2dc"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-c029505b389so935174466b.1
        for <linux-ide@vger.kernel.org>; Mon, 22 Jun 2026 08:02:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782140540; x=1782745340; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o2ItdEcHDfZg3spaR2vkHfWXupwNyd8K/n8D+nYsU+w=;
        b=TUoGK2dcXx0zrEQQQrgl5Ljtmqn1suquBhqlyshDAw4Say2hGKTcsieDmYLVFdn0FS
         F7IA2PAlFC+Eg0fvYztShVgfWsib4ZbvWlwcW82RCL+2quGenmnUIb1nsRZoquVLSVLX
         F8s9lPfy4LC8lnTOY5HXq5uwpb35TvgB0DTiQQ5t2rWcw2tjPvAyFfreJRR+et/Iziy6
         2OiQxWb3NQkx+iOoYgYjEms8Wv7CEr3O1tJGRq3X8YUktaRkkqExKobkXmjvhzJF2ods
         Nc4r3jrZcO6uu2qrfJ7M1a246+lLj4lAZVUJGkhSrRH+7sNOvK0s3MpryLthtC6lycEs
         9kkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782140540; x=1782745340;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=o2ItdEcHDfZg3spaR2vkHfWXupwNyd8K/n8D+nYsU+w=;
        b=C9BlhcPTU5IWvq7Tq/s38eH+nEHvYJpzSmoxsdN3n0dpXAr1+4QoKDDmUfMEVXEHoY
         hFrAvG+uIl4hnp9hfQahgCuYRhV6uaCzALtXS0X+SzwMFsivI8v7oXAGvb+52bvo4Dxr
         nPMpBE/ayQj0If7sHRxIouTrua4ASePesTiWaxk8RHEUHLhyBxyRl6e6TAc6/oGAP+cT
         1xkjaugQzMxjE+J7ZFDOhncNMcf4ym4FNo31YhEAlWHaA/oPZqeF7rAYvXRRuDGfRv02
         2hqfB3++NBSCG6hJPFSnhRvXxTWeb48jUWYHJmsoZtBmFBs1v0aHyzDeOfBQBGZKLXPj
         /f2g==
X-Forwarded-Encrypted: i=1; AFNElJ8t60Zv8U/ch2SG8seOOB9rH3HGP3RM10tbIDt/U/TbqCbmefp3BlA4kHgBmAuJTip5Yx9PK7P08SU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKhobvrEb0Jhe80AptBZYdOdg+7cOXTduwxhibHv/RRb8nBQMe
	EUvKdrI1THi0XEO+VTvwdH0HAJwZnkDLJPhirEtZK/CI81VyaB4tWA0y
X-Gm-Gg: AfdE7cnJ11cGk6ORkiFIHCSBxyOv3UxaRAvir+vs5AEmSf+wudOYuODWbbM0UxslZUp
	AsE2n70GXw/adHSfvjKZXf4FuvZp/qY/NmVJQgqzaCuYTBp6ZNi/Xw5wkfx/nZ1uObnR+RmI0Ih
	vhxpximHzrtnqSiBFtycfCdaUKgMB47ThWAB2zYBTFvJ4tomY6hzo8yRTOAJ9QaujcHKgT025mv
	5UG33PsgdW5ueDXsjfSIPkPl3LyefvpXb//anrHEvWh+jo5ng0xur9ELrZ6FVAoBcU+j4uiC0b/
	u2UXNvrWT9kYm0lPfNlkDz+QadXgFeJ427nH7m/XBX5AqlAHfO9OZP9BmsRUYvPl63daSbFvEoK
	9lQoDnmCPdG7KZzZNsoJ2a01Eu+VbEl2XWQof1XrojzewfCBJhnzTudLOodojeZjUkwJON/ql2v
	ixNCx3d+6B5yegUi1pLGmvP73H4CmpGCNKs47TUUuzOAKzs5oK8A==
X-Received: by 2002:a17:906:8e14:b0:c08:7c60:9069 with SMTP id a640c23a62f3a-c09ba166c64mr632036266b.32.1782140539479;
        Mon, 22 Jun 2026 08:02:19 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-46666c57afasm27559018f8f.29.2026.06.22.08.02.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2026 08:02:18 -0700 (PDT)
Date: Mon, 22 Jun 2026 16:02:15 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Niklas Cassel <cassel@kernel.org>
Cc: Damien Le Moal <dlemoal@kernel.org>, Alvin Lim <alvinwylim@gmail.com>,
 linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH] ata: ahci: force 32-bit DMA for ASMedia ASM1166
Message-ID: <20260622160215.67e6def5@pumpkin>
In-Reply-To: <ajk2WIzpNgQSJ2dh@ryzen>
References: <20260621100844.1224301-1-alvinwylim@gmail.com>
	<8c681e59-30aa-4a66-a5cd-9cccf8e338ff@kernel.org>
	<20260622140257.113f2275@pumpkin>
	<ajk2WIzpNgQSJ2dh@ryzen>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 22 Jun 2026 15:19:20 +0200
Niklas Cassel <cassel@kernel.org> wrote:

> On Mon, Jun 22, 2026 at 02:02:57PM +0100, David Laight wrote:
> > On Mon, 22 Jun 2026 20:31:54 +0900
> > Damien Le Moal <dlemoal@kernel.org> wrote:
> >   
> > > On 6/21/26 19:08, Alvin Lim wrote:  
> > > > The ASMedia ASM1166 SATA controller (1b21:1166) advertises 64-bit DMA
> > > > support (AHCI CAP.S64A), but on systems with the IOMMU enabled - where it
> > > > can be handed DMA addresses above 4 GB - it silently corrupts data in
> > > > transit. Reads return different, wrong data on each access. SMART is clean,
> > > > there are no SATA link resets and no MCE is raised, so the corruption is
> > > > invisible until it surfaces as filesystem metadata errors (XFS EUCLEAN)
> > > > or, on Ceph, mass scrub errors across multiple independent filesystems at
> > > > once - i.e. host-level, not filesystem-level.
> > > > 
> > > > This is the same failure mode already quirked for other controllers that
> > > > falsely claim working 64-bit DMA. See commit 105c42566a55 ("ata: ahci:
> > > > force 32-bit DMA for JMicron JMB582/JMB585") and commit 20730e9b2778
> > > > ("ahci: add 43-bit DMA address quirk for ASMedia ASM1061 controllers").
> > > > The ASM1166 currently maps to plain board_ahci with no DMA limit.    
> > > 
> > > Have you tried the same quirk, limiting DMA to 43-bits ? It is very likely that
> > > this adapter bug is the same as the 1061.
> > >   
> > 
> > It would also be worth checking that you get the read fails with a 44-bit mask.
> > 
> > I'd guess it also requires that you keep the controller busy for (about) 8TB
> > of reads - which is where sequential address allocation would exceed 43-bits.
> > But that is just conjecture since I've not looked at the iommu code.  
> 
> The iommu code will by default try to allocate a 32-bit IOVA by default:
> https://github.com/torvalds/linux/blob/v7.1/drivers/iommu/dma-iommu.c#L780-L799
> 
> Only once a 32-bit IOVA allocation fails, will it start using 64-bit IOVAs.
> 
> 
> It is possible to to set iommu.forcedac=1 to allocate from the full usable
> IOVA range immediately:
> https://github.com/torvalds/linux/blob/v7.1/Documentation/admin-guide/kernel-parameters.txt#L2619

Ok so SAC => Single Address Cycle and DAC => Double.
This all makes less sense than before - especially if that message
isn't being output.

That all rather implies that with the iommu enabled it is unlikely the/any
device will see DMA addresses above 4G.
(Unless you manage to have approaching 4G of active buffers.)

If changing the dma mask is causing bounce buffers be used (and there is no
reason it should when the iommu is enabled), then the difference starts
looking like a timing error.

Have you identified the type of corruption that happens for disk reads?
I'd guess typical errors are:
- Buffer not written at all.
- End of buffer incorrect.
- Buffer written with data from the wrong sector.

The PCIe write TLP associated with disk reads are relatively simple.

I learnt more that I wanted to about read TLP diagnosing a corruption
caused by an fpga implementation failing to correctly process read TLP
that generated more than one data TLP in response.
We managed to loan a PCIe analyser (very expensive, difficult to setup
and difficult to use) by suggesting to a salesman we might buy one!
and identified the problem, fortunately the bug was in logic supplied in
source form so we could fix it.
I then added logic to our fpga image so that we could trace the TLP and LSSM
state changes.

	David


> 
> 
> Kind regards,
> Niklas

