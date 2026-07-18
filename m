Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDDAD28A3FA;
	Sat, 18 Jul 2026 03:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784343886; cv=none; b=EK0A+NI3QaPL9nGkQGM8yI03kjsfkGecGJ1gP+9oL/h/+7EjMsa4MxkJ9q/ATU7ePBKoMVJaMIgddHFdwlhOBnXnsQ710s+O4U/nrfgNFWYjE37w9eQKuAVLEFLdtY5aiKPvnrMjbqnQQN7kAtCA7md34ZQ0p5FtMQA0ISplVlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784343886; c=relaxed/simple;
	bh=/tcQOrv/G2uf0kpud2nAvXn7MEaXdPaLuPGmWuh5eEU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UIb30MR1FfioQqmgFQRzU4dTongWgAs5WPgu79Hr3kOolFvXz2panM4d0bFSfPCpOiqxlLxnGPrOFvzxi+TPWneJkNNktCm5EE1fa6QxOiNGpo96ALuL1cPwSk+6K8HawXIdmyPQCz291i+X9ocyGKKk2yB27rb6mYEblVdQuxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PrRSHdvj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PrRSHdvj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B6A91F000E9;
	Sat, 18 Jul 2026 03:04:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784343885;
	bh=4Bt/rWsA2Gs0rnRPZia1FxqctfjOq7NUIwAxV3FX0Wo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=PrRSHdvjqfazDwMZuSrhkKVW+Qe4PpfwCZALSVjwO+JLjaTyuljaWqgYHPz1Dwj+s
	 A9L6wHwEtgL9BcKKHGPpQReDVajT/1kD+6B0L18bcqB1U9oOL2EUNYdDE61KqiGU1E
	 0b8krFI0PbK+hnf037cseHj7LRX3v00G2U29/EpPxNBnXm0wVZwlx2WQnPuj9R9mfM
	 /JF/sDCKoRo4H8E6UYnqI+UQGSK9GzlJkj9lJJ4P/UG3VF1x0jopgBqhwKvHheASpt
	 0w6gv3NZPEtQ7ojorstx47BHJNZI58rwKUF+AsBuKvFxg/I0+49RGGUUYoJOodft1R
	 pXXF/ghsQ89IA==
Message-ID: <65196e27-610e-4b57-8e5e-0af7e8eef06d@kernel.org>
Date: Sat, 18 Jul 2026 12:04:42 +0900
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ata: pata_pxa: use devm_platform_ioremap_resource
To: Rosen Penev <rosenp@gmail.com>, linux-ide@vger.kernel.org
Cc: Niklas Cassel <cassel@kernel.org>, Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling
 <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 open list <linux-kernel@vger.kernel.org>,
 "open list:CLANG/LLVM BUILD SUPPORT:Keyword:b(?i:clang|llvm)b"
 <llvm@lists.linux.dev>
References: <20260715011343.1270261-1-rosenp@gmail.com>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20260715011343.1270261-1-rosenp@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/15/26 10:13, Rosen Penev wrote:
> Replace the open-coded platform_get_resource() plus devm_ioremap()
> sequences for the CMD and CTL ports with devm_platform_ioremap_resource(),
> which fetches the resource, requests the region and maps it in one call.
> Switch the error checks to IS_ERR()/PTR_ERR() accordingly and drop the
> now-unused cmd_res and ctl_res variables.
> 
> The DMA port keeps using devm_ioremap() as its resource is
> IORESOURCE_DMA. The CMD (res 0) and CTL (res 1) MEM resources are
> disjoint in the ATA task-file layout, so the added region reservation
> in devm_ioremap_resource() does not introduce overlap failures.
> 
> Built for ARM (drivers/ata/pata_pxa.o) with LLVM=1.
> 
> Assisted-by: opencode:hy3-free
> Signed-off-by: Rosen Penev <rosenp@gmail.com>

Applied to for-7.3. Thanks!

-- 
Damien Le Moal
Western Digital Research
