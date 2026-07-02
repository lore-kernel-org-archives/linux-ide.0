Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 121253C0A04;
	Thu,  2 Jul 2026 10:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782989535; cv=none; b=sthzx3ZE2r0kRif5ivHA5Tv6qQKlOV/VREP0srw+fXaXAaPO6mtyZFzXrnxoVwcjbZckpn44RqER0sNAUNTwhNApJgZsD7LSsSs6APmFHT6gFNX7r7JlSSOG6Yy+VpTWAvFE0IuoZp+bpkaNrZycPh40UwcKkQa4qDQVIiDiF2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782989535; c=relaxed/simple;
	bh=ShcVgI1Os/oDemJHF2nrjmRcOCyi8GjpBx9sQPj47A0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IS3h/kmaS7TJogf8TGRX/VA6NTx6k12wmriq2ulkSdDS4Ga4pK7ympULkHCGnsnK9eEeUL1khVb9zYC4N3yo9eCoRsfZJ2Z4RjoJBM/pCzEvioZZGxUHePGLrxOBxz7bKyHgXLl6SG+6oqPXoTwZHrWK5GeniK4M0vEOLxNrIUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G2GejuUC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G2GejuUC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDB661F000E9;
	Thu,  2 Jul 2026 10:52:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782989533;
	bh=LEWfYVVlcSywUi5oBH/+a3pGIKZoJBxUKL2OZtwm6gU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=G2GejuUC9koEkTdmgoDSOaUAmZboK2VLeDMk6cdRa2zq/mXSZ8DPVBEUaoZGz9+e3
	 Db14LoYDmphE3INB57Xi8HPcMaHCCoMf+Q9rYytqNgBjyYYNwwDOsZJnoUBC6ca1JT
	 S7UWEJ0W3Ji6ONlTc4KIk6gqloZJaIxg3hNP6dqEYrXNh47MJ7mMoAkcTzpJk/jZDD
	 anrgaK0pY8TofERVKSwLp8MctDDaF9qKbsSbfqrSEl6cPuAT9q60+ewlRL4Uxxim7i
	 kDrADM6LerMMDg6TsbEZXVWnicGJCp7H27J4U+RFTGNnW1G7N4ZyuSQa/OfbxZbesj
	 u9wgRO7WB42LQ==
Date: Thu, 2 Jul 2026 12:52:10 +0200
From: Niklas Cassel <cassel@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: dlemoal@kernel.org, linux-ide@vger.kernel.org,
	Shaun Tancheff <shaun@tancheff.com>
Subject: Re: [PATCH v2 2/2] ata: libata-scsi: scale DSM TRIM payload by MAX
 PAGES PER DSM COMMAND
Message-ID: <akZC2lsthFlhyR41@ryzen>
References: <20260702100410.2039383-4-cassel@kernel.org>
 <20260702100410.2039383-6-cassel@kernel.org>
 <20260702102012.1FD1F1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260702102012.1FD1F1F00A3A@smtp.kernel.org>

On Thu, Jul 02, 2026 at 10:20:11AM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] ata_dsm_trim_pages() does not enforce a minimum value for logical sector sizes, causing max_pages to evaluate to 0 for non-compliant devices. This permanently disables TRIM for devices that previously worked.
> --
> 
> commit cdc4dda768e65a6957c51f439c9f87c5c94b90d7
> Author: Niklas Cassel <cassel@kernel.org>
> 
> ata: libata-scsi: scale DSM TRIM payload by MAX PAGES PER DSM COMMAND
> 
> This commit modifies DSM TRIM to emit a payload sized up to the maximum 
> number of pages the device can accept, instead of just a single 512-byte 
> page. It also builds the descriptor directly into the WRITE SAME data-out 
> buffer via an atomic sg_miter mapping.
> 
> Reviewed-by: Hannes Reinecke <hare@kernel.org>
> Signed-off-by: Niklas Cassel <cassel@kernel.org>
> 
> > diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
> > index 429b03a080717..82342351b1c99 100644
> > --- a/drivers/ata/libata-scsi.c
> > +++ b/drivers/ata/libata-scsi.c
> 
> [ ... ]
> 
> > @@ -2198,6 +2198,39 @@ static unsigned int ata_scsiop_inq_89(struct ata_device *dev,
> > +static unsigned int ata_dsm_trim_pages(struct ata_device *dev)
> > +{
> > +	unsigned int sector_size = ata_id_logical_sector_size(dev->id);
> > +	unsigned int max_pages = ata_id_dsm_max_pages(dev->id);
> > +	unsigned int pages = sector_size / ATA_SECT_SIZE;
> > +
> > +	/* If the device does not specify a limit, assume only a single page. */
> > +	if (!max_pages)
> > +		max_pages = 1;
> > +
> > +	pages = min(pages, max_pages);
> > +
> > +	return pages;
> > +}
> 
> [Severity: Medium]
> What happens here if a buggy device reports an invalid logical sector size 
> less than 512 (e.g., 0)?
> 
> If sector_size is 0, pages will evaluate to 0. Since min(pages, max_pages)
> is used, ata_dsm_trim_pages() will return 0.

Well, if a device reports an invalid logical sector size, non-functional
TRIM is probably the least of the problems :D :D

Anyway, we could replace the min() with a min_not_zero() to silence this
warning.


> 
> While the SCSI disk layer typically corrects invalid 0-byte sector sizes 
> dynamically to keep the device functional, this raw uncorrected IDENTIFY 
> data calculation bypasses that correction.
> 
> [ ... ]
> 
> > @@ -3523,7 +3568,7 @@ static unsigned int ata_scsi_write_same_xlat(struct ata_queued_cmd *qc)
> >  		goto invalid_fld;
> >  	}
> >  	/* If the request is too large the cmd is invalid */
> > -	if (n_block > 0xffff * trmax) {
> > +	if (n_block > max_pages * ATA_MAX_TRIM_RNUM * (u64)U16_MAX) {
> >  		fp = 2;
> >  		goto invalid_fld;
> >  	}
> 
> [Severity: Medium]
> Does this unintentionally break TRIM operations for non-compliant devices?
> 
> If ata_dsm_trim_pages() returns 0 as discussed above, max_pages is 0 here.
> Because the Linux block layer prevents 0-length discard bios, n_block will
> strictly be > 0. 
> 
> This makes the condition n_block > 0 unconditionally true for any valid 
> TRIM request. The request will safely be rejected via goto invalid_fld, but
> this permanently fails TRIM operations for a device that might have previously
> worked.

Well, as mentioned above, this can only happen for broken devices that does
not report a valid logical sector size.

Anyway, modifying ata_dsm_trim_pages() to use min_not_zero() should ensure
that the concern raised in this review comment can no longer happen.


Kind regards,
Niklas
