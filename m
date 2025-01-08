Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE2B01FCF6D
	for <linux-ide@vger.kernel.org>; Wed,  8 Jan 2025 13:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736343949; cv=none; b=hqWJHLLBJYJ43N81M4gzC/SRb2762GJNqBbVppKzvcsFt9b2ErAqSzTJDzGNzXtoSbkUeX5tOvQwgRGWttTxFjCVY3fRHmCSrGETWiR0uTGESxN7hyYomRWYnef387wXo4ogaNo3iVTg30BqbppqVWxPPUPLpdWqiZt05zQvuhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736343949; c=relaxed/simple;
	bh=EOBJYT+FGDCLe7QI5pB4UZCf+/gpiWGjnI4KW+xjLeY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L9USbmudCuk1K7gWnA1MQ1O2vpVQ15DcXijLID7cm8NO/VuauAE+SVzsBFe7XMWjXk8/TvgYQvhhubHcStDlBbfFzf2BLhHTqBWyhqj8PE92+RB2rPeLJM9+NPw2Q0NE3fRyRfwghlMPSRfHTthsjj5isDgghbi9QKuMS4++xAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vFCjPYU9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vFCjPYU9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8AA2C4CEE4;
	Wed,  8 Jan 2025 13:45:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736343949;
	bh=EOBJYT+FGDCLe7QI5pB4UZCf+/gpiWGjnI4KW+xjLeY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vFCjPYU93xnWbtLScX9YC1DbvhBWiXLZ1e6/hIrBUtu3QC6QElRi6ugJhUD0CjLWb
	 0Y6PENBrXMWCwzkDJODYDP12yKhqXSaA5ytBBSrsh3S12nkwPcOIM3k23JbwVdlRk9
	 sL9wrjoBqx9sK8ml6xoO4R8/kGqiKglGgMAjdongWj+j7T0R1Mnf8Judl4yFVk+KmZ
	 8NQW5BUM92e7k3FoQw+yoNzggmlzSvYgKFa3Caect53guGLBr/ylxLqOGAXr/lOTQ0
	 LSiso6Sliz9MGObA4GGXdvNPxwqX9lGMVG+P1s4ab0iukGY+GibYmXCWnL30mwgq/d
	 XgsRqvuq1oVQQ==
Date: Wed, 8 Jan 2025 14:45:45 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Philip Pemberton <lists@philpem.me.uk>
Cc: linux-ide@vger.kernel.org
Subject: Re: Zip 100 ATAPI not working, "qc timeout" and "failed to clear
 UNIT ATTENTION"
Message-ID: <Z36BifsJRlPJIzIa@ryzen>
References: <c6722ee8-5e21-4169-af59-cbbae9edc02f@philpem.me.uk>
 <Z36AtY5oZY5vLcuJ@ryzen>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z36AtY5oZY5vLcuJ@ryzen>

On Wed, Jan 08, 2025 at 02:42:13PM +0100, Niklas Cassel wrote:
> Hello Philip,
> 
> On Wed, Jan 08, 2025 at 12:52:50PM +0000, Philip Pemberton wrote:
> > I'm trying to connect an old Iomega Zip 100 ATAPI to a B550-chipset Ryzen
> > system, to exchange files with an even older system. The Gigabyte B550 AORUS
> > ELITE AX V2 rev1.3 motherboard doesn't have any PATA ports, so I'm using a
> > SATA to PATA adapter.
> > 
> > Sadly it will not work in the B550 system (Kernel 6.8.0-51-generic x86_64,
> > Linux Mint 21.3 based on Ubuntu 22.04). When I have the Zip drive connected,
> > I get the following in dmesg and the sd device never appears:
> > 
> > ata3: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
> > ata3.00: ATAPI: IOMEGA  ZIP 100       ATAPI, 12.A, max PIO3, CDB intr,
> > DMADIR
> > ata3.00: applying bridge limits
> > ata3.00: configured for PIO0
> > ata3.00: qc timeout after 5000 msecs (cmd 0xa0)
> > ata3.00: failed to clear UNIT ATTENTION (err_mask=0x5)
> > 
> > I've included a more complete dmesg at the bottom of this message.
> > 
> > I currently have the following in the kernel command line:
> >   libata.atapi_dmadir=1
> > libata.force=3.00:atapi_dmadir,dump_id,nodmalog,noncq,pio0
> > 
> > I started with only having the DMADIR option as suggested in this old patch
> > from LKML:
> >   https://lkml.org/lkml/2013/6/18/933
> > 
> > With "atapi_dmadir=1" and DMADIR forced, I have the same messages in the
> > kernel log - except obviously none of the other "horkage" messages or the
> > ATA IDENTIFY dump, and I think the "xfer mask" starts at a higher speed.
> > 
> > 
> > The BIOS can see and access the Zip drive fine, as can Windows.
> > 
> > I've also tried the same setup (SATA bridge) in a Pentium 4 PCI+AGP machine
> > I had sitting around. Admittedly this isn't much of a test as it was running
> > a much older and 32bit OS (Knoppix 7.2, kernel 3.9.6) but the sd device
> > appeared and the drive could be accessed fine.
> 
> Did you specify anything on the kernel command line when using kernel 3.9.6 ?
> 
> FWIW, commit e771451c0a83 ("libata: make ata_exec_internal_sg honor DMADIR")
> was first included in v3.10.1, so even if you did specify it on the kernel
> command line on kernel 3.9.6, it wouldn't have any effect on internal commands
> (e.g. IDENTIFY).

I take that back... the commit did exist in 3.9.6, but with a different SHA1:

commit 27a8de81bf1a476a3df6dd548c4925aa87689c92
Author: Vincent Pelletier <plr.vincent@gmail.com>
Date:   Sat May 18 18:44:04 2013 +0200

    libata: make ata_exec_internal_sg honor DMADIR
    
    commit e771451c0a831d96a7c14b0ca8a8ec671d98567b upstream.


Kind regards,
Niklas
