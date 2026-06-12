Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A0B63CF698;
	Fri, 12 Jun 2026 07:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781250127; cv=none; b=gIY8yeLonjafeOAruEXUOLPURxS7fiQ6+FSv+zcQTE+gxJYPGoa8hH6K/9UPumlZxxYcddSo6HiE6Xhg0LjKKABg/KYjXdhzJZViu1ZqWUGEviH2CVzsiCacGMfaVWJxyPSYJ1M1jXg+gmFeCuROpZCAOHvjR9VzjUuVBqX1Enk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781250127; c=relaxed/simple;
	bh=svnQHefbqWa8+tj1ux+Qi7ibjPUQJrevyxfh+QrAH10=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fFU6zxvJ48o12iNJR1ZvBJBOhmmdRC+irhwSv4XUr+qg9+7x0sjcFKO/MeTiPk8tweGlqfIoXgt5bdRmAFwfIjKozBbMpSaceiAJIm/lbtxb0JgIqOvDeN4I2QjzcU42b18WEqRQXdyQQ6vPVFq/TNb8hiOQNyi84Ds5i9ygC5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jIXRjMWH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jIXRjMWH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EF7F1F000E9;
	Fri, 12 Jun 2026 07:42:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781250125;
	bh=sYrAsvI1TMF27BlrtJzOPze0/0VOjh6khegUzr2P/Qo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=jIXRjMWHSdwGkN9KbAxMu7t170aOYoNSShkBDfYNzIXHy3dSBnrFDr7Vruq3NmIlD
	 FXuI3U7U53i9nQ56I256kLCl2GK7gIloiaI0VopPI7s1NLTmHZ/AKzcN2oZ9ERDHDO
	 b4z3m1jkUspR8rF53nEbNpUHX4FeYZOLEEQlkCKHEYNa9b4DmAr3MwbrzAUu/LfeL3
	 fEJohA7y0WhkdXthmC85ixEN2EvzSQQw9Oood/G8IePcOAvv4SIfD7Ru4L4TorPmnf
	 A0MCGtkzA1N8TRBOpmZNHe0QF8wpoa/c4c+nQSew1A0X31cgILWl582de76LYqizSf
	 Yk6OHtnCiWk7A==
Message-ID: <bc1234d8-c202-4418-b85f-7672c667ceb1@kernel.org>
Date: Fri, 12 Jun 2026 16:42:03 +0900
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] ata: Consistently define pci_device_ids using
 named initializers
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig_=28The_Capable_Hub=29?=
 <u.kleine-koenig@baylibre.com>, Niklas Cassel <cassel@kernel.org>,
 Mikael Pettersson <mikpelinux@gmail.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1781248922.git.ukleinek@kernel.org>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <cover.1781248922.git.ukleinek@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 6/12/26 16:35, Uwe Kleine-König (The Capable Hub) wrote:
> Hello,
> 
> (implicit) v1 of this series can be found at
> https://lore.kernel.org/linux-ide/20260430170612.510869-2-u.kleine-koenig@baylibre.com
> 
> Damien asked to rework the patch adding more line breaks to make the
> resulting lines shorter. I didn't rewrap all arrays, only those that
> appeared too long to me; the longest line I kept is:
> 
> +	{ PCI_VDEVICE(NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE_MCP61_SATA3), .driver_data = GENERIC },
> 
> which is short enough to not trigger a checkpatch warning.

Yeah. But we tend to stick with the old 80-char max lines.
But no big deal as this was already a long line anyway.
That said, it is a chance to rewrap that too. If you are willing to send a v3,
we'll take it :)

Nevertheless, overall, very nice cleanup. Thanks for doing it.

For the series:

Reviewed-by: Damien Le Moal <dlemoal@wdc.com>

-- 
Damien Le Moal
Western Digital Research
