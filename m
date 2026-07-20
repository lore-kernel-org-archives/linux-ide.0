Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 910D423B62B;
	Mon, 20 Jul 2026 23:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784591804; cv=none; b=YtLmvO3zVjKB0CsMEeF+/ynMUFmoZ6ab2B2E58GiZA+4t0Tizx3lufulBEBN4TtJnHGFthupyu+BFGJfRKkz/DEKEpRcXrKJlZLvJG2y4ljI0SnY/jNDFHeTAoiGpBgKIkI7CME5UKPXKl60wNjYwxmbCmK5vhkIavgXxWJoHIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784591804; c=relaxed/simple;
	bh=CGJZw57P69O5TYEpK0H10NkvsoFu/mqQfS+W2Jwsu+k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XPKV33H7Q1xaPGuQnJlPXaf01i78OrPT+r12C6OhjWtroemvyTRlodpVYl6bY7SHZzVqOu6/Nw/9p7GGu1vciubsVm2Kawx9pQNK4blNYE/NPtFN3nKBjjI1e2Ew/AfGMCsgKdMJHsdnC/ZmH+J5wI1pY2eZZBFiRtnyU8Ps8lQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nG2i01M5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nG2i01M5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D3FE1F000E9;
	Mon, 20 Jul 2026 23:56:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784591803;
	bh=tI7vORlL+DB+4YyVwN29M7SJQROrCvVY6k9WER4GKKU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=nG2i01M5ukbbfrovdaiV0NWU8rLTOTLTZTwB8scYQqg5Xp5tuPyFX1CaXmIUyB5I/
	 8BkFFfK/KQRiqKjVdXhCp0ocNh5zV1qmtUPvRHXZjX4jUGYKhVet/BNY53emH+gbs6
	 jU6CXufDtxYbTHvVdy3wCVuZCs6I7Ufgh9lq9acSELAbOER9Wa+zO6UTeENr5joP8U
	 8CbSrP2WSykIyVFowwnXzPJB9WH7KyaDXTpDslnD0KayfWECFQnTQOfjSyUfCb7dQ9
	 sLpd64mPytdlhFTVHFgtH65ndQEG0Zw19GqcGwXhzEP5B9QIj9z1znJLGBLSgbNDoS
	 HygKVZYEBF4kw==
Message-ID: <a174426c-ba54-4f3e-8ac8-010734f98bf2@kernel.org>
Date: Tue, 21 Jul 2026 08:56:41 +0900
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

Applied to for-7.3 with a modified commit title.
Thanks!

-- 
Damien Le Moal
Western Digital Research
