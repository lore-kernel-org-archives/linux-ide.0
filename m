Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F209923D2A1;
	Tue, 22 Sep 2026 03:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790046928; cv=none; b=UigbISOeXEZPFRiofAYUTT0bvEhsQfE69DndQPKpE/7PPhxoRfLM3JkXcJ9L6QWLD5X/9gha2eNFVAR3x+Bxt+wd5oWnPMjNbrCKKdxi8sq9rlgX1omdGuYm7RzD/LTcl677rscxB9cp53yn0Y+zA0Toks1hS+KGUJg1dCR/edo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790046928; c=relaxed/simple;
	bh=D8RSodxz5wnlYhy363Z8I2sM9SaU5zj6vpfYAYP/mZU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bOJA60CQbT9pv9sd5LyGLvdFhHAFQT5WIxZhPXMGTecipt410dtgnAMqit0/EjO1ReVwdtLqBrXtjGqPoOdVST20RdjvFte9e8SUzLB9jkFsHWe31AI1y425NDVja7mWdb/Npkpk+AMsceQ/He4kEaTjUE6vZmNWXTZuBpgqqZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LLpy1M/o; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LLpy1M/o"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5E841F000FF;
	Tue, 22 Sep 2026 03:15:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790046926;
	bh=lkvHg5B32WXSW8Eqp6vF27+ViO8pw2Klh9/bfHz7i60=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=LLpy1M/o9DzGYFgRPZxBWEw2bDTxh3RXAdp+LWvz7FVuq7ctFxRWYnjifMp0uLCg5
	 C1yHr1m7SL9OjANT1Jl9olgqQQ58R+bxyb7pfN6DiYH0N8xDBt9LoqeA5ffFOoFmJZ
	 kdmYMpWZ7NKOfFPwGMcq/Tcllo71lqy+arIN3fP8B1kkQARb1has7iCMlD1T+B4fSv
	 enn+sFLPMXF/aTfpKPvdw4ETOPYQRBFpuEoI+fFcry4yBiH/qgf1mpTCqjfZh/X5et
	 OL/0wZ6RghTZPe9uZV9/XL1rsSMAK3HzxXVk+gjfsCRY7TnF5YTBR6jVUvwvwf8N4k
	 9JDW+iUtHy1OA==
Message-ID: <27251f00-04b2-4525-992a-904f3a8247b4@kernel.org>
Date: Tue, 22 Sep 2026 12:15:24 +0900
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ata: libata-sff: replace kmap_atomic() with
 kmap_local_page()
To: Danish Khateeb <danishkhateeb03@gmail.com>,
 Niklas Cassel <cassel@kernel.org>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260921182448.194307-1-danishkhateeb03@gmail.com>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20260921182448.194307-1-danishkhateeb03@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/22/26 03:24, Danish Khateeb wrote:
> kmap_atomic() is deprecated in favour of kmap_local_page(), as described
> in Documentation/mm/highmem.rst.
> 
> ata_pio_xfer() and __atapi_pio_bytes() each map a single page, pass the
> address to ->sff_data_xfer() for one transfer and unmap it again, so the
> mapping never leaves the function that created it.
> 
> Neither needs the pagefault_disable() and preempt_disable() implied by
> kmap_atomic(). ->sff_data_xfer() only moves data between the device and
> the mapped buffer, and both functions are reached only through
> ata_sff_hsm_move() with the host lock held, whether from the PIO task,
> an interrupt handler or EH. kmap_local_page() is fine in all of these.
> 
> Tested on i386 with CONFIG_HIGHMEM4G and CONFIG_DEBUG_KMAP_LOCAL_FORCE_MAP
> under QEMU, with the PIIX IDE controller limited to PIO by
> libata.force=pio4: O_DIRECT and buffered reads from an ATA disk and an
> ATAPI CD-ROM, and O_DIRECT writes to the disk, all checked against the
> image files. The O_DIRECT buffers were in highmem. Both call sites ran
> in hardirq context, and ata_pio_xfer() also from the PIO task. No
> warnings with lockdep and CONFIG_DEBUG_ATOMIC_SLEEP enabled.
> 
> Assisted-by: LLM sparse
> Signed-off-by: Danish Khateeb <danishkhateeb03@gmail.com>

Looks OK.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research
