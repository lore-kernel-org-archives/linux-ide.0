Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B792F17A2FB
	for <linux-ide@vger.kernel.org>; Mon,  6 Jul 2026 01:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783301189; cv=none; b=T3EHMIOKSHccr9WxJpf8EYx1uhl3cL5VuYt4qsxZEdN3rshNYh5cET+KCANiWIzm4YSFjQJY5tn2D0pGVuNIpPM+muxYqKOodSrHNk1MMAnOnilt1xiFe5fFvKvlxAQ6vqHVh2cWn/JtSTaIkwwzzS67sCd31WvX5DbD4EDueq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783301189; c=relaxed/simple;
	bh=0rVZOpJKpcFQRVORzCqdab+EPr+UsNCrXqBLAu2I6hk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iB07NdAUREuxo1mgKg0xxt2E8i8r/T2vhnKeFLES8Cx5Xkv6KtXo+ghi7b/yvhw6t4RCzbiwRsQMcTNfJZarjuKnj6QubYT8cmkD3+KsyYm2iVWVE76TuKB1P3bAU73A1qWw35SnDLVgLlj+jfKq0TJaWaB9+64jtYx3Cu2HCm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YxB7vTYT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YxB7vTYT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09A921F000E9;
	Mon,  6 Jul 2026 01:26:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783301188;
	bh=Df5fhWscvQ2G3qeGGV/LYzlgiPTatwp+9qjbil2mZK0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=YxB7vTYToCkw0jQmF2pNqSa9+v9V1A28DgcQCkWLanX00IxFeLCiW8cgPzkpnKjhk
	 Fg0sQc8HWGA4ITUXVVnPE/CKcb1bpDIxcs1B/n+/ULhtGEMXvOCJrjZzvStrutLask
	 oWifd5wMvkg5lXyqmpJA4zfYUcobVaPViR2wB+d6gwzQ77ZQtZVw2U2Ng+jnnJgYQ3
	 boqf7jCeG6X1LRMz44FWS3SHE/qbTQfA8dVvHSUoJU81R+abtbP/8h0NDHA3riEmjh
	 bpJM0KiDPJq2OANCOwCutJ0A1W3egfMgTQnOsGD44/1zj7v5x96IMr2DBonS4Oj6jN
	 HpVuB+Vd7A43w==
Message-ID: <18c82234-c0ed-47d6-9e69-9be2d461892c@kernel.org>
Date: Mon, 6 Jul 2026 10:26:16 +0900
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/2] ata: DSM TRIM fix and improvements
To: Niklas Cassel <cassel@kernel.org>
Cc: linux-ide@vger.kernel.org, Shaun Tancheff <shaun@tancheff.com>
References: <20260702105956.2058733-4-cassel@kernel.org>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20260702105956.2058733-4-cassel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/2/26 7:59 PM, Niklas Cassel wrote:
> Hello all,
> 
> This fixes DSM TRIM for 4Kn devices, which has ironically been broken
> since commit ef2d7392c4ec ("libata: SCT Write Same / DSM Trim"), which
> claimed to correct the DSM TRIM handling for 4Kn devices.
> 
> 
> The first commit is a small fix that can be backported, which limits
> the DSM TRIM to what we currently report in the Block Limits VPD page.
> We currently report a single 512 byte page of entries, i.e. 64 Entries,
> where each entry has a maximum of U16_MAX logical blocks.
> 
> The second commit:
> -Improves the support by reading the MAX PAGES PER DSM COMMAND limit and
>  populates the Block Limits VPD page accordingly.
> -Modifies ata_scsi_write_same_xlat() to properly support up to this amount
>  of pages.
> -Removed the intermediate copying to ata_scsi_rbuf, writes to the scsi
>  buffer directly.
> 
> Practically, sd still caps n_block at SD_MAX_WS16_BLOCKS
> (~3 pages actually used on 4Kn), so while removing the limit on
> ATA_SCSI_RBUF_SIZE (2048) - i.e. 4 pages), we will still be limited
> by SD_MAX_WS16_BLOCKS. The main improvement is not longer taking the
> ata_scsi_rbuf_lock and doing and extra copy from ata_scsi_rbuf.

Applied to for-7.3. Thanks!

-- 
Damien Le Moal
Western Digital Research
