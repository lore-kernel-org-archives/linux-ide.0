Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FC852505AF
	for <linux-ide@vger.kernel.org>; Fri, 21 Feb 2025 17:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740158944; cv=none; b=Lt9s71CeBJ2Jjta2WX7Z+7qPMzjeokaGAMBsWcib3knPO7GcHMIOPjTO0qBEodXuWhhadMxzdsP0K/1Iq0ueJFg6lXEXpHjH/3WevZjyEA/qLVnXui4BP6GxA0PSwQJT3OG8ofJP1EjXgxY62Z4zxtIXHkZSmG8jib2tw9YJZd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740158944; c=relaxed/simple;
	bh=yi3wb13HmQmIXR2/sTCbi9aesTOXAUJPugO5TugGif0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=OpuV5LqhZOgeOqvkjDzoOiHaCJv9kTaICqqPsQbWpxS6m7Irzk1GzcEbuC8FTnLP0LsR0frAzcPAjkGzsaeM+f6iYcKvozyHOSfS2cVTXfq086J12ACgfLtLh+5Kw1eSR7QEA/M32gvgOCzBi4+S1zSYbq5SWI+w2GnyrhuWCBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mD0fnAXZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mD0fnAXZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08921C4CED6;
	Fri, 21 Feb 2025 17:29:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740158943;
	bh=yi3wb13HmQmIXR2/sTCbi9aesTOXAUJPugO5TugGif0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=mD0fnAXZTbUepLECVeht6ryTCFKYHvrAMfIcgVSjX4RRqTCV63owP/8vZZpiRa1gS
	 Sob3pWl/NlS8MbT98CY7/emlnDAwVE5PQw7f0yUFOL1ppgneN3/EMmM5zlpe9y7TMs
	 1X+E4SfR4S4/tTfNKAHmDmhYmBmqrMLTHTLfRCNuLsGAaNNKAEbP/f8g46wNj2FFsG
	 8CM1dmiORdqjKVUZ+9Cs194bB060hD8o3Q4hXjWhxiZafM93ZAeiYkJ3MVP8bxQg5I
	 6aP/qTPN0D+W0gig4LA8Tqe6ShvHGX2n28BUQ65jGs24Jg8xDSP4dhGUvP0bWGtTHH
	 ccitAHphaSKNg==
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>
Cc: Philip Pemberton <lists@philpem.me.uk>, linux-ide@vger.kernel.org
In-Reply-To: <20250221015422.20687-2-cassel@kernel.org>
References: <20250221015422.20687-2-cassel@kernel.org>
Subject: Re: [PATCH] ata: libata-eh: Do not use ATAPI DMA for a device
 limited to PIO mode
Message-Id: <174015894276.25606.12774433973024830684.b4-ty@kernel.org>
Date: Fri, 21 Feb 2025 18:29:02 +0100
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2

On Fri, 21 Feb 2025 02:54:23 +0100, Niklas Cassel wrote:
> atapi_eh_request_sense() currently uses ATAPI DMA if the SATA controller
> has ATA_FLAG_PIO_DMA (PIO cmds via DMA) set.
> 
> However, ATA_FLAG_PIO_DMA is a flag that can be set by a low-level driver
> on a port at initialization time, before any devices are scanned.
> 
> If a controller detects a connected device that only supports PIO, we set
> the flag ATA_DFLAG_PIO.
> 
> [...]

Applied to libata/linux.git (for-6.15), thanks!

[1/1] ata: libata-eh: Do not use ATAPI DMA for a device limited to PIO mode
      https://git.kernel.org/libata/linux/c/91ec84f8

Kind regards,
Niklas

