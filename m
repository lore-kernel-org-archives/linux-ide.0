Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEAFC1E8823
	for <linux-ide@vger.kernel.org>; Tue, 17 Dec 2024 11:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734434139; cv=none; b=NJJdbMjNaHwiXWSBlKViOPQvynWJ+t3OJ5VETitxWxLW3aEBVbLo/Na0LLzl7QQWi27Q7GMFVC7Iq7nQTs5zINtzs44UgnXrlkZi+n4WqX8hH+IgPVbJtX7K2dKw2BGAxR42MGhzfjd+0UYKXTG+6D9zBZMpSSAgtN0v0qBzuxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734434139; c=relaxed/simple;
	bh=Z6IdxfK6vqvA0S/1vdJGKoA9ikcRPB356mSHGGKqHdg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ujwOv1j7i5dnTAiFX4Hwz3AYErrEdrOgzhWGD2RUvXHbBkTB+KRj6fQzevY1u1G1u6pbpEX3mJtUFz0ENc3ntt4KvigLeaRdReErFcsIFLOAVeu1yvF8yMA6WW3WhdVGqb/wK48QKFaL6YiYdGFW+CCrfpKtRyFtydEhz4eifZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IOJROs/G; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IOJROs/G"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABE9FC4CED3;
	Tue, 17 Dec 2024 11:15:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734434139;
	bh=Z6IdxfK6vqvA0S/1vdJGKoA9ikcRPB356mSHGGKqHdg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=IOJROs/GhIc+zbJaImgEVqe5A/hcdYTyQ4rVvYypsIaMenjRqFxMWDQiPo/QU0KBR
	 4uUktt6LYHU3zCC9pDpc4Ft/26C1TFWkM+6Vf3+6DgrYsWs7iBSLJ3+iKOWdBEUEvW
	 CAi5XbzPoJqI7ICParmCE3LEwuE2JZc8UWwq5XgWSLGiMMbWbdgi0eKShEnyzLwRk+
	 Y1cMZz3Von4uraM85/7f3uwoeRDvShW42Bfv/qPkBbWkp0q1bQLRMOmuO2y4ds+hx1
	 bosHlayILESdA0JIncM+QLMwzLmtPifm87CaGW1ymUvsspKRKIA37U0iwsVNe8S67t
	 T4mATMWFesaNQ==
Message-ID: <66ceb32b-a719-420b-a79c-35b509580edd@kernel.org>
Date: Tue, 17 Dec 2024 12:15:35 +0100
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ata: sata_highbank: fix OF node reference leak in
 highbank_initialize_phys()
To: Damien Le Moal <dlemoal@kernel.org>,
 Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>, cassel@kernel.org
Cc: linux-ide@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>
References: <20241205103014.1625375-1-joe@pf.is.s.u-tokyo.ac.jp>
 <5d847931-218a-4bdb-b225-a5fb4a09c096@kernel.org>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <5d847931-218a-4bdb-b225-a5fb4a09c096@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 09/12/2024 01:14, Damien Le Moal wrote:
> On 12/5/24 19:30, Joe Hattori wrote:
>> The OF node reference obtained by of_parse_phandle_with_args() is not
>> released on early return. Add a of_node_put() call before returning.
>>
>> Fixes: 8996b89d6bc9 ("ata: add platform driver for Calxeda AHCI controller")
>> Signed-off-by: Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>
> 
> Applied to for-6.13-fixes. Thanks !
Considering that:
1. Few other fixes reported by this static analysis were bogus and never
tested,
2. Missing of_node_put is entirely harmless, absolutely 0 effect, no
leak of anything, nothing to worry, no-op code currently,
3. But a mistakenly added incorrect of_node_put is a use-after-free bug,
4. This was in the kernel for long time, like 12 years (!!!),

then I really do not understand how it could be a 6.13-current-rc-fixes
material.

That's just wrong and possibly causing more harm. Really, please stop
sending trivial static analyzer fixes for 12 year old bug to current RC.

This was brought several times, last quote:

"I'm definitely not reverting a patch from almost a decade ago as a
regression.
If it took that long to find, it can't be that critical of a regression.
So yes, let's treat it as a regular bug."

Best regards,
Krzysztof
