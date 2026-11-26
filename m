Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795678217;
	b=OD5zJNkMoQPInR8j3i8f7yCTbePxMIc2N+UDUYJyVcoa24o4bW/WbVHbptlZA0gGZxlg
	 3OI5uwKbTaeTsVhqZ0oqX5UVBlc00+DfNli47Y5l4IBdWccBoA16bQaJqh7Ea3eW77kQO
	 yiPdG0VHUlDaO5MS3tJPv+5wAZ2dbCkHmK/DzpssLZ8F0p1LoqNMITIG8yMW8EJU/QtFg
	 F2O09E206WTzFoBkv08jWVO/Ir/3dXgvPLsZ3keKI7H3FZZaVEXs2Xr3Bjpopvx4e2lfQ
	 s5h/81e0g/4FREBT+KqqR+n+ctJYxpwDTNg/AZ7vQE/4r9xR8Ak4u9yxUNeLcN5jbYA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795678217;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:Organization:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=V4dFpyirrkb+PtIKHe7qL0g9hFgT7M3wKNeLq15vw/g=;
	b=imbnTxCdcOxC1qssyatlQG/Y9VvturIMKdzDoex855zB37iK4GpFAymTMxjI0L1sT3A4
	 8wLHXPlJdiHux57P5BozkKABdxZ+SXrZLXvsDzoTbQiEoHv0LJqJC0Pazs9yEEzp23nM7
	 f+BV0ihXngeNnqFXFoFndAf0Pv/+9Cp+N6Jo/fwRsOhVMq/VmNuUT3TWLl0OkI1Vo6nlt
	 tm6YlbzPIF9rtMwmWkVFrJvtyVkx25SdknTc8e1b3nkzbqFi/DFIXbqIQbLHNFygI7G9Q
	 rNOa1iuQUWdvqqSzXs7VaiukVrBUsvUUkIRhrG5O8uutS7O6Nyx/G8MtziavMaGVRAA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DIxaelPO;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F5B9606A326;
	Thu, 26 Nov 2026 07:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DIxaelPO
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0827E1F000C0;
	Thu, 26 Nov 2026 07:30:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795678216;
	bh=V4dFpyirrkb+PtIKHe7qL0g9hFgT7M3wKNeLq15vw/g=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=DIxaelPO5cg4N9O3ZR66whOeGOK2iTxAOwAowHPM7qHHmc0e26kcM079jJck5dKDA
	 8oLznhsBKHxx3rve7yJUFbA+KrokNHml+Od/IBrZz+6NOuEPwreSp5OnZhzxHGQgtT
	 g7AEFTovctfCb0M/9uVKP2KpHLN+x0f1nS3zpOwssfS4xZIN1EAORs0qeDkAwe7ruF
	 ENF2VGJW00o29JpG9wAJqJJac/UbywiDqod/vSekEP0BfCx4dRGp8FXLIhTsmTcnee
	 Lh/yBgix5cgXTb5uQgvQIwWu1TREHsrdymxMbhCvXe2KvbRx3R71m+isftAz/jCUFU
	 nCOaxhYBfv3CA==
Message-ID: <5e79c0fa-3522-46ab-99a7-fb08aea79e73@kernel.org>
Date: Thu, 26 Nov 2026 16:30:14 +0900
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Post: <mailto:linux-ide@vger.kernel.org>
List-Help: <mailto:linux-ide+help@vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-ide+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] ata: sata_gemini: add missing newlines to error
 messages
To: Artem Novak <artem122novak@gmail.com>, vireshk@kernel.org,
 cassel@kernel.org, linusw@kernel.org
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20261126051523.14431-1-artem122novak@gmail.com>
 <20261126051523.14431-5-artem122novak@gmail.com>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20261126051523.14431-5-artem122novak@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/26/26 14:15, Artem Novak wrote:
> Terminate the SATA clock lookup error messages with newlines
> to keep kernel log messages properly separated.
> 
> Signed-off-by: Artem Novak <artem122novak@gmail.com>

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research
