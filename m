Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 997664611CF;
	Wed, 27 May 2026 18:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779905898; cv=none; b=AMBYvpE2yyl5eNSByyncwUMAeGlMAZ/qO3XZ59p9JJUPTbSvGfJUFOX9kct4ga9tTFSbbvvfPkVjtjHUfI1qjjuHTsL6+1r/fgTfgf5mGo4QQkgCG2LBWzO5dvVAjoZMPMqe39rWgxzJd7/f6QRkaWFuzUOyyD8Tepnh/b6LJTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779905898; c=relaxed/simple;
	bh=jRZ+oB2r0ICYZ4egi58cPvFNtDBREC4vRyomBemW2UU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dFZIMA5NwUhQWFdL5ggbzC4H5PuAOYhgE7ePHduDjLrAgm8pQ0A3pV0PDcJSQ1pZNwxKN5yt5MHTWX6vaX/uWwd3cuc1Wr97yAH++l9EOjrZGFnW+G+1jhlvefM/lx/Wcon79cc1yURT4fM9wWmf+2aqd/QgHS8ry2+0U63jTkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ffR2xd1U; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ffR2xd1U"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB36E1F000E9;
	Wed, 27 May 2026 18:18:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779905897;
	bh=DsBPDEPLa4a42XhXh7va6YxCIjG8SfdnT9RBSiTIv7E=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=ffR2xd1UMk9cwe3j0Dg3jgwRWPYd4CLNy0IZa9tmECSgetoFi+1nhWhwWUavz5RZv
	 XrIfQx7lNohH9XrQdRHL6Ysnw+Ni8KBtB3dqoeoAk3qA5pAkXh1EKlob80pBswPqc8
	 EzZwkBnL/Z5MhKs+L02SQvLMof9g9/kSyxf59Il7QZrXJvvbIAJoqQVio43v9kxItp
	 mZSYZO9RSUcmmGh+lsgFN6lY0dY9kHEbZqKBP+yrO6V7sN8xA2M4BcNh5cVphdZdWc
	 0KLwJZ9I0vLIRFvKq6NQkSmImvZvQqmNY5Be/KI/hX8aUnRNZzDhDNFhO/tMAGJB+T
	 UkE8PRxEMyDWg==
Message-ID: <cd21e56b-04de-4b29-bc4a-d936ac8d29bb@kernel.org>
Date: Thu, 28 May 2026 03:18:15 +0900
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ahci: use hweight_long() to count port_map bits
To: kensanya@163.com, cassel@kernel.org
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
 TanZheng <tanzheng@kylinos.cn>
References: <20260527091729.266582-1-kensanya@163.com>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20260527091729.266582-1-kensanya@163.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2026/05/27 18:17, kensanya@163.com wrote:
> From: TanZheng <tanzheng@kylinos.cn>
> 
> Replace the open loop used to calculate the number of set bits
> in the port mapping with the `hweight_long()` function, which
> simplifies the code without altering its functionality.
> 
> Signed-off-by: TanZheng <tanzheng@kylinos.cn>

This looks good to me. But as Niklas commented, if this needs a Suggested-by
tag, please add it.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research
