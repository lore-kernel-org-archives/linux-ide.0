Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15FD730C63A;
	Fri,  3 Apr 2026 02:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775182154; cv=none; b=b0pYOtcl90DDvSBkPf0E2Kn9K+LU+r7aNaHAzbo5jBvQhJIF2JkSU4+Cpg4aKWxHjqayuxWYOwhSlGZ1BcTJNFIOwFfVvCDaS4u+8mHkFp/0VhdcnbHu1z0rh/FQKX8PJKGBaxONaI58eGIxqzfhbkS0zpeaZStFZsA8wHVdRNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775182154; c=relaxed/simple;
	bh=ka7q2gQNHThtFQ1bc0OSRGjLIaRE8GqzWBgT2MdTYLA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lrhQKGCoAhDOiLaKmkS1qOBm33JGz6I0VYVSZ+GlFh+CwcuwnZZWX138ai4thLK01I9cdkwkNLN0AN+0iuGI84qnep0HqGw5k26dzvnSGRwNHr54axG3qfkE6cbWBITCN3keLzOM3tF2hH4pueoVx6azbM8qzE0WXJ8PraOOqZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sT4nCkFR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sT4nCkFR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF5DBC116C6;
	Fri,  3 Apr 2026 02:09:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775182153;
	bh=ka7q2gQNHThtFQ1bc0OSRGjLIaRE8GqzWBgT2MdTYLA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=sT4nCkFRwGX+vroB6ZYTcg17PgIZzVSp5PUeXSv0IwE30NoOh9BR04aTmNBqmTNsL
	 UGMomIKsa1iGZZRYdp+d0Piy4Fjbcn8BI7BxiCmqZnNvnPLBPH1wqPifsXU5LLByUb
	 7wiFr2v0Ws2jwtDY2y5zEj5PlqEo4oA7XZmZtnucnyxHb2NZSt5jLNeTd8B/iIa69Q
	 3ZbBd1KqoHBioRrHaG856qWsDWRT8VWxYn89ofzpfh+LQAbH6701KP1zt0aJ50ll4J
	 WnxoNAA+5ErwXFBj5I+Ps4ntNZMO/LJW3djKbm8EyCGgdScSZEgAZWjipF0x0hgxV7
	 /ZYebcSs4qgqA==
Message-ID: <a802909c-688e-44d3-b904-33f4ac75ef77@kernel.org>
Date: Fri, 3 Apr 2026 11:09:10 +0900
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] ata: pata_arasan_cf: fix missing newline in dev_err()
 messages
To: Haoyu Lu <hechushiguitu666@gmail.com>, Viresh Kumar <vireshk@kernel.org>
Cc: Niklas Cassel <cassel@kernel.org>, linux-ide@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260403020710.254-1-hechushiguitu666@gmail.com>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20260403020710.254-1-hechushiguitu666@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/3/26 11:07, Haoyu Lu wrote:
> Add missing trailing newlines to dev_err() messages in pata_arasan_cf.c.
> 
> This keeps the error output as properly terminated log lines.
> 
> Acked-by: Viresh Kumar <vireshk@kernel.org>
> Signed-off-by: Haoyu Lu <hechushiguitu666@gmail.com>

Looks OK.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research
