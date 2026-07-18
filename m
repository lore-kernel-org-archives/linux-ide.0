Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACD7163CB;
	Sat, 18 Jul 2026 02:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784343145; cv=none; b=CD9c756psp++4nNvhRWHZwpGyiGU7wm+ajgb7Ma4qPPPTD2D+n1RNLIQnT4bWbGcX8LMMpPUp/iVdUxafAYJs3Zin2e6MxKbw8uDb5lQUlxkn6UcdWjpum2KNwCWD3l4Mi93Gv+vPq/bpMB5lC2bOi8Nn4fBY8K8Xab6mUU0lg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784343145; c=relaxed/simple;
	bh=vcieVS/MuvF+8Xq/Q3wLA+Y8T7kWawQMmSkHdURqSWM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CuNHLd+7gnyhOSGaP4K4rhS+T+QCSN2kHPwdn5yG3Xm5wHqjTwtbi/ySjqHq8Z4gr2UiDsThiiHMtPwhHK8XbwQnKpzXOL4oR6ifnXeJY4dqWZLVMiIMkAGqHPzE0XVcPeSCyqPvpsyge4TingNs0q79RWcOP8pg7vpeIeTGNhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HytXP9mn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HytXP9mn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B73C01F000E9;
	Sat, 18 Jul 2026 02:52:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784343144;
	bh=wary494sf+tZ/Y242ROIj6qSUtjFdHTqFLjIC5oB9QM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=HytXP9mnJEUP8QBpN4DMlrCHkZMx/MstL25HKbswlykG5GtZaxI1r+Pc69Fiaa6Qm
	 JZkeGDSDe5S5EAkB+MQJ+x//vdGkU4fSO53KyMmYIVIdfDCnxLtEPQvmRK7LH7/va9
	 okVbSPBEh/iyMF6RH4ze816BVi9d2gBmkd5XTRGJCEgMbv5VVD7gS6uxac2yCau+gg
	 Dc6l8MqkIP0T5JKOWJ+NI5RgL2TLbVsLm1KfNsYFqD2IZVFY07PccDL/auC4h93rJh
	 L7UEx/6mVLbttQNlYWly1VCjpAm3sFCJpa1x2RrhGC/5myn6ibfISOwaUgT4SMhJRG
	 pM9n4RYqTFh6w==
Message-ID: <49f67374-7c55-4aad-999d-3a74ffefe7ae@kernel.org>
Date: Sat, 18 Jul 2026 11:52:22 +0900
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] [RFC] libata: Don't busy-wait for PIO data-in command
 completion
To: Richard Weinberger <richard@nod.at>, linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, upstream+linux@sigma-star.at,
 cassel@kernel.org
References: <20260717090404.857078-1-richard@nod.at>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20260717090404.857078-1-richard@nod.at>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/17/26 18:04, Richard Weinberger wrote:
> libata: Don't busy-wait for PIO data-in command completion
> 
> Unlike PIO data-out, the PIO data-in protocol raises no completion
> interrupt, the last interrupt announces the final data block, and once
> the host has drained it from the data register the ending status must
> be obtained synchronously.  ata_sff_hsm_move() does this by spinning
> in ata_wait_idle() for up to 10ms.
> 
> Usually this is not a big deal unless the device is slow.  In my case
> it's a CF card which keeps BSY asserted for multiple milliseconds(!)
> after the final data block.  Since the waiting happens in the
> interrupt handler, under the port lock with interrupts disabled, the
> CPU is hogged for milliseconds on every read command.
> 
> To improve the situation, bound the inline wait to ~100us.  If the
> device is still busy after that, mark the command ATA_TFLAG_POLLING,
> so the interrupt handler won't race for it, and obtain the ending
> status via ata_sff_pio_task(), which sleeps between status checks
> instead of spinning with the lock held.
> 
> Since ata_sff_pio_task() may now finish a data-in command, it must
> wait for both BSY and DRQ to clear at HSM_ST_LAST, matching what
> ata_wait_idle() enforced.
> 
> Signed-off-by: Richard Weinberger <richard@nod.at>

Looks OK to me, but the patch title should be:

ata: libata-sff: Don't busy-wait for PIO data-in command completion

I can change that when applying if you want.

-- 
Damien Le Moal
Western Digital Research
