Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795767270;
	b=Ytu6aqs/7+3SRUqXMB0BsdlzLP5oYU82e+GRT4Q2aS79aJmiS3IdmQkufHe6aF3s1osY
	 /4seg9EiVtPDMt7MRFwoD9unCduXO/FeIV+7ArBRaH/NstMTWdAsqJgWTI9lVDg7Jq8e4
	 pKmWDMEhPT+IhEsqRwpmFg1t3Wlw1ZnIlmnLVobvtFwhsrzg9nPyq7Qo3nRoasVEsp8G9
	 bTgzWIVWnBnkrCW4H1U4wXHNP1jNFIGZluzTJCevn3mTLebK222KlVw2aWqrYthu+Gnau
	 Eazbl9k3n93Mn3bwHbYXhfXV+N5TVSV4Rmaqh4RyWdo/Eqb3GkwvyUHdzYwSLqr87jw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795767270;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=+xRVDCQpYyYjeXDffVhzpmBvTxYsEAe9NPA3pfZk1cg=;
	b=QzUTwuWggKLir1waeBgXBQX4vd2JDXsFDVM4zc1vS7G38G9QJ7qAQOLawor20QexTo5M
	 9PlrNsr2dL9CP3yCdhY+JTHJ6L5abnfvP5XoRQGrNtmnyNs6OGDNQdhKHisUjHQF4doG3
	 QbYQpCkUpSd/c6HlIKhUm2+eTk1wYQ97kK/2e5SVEJp3gwgjov7W61D5ELkytfDmUiWqk
	 U8VZZN2aRRczG9tZyAiCLerwNM62YLDrHUG8BKVGuoz7xJaU5ZyvpPI9wYjFaw7AAgh0e
	 Mt4iQJCjwgUfbEh8mvRNBk/lrTj1Pem2P+ORjIFudNznhbsXk+mAMYztSKXX14rYbZA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=N2B3mT00;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA3A1606A31C;
	Fri, 27 Nov 2026 08:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=N2B3mT00
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB9471F000C1;
	Fri, 27 Nov 2026 08:14:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795767270;
	bh=+xRVDCQpYyYjeXDffVhzpmBvTxYsEAe9NPA3pfZk1cg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=N2B3mT00365QXwGcTsUAFdNdoDlen+nhm77FM77Ll6dCgzUmvFTv7+k+EieRGxET+
	 EdNMTYsUJHVpaCxH+K7yE2CJ8kMhNuzwQXe0GeFqPkWsTBys9xLHSTMWdVpprFISIQ
	 affzYqT+wspr29jm2LiLCOqKE9t54pE3a5/vxcQMs7tBt/rMB2m2wM/zRSTwcwnYQc
	 gSBj5irxiFtaOMLNw2Ef5XyF9wuey4uWB1hbxxJ63ugh4isDaHopiEGUF+wQ+/iQGz
	 IzE+8Asf88nQNmN6cLBkrMeEY+ZWiJJdYLrOHb7N+52Qq316icyIb9Vom6beFxpXif
	 G89nGKvvaQ3Ng==
Date: Fri, 27 Nov 2026 09:14:25 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Artem Novak <artem122novak@gmail.com>
Cc: dlemoal@kernel.org, linus.walleij@linaro.org, viresh.kumar@linaro.org,
	linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/4] ata: add missing newlines to error messages
Message-ID: <awk74XffmMjYTJ2j@ryzen>
References: <20261126214756.39027-1-artem122novak@gmail.com>
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
In-Reply-To: <20261126214756.39027-1-artem122novak@gmail.com>

Hello Artem,

On Thu, Nov 26, 2026 at 03:47:52PM -0600, Artem Novak wrote:
> This series adds missing trailing newlines to error and warning messages
> in four ATA drivers.
> 
> The changes are formatting-only and do not alter driver behaviour.
> 
> Changes in v3:
> - Carry Damien's Reviewed-by tag on all four patches; it was
>   inadvertently included only on the sata_dwc_460ex patch in v2.
> 
> Changes in v2:
> - Fix an additional missing newline in sata_dwc_error_intr(), as pointed
>   out by Damien Le Moal.
> - Add Damien's Reviewed-by tag to the sata_dwc_460ex patch.
> 
> Artem Novak (4):
>   ata: pata_arasan_cf: add missing newline to warning
>   ata: pata_pxa: add missing newline to DMA warning
>   ata: sata_dwc_460ex: add missing newlines to error messages
>   ata: sata_gemini: add missing newlines to error messages
> 
>  drivers/ata/pata_arasan_cf.c |  2 +-
>  drivers/ata/pata_pxa.c       |  2 +-
>  drivers/ata/sata_dwc_460ex.c | 10 +++++-----
>  drivers/ata/sata_gemini.c    |  4 ++--
>  4 files changed, 9 insertions(+), 9 deletions(-)

This series does not apply.

Please base it on:
https://git.kernel.org/pub/scm/linux/kernel/git/libata/linux.git/log/?h=for-next

or linux-next.


Kind regards,
Niklas
