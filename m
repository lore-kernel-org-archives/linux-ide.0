Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A009C3A257E
	for <linux-ide@vger.kernel.org>; Wed,  1 Jul 2026 22:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782946685; cv=none; b=hHMWJXBMulyFbo/Tqzer0v/9S057z1No5/TXbDME3vF/AQtFc/KtbQo9Kwu6qIuNgY+GBTnOM/ZbJvcPwRIW106pxYjJ9Trlp0J0GGzE76nVax7Sxv+FO6P4Va8yKdOL3TqWX/TCcVOV6KYInnk1aKdYSGyKbeJIBELTtzBAOUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782946685; c=relaxed/simple;
	bh=P1J7HPjxirmi+89+4AOnZPYpWkXlSexB5pRpW1vl+84=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=TwpwSI6Ta/zbK9xL3XjUSyE0P47L9AweCrDZKxUY/stS8cQSQ+xHdBdtJiCQi8jZXa7ROHLIv72qzp7yEoxd2U9thm15js4X+69VYhcyQwO6YSu3m0bBOj75tVWDzxQwwsy1MXKgMC35Fvuyj81gXd98HAyJbyawcdMb7M86TuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hu/5UA4s; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hu/5UA4s"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DFA01F000E9;
	Wed,  1 Jul 2026 22:58:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782946684;
	bh=iMQ4H0nvU9ZZ+o1Ez/7BjmJ52mQevLe7hefCaKwQMHw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hu/5UA4s3TyNFXiTjD3GHjrIU5IBWjpZ7Osvm5YVm2GbshbyN9oye15+yvXfyXtdF
	 +zVq7BvkTxcCc8ktHMcihB2AFN48ZKVQwaCtx67TxwcU2zRC/LNZ9NhJCqDOcQ/Lpt
	 wn+rD7k71Z3hkHx9VYXwXW1QDhI6fNW+EcOT0EC8KwcYfwipR+u6W/wOl1hsgHdShd
	 EleaDuULdTiPvQxieFZp+CSDJsJT7bsQVLAuvst0D6pQQb2xH6+4llCIqMMK70GMWg
	 zLVUgOA+gYEz1SZAUg7N0CAFOxGdfofZ/NPvYKgM31H3zXsBdSAaBj3MCBi6l0m9wv
	 fLN8m6N0uhSlg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] ata: libata-scsi: scale DSM TRIM payload by MAX
 PAGES PER DSM COMMAND
Reply-To: sashiko-reviews@lists.linux.dev
To: "Niklas Cassel" <cassel@kernel.org>
Cc: linux-ide@vger.kernel.org, dlemoal@kernel.org, cassel@kernel.org
In-Reply-To: <20260701224638.1835123-6-cassel@kernel.org>
References: <20260701224638.1835123-4-cassel@kernel.org>
 <20260701224638.1835123-6-cassel@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 01 Jul 2026 22:58:03 +0000
Message-Id: <20260701225804.0DFA01F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] ATA DATA SET MANAGEMENT (TRIM) commands will fail on 4Kn devices t=
hat do not report a maximum DSM page limit, because the code defaults to se=
nding up to 8 pages instead of the specification-mandated safe minimum of 1.
- [Medium] 32-bit integer overflow in the DSM TRIM maximum blocks calculati=
on artificially clamps the block layer discard limit, causing performance r=
egressions.
--

commit a387741dfad7fa23a80a62ebd7e1d57854a6d80e
Author: Niklas Cassel <cassel@kernel.org>

ata: libata-scsi: scale DSM TRIM payload by MAX PAGES PER DSM COMMAND

This commit updates the DSM TRIM command translation to scale the payload
size based on the MAX PAGES PER DSM COMMAND reported by the device. It
sizes the TRIM descriptor as a whole number of 512-byte pages, capped
by both the device limit and the logical sector size.

> diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
> --- a/drivers/ata/libata-scsi.c
> +++ b/drivers/ata/libata-scsi.c
> @@ -2198,6 +2198,36 @@ static unsigned int ata_scsiop_inq_89(struct ata_d=
evice *dev,

[ ... ]

> +static unsigned int ata_dsm_trim_pages(struct ata_device *dev)
> +{
> +	unsigned int sector_size =3D ata_id_logical_sector_size(dev->id);
> +	unsigned int max_pages =3D ata_id_dsm_max_pages(dev->id);
> +	unsigned int pages =3D sector_size / ATA_SECT_SIZE;
> +
> +	if (max_pages)
> +		pages =3D min(pages, max_pages);
> +
> +	return pages;
> +}

[Severity: High]
For 4Kn devices that report 0 for the maximum DSM limit (word 105), this
defaults to sending up to 8 pages (4096 / 512). Does this exceed the ATA
specification's guaranteed safe minimum of 1 page, potentially causing the
device to reject the command with an I/O error?

> @@ -2237,7 +2267,8 @@ static unsigned int ata_scsiop_inq_b0(struct ata_de=
vice *dev,
>  	 * with the unmap bit set.
>  	 */
>  	if (ata_id_has_trim(dev->id)) {
> -		u64 max_blocks =3D 65535 * ATA_MAX_TRIM_RNUM;
> +		unsigned int max_pages =3D ata_dsm_trim_pages(dev);
> +		u64 max_blocks =3D U16_MAX * max_pages * ATA_MAX_TRIM_RNUM;

[Severity: Medium]
When calculating max_blocks in ata_scsiop_inq_b0(), the multiplication invo=
lves
a 32-bit unsigned int (U16_MAX * max_pages * 64). If max_pages is greater
than 1024, can this expression overflow a 32-bit integer before being
zero-extended and assigned to the 64-bit max_blocks? This might artificially
truncate the block layer discard limit for devices supporting large TRIMs.

[ ... ]

> @@ -3523,7 +3565,7 @@ static unsigned int ata_scsi_write_same_xlat(struct=
 ata_queued_cmd *qc)
>  		goto invalid_fld;
>  	}
>  	/* If the request is too large the cmd is invalid */
> -	if (n_block > 0xffff * trmax) {
> +	if (n_block > U16_MAX * max_pages * ATA_MAX_TRIM_RNUM) {

[Severity: Medium]
Similarly, in ata_scsi_write_same_xlat(), could this 32-bit arithmetic=20
truncate the intended validation limit if the device reports a large=20
maximum DSM page limit, inadvertently masking the mismatch from the truncat=
ed
limit above?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260701224638.1835=
123-4-cassel@kernel.org?part=3D2
