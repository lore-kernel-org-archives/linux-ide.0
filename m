Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 765441FAC54
	for <linux-ide@vger.kernel.org>; Thu, 15 May 2025 12:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747312796; cv=none; b=RCdBJfMYiTf5GvLGSHAuHdMc1vsxVbp8vocs9biSYiExnLgpHKq4EKb8FPPDZlzMGEu6AVNk/ElgObn/bJ9KluvmRzes9jiia4rXtZTErPd8ZpTIK2+ZuYiYzhcs2ZcZYF6HPgIWETl2xK9Vw2BLWGTRaDxgJOB4kea1RrQ9eNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747312796; c=relaxed/simple;
	bh=lEXDNRiNuo0DZJdyRtGqbx4RvqCL5foE3bH+OzgE4LQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=euMhcOU8ZyFB9oPBLZOMGXA4INrerb93fSbbqvvguynNEai+cM5jX/laU8gaeyAC0WQlMgWNaplMlbokyzKdSGkzAsfoNKMuQuh2k8Qj5DYhUkAvJj6aAnune7Ozxg0RthPZcIpIE21z3bLLQ/w8V/UJEsKYHhljDv1nggLEqBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mfDQ48Ic; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mfDQ48Ic"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F18CBC4CEE7;
	Thu, 15 May 2025 12:39:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747312796;
	bh=lEXDNRiNuo0DZJdyRtGqbx4RvqCL5foE3bH+OzgE4LQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=mfDQ48IcyYQ9avSregBAjampR3TxwaD7lK6adlpUKNHdvy/O/J/H+abthkDSnD5Kl
	 rYnq8Lv3X/S1SC/pqR/yYsbVQS7fh/pISJvFQ5hRcFifo4C3sULCV1TA4byGfYMglX
	 jmyxl6JMaME0kLetWokoivojJkTl/JKCksgFzu4+xTRlf3soegpqfAFMQvEGDGg/1A
	 tDabPwFaCedL/0f/obYF6tj35VVtyUQnkdHMJESTak6NahLr8NcNYiXg+MCsdsQ3lW
	 Qq8U0pwgdHsFhW7qgfMa4Nq3CXk5tpXDTpTkuUjxjCcQP4d1aoqYTU7XU3aPkIHloc
	 CrckPTgX8S2+A==
Message-ID: <5fc39c58-83db-43f0-86d8-782fea550ed8@kernel.org>
Date: Thu, 15 May 2025 14:39:52 +0200
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/7] ata: libata-eh: Drop dipm variable
To: Niklas Cassel <cassel@kernel.org>
Cc: Mikko Korhonen <mjkorhon@gmail.com>, linux-ide@vger.kernel.org
References: <20250514172210.383801-9-cassel@kernel.org>
 <20250514172210.383801-12-cassel@kernel.org>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20250514172210.383801-12-cassel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/14/25 19:22, Niklas Cassel wrote:
> The dipm variable is confusing.
> Drop the variable and inline the expression at places where it is used.
> 
> This will make it easier to perform additional cleanups.
> 
> No functional change.
> 
> Signed-off-by: Niklas Cassel <cassel@kernel.org>

I do not see the point of this patch given what patch 4 does. Can you squash 3
/7 and & 4/7 together ?


-- 
Damien Le Moal
Western Digital Research
