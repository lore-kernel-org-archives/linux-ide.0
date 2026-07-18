Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A287B279903;
	Sat, 18 Jul 2026 03:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784343742; cv=none; b=PFTDcCzTYWmcZ5PNKGTlyy4WIiSrjT3fCoFrhjwiNPiGcLaZFbUV9SZbhw+d8Axwm5WwsXRlvT7Hs48uQGDOnwiQg+P+1tVLesFXuP/A+b4sZgCuu3HXSguDJz2on9UT8uyPSZaGdjXG0N9zER2lfHk77wLUE/fmug1Wk6fzpgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784343742; c=relaxed/simple;
	bh=1y0pmZy1zZiAQ5iqOmSMzEJGZNXdlWKieX6xJeXD3Us=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=l4Ph45P9dqNdzWrrrmxkIpsHBqXr3K7EvLsGs4KCQIZ2m0akp0Nbz8k05vdDjPTpFuy3NbW7esmC5CwMqiUaonYJ5yKpDpSnJYEJgxer2UV0BdqynzS3iF0/gnTvOK1cocihA8vWBG5heEjEeouMcHjlN3dwhEbBdLPfQ4DE+Jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y4WbxG+h; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y4WbxG+h"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED7301F000E9;
	Sat, 18 Jul 2026 03:02:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784343741;
	bh=H4e8ODCgXF9YsjLnROy+1O4qWV09iwJI71DEeUIbIsw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=Y4WbxG+hYG6rm+rmAinVd5PBYW/f5TdqbdjlS40QYI5w0PV8auALhM/bAXdNg6C6k
	 p4eMHa7Gw7IFldNQp7nyV+5+W1bm3Hen2AkxJgBgzMgAQ01hhTLfzH1P14iHjos8XR
	 AExh2+h5FH3LqEQasHn9YmCGRpy4nLnUHN67ARKNvt12g5Wyd2r2G6NyVwxwPxx/vx
	 rISFHEle8ewbTga1ne8YLfeUkJBw8kn1ExqKVqxgOBj+MUxffhTvwet1Vr7k1wMni8
	 NltmCoQyJB5YjW8H/uxeuPA66qgPYJIE7fSAkoqg+vjNbstELSh0v/kgjGoy2ULFU3
	 uDQA+vjmm7o1w==
Message-ID: <0dec403f-2c88-4197-b25f-5b112f418e41@kernel.org>
Date: Sat, 18 Jul 2026 12:02:18 +0900
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ata: pata_rb532_cf: use devm_platform_ioremap_resource()
To: Rosen Penev <rosenp@gmail.com>, linux-ide@vger.kernel.org
Cc: Niklas Cassel <cassel@kernel.org>, Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling
 <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 open list <linux-kernel@vger.kernel.org>,
 "open list:CLANG/LLVM BUILD SUPPORT:Keyword:b(?i:clang|llvm)b"
 <llvm@lists.linux.dev>
References: <20260713232143.1114497-1-rosenp@gmail.com>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20260713232143.1114497-1-rosenp@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/14/26 08:21, Rosen Penev wrote:
> Replace the open-coded platform_get_resource() plus devm_ioremap()
> sequence with a single devm_platform_ioremap_resource() call, which folds
> the resource lookup and mapping into one step and returns an ERR_PTR on
> failure, checked with IS_ERR() and propagated via PTR_ERR(). Similar to
> platform_get_irq(), it can return -EPROBE_DEFER so move it early.
> 
> The pata-rb532-cf platform device (arch/mips/rb532/devices.c) provides a
> single IORESOURCE_MEM window at the DEV1BASE chip-select, distinct from
> the other RB532 chip-selects, so the region reservation now performed by
> devm_platform_ioremap_resource() introduces no conflict. The mapped size
> is unchanged. Drop the redundant error message, as
> devm_platform_ioremap_resource() already logs on failure.
> 
> Built for MIPS (rb532_defconfig) with LLVM=1;
> drivers/ata/pata_rb532_cf.o compiles cleanly.
> 
> Assisted-by: opencode:hy3-free
> Signed-off-by: Rosen Penev <rosenp@gmail.com>

Applied to for-7.3. Thanks!

-- 
Damien Le Moal
Western Digital Research
