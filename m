Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795678086;
	b=hTGLRGgAooE/31NtqWhNLjGhgoKOPl3uae2B0Z9XUruZlipNb8GvW51d+PaKXFyQUgxT
	 Q7AcXIK4dHEWBsM+mGJu3GGV+UaZgWISpbqzEJCt87jG3iTG6rfofdmI5vLbEmMXNSbKG
	 SkSTOe9ZulYPn+6Csxg2G3NN7vdKnnt8Tcag76oVr8dU2hL1M8DHZqOi3BwvjPf3eDjgZ
	 a+uYrvJB1o0Iy+fHdoi8od+DkOUp87rhFamcfj6xA0Xuolyt8JgpkDbpMmorXH45fLkfe
	 Vh+0WouyutcqRhNyC8cmedWI+/y6gkYhvQsEH5s+rSsnRIOA8y95NbvucZUSCvQbTqg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795678086;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:Organization:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=x/OD6fcp2rPpLfPl9B2D5fZUfkOyLZDg7EWK5Xblte4=;
	b=2mM63O4SapjrriZQ6Z2ce8awlfe8oAOM9CFu9vM8GIfe8FLOPc7nS2Wtbe/YXXLmqVGV
	 lkg66MQ4HiTiR0BynjgWIlgV0Xnw8pO+mgtlbVzC2uZZf/2yEFFDGkblXHQlcF4hFlkFJ
	 pEpp2GPcm0xWryGsCP8GunmrLbCVa45+Ynx3AmErVfWpzaPQwop879R3l+NGbt9ENk+XG
	 eWsyamE/owsLXXHOGQpihaQHYDsxtpNGcpbdUq8VoaNnOTP8z3Log9BF/daYS6GTsK8ie
	 qA0lT7ZP04F/I6euGZRHrZ/zcBNZR6A4RRHNj/dhuQoSeZk5VFwU5f1XXDcTnFAAyZA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CMleBN71;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60BA2606A31E;
	Thu, 26 Nov 2026 07:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CMleBN71
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3160A1F000C6;
	Thu, 26 Nov 2026 07:28:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795678086;
	bh=x/OD6fcp2rPpLfPl9B2D5fZUfkOyLZDg7EWK5Xblte4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=CMleBN717YCQnesJABLw9AlZ9hmQpUyt/zmtZW876/7qefuTLcp+7UvM07LsFTRPg
	 FMhjQgHpbwzuc2do06SKn1q8x+eFiv7uiJ5YtDAKQIE12GxTKsskbf4dt2VcAiBZ5t
	 0HT33GQwNKHahrsI2lhdwrcPvjrLO5eopAl2GLqQueDsTQJ+fNbndZFrQ3bjD7XGHF
	 CSMfDh5/IWjGmqbmHUnVo1t6FuhBHDYYgUb2awjcDb5a7pQ8WYpmhri1ueBCeFSA8N
	 WmHGrvayK/VxSypHmQSRwDsBfHc/gKEFPcYNMzmPzzJKXC25YENvlQ0p6Tu4XocTfB
	 axpsIKl+oXHsQ==
Message-ID: <921c97fc-dfa7-403b-aba5-6e6b41c62664@kernel.org>
Date: Thu, 26 Nov 2026 16:28:03 +0900
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
Subject: Re: [PATCH 2/4] ata: pata_pxa: add missing newline to DMA warning
To: Artem Novak <artem122novak@gmail.com>, vireshk@kernel.org,
 cassel@kernel.org, linusw@kernel.org
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20261126051523.14431-1-artem122novak@gmail.com>
 <20261126051523.14431-3-artem122novak@gmail.com>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20261126051523.14431-3-artem122novak@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/26/26 14:15, Artem Novak wrote:
> Terminate the DMA completion timeout warning with a newline to

s/warning/error message

> keep kernel log messages properly separated.
> 
> Signed-off-by: Artem Novak <artem122novak@gmail.com>

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research
