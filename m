Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2BB118FDBD
	for <linux-ide@vger.kernel.org>; Wed, 27 May 2026 18:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779907870; cv=none; b=L4W0ZncRO9shoISb8zTcyMYtcby51/rYTv7BaQrFG8YTaZ1pydBtqcpdtmJrXwQz+O521gm7ZuPa6Y9HUyeWTH08ah/csLDN3d5+SVjXhTbHxxkyxiWccRLQ/YIKMFD4P+6WFtqqeR48MFCSX0owWiZ4OmJ4N3xEgbZ0tCV+YrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779907870; c=relaxed/simple;
	bh=OA4kcteOsazZOX4DtHkXjkwp8FqZ74/Z7tWSYjvkdOM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=joGwNJdeyTU3eMrZgDwmrgnpYq2SPuoYWAa3yXkGUP09hqBgsL8Jqz1rehcOf8zJvKQZwKqlpFU7ewI4tFxyOFp2nPIQCjgLqIpkPMHJPeDx9u4Qj9CUaE73hHoNm6e8eov067elYyOLoYq/sUpGTAnF3EYCOMrhkvPMuXJCLuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dwIE9+bs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dwIE9+bs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8739F1F000E9;
	Wed, 27 May 2026 18:51:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779907869;
	bh=34swYXaiag6WOoZabd5HtBCXgI4UUKJMdjer7xReBVM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=dwIE9+bsDfAHldwNh0ClByaCsI43rRL251iFTDfvmHlljAh1yNH9Yb7iB8F4CARLY
	 DQ4RFtsIZBFFHnpz1PV6BAx5ELMFDisWT2Vheybvcwdj64zmgCWKH+brIhS8w8Jj2n
	 HDdSA4jNXocZHz6flHlgaCDdsrpIwJlw5mFthxTBH+rr3mS4Xe3ZThIhVuMFUJUx3W
	 nKriER53dfktisIiw88u1pkScjixOP5pc43mSvKBM/G8IVoLsWdmi094PIBYrbmNHE
	 6qRJRv5XxcltFE4E/zb28j1UBOnnxXRJtwuNcx7hBogpF0h77C0E53kN/EzG1a2JEi
	 2cWISelqounUQ==
Message-ID: <28915fc8-f2a1-4372-9f09-25f638585e0c@kernel.org>
Date: Thu, 28 May 2026 03:51:07 +0900
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 9/9] ata: Annotate the code that uses the host lock
To: Bart Van Assche <bvanassche@acm.org>, Niklas Cassel <cassel@kernel.org>
Cc: linux-ide@vger.kernel.org, Marco Elver <elver@google.com>,
 Mikael Pettersson <mikpelinux@gmail.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Magnus Damm <magnus.damm@gmail.com>
References: <20260521173347.2079560-1-bvanassche@acm.org>
 <20260521173347.2079560-10-bvanassche@acm.org>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20260521173347.2079560-10-bvanassche@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2026/05/22 2:33, Bart Van Assche wrote:
> Annotate all functions and also their direct and indirect callers with
> __must_hold() that have a lockdep_assert_held() statement in their
> function body for the host lock. As one can see in the comments added by
> this patch, locking is missing from the following two functions:
>  * Some of the ata_port_freeze() callers.
>  * nv_do_interrupt().

What do you mean with locking is missing ? Do you mean we have locking problems
and bugs ? Clarify please.

I am not a big fan of all the __assume_ctx_lock() calls because I do not really
understand them, especially together with the comments you have that do things like:

+			/* Tell the compiler that link->ap == ap. */
+			__assume_ctx_lock(&link->ap->host->eh_mutex);

Form the name __assume_ctx_lock(), I do not see the relevance of the comment. My
understanding is that __assume_ctx_lock() tells the compiler to assume that a
particular lock is being held. But if that's the case, and the addition of these
__assume_ctx_lock() are bogus, what do we endup checking here ?

Back to my previous comment on patch 2, I would prefer, at least for now, a
lighter version of this that adds more lockdep annotations, and simple/obvious
static checks with __must_hold() annotations. Ideally, as suggested, a
locked_must_hold() function doing both would be nice :)

I am all for improving lock checking in the ata code. But We have been doing
fine without it until now. So let's not take this too far from the start and
improve annotations step by step.

-- 
Damien Le Moal
Western Digital Research
