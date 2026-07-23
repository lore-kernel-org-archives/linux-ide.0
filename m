Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5BBA3ED10F;
	Thu, 23 Jul 2026 07:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784792602; cv=none; b=HYnbDNZRVVhfjqPCl5oPT6/kZtPt+0i58NWAyhtpqE4KZKdAy2OIshO1TU+Bq8uT7IBPnVtPlg7l2e8mT6LIiwbNDfSOGwg4dXbs36NNAcWNDerlKC0dkKtvx4Ey+oF5rIKgxAj6D7bD0q31f88fSTfsRRXnRiTaREb1sjzxf38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784792602; c=relaxed/simple;
	bh=YfiVjQuylJOLR8xVQg8VGMf9Q+qNRdsO5mgJLm8O3Og=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NqqT0j/SVSQ8NbcgrikYXfrJBfMbEg4t5jB2ppFSyxSrA0bzMf34G59C0SsWG1SIYWlZX+h3HwpwYutWnvjcFdxYrVp3SUaWBs3rvG0uHqwOnzkzTXfizH+qVbZcry8HbkdNzn2rxSAi5n97uOgaCrcNhTlFfKLGJXKSniQRaN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BA7C1F000E9;
	Thu, 23 Jul 2026 07:43:18 +0000 (UTC)
Message-ID: <7b5fd9c6-28b3-43d0-9d4b-14203d7c57d9@kernel.org>
Date: Thu, 23 Jul 2026 16:43:16 +0900
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2] ata: pata_ep93xx: add missing "cc" clobber to inline
 asm
To: sashiko-reviews@lists.linux.dev, Rosen Penev <rosenp@gmail.com>
Cc: linux-ide@vger.kernel.org, cassel@kernel.org
References: <20260720235952.1334318-1-rosenp@gmail.com>
 <20260721001238.8CD4B1F000E9@smtp.kernel.org>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20260721001238.8CD4B1F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/21/26 09:12, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [Critical] Trailing byte transfers in `ep93xx_pata_data_xfer()` silently corrupt data on big-endian systems due to incorrect endian swapping and variable truncation. For READ, the code assigns the 16-bit swapped result of `cpu_to_le16(ep93xx_pata_read_data(...))` to `*pad`, which is an 8-bit `unsigned char`. This truncates the 16-bit value. On big-endian systems, `cpu_to_le16()` swaps the bytes, so this truncation discards the lower byte (the correct data from the bus) and saves the upper byte to the buffer. For WRITE, `le16_to_cpu(*pad)` promotes the 8-bit byte to an integer before swapping it, resulting in a shifted 16-bit value, which causes the device to receive corrupted data on the wrong data lines.
> - [High] The inline assembly delay loop `ep93xx_pata_delay()` lacks a `"memory"` clobber, permitting the compiler to reorder it with respect to I/O accesses, which violates ATA PIO timing requirements. On older ARM architectures like ARMv4T (used in EP93xx) where `CONFIG_ARM_DMA_MEM_BUFFERABLE` is not selected, the standard I/O macros (`__iormb()` and `__iowmb()`) evaluate to empty, meaning `writel()` and `readl()` provide no compiler memory barriers at all. Because `__raw_readl()` and `__raw_writel()` are implemented using `asm volatile` without `"memory"` clobbers, GCC's instruction scheduler is completely free to reorder these volatile I/O accesses across the `ep93xx_pata_delay()` loop. Even if memory barriers were present after the read or before the write, the `asm volatile` instructions themselves lack dependencies and can be swapped.
> --
> 
> --- Patch [1]: [PATCHv2] ata: pata_ep93xx: add missing "cc" clobber to inline asm ---
> commit e8afdf774c87485ee82a0fe97b982fc47fc827bc
> Author: Rosen Penev <rosenp@gmail.com>
> 
> ata: pata_ep93xx: add missing "cc" clobber to inline asm
> 
> This commit adds a missing cc clobber to the inline assembly in
> ep93xx_pata_delay() to prevent the compiler from reordering flag-dependent
> instructions.
> 
>> diff --git a/drivers/ata/pata_ep93xx.c b/drivers/ata/pata_ep93xx.c
>> index 42a24dc51d26b..0bb748a86ac6e 100644
>> --- a/drivers/ata/pata_ep93xx.c
>> +++ b/drivers/ata/pata_ep93xx.c
>> @@ -211,6 +211,7 @@ static void ep93xx_pata_delay(unsigned long count)
>>  		"bge 0b\n"
>>  		: "=r" (count)
>>  		: "0" (count)
>> +		: "cc"
> 
> [Severity: High]
> This isn't a bug introduced by this patch, but since you are updating the
> clobbers in ep93xx_pata_delay(), should this inline assembly also include a
> "memory" clobber?

Rosen,

Can you look into this please and fix it in this same patch ?
The other critical problem can be fixed in a different patch.


> 
> On older ARM architectures like ARMv4T used in EP93xx, standard I/O macros
> can evaluate to empty, providing no compiler memory barriers. 
> 
> Without a memory clobber here, the compiler optimizer might be free to
> reorder independent I/O accesses across this delay loop, which could violate
> ATA PIO timing requirements.
> 
>>  	);
>>  #else
>>  	while (count--)
> 
> [ ... ]
> 
> [Severity: Critical]
> This is a pre-existing issue in the same file, but could the trailing byte
> transfers in ep93xx_pata_data_xfer() silently corrupt data on big-endian
> systems due to truncation?
> 
> For READ transfers, the code assigns a swapped value to an 8-bit variable:
> 
> drivers/ata/pata_ep93xx.c:ep93xx_pata_data_xfer() {
>     ...
>     *pad = cpu_to_le16(ep93xx_pata_read_data(drv_data, IDECTRL_ADDR_DATA));
>     ...
> }
> 
> Since pad is an unsigned char pointer, this truncates the 16-bit swapped
> result. On big-endian systems, cpu_to_le16() swaps the bytes, so truncating
> it to 8 bits discards the lower byte containing the correct data and saves
> the upper byte instead.
> 
> Similarly for WRITE transfers:
> 
> drivers/ata/pata_ep93xx.c:ep93xx_pata_data_xfer() {
>     ...
>     ep93xx_pata_write_data(drv_data, le16_to_cpu(*pad), IDECTRL_ADDR_DATA);
>     ...
> }
> 
> Promoting the 8-bit pad value to an integer before swapping it on a
> big-endian system seems to shift the byte to the wrong data lines, sending
> corrupted data to the device.
> 


-- 
Damien Le Moal
Western Digital Research
