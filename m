Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C7DD18D
	for <linux-ide@vger.kernel.org>; Mon, 27 Jan 2025 07:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737963534; cv=none; b=LnxuT6PnNaOl0zOdvUyHN8W1TXj5aBDfYj5/rgASmB+91Qd4DceXes3QzSvqQcm0geQCSjMJHpfeE1VwBFtU9vVqTgCC+66TGW3KtCustX+RvAfdHHa+AxgWeSk0gfupHhiGqXdh8/DED3lLwUDR/HgD78pKZxFRzAm0o3LYcKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737963534; c=relaxed/simple;
	bh=YJj4XtuTN4xv1O+B63betIizIoCmrS29mILg/pH19q4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iju1Kt4vBwxd9ayARRDJIkAoc9stjhOyR++YOEMhrUpiXGo2G4VbFikLj+QLH5cllMn0IGYwvB+16bfmSem6jzNpxHprSIl2fzFsNeCwRDFdZlBGYy0q9wcd0jIXFBsbmf47qg88zY0A2XrYeZHeeP6pHds/EH9/kThyaTjQ5eQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KOyCjJB9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KOyCjJB9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E02CC4CED2;
	Mon, 27 Jan 2025 07:38:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737963534;
	bh=YJj4XtuTN4xv1O+B63betIizIoCmrS29mILg/pH19q4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KOyCjJB9KeBXppCFXv1Jgq/qVFUjfZVhZCct9/obVuD5GER3iwRk01AWu/617bS9W
	 Cu6aI4FsDqU+Lo69pb/nzTzEAlFlxtkd4yJu7FoAJxSM5FLUR3w/To4LpSlaJ+h3oA
	 OWGu2AJZT2ZGi4uqmArLqAMiLciCzCdOghvpX0Lgog2/utN0zU/bUeQOTI32ipcKFZ
	 A4rzGCKilmkF0gfE81WLCTfvQoo0YYc0Rsa2ceuLyarVXs0vnNcx9AECVAuRICe+KL
	 GZ26yoUWaXRdHNsVR/AXTgVGSyT6VUetXrNxRTADeg4Rcj3WQDS8mu9XwfRcdhZqJb
	 FLqCR7N3Rv0RQ==
Date: Mon, 27 Jan 2025 08:38:49 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	reveliofuzzing <reveliofuzzing@gmail.com>,
	linux-ide@vger.kernel.org
Subject: Re: [PATCH] ata: libata-sff: Ensure that we cannot write outside the
 allocated buffer
Message-ID: <Z5c4CZnLNxlasYpe@ryzen>
References: <20250124141118.3722754-2-cassel@kernel.org>
 <4dee6487-4b9a-408c-aa7c-834802781887@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4dee6487-4b9a-408c-aa7c-834802781887@kernel.org>

On Sat, Jan 25, 2025 at 08:12:38AM +0900, Damien Le Moal wrote:
> On 1/24/25 23:11, Niklas Cassel wrote:
> > reveliofuzzing reported that a SCSI_IOCTL_SEND_COMMAND ioctl with out_len
> > set to 0xd42, SCSI command set to ATA_16 PASS-THROUGH, ATA command set to
> > ATA_NOP, and protocol set to ATA_PROT_PIO, can cause ata_pio_sector() to
> > write outside the allocated buffer, overwriting random memory.
> > 
> > While a ATA device is supposed to abort a ATA_NOP command, there does seem
> > to be a bug either in libata-sff or QEMU, where either this status is not
> > set, or the status is cleared before read by ata_sff_hsm_move().
> > Anyway, that is most likely a separate bug.
> > 
> > Looking at __atapi_pio_bytes(), it already has a safety check to ensure
> > that __atapi_pio_bytes() cannot write outside the allocated buffer.
> > 
> > Add a similar check to ata_pio_sector(), such that also ata_pio_sector()
> > cannot write outside the allocated buffer.
> > 
> > Reported-by: reveliofuzzing <reveliofuzzing@gmail.com>
> > Closes: https://lore.kernel.org/linux-ide/CA+-ZZ_jTgxh3bS7m+KX07_EWckSnW3N2adX3KV63y4g7M4CZ2A@mail.gmail.com/
> > Signed-off-by: Niklas Cassel <cassel@kernel.org>
> 
> Looks good to me. But doesn't this need Fixes + Cc-stable tags ?

ata_pio_sector() has been able to write more data than what fits in the
buffer since the commit that imported linux into git:
1da177e4c3f4 ("Linux-2.6.12-rc2")

although ata_pio_sector() then lived in: drivers/scsi/libata-core.c

Do you want me to use this as the Fixes tag?


Kind regards,
Niklas
