Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B01E53B637A;
	Fri, 26 Jun 2026 11:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782473705; cv=none; b=hRo3sMDw2lCKULar3ShAcZOe0d08KMxeo8FRgL9FK3vsaSurgJOEFlw9HjOXi6h71Agd7JdHtmFFZQj0cdP83ZDevUfaaVhvnhVzeQIaLx/cnrYcPLUaTIkB6yVIGrQ8+a2RQnGYpeteHgYiMefndU6HsjisJYusiFeUXWDdW8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782473705; c=relaxed/simple;
	bh=sZyVrPZ67cQCaHuAFkBF6288AUP/SkxrVyYIC+dj5t4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lWi8dGD2BOcCeKjUtCGbO3nXBln8sm+xeROnzVOOx1lNsqm7RTxuqFYnHKeHBAjScwrCpqJTqpTq4bhyEyCXXWanFZEDm1jkfy0aVRtN8K8x/rl8PNAaR7EBE9SvVB2cJPaSnrJEMjNKN2AYchJRhTdnozOXP0gT95py5VOo/Cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BDaDQ6UJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BDaDQ6UJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C740A1F000E9;
	Fri, 26 Jun 2026 11:35:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782473704;
	bh=TGjGJ9mv1+3deqvUVD9GkukWE/to3mN64G2Kxt8BbVQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=BDaDQ6UJXIs/N2kPvHaMbsSvMD+JpfSRtRXa9hYMyeeVHf98JCiWkqeUlxDaxFrq8
	 ZyBtqBmgDMFfH87V3BUkyoiJcPJcKy+V1YhoX6M58ZQTFuQSXRdeJ12qUA0M+na30V
	 Rap+8+W31lgc12aVoJbQyXc6lhFNgkcFVHeUOs0dW1/7KW+twEpMI1Bm+jwYiomSN3
	 79lnZxNfv2ITbeViZGIDpyzUSgdAyxwyvJ8Vmz2G35R0t9xCY+L0WgoyYmG8kgD/3P
	 WrEJP3W6QiCfG4nOxuEJJMWQCIGK02BTh4E9/Gg5NRI2eGjpdNvIjWbQrySO2b8C5H
	 yRAaxQ18hv9Yg==
Date: Fri, 26 Jun 2026 13:35:00 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Myeonghun Pak <mhun512@gmail.com>, Linus Walleij <linusw@kernel.org>,
	linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
	Ijae Kim <ae878000@gmail.com>
Subject: Re: [PATCH] ata: sata_gemini: unwind clocks on IDE pinctrl errors
Message-ID: <aj5j5N2ROauxUEBF@ryzen>
References: <20260626085848.40199-1-mhun512@gmail.com>
 <d1b55e87-cc63-4851-9dc5-94ee9d326333@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d1b55e87-cc63-4851-9dc5-94ee9d326333@kernel.org>

On Fri, Jun 26, 2026 at 08:32:02PM +0900, Damien Le Moal wrote:
> On 6/26/26 17:58, Myeonghun Pak wrote:
> > gemini_sata_bridge_init() prepares and enables both SATA PCLKs, then
> > disables them again while keeping the clocks prepared for later bridge
> > start and stop operations. If gemini_setup_ide_pins() fails after that,
> > gemini_sata_probe() returns directly and skips the existing
> > out_unprep_clk unwind path.
> > 
> > Route the IDE pinctrl failure through out_unprep_clk so the clocks
> > prepared by gemini_sata_bridge_init() are unprepared before probe
> > fails.
> > 
> > Fixes: d872ced29d5f ("ata: sata_gemini: Introduce explicit IDE pin control")
> > Co-developed-by: Ijae Kim <ae878000@gmail.com>
> > Signed-off-by: Ijae Kim <ae878000@gmail.com>
> 
> One of the above 2 is redundant I think.

The tags are correct:
https://docs.kernel.org/process/submitting-patches.html#when-to-use-acked-by-cc-and-co-developed-by

"Since Co-developed-by: denotes authorship, every Co-developed-by: must be
immediately followed by a Signed-off-by: of the associated co-author."



Kind regards,
Niklas
