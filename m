Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C257275B15;
	Sat, 18 Jul 2026 03:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784344016; cv=none; b=jjDK1FBm0k125Gmg7l8fztKCQ5jUqbP7w4fdRbZUQO1qe1Xev07wzQlL1dCWHQxIB6rUQlBC9XXpRgRzxHQO3FcwkxZTThYPqX9wKN9sst5+97DILr5gaQm0/lxGG/t3cw7q/wGDav4PfL7jlFL0hZJN8CtJ8q73L3EIzCnxSeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784344016; c=relaxed/simple;
	bh=p4JOB36lGcXPFHPbt56Bg74bGnjwWfVYuns2nlJL0RQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u4RC3vHVy+P1XjQA9cNTgMDOlowdcbtrQiAhRRFuH8vvi4JXHnhiszu+WgyPD0JurrYSN0/qfv+rb6vqo+hoZ7/j8rm7eDjR36m7OWdQpje5fwmCvaXut6MnNDTirxNY8kVf/UDh0NTvUbHn2Vs0mCNhIxumeOL1KsXWLKOCy4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iqng4EZ7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iqng4EZ7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52F731F000E9;
	Sat, 18 Jul 2026 03:06:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784344014;
	bh=uR5S0lZ/RW8bcQ30G7ut92wNe6S6K/xrg98kIv24WU0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=iqng4EZ7lXnuFin1qMNho5aQGpHf1qA/6+Zh0okDapYrEnmAphs6ahQcSqEW/JYdA
	 9o2JodyVDPpGoKNJtNt7gwWhYGI1kx++28xbfEp0qEyMhX0a2S26VIG8hOlk65IJ46
	 1lnFQr0HfENBbiRetJZvAcVedfPv8Vdk8IMjBbLKW3opuhXUZJ8qdgjB0KStBvcjAD
	 ZWP73epa5NVhuj44RHEv1hbHQ2cVHsUpe+9i1Hmmgv1y0kUUTqu5jIZUAd3lpt05pf
	 K0JTPbzsG6S3q4V54Q9jYUfvHAs8DC+eGDU4iTmdHiOrZV+FxsaM3EKW9ZHVclsTdj
	 jNaVvQZmXAEPA==
Message-ID: <68fd3c1a-e3b7-4689-898f-d47e95e5fcc0@kernel.org>
Date: Sat, 18 Jul 2026 12:06:51 +0900
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ata: ahci_da850: use devm_platform_ioremap_resource()
To: Rosen Penev <rosenp@gmail.com>, linux-ide@vger.kernel.org
Cc: Niklas Cassel <cassel@kernel.org>, Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling
 <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 open list <linux-kernel@vger.kernel.org>,
 "open list:CLANG/LLVM BUILD SUPPORT:Keyword:b(?i:clang|llvm)b"
 <llvm@lists.linux.dev>
References: <20260715011658.1284298-1-rosenp@gmail.com>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20260715011658.1284298-1-rosenp@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/15/26 10:16, Rosen Penev wrote:
> Replace the open-coded platform_get_resource(IORESOURCE_MEM, 1) plus
> devm_ioremap() sequence with devm_platform_ioremap_resource(pdev, 1),
> which looks up resource index 1 (the power-down control register),
> reserves it and maps it in one call, returning an ERR_PTR checked with
> IS_ERR()/PTR_ERR(). Resource index 0 (the AHCI register block) is still
> mapped separately as hpriv->mmio via ahci_platform_get_resources().
> 
> Built for ARM (davinci_all_defconfig + CONFIG_AHCI_DA850) with LLVM=1;
> drivers/ata/ahci_da850.o compiles cleanly.
> 
> Assisted-by: opencode:hy3-free
> Signed-off-by: Rosen Penev <rosenp@gmail.com>

Applied to for-7.3. Thanks!

-- 
Damien Le Moal
Western Digital Research
