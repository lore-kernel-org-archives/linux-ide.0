Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8FF28C1E
	for <linux-ide@vger.kernel.org>; Thu,  8 May 2025 04:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746678900; cv=none; b=M55VxsY01P1VI6QIVA3jmdkWuI+UtEy798yH3Brte2SB4/YisqB05QyH7fFHg1zOSHhAu210hwPfCqtKDKHqvxl1oucIRswydmxozUZWmByu+fDCShMYc78UoNzhbyu+2pf+F8Bg+oq9aoSOYHb5cqc41iCB0PkbHJYTqnGTxSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746678900; c=relaxed/simple;
	bh=YHJyv/3JP3nvBFE3fV1jQgFCahtzzgNa4pSfQ20zozA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=JeO8xUJ4U0u7KCaw5OyjOhY4tFsXjod9OU7pK6dsxc+hJxMGRoE0CRGmOpB+FiubXsIPyySBW3fAnqmyC+IkXFO31AWaA8LRbBjOw4OTN9FJmOAxaHs7BtJHFYxlZFVVAmpgwdJuS2Y4aZGgBa/7LjUK5gySchXsNMXt5YmY3QU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RKa4eY5M; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RKa4eY5M"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A71ADC4CEE8;
	Thu,  8 May 2025 04:34:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746678900;
	bh=YHJyv/3JP3nvBFE3fV1jQgFCahtzzgNa4pSfQ20zozA=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=RKa4eY5M2hUx0NCC/BfcElVClTvSHEupjUB824iJYgPZH63MHOhREO20+BSm3UDO0
	 7rYo+OZzzv7qXnL53I2+VtkZTg2UqMK/ZkZFCe57Er09eBmEuQYwupmbLb1brEy0qc
	 rHhLxBtBS2oYgDR6I/rlOhJPLIXptA53wtYd2EYsc8pd0hJkdRg2PGPyJ+AM5BhWMs
	 hCCETFaXfch/+zvjovS2Mlfed4mgibm7KZuqCoBjSV1QT2C9UrDvN7EC9HLXAExtkb
	 ohl8J345FAchws1Q3QBSe1qiPcjovJV35dRS+m+2DD1IQgedvjXSEVzZhR/EbmXdez
	 gfHE1gPkCh0XA==
Message-ID: <66e16c3d-d7b1-4d53-a1b2-c1568e1ad585@kernel.org>
Date: Thu, 8 May 2025 13:33:48 +0900
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Multi-LUN ATAPI devices (Panasonic PD)
To: Phil Pemberton <philpem@philpem.me.uk>, linux-ide@vger.kernel.org,
 Niklas Cassel <cassel@kernel.org>
References: <398bda0b-6eaf-4a4f-8f46-0b0befd3aa89@philpem.me.uk>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <398bda0b-6eaf-4a4f-8f46-0b0befd3aa89@philpem.me.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/7/25 10:06 PM, Phil Pemberton wrote:
> It's me again, with another weird IDE device..
> 
> The device is a Panasonic PD/CD-ROM drive. Under Windows it enumerates as two
> drives, apparently LUN 0 and LUN 1. LUN 0 is a CD-ROM, and LUN 1 is the PD-RW
> block device.
> 
> (PD is Phase-change Dual, a rewritable optical disc format developed by
> Panasonic in the 1990s, it stores 650MB on a CD-sized disc encased in a DVD-
> RAM-like caddy)
> 
> Unfortunately Linux 6.12.9 (on Debian Bookworm) only detects the first LUN, the
> CD drive. If a PD disk is inserted into the drive then there's no way to read it.
> 
> It seems like the Linux ATAPI layer only supports a single LUN. Is there a way
> to extend it to support the second LUN on the Panasonic drive?

Is this a new issue with 6.12.9 or was it working before ?
There is no concept of Logical unit/LUN in ATA/ATAPI. That simply does not
exist at all. Likely, Windows has a special driver for that second PD drive and
exposes both drives as 2 LUNs of the same device.
Unless that PD drive thinggy uses a standard ATA/ATAPI interface, I do not see
how to make this work.

But just in case, please share an output of dmesg for this system probe of the
AHCI adapter and ATA/ATAPI devices so that we can see what's going on.

And please CC the maintainers when sending emails to a Linux kernel mailing
list. Otherwise, your email will likely be lost/ignored.

-- 
Damien Le Moal
Western Digital Research
