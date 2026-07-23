Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 297013DB641;
	Thu, 23 Jul 2026 07:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784792238; cv=none; b=rFtYxggN3b/pynQ+cMjAIVK+fHBQP7vFVfBHLv925D+8Wpqp476CZroHCYm/i4yorLeZ4XyzLAMqhRBtFsL7lFX4x8ipfuWwb+6AR8mZQPKsYWiYBhV8ug2Hekrk7fHwd1jrrD/jV96ezlf1gumuZ2nBMbAoB1TopBrek+4v8ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784792238; c=relaxed/simple;
	bh=uTzUID5Q5asTO+ZSEnm4Z4ibr7doJgyKl89+AK63Xqs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cgrHzqynvhW1/kzEIxnO9wEc980OFWZTrAj0TygfPa9Rio2sDMO4R8bu70smf398kNJl/TPtGT72u6qFTjwlGA5W1Lrvbuc8rUpabFknEyNXJ06UMFmnjpu6yV95mmpd3yIC/xnqMl4cCSK+2AB/kYsAhLtwADboAjAXmAyQQMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hn2Ateqd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hn2Ateqd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 155551F000E9;
	Thu, 23 Jul 2026 07:37:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784792236;
	bh=ZJ2xmlDZahPQ2k864yM9jfsRjLDS4NlSqqiCIU87AtQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=Hn2AteqdXXjwqzpEUUFBNkQsEX1n1BGXLyOOYgyBsphxzS0z8FtwhhsPmNZr15fO5
	 0LV4Sgpqtz9d7sRfGcJmV6+xIw+7Q002Y7nj9pB849KdhaNif9QVlDUetSi/ZOoPt9
	 xOTa/g9h7d51oYIO4u3evgRXOplNRZHxdRxvSBw8/oMbulVTtLHzF0LXsnyb7NXkkN
	 lVpH3Lrb3RjaFqoycm7I9upVyLfEDW7UzQTgm90AggfOaGYOxyT/+SAD66yf4EEsu2
	 m48WXs0dqOFWMnD6+dKWWMfdy3m42FqWb525R5Q6ke4JGuKmbb2yD669T13arHz+tS
	 x+WKFc4PFQf7Q==
Message-ID: <7779fcfc-f74e-48f2-bd87-c59087ca96ff@kernel.org>
Date: Thu, 23 Jul 2026 16:37:14 +0900
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2] ata: pata_ep93xx: fix PIO fallback when DMA init fails
To: Rosen Penev <rosenp@gmail.com>, linux-ide@vger.kernel.org
Cc: Niklas Cassel <cassel@kernel.org>,
 open list <linux-kernel@vger.kernel.org>
References: <20260720020229.1972888-1-rosenp@gmail.com>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20260720020229.1972888-1-rosenp@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/20/26 11:02, Rosen Penev wrote:
> ep93xx_pata_dma_init() returns an error when dma_request_chan() fails,
> which causes ep93xx_pata_probe() to abort entirely.  The probe function
> already has a PIO fallback path (it checks both channel pointers before
> enabling UDMA), so the DMA init should not fail the probe on non-fatal
> errors.
> 
> Propagate -EPROBE_DEFER, such that we allow the DMA controller driver
> to load, in case we got probed before the DMA controller driver.
> For all other failures (e.g. -ENODEV when the DMA controller is missing
> in the device tree), fall back to PIO.
> 
> Assisted-by: Opencode:Big-Pickle
> Signed-off-by: Rosen Penev <rosenp@gmail.com>

Applied to for-7.3. Thanks!

-- 
Damien Le Moal
Western Digital Research
