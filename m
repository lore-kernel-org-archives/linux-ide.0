Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE04118FDDE;
	Tue,  7 Jul 2026 01:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783386606; cv=none; b=pmTRGeMNQixMFNCue2sOynj5F9lPoT/GAqGXBHZyqpVj9+lUmQ+1jrO6I/ou4gfxnN+zUDaQ4L9wr/3SIj4gpynlkywiNFWoDne8K2tlXaI7lMsVGtClA707YfwFNq0lN1oz6RGDM0vH3IWX+UF+eOBZyO9j2aEyFTBlTi1YoH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783386606; c=relaxed/simple;
	bh=SHwHPZA6/XwgSDAWSEBWC4qF7jqDBNDSqAZONQQ7hL0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RGxbZIA45X+1QLMUjxftA2oI37Yo3DRE4zDN4K9KobqDYI4Ex5Ed+Ce9/5Lp1ejHkgDqJdKLbvTA44cPjDHkBNkVjHkV7WhP/z02CIf37I8UN4494pmZJBju0JA/qWzhfDpNK2Stj8cT6aAPYCm6Yj1/4RGPb+7ZtZPPiyPhatQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eJVlX9M9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eJVlX9M9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A59C91F000E9;
	Tue,  7 Jul 2026 01:10:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783386605;
	bh=Ufs0QMwjMC245Jwe41XmuQJGJHxSCoZG7qTSaaOsHJw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=eJVlX9M9taBC+C06AuSCkoSWpVT5ZTBtPj/Q925f+A4IFpVpRwUkFhM9OAzb63+gK
	 7df49bI6RhFNBohDwpNfm21jU748W7U/MyEHxJhMPDVw3QvH6zdAjJl9XnziNMYewj
	 Hv7OUOGazBbegApdw8LjhXWTAzpGmFoubsslaFiHnZShjlmdk8rm5XDi/R4W3K4PSw
	 4htkKvlR3WHD8ojTpfu1PRYgQcObau2sjVCTfKCiWbh4IURRNSMLfReWNUFyTo3SBd
	 bmUS1h1bQBTdD26fErSq1yL4fdxi6M6UBPMa8WuU/mH+hs8gVIdVVbDfmIb7wILrm7
	 KTDFxQ6e+vJOA==
Message-ID: <49cb57c1-d7d6-4f30-b628-72c083981da6@kernel.org>
Date: Tue, 7 Jul 2026 10:10:02 +0900
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] ata: libata-scsi: limit simulated SCSI command copy to
 response length
To: Karuna Ramkumar <rkaruna@google.com>
Cc: sashiko-reviews@lists.linux.dev, cassel@kernel.org,
 linux-ide@vger.kernel.org, Igor Pylypiv <ipylypiv@google.com>,
 TJ Adams <tadamsjr@google.com>
References: <20260702020142.3399851-1-rkaruna@google.com>
 <20260702021411.B01331F000E9@smtp.kernel.org>
 <16780c1b-418a-4555-b4bd-d442cedd620e@kernel.org>
 <CAD50Xqp_LBvRqhn0q93s3aVxtfFWGhf42jBePKsUonfE6V=WNw@mail.gmail.com>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <CAD50Xqp_LBvRqhn0q93s3aVxtfFWGhf42jBePKsUonfE6V=WNw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/7/26 08:10, Karuna Ramkumar wrote:
> Before I start working on this, I would love to hear your feedback on:
> 1. Whether you think this API update (passing `rbuf_len` down to all
> actors and helper functions) is the right approach, or if you prefer
> simpler, and more localized checks elsewhere.

I do not think it is necessary at all because rbuf is statically declared:

static u8 ata_scsi_rbuf[ATA_SCSI_RBUF_SIZE];

So the buffer address and maximum size is known to all functions using it.

> 2. What would be the best way to test all these simulated command
> paths to ensure the fix is verified appropriately?

Most functions for emulated commands generate only a very small amount of data,
far below ATA_SCSI_RBUF_SIZE. So I would suggest that we simply add checks to
the functions which may potentially exceed that. Off the top of my head, I do
not know if we have any, but we should just check.

Note that ideally, we should have each function allocate their own local buffer
to handle the translation. But this is right now a little hard to do because
these translation/emulation functions are called with the port locked, so we
would have a memory allocation for a potentially large-ish buffer under a spin
lock, which means no reclaim/no wait allocation, and thus potential for failure
which we do not have right now. A proper/ideal fix would need to drop
ata_scsi_rbuf, have some helpers for managing the internal buffer and redesign
the submission path to not have the port locked until the translation is
actually generated. That is all more work and more changes.

So as a first step, let's check the emulation function if any of them can exceed
ATA_SCSI_RBUF_SIZE in size, fail them with internal target failure.

-- 
Damien Le Moal
Western Digital Research
