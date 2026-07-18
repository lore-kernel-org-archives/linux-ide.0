Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9525922F74A;
	Sat, 18 Jul 2026 03:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784343980; cv=none; b=PgZnaVeeTbbDlYbHPTLabVQKlu/HSQONqGj6j/S7GfK2QrQ897c8zsdi84woTT85M0nZ986meOZCWm3J9eMEGpe3wKowchF+lWOE1FlkTIXuSvNIMDnT1YSiGIBxWvtTvdwzGRCFKpmXrJ2YkMdcBm6VzowH7/vUltLuJgJWJ1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784343980; c=relaxed/simple;
	bh=B1pLyXiBfz8FJtiNiHqqcRei2magNrn45lRx0VEsjI8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lNa9HAawVskjilgzNo1/WkOMWZ+bK59HqopA9akfWKFIuMjXQdu4TNyOYx74uT33R+FYDi3Mr4NaA1eRkMRCprB/BTPLQjkZGfQroZc+zQhHW7ySZTZzeSqnkA4BgLyhRMx8f/pJcXEhA1BibJPR/NVRbj7+AhaMy0zhUPcyA1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ClovAH2Q; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ClovAH2Q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D41A31F000E9;
	Sat, 18 Jul 2026 03:06:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784343979;
	bh=XGFTNxM9Z/2RjgmpHqplp4yG8TPz8jfl165BROgo5Io=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=ClovAH2QSNI3juByeDpEx++1KoIYIsdaex1B62ZJmnX7C8NUQPNQVJ2PqSa+GeYQO
	 SOtyZuDKQknQ/W87muGGE2WPw7alB109xhb+tKeMnDWfeOmoItXBbYWhudU/u2PikQ
	 8hIVwzhBi654S0zLyMNXc5hGcMcGTCFXHznZLkrYPvmaJuQKRtD/KO2euwJCOqVfvj
	 D9jrBAxMaZv5r0rk0SvMeBPWOUS2f+K5LMleXw696sPwxVe/uE6Fi1DgxA2k+xRzmx
	 nN+ZdNJR0cq4eOvXCeU80LIGZvIy/GSR1ghC6uDWlcCkPNB20Oc8CQTg7RZSjcKryf
	 9o2KDPeCU/7KA==
Message-ID: <314972c4-8f66-46d3-bc09-1e05db700688@kernel.org>
Date: Sat, 18 Jul 2026 12:06:16 +0900
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ata: sata_highbank: use devm_platform_ioremap_resource
To: Rosen Penev <rosenp@gmail.com>, linux-ide@vger.kernel.org
Cc: Niklas Cassel <cassel@kernel.org>, Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling
 <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 open list <linux-kernel@vger.kernel.org>,
 "open list:CLANG/LLVM BUILD SUPPORT:Keyword:b(?i:clang|llvm)b"
 <llvm@lists.linux.dev>
References: <20260715011438.1274211-1-rosenp@gmail.com>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20260715011438.1274211-1-rosenp@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/15/26 10:14, Rosen Penev wrote:
> Replace the open-coded platform_get_resource() plus devm_ioremap()
> sequence with devm_platform_ioremap_resource(), which fetches the
> resource, requests the region and maps it in one call. Switch the error
> check to IS_ERR()/PTR_ERR() and drop the now-unused struct resource
> pointer.
> 
> There is a single IORESOURCE_MEM resource, and the SATA PHY registers
> are mapped separately via of_iomap() from distinct DT nodes, so the
> region reservation added by devm_ioremap_resource() is exclusive and
> does not introduce overlap failures.
> 
> The mem-based ata_port_desc() line is dropped along with the resource
> pointer; the remaining per-port description is retained.
> 
> Built for ARM (drivers/ata/sata_highbank.o) with LLVM=1.
> 
> Assisted-by: opencode:hy3-free
> Signed-off-by: Rosen Penev <rosenp@gmail.com>

Applied to for-7.3. Thanks!

-- 
Damien Le Moal
Western Digital Research
