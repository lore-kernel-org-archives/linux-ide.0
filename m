Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9F8B34676F;
	Tue,  2 Jun 2026 12:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780401913; cv=none; b=u9Invhb2PHP2wZ6/A66DRX2VqW+Wu9J6rSgimMxQcWlXa2wexsjI+qC1OVquqdhCH7M1NQak9ijMxjVJGfLtyBWQ8AF3h7yTiPfCS+Z6z453YbzSLcwG1aqrOG3S2Gu6BXYLz2DU+V5g80xrIReyHi7++yXOAXp6HWeDDCI+pVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780401913; c=relaxed/simple;
	bh=wvrWxadkk8SKsiZxpl7sBv0GWUmrQnuER1eCBZ+Lkes=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hzdHVGKjwl6CMANofCiE3i7ci0YrdTwq+Wb8/b33dB7U1r6sgny96yIdoff7vSNUMtJhVxzYLOVy37n/NJfF67KwgI7Kv66GwkgoWjYQjEWqPVDc7e5xKRrPDpvjacPagv5FXpATmpcjUJAXZxcU1h17rZr9RcvFBgaNp1Fxh9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IHBcO7rD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IHBcO7rD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D4C01F00893;
	Tue,  2 Jun 2026 12:05:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780401912;
	bh=ZZ7dZKXsMsEuzdpOdDGLfXw/jy6/VBwGBSczq13c9pU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=IHBcO7rDqfDU2jr1byJvWZnKfgywyf+oTx/1jfCWpWkqTMxqqXY97WHolueRC0cyG
	 ws2/fjcEKwwzuQjvbxIyo3IdRSGeS+ahyL2XeTbh/oMl6IipOdwet9GWv9SIwLx3b/
	 XQ+wxb6O0cDhPIFWSYT3Pm6rJA/w0zyeCW5GvO+qHkK180p7J93XqY9QTtTJ7rEKcM
	 PkATBO4h1RhA6y0CbsG2QH10i+Kq5Y3bB0qn7ABnEjpNvSDtvZW6yJbab+5ffSsMa6
	 MzF20NSpm4rwXcKtnek6FOrSa/qTG2C5V/HgEJvBveTRstGWeiPDnnCVx5RQ7M/bGq
	 rGe66uHCjLWqw==
Date: Tue, 2 Jun 2026 14:05:08 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Rosen Penev <rosenp@gmail.com>
Cc: linux-ide@vger.kernel.org, Damien Le Moal <dlemoal@kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ata: pata_ep93xx: fix PIO fallback when DMA init fails
Message-ID: <ah7G9AbYy1M66u0s@ryzen>
References: <20260601190749.20045-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260601190749.20045-1-rosenp@gmail.com>

On Mon, Jun 01, 2026 at 12:07:49PM -0700, Rosen Penev wrote:
> ep93xx_pata_dma_init() returns an error when dma_request_chan() fails,
> which causes ep93xx_pata_probe() to abort entirely.  The probe function
> already has a PIO fallback path (it checks both channel pointers before
> enabling UDMA), so the DMA init should not fail the probe on non-fatal
> errors.
> 
> Treat only -EPROBE_DEFER as a fatal error.  For all other failures
> (ENODEV, ENXIO, configuration errors), release any allocated channels,
> NULL the pointers, warn, and return 0 so the driver continues in PIO mode.

This patch looks correct to me, but I do think that the commit message,
which refers to -EPROBE_DEFER as a fatal error, is very misleading.

Better phrasing would be something like:
Propagate -EPROBE_DEFER, such that we allow the DMA controller driver
to load, in case we got probed before the DMA controller driver.
For all other failures (e.g. -ENODEV when the DMA controller is missing
in the device tree), fall back to PIO.


Kind regards,
Niklas
