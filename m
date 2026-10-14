Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AACF0524AE3
	for <linux-ide@vger.kernel.org>; Wed, 14 Oct 2026 15:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791991344; cv=none; b=nqygygReih8UQbXaVs74TXDy6ZK9B7v3Jt9uW1zUdBtkpRjajd45JXZHj5I3QqS82OiaLU6tUmfVxCwZ9NvL/xyZHwgVVNSK556f395O+KecQWjAZbg+pHhpq9qtR0MU80tg6tgynKqs62lm0kJDGPHXCJCj/ETTtKxk1pq9es4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791991344; c=relaxed/simple;
	bh=CIuVz37YUldv2prHhWm0QaZPWqaHOfhN9X5wbtnLh2Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EUolzumI+GEaxAWuNEoicldBS7CurfI96ssLzWPzgfeasH1JDHGTZC0TnwSq+aiGIzwlogktCBFwq8ZCw5iKzOO9YbXxPYap2e7+DtFp1o7Ew7I/RAh2HuI3zAlAOptD/MVRWFthj9Fp7CsuUSRbl94MxkshVUWU6DUKYeSolu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B5WJJ6Jd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B5WJJ6Jd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 208841F000C4;
	Wed, 14 Oct 2026 15:22:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791991343;
	bh=vHzRhPrZqgvE9jrRZGn5fQuKwjcnwAPyUanHkYvXUIg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=B5WJJ6Jdnfo9eQ/IISPFzRnWBieiRADdnxLYlRnnVg7orCqXA15S6qKfaRd9ZcP30
	 frei+QcdvW2i8wLYVlqQEV8EAeN+Q4EPhFBfj++HYHXQYDOIxBLv0hOkt1ksc2L7KO
	 t/xjESMmKe1nbTSipZWonbj0ZBW1v7tjBCH92HKladANoO+8qeaG9f998H+OX9DDYe
	 WmsTyERVVwuz5y3PXp/Ewgc/HKTvJc1+fVWYFmbPpo5qvVof7OdGw2KShcZRtqAjyf
	 rOp0Cek4ushv6c33WeQZVwIBTV0ERSh1tGyix2y/Cxuz7u04vAdI6acYFvBVXD9xRo
	 JWarvaaZcWCcQ==
Message-ID: <d50ff5e0-b5db-48b7-88eb-1574c0348b1c@kernel.org>
Date: Wed, 14 Oct 2026 17:22:21 +0200
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ata: libata-core: Fix NO_FUA quirks shadowed by earlier
 quirk entries
To: Niklas Cassel <cassel@kernel.org>
Cc: linux-ide@vger.kernel.org
References: <20261013193915.174460-2-cassel@kernel.org>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20261013193915.174460-2-cassel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2026/10/13 21:39, Niklas Cassel wrote:
> ata_dev_quirks() uses the first entry in __ata_dev_quirks[] that
> matches the device and ignores all later entries. Commit 38d431229bfb
> ("ata: libata: exclude FUA support for known buggy drives") appended
> three ATA_QUIRK_NO_FUA entries to the end of the table, with model
> patterns meant to cover whole product lines. Earlier entries already
> match some or all of these drives, so NO_FUA is not always applied:
> 
> - "INTEL*SSDSC2CT*" never takes effect. Every model it matches also
>   matches the earlier "INTEL*SSD*" entry, so these drives only get
>   ATA_QUIRK_ZERO_AFTER_TRIM.
> 
> - "WDC*WD2500J*" does not take effect for "WDC WD2500JD-*" drives,
>   which match the earlier ATA_QUIRK_WD_BROKEN_LPM entry.
> 
> - "OCZ-VERTEX*" does not take effect for "OCZ-VERTEX" drives with
>   firmware "1.30", which match the earlier ATA_QUIRK_BROKEN_HPA entry.
> 
> Move the Intel entry in front of "INTEL*SSD*" and keep
> ATA_QUIRK_ZERO_AFTER_TRIM in it, so these drives stay on the
> ZERO_AFTER_TRIM whitelist. Add ATA_QUIRK_NO_FUA to the WD2500JD and
> OCZ Vertex 1.30 entries. The quirks of all other drives are unchanged.
> 
> libata only uses FUA when it is enabled with libata.fua=1, so systems
> using the default setting are not affected.
> 
> Fixes: 38d431229bfb ("ata: libata: exclude FUA support for known buggy drives")
> Assisted-by: LLM
> Signed-off-by: Niklas Cassel <cassel@kernel.org>

Unfortunately, my idea does not work. So:

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research
