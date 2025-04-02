Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04616233732
	for <linux-ide@vger.kernel.org>; Wed,  2 Apr 2025 07:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743580779; cv=none; b=Ln2RsvtyhoB8B37l8NwCPXiNHPwukDWcMJ4jo8UO2pRkfOoC/vk92nKS1mU30kYbzedjzZGVbvKdibdilhAtPNsKraaeDeXLeYZfnaAutW+JiwOR4ir/6bIFxw7a5ntbZmCkdNjNfu/bV7wAkq6FQ9t8XlBjRhxO48tx4Gei+Sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743580779; c=relaxed/simple;
	bh=epNVdB7jnIvkHoNKK5s6r5v/ZilK8ibYbum/uGREX0M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X7QQvdJLcSaZ+GfaYWL6JI2R4ZrKIkz3kfv2/dURA0L5UMP3fHMYjJQ0jW+MhZam4Hyh9nPefi9CHkCKAfWwUZ391ECa/Fb/+aAG1BI35/yv3TL3k4qKP5rygj989erMRZJ6SUbq5kljNOB3gZFQkG+Acx8mBl4oYb/xAUK/y/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AmipAty1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AmipAty1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5E21C4CEDD;
	Wed,  2 Apr 2025 07:59:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743580778;
	bh=epNVdB7jnIvkHoNKK5s6r5v/ZilK8ibYbum/uGREX0M=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=AmipAty1dAaFLAoF+1ExMivrluWBodgpP05qrKd8exov3X97MwssqBFpTZO7l9mpO
	 1XgjkoWfkD7z7DhBKYuLFCyn6QzPwL7lz1AElvHaUWxFAfe0ZAv8/tYmLdupU9MVKF
	 qMO3sm/umQYwII5IAmcBksEEXblDFEvo6Imhf75qQpGeApzwStt7tOrW840+OkPtuJ
	 eTlm1ebWm5y/ipY3l8r4AyfX4rYIGsdCDp+gghTpzFHiVnQ2UdiljvgLhv8++yI9jN
	 ++h/N6UZNpNuE2iZHI+nedSYY9gYil9vYYT9APSb7E3GUgh5NyqeOUUZX9o48DlSwM
	 WInKSEsQTETog==
Message-ID: <a9b1ae13-7ecd-41bd-b549-35185b7e701e@kernel.org>
Date: Wed, 2 Apr 2025 16:59:36 +0900
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: ATA WRITE DMA Timeouts and Link Reset Issues
To: Naveen Kumar P <naveenkumar.parna@gmail.com>, cassel@kernel.org
Cc: linux-ide@vger.kernel.org
References: <CAMciSVX_wQNM9NQeOsvC=OwcqFhfa3=eBoNZ_TX1YVqbxBNMpQ@mail.gmail.com>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <CAMciSVX_wQNM9NQeOsvC=OwcqFhfa3=eBoNZ_TX1YVqbxBNMpQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/2/25 15:40, Naveen Kumar P wrote:
> Questions:
> 1. What could cause periodic WRITE DMA timeouts followed by link resets?

The drive not responding (drive failing for whatever reasons)

> 2. Could this be a hardware-related issue (e.g., cabling, drive aging)
> or a kernel bug?

It always can be a bug, but it looks like this is with a kernel version 4.4,
which is really old. Please try with the latest kernel. We do not debug older
kernels.

Hardware (SSD) failing is more likely though. Your SSD is being operated with
NCQ turned off:

ata2.00: FORCE: horkage modified (noncq)

which indicates that it is somewhat buggy to start with...

> 3. What additional debugging steps or kernel parameters would you
> recommend to further diagnose this issue?

Try latest stable kernel (6.14). But I suspect you will see the same issue.

> 
> Complete dmesg log is attached to this email.
> I appreciate any guidance you can provide. Please let me know if
> further logs or details are required.

The errors you see are timeouts. So it seems that your SSD is simply not
responding. This could thus be a hardware problem with your drive.
If you can, try testing with another (newer) SSD ?


-- 
Damien Le Moal
Western Digital Research
