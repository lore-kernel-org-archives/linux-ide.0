Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 804142153D9
	for <linux-ide@vger.kernel.org>; Thu,  9 Jan 2025 13:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736428945; cv=none; b=NKzzn2bYTnEujKNhM0lbxb6PT/Z2Heq6Ug++DFGA01l5ZJIl4rK3bEVqaA73hOr9WbxnmoiozvS/lnQg4v+0RjVJLl01kWmofJyiUTYKrZpd031ZmdLTaTLh5DuWbMWGmohawnjUWQ1DrPDYPIWWsYUqJekeNKsy/GGGWkZ6adk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736428945; c=relaxed/simple;
	bh=D/uMih66aEJ+ZPk8RK6OwZpEU24h6A0NI7XOiVhKYoM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aKr4rSRzB6ZRm7jhU0n3j9d3Os+8d+yiDbakMSPcHEWZI1H9grz08b3dA846AUs1enhsEPJbHPBBstgVvHtLZ4evdWF6rbMTRk4qiO8Oj2hajB9UKByw/yP8KqPy9to5D8HUGYk/pwVYbt7sQYjyzxeOudriTDxpQUg9CQDwMSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ncJ50qr0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ncJ50qr0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28F72C4CED2;
	Thu,  9 Jan 2025 13:22:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736428945;
	bh=D/uMih66aEJ+ZPk8RK6OwZpEU24h6A0NI7XOiVhKYoM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ncJ50qr0E5kNIkLZn5ez1p6qdSZaLe/dNoRGONclBlSaEONYNy4J4rhI6nG8TTSPz
	 q+RBeB8EV8NB0oCGbbCeqTueQcSPKMRyhXMTXaYbrNRF3Eh6RKznuldPpmeZlm55Kx
	 v78dP8n5a7H+gcmwbF056tiAMbEf36T61XNfSVrRZNzuU41Ds7dOl0dg2e4Fu4KqXF
	 EGWGXQBDFIjOYilXJYcrZoqzIETcrkpoLMYGHXlDT8ASUd/cH8YqFT7RROWGOb3KRu
	 khMoFg0h6BelUAQUpj6ecTwBSQoqFmZ/01phbtMtLEgiyNn8Y1MBBAEapNXbjLpljK
	 /GmXQDUkUenng==
Date: Thu, 9 Jan 2025 14:22:21 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Philip Pemberton <lists@philpem.me.uk>
Cc: Hannes Reinecke <hare@suse.de>, linux-ide@vger.kernel.org
Subject: Re: Zip 100 ATAPI not working, "qc timeout" and "failed to clear
 UNIT ATTENTION"
Message-ID: <Z3_NjZyXSL9ymjIF@ryzen>
References: <c6722ee8-5e21-4169-af59-cbbae9edc02f@philpem.me.uk>
 <Z36GMwr49ihd2nAG@ryzen>
 <0d1ec6ec-1938-419d-90ff-d4faf2ebaea6@suse.de>
 <8d8be593-51c5-4029-b310-a0d9082f5eaa@philpem.me.uk>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8d8be593-51c5-4029-b310-a0d9082f5eaa@philpem.me.uk>

On Thu, Jan 09, 2025 at 11:33:11AM +0000, Philip Pemberton wrote:
> On 09/01/2025 07:17, Hannes Reinecke wrote:
> > Which makes me wonder: does the SATA-to-PATA support ATAPI? It has been
> > removed from recent ATA specifications, so there's a chance the bridge
> > simply doesn't implement it ...
> 
> It seems to -- if I use the SATA-to-PATA adapter to put the drive in the
> Knoppix PC, the Zip drive works fine.

Which SATA-to-PATA adapter are you using?


Perhaps that computer (which was running a v3.x kernel) is using a different
SATA controller/driver, which has better ATAPI support?


Do you have the:
[ 4465.218535] ata3.00: ATAPI: IOMEGA  ZIP 100       ATAPI, 12.A, max 
PIO3, CDB intr, DMADIR
[ 4465.225787] ata3.00: configured for PIO0

prints from that other PC running v3.x kernel?


E.g. DMADIR can be automatically detected, if it is needed based on the
returned data in the IDENTIFY PACKET response, see:
https://www.mail-archive.com/linux-ide@vger.kernel.org/msg16469.html
https://www.spinics.net/lists/linux-ide/msg01514.html

The DMADIR print will only be there if we send an explicit DMA direction
with each command.

It would be interesting to see if it was there on your older kernel.

Also your device seems to only indicate support for PIO3, thus we see it
being configured for PIO. Thus, it seems that you are using PIO instead
of DMA. I think that DMADIR only matters when using a DMA mode and not PIO.

Forcing DMADIR=1 when your device only supports PIO, feels wrong to me,
but perhaps I am missing something. Also, why is your device only being
configured for PIO0 when it seems to support up to PIO3 speeds? Bug?


E.g. my print when using QEMU + ATAPI:
[    0.647370] ata2: SATA max UDMA/133 abar m4096@0xfebd2000 port 0xfebd2180 irq 90 lpm-pol 0
[    0.966896] ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[    0.971060] ata2.00: ATAPI: QEMU DVD-ROM, 2.5+, max UDMA/100
[    0.971818] ata2.00: applying bridge limits
[    0.972918] ata2.00: configured for UDMA/100
shows that the device supports up to UDMA/100, and later we also see that
we configure it for that speed.



Kind regards,
Niklas
