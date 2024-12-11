Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DD011F2395;
	Wed, 11 Dec 2024 22:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733957624; cv=none; b=SX0fY1wnH6zbBOEaq484vZM70DSq3pL9cqId6wT2sgpMSFI1UBbEM5bjouYIea32CiG/XoQ1+aTDq0sJCp9gfA+TEjKFUmeN0m3RafOiAo7TczpO3bzKJyFF7sO/NVmBlZgxb0Rga/QQAelJWLub3jQHAFbG1Y7voBTjKZdpNQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733957624; c=relaxed/simple;
	bh=wVSNOH6u4FTmDwvcAz5QnT7H4sQvF7ruHANUwyK3/DI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h/FlsK5S4HXkR+hl7fA3/lzatePmjp2OfJItVO7EqaQnLZlYazuYXki88N1i00ihF/qrRrcN6BNJfoe86HfTBr/rNU0IU6UWbfr0OhdxoIq9G87FRjBWwwH1BVcayWNDvxrTxfmHT/+Ib5re8O1JH4YgQvq9qBEjLiUKlkCI+Zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RpTLodq4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RpTLodq4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40E18C4CED2;
	Wed, 11 Dec 2024 22:53:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733957624;
	bh=wVSNOH6u4FTmDwvcAz5QnT7H4sQvF7ruHANUwyK3/DI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=RpTLodq4bRWFG7QjAKEWqgFLGlxNywNIoEPGBh6tb/S3NTiASWjiPLU0M/SL3AHbE
	 A3GwBe9liytQyxBzlndBc9gfd6q94hHBgL0PVtGIi2aVG7AzPc7JFFDVpD4GN5oIkp
	 VQu0TT1JhwuZT5G6060GgFwKXL4W5gmJUZBSHCY8Twx3753H8m2IPBKdJ/m64HL9Px
	 7ezhyoeZCRCY1bn4aPLANHVZinWee+nkL4zRczslfqe+TMGi/Ljeabp3v9RRIaVu71
	 4sdeonkWSOuYi5y00YczfWcD2AFaPU8OnlJ82anRksRgOdfvq+T5kRW16f6hSNsN4v
	 snu+zYREG9Pdg==
Message-ID: <d74c3d02-e4e2-4f78-bf30-3940f50af39b@kernel.org>
Date: Thu, 12 Dec 2024 07:53:42 +0900
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ata: sata_gemini: Remove unused
 gemini_sata_reset_bridge()
To: "Dr. David Alan Gilbert" <linux@treblig.org>,
 Linus Walleij <linus.walleij@linaro.org>
Cc: cassel@kernel.org, p.zabel@pengutronix.de, linux-ide@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20241211011201.261935-1-linux@treblig.org>
 <CACRpkdaarPM3vx6vAVhdSv+KHDZq6MTDo0JpQYGj1gJnaE7OrQ@mail.gmail.com>
 <Z1oI6cAAhGrcIVw9@gallifrey>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <Z1oI6cAAhGrcIVw9@gallifrey>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 12/12/24 06:49, Dr. David Alan Gilbert wrote:
> * Linus Walleij (linus.walleij@linaro.org) wrote:
>> On Wed, Dec 11, 2024 at 2:12 AM <linux@treblig.org> wrote:
>>
>>> From: "Dr. David Alan Gilbert" <linux@treblig.org>
>>>
>>> gemini_sata_reset_bridge() was added in 2017 by the initial
>>> commit be4e456ed3a5 ("ata: Add driver for Faraday Technology FTIDE010")
>>> but has never been used.
>>>
>>> Remove it.
>>>
>>> Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
>>
>> Right it was never used because the corresponding reset in
>> the low-level PATA driver didn't work so I patched it out before
>> submitting.
> 
> Ah right.
> 
>> But should you not also remove sata0_reset and
>> sata1_reset from struct sata_gemini and the code fetching
>> the two reset lines? And even #include <linux/reset.h>?
> 
> Oh I see, I was just looking for entirely unreferenced functions
> but that takes a little more following to notice.
> 
> I'm happy to do that; are you OK with it as a follow up patch or
> do you want a v2? (And can you test it, I don't have the hardware).

I already applied your previous patch. But I can replace it. So either an
incremental patch or a v2 is fine with me. Thanks.

> 
> Dave
> 
>> Yours,
>> Linus Walleij


-- 
Damien Le Moal
Western Digital Research
