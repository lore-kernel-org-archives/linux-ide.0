Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BABD8156CA
	for <linux-ide@vger.kernel.org>; Mon,  9 Dec 2024 00:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733703262; cv=none; b=idSCqfYBcQ+dTQx6wYhlxeuaUe6AFaJYiy2Jg5iVZ9ZZHkDZ/wupQUR/CxgQqqY0Nd9W33aUO7JpLmZwGMcOEgkQNFqMDcPpS3eMNC8mwb5H6ZHMayxsXOZRtau7Pl+pngLLqyqrClJM5I/YD+MRZbScepbjBe98/rpVzZeS2JY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733703262; c=relaxed/simple;
	bh=eqxRc1r4lOBIom9f+sx2PjwRfKXKuGaen6tdYD+Z7UA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mtEB+aRHWfg/k9my+LpdzzC9IYdiYrP4mJa9s9pvM8ZKNLvuerFCCgbDz3yclGJ1TBzmwk+NGuuxPqv38cFpskCFu49eOxfebKIewr7UL7bdMcGOVJWVtoZcRmnYL6g+aPTDczzqqPyrvdCkszGxBJ0XFeNZ1o3Oshd8zlA4Hv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rCWI5C9M; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rCWI5C9M"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B698AC4CED6;
	Mon,  9 Dec 2024 00:14:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733703262;
	bh=eqxRc1r4lOBIom9f+sx2PjwRfKXKuGaen6tdYD+Z7UA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=rCWI5C9MJXKN211USrtQNhbiRQ/Ze9UZi4jzBI3587sXFwPSY4OIgCDMyH0gZRLS0
	 yv1ocR9CDAe6JGkp0/m6irG4QP6J5sUnxSMpJxj0rGl5ODvoWL1hzYbIipSHS/XEMC
	 iBdQ0TUnjsWqxwSwwb0zpPOWzB8trybCPgMQSRVVSoZ3UGQddSz+EqiJOEZH1ji87a
	 S4JvEic78LSk+eM8e7MR1IGAe4xg7jpaXZgTRp2+6eOGrVxla50H4LYwG88DEIwVKp
	 HnGUKMU5GYd6nSBeq45uDzWyjWyxNvawOa2mpjLzveStBbXtHitL8PlQA+CpvQkJ3O
	 wCKfA0HzvVaXQ==
Message-ID: <5d847931-218a-4bdb-b225-a5fb4a09c096@kernel.org>
Date: Mon, 9 Dec 2024 09:14:20 +0900
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ata: sata_highbank: fix OF node reference leak in
 highbank_initialize_phys()
To: Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>, cassel@kernel.org
Cc: linux-ide@vger.kernel.org
References: <20241205103014.1625375-1-joe@pf.is.s.u-tokyo.ac.jp>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20241205103014.1625375-1-joe@pf.is.s.u-tokyo.ac.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/5/24 19:30, Joe Hattori wrote:
> The OF node reference obtained by of_parse_phandle_with_args() is not
> released on early return. Add a of_node_put() call before returning.
> 
> Fixes: 8996b89d6bc9 ("ata: add platform driver for Calxeda AHCI controller")
> Signed-off-by: Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>

Applied to for-6.13-fixes. Thanks !

-- 
Damien Le Moal
Western Digital Research
