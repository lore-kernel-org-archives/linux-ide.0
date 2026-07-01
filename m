Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2C17347FC4;
	Wed,  1 Jul 2026 23:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782950182; cv=none; b=Z0EgD5D+loIHI7T+h7YSp56j5tDmy/ewLrf7spi8P7Vu3vjCDPY0IAy9EVTe5a234LAEqwvPCRge5uMsp2FKOWN0jGsk17GyGLIVabllo5IRGfzgHcb7T3bVhMamZXwU1nxJwqsAybh0eDEro9PngvzkK9RNKSzB2l5YFNDmOKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782950182; c=relaxed/simple;
	bh=WevDxpmpafwpa1bxcBI4ZvMQYuDiVUfIuN+wjsReXsE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NCq3BoSzUPMJF7nEwBm8k3Y0tsMHCeWwD6WVQVGOy6Rm9EHr4RC4FeMPQv0kTahzcWuwetIy6zIIMsyZVNo6Yj7UcNG6PDYVikLnR2eFoKUx+dFGM/WRZMQV/rkdCcUWI0PamNJuIFce1FiL3rA2qR29F18H8dIo+yO3y2us74s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=khOS1UBP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="khOS1UBP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 612A21F000E9;
	Wed,  1 Jul 2026 23:56:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782950181;
	bh=iganZLzbkHu3MIFKmTwqm8/b9ca1be2Zt4iNREPVULE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=khOS1UBPTCB//T2kq74VVUCZNdLs3I+LcMYLq6yCLScJ2eq4vcIPtGAdoloaaIrgR
	 unDVItFHP8pv3/7wj/WTd6odiihQr9psCGPdaMhjslLmMHnHoMmTKozALnJkFe1eMl
	 1WeGCjSOio3dXGb0/jqjR1mwbWqBgD31IceA43C05djDKdu4hPAyt09+cIgbeur1pI
	 aUb9A2n456tIwJChTc+bhDFctsB0RTnO8jxUKuAHcTdKVivmMzc6jcrMzx7N85Ger8
	 +e/6OlUV6AmQgNHmww2vNEDUUNnEFMtTt0ZBSwQPyoT9t0U/NdZH7o3czJ/20dcZzD
	 VXhoDz+NUbbCQ==
Date: Thu, 2 Jul 2026 01:56:18 +0200
From: Niklas Cassel <cassel@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: linux-ide@vger.kernel.org, dlemoal@kernel.org,
	Shaun Tancheff <shaun@tancheff.com>
Subject: Re: [PATCH 2/2] ata: libata-scsi: scale DSM TRIM payload by MAX
 PAGES PER DSM COMMAND
Message-ID: <akWpIuetYHwwOEqC@ryzen>
References: <20260701224638.1835123-4-cassel@kernel.org>
 <20260701224638.1835123-6-cassel@kernel.org>
 <20260701225804.0DFA01F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260701225804.0DFA01F000E9@smtp.kernel.org>

On Wed, Jul 01, 2026 at 10:58:03PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> - [High] ATA DATA SET MANAGEMENT (TRIM) commands will fail on 4Kn devices that do not report a maximum DSM page limit, because the code defaults to sending up to 8 pages instead of the specification-mandated safe minimum of 1.
> - [Medium] 32-bit integer overflow in the DSM TRIM maximum blocks calculation artificially clamps the block layer discard limit, causing performance regressions.
> --
> 
> commit a387741dfad7fa23a80a62ebd7e1d57854a6d80e
> Author: Niklas Cassel <cassel@kernel.org>
> 
> ata: libata-scsi: scale DSM TRIM payload by MAX PAGES PER DSM COMMAND
> 
> This commit updates the DSM TRIM command translation to scale the payload
> size based on the MAX PAGES PER DSM COMMAND reported by the device. It
> sizes the TRIM descriptor as a whole number of 512-byte pages, capped
> by both the device limit and the logical sector size.
> 
> > diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
> > --- a/drivers/ata/libata-scsi.c
> > +++ b/drivers/ata/libata-scsi.c
> > @@ -2198,6 +2198,36 @@ static unsigned int ata_scsiop_inq_89(struct ata_device *dev,
> 
> [ ... ]
> 
> > +static unsigned int ata_dsm_trim_pages(struct ata_device *dev)
> > +{
> > +	unsigned int sector_size = ata_id_logical_sector_size(dev->id);
> > +	unsigned int max_pages = ata_id_dsm_max_pages(dev->id);
> > +	unsigned int pages = sector_size / ATA_SECT_SIZE;
> > +
> > +	if (max_pages)
> > +		pages = min(pages, max_pages);
> > +
> > +	return pages;
> > +}
> 
> [Severity: High]
> For 4Kn devices that report 0 for the maximum DSM limit (word 105), this
> defaults to sending up to 8 pages (4096 / 512). Does this exceed the ATA
> specification's guaranteed safe minimum of 1 page, potentially causing the
> device to reject the command with an I/O error?

Well, from the spec:
"A value of 0000_0000h indicates that the maximum number of 512-byte blocks of LBA
Range Entries is not specified."

So will it be safe to send more than one 512-byte block?

We could cap it to one 512-byte block for devices that report a zero in
the MAX PAGES PER DSM COMMAND field, that is probably the safest, as we
have no idea to know the actual limit if the device does not report it.

(Note that the previous commit that claimed to add support for 4Kn
devices completely ignored the MAX PAGES PER DSM COMMAND field.)


> 
> > @@ -2237,7 +2267,8 @@ static unsigned int ata_scsiop_inq_b0(struct ata_device *dev,
> >  	 * with the unmap bit set.
> >  	 */
> >  	if (ata_id_has_trim(dev->id)) {
> > -		u64 max_blocks = 65535 * ATA_MAX_TRIM_RNUM;
> > +		unsigned int max_pages = ata_dsm_trim_pages(dev);
> > +		u64 max_blocks = U16_MAX * max_pages * ATA_MAX_TRIM_RNUM;
> 
> [Severity: Medium]
> When calculating max_blocks in ata_scsiop_inq_b0(), the multiplication involves
> a 32-bit unsigned int (U16_MAX * max_pages * 64). If max_pages is greater
> than 1024, can this expression overflow a 32-bit integer before being
> zero-extended and assigned to the 64-bit max_blocks? This might artificially
> truncate the block layer discard limit for devices supporting large TRIMs.

Sure, can cast one of them to u64 to make sure that 64-bit arithmetic will be
used.


Kind regards,
Niklas
