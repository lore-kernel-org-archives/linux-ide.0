Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792656678;
	b=zF5a/VyWqjQebQwfTnugpGFizUFJKY08FRSWDN31zF10a4dBUvP0ca58UHx3RLOEcJ8a
	 uD/5IS/TyjIaIeU18jHuoynxuBrI/327PBCaOt4tEQhmF+YodfMOoxd4//AftUrVIo1aX
	 T3AWXZS+MIQ64cacsVi+2bRD9zH2/UT5j4BEq1EAuvUGnHc6/AYxEngMsLq4jfRiSP5el
	 ahF2ZRKpx+DV/qpWOL6L4Ph/XhwPPkjmSyHXmYQom5RRte75L2r1DSDlguB97BjO02pfd
	 At5AEXdgotI2UPBKE1BijNyn0F3z0WG+m9sw339cb46cMCbPx0OuvDC6TlDA27kaogw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792656678;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=YQNH48iJWVOkBuc+qEw4fymPxSNZ+X48xg8gU4VZE/c=;
	b=Bzq9GivgAU3u4rhfgVIRjwmvCG21HzbJ/kU4THvye94ovb5cepMzjoU+LzZ0orlkdxy1
	 rDEjh30emc48z1RYssbPnqIKnPdenYBwd+zoXtVgEyTFTK+09eWYs+DCnFi5VeyGQao2i
	 yHRrMjQY5F/vYGeAxIX1gLPQ+myfPpqYZd7mSziplTub/Vxt/TBGn7ovceSTQBir3c/V8
	 igm0QEWt14DPKeSU+D+j70PKuGQ7QQsUJtKeicQxc6DQYvulOhZqw/UCrIfM+Ckh8p55X
	 mnPlKGKeGSyi4bcKX9Vl6vxjtwTU8a9gqzoTcND1uTQaWxri+XrAK5T9Lk0mN066IYA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jwqw5q3C;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8454E606A319;
	Thu, 22 Oct 2026 08:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jwqw5q3C
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E7251F000C1;
	Thu, 22 Oct 2026 08:11:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792656678;
	bh=YQNH48iJWVOkBuc+qEw4fymPxSNZ+X48xg8gU4VZE/c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=jwqw5q3CdcwsKrc37HglkZFLjp537xeoufvVqj9USCkiAug2AIdRPQQDpt3hLwA1W
	 KoNdANu1V9L/c2v4vTuLA7xoDjiyjztDfbnAu4e10xieJV64Z5kfgOjygQAuP/KH/P
	 lRpjIqaQcGK+1Np2Mkf4peXV1cglM9M5XI3hd9SbI+FM8SNiHOv8Vn724lAZM8WzjI
	 gcs/nc2SerTr3BgKlxd2XXOrXbwNa/r5lknmWIDhVrDaDMbtGxMHGSMlwRY89h9ohr
	 wryS3xjl3NN0dAsKMNrE/lON4gM4r7FVmChb0Bv8NhGep+/BBMd0c9RwieP1AIt6bj
	 GbS+RM/lEPPqg==
Date: Thu, 22 Oct 2026 10:11:13 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Rand Deeb <rand.sec96@gmail.com>, deeb.rand@confident.ru,
	linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org, shda@confident.ru
Subject: Re: [PATCH v2] ata: libata-core: Ignore forced transfer modes the
 host does not support
Message-ID: <atnFIf_bZA28HRwk@ryzen>
References: <20261015194935.1497-1-rand.sec96@gmail.com>
 <fb677bdb-355d-4a46-9e4b-db989a7690d9@kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Post: <mailto:linux-ide@vger.kernel.org>
List-Help: <mailto:linux-ide+help@vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-ide+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fb677bdb-355d-4a46-9e4b-db989a7690d9@kernel.org>

On Thu, Oct 22, 2026 at 09:55:35AM +0200, Damien Le Moal wrote:
> On 2026/10/15 21:49, Rand Deeb wrote:
> > The libata.force parameter can force a transfer mode (pio0-6, mwdma0-4,
> > udma0-7) for a port or device. ata_force_xfermask() applies it in
> > ata_do_set_mode() right after ata_dev_xfermask() has limited the device
> > masks to what the host supports. It replaces those masks with the forced
> > mode without checking the host masks, so a mode the controller does not
> > support is passed to the driver's ->set_piomode() or ->set_dmamode().
> > 
> > Several PATA drivers rely on the host masks to keep the mode number in
> > range when indexing their timing tables. ata_piix, pata_efar,
> > pata_it8213, pata_oldpiix, pata_radisys and pata_rdc declare ATA_PIO4
> > and ATA_MWDMA12_ONLY, index a five-entry PIO timing table with
> > pio_mode - XFER_PIO_0, and index a three-entry needed_pio[] table with
> > dma_mode - XFER_MW_DMA_0. Booting with libata.force=pio5, pio6, mwdma3
> > or mwdma4 makes them read past those tables, use the values read as
> > further indices into the timing table, and write the result to the
> > controller's timing registers.
> > 
> > Make ata_force_xfermask() skip, with a warning, a forced transfer mode
> > that is not in the port's PIO, MWDMA or UDMA mask, and keep looking for
> > an earlier matching libata.force entry, as it already does for entries
> > that do not apply to the device. With libata.force=pio4,1.0:pio5 on a
> > PIO4 host, device 1.0 now gets pio4 instead of pio5. Forcing a mode the
> > host supports still works as before, including a mode that
> > ata_dev_xfermask() removed for the device or cable.
> > 
> > Found by Linux Verification Center (linuxtesting.org) with SVACE.
> > 
> > Fixes: 332673257056 ("libata: implement libata.force module parameter")
> > Signed-off-by: Rand Deeb <rand.sec96@gmail.com>
> 
> Looks good.
> 
> Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

Repushed commit to pick up Damien's tag.

Code unchanged.


Kind regards,
Niklas
