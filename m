Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C623360EC4
	for <linux-ide@vger.kernel.org>; Tue,  2 Jun 2026 17:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780420709; cv=none; b=uDvHgnsaZhX+j2MpFD+cWVFep93q99EYPDDLtKE6M80yRp+Gh1aaiOiLLSai5Qzr2u0qytaU7uLHiW+9+XJ+9bZDOT12BIKXPkYi0ddVfT8MXiTQDWOryaiLQWjgrPLbeeHJqgai1XeDzGYDsaoKHbYQhi8gaFvzGntWpleQg4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780420709; c=relaxed/simple;
	bh=c4sTU6Z+3wQ1uQBjgFrw8ngp5SW76Re6Syv9BCbI1DA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UShnXSMAE1WqDRfWZJwE6WEgf4V/3Z78fWq/0ZlJz3jcwBvKUgoA4ZKwTWCCSSv4oJyjZHyRzrNdAvEvsGDOaRxH7YGqGFcq7Sxxf59CoykPiDuuQmWee5KeAMIqIvG+Z5ATquH3etUGYcPJkToieRAI/qN+0aiX8ABdn7rc7aM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=mKbZGmoE; arc=none smtp.client-ip=199.89.1.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="mKbZGmoE"
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4gVHbl65xJzlgyGQ;
	Tue,  2 Jun 2026 17:18:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1780420704; x=1783012705; bh=LeqkaOosioOfeUMPidWwTz2g
	oP0d9P7a2fctQV7bVP8=; b=mKbZGmoEwVgKJclswbORucWeF205nAOVmdZBgdme
	vryTPkMpveDX1hafAX5Cd/m5mrdO62FjB+mPMUCXZbwaPpoOQbEh+rb9BmPmJvmR
	JFLUB5h6zEh8X5QHwilFq86o7CMsnPXJP2yZeVvosqOIzbOZ1mgWGTTD7lp7VmSh
	0yxoXJMypo+AV4lSRrxwbin3uKPknB2uqwotoDV56pp33DfZbJHWwCgVuzqTwNyV
	aT1Im4VPOvO1xZTqQb0+sqj4f997pO7mo0yYaxvDMP+VkcJ+jDntz+rqKRi6Ekp1
	K1fzr/VDPcHzNuRdXCqe2rQ16BG+shDJFR6IhF5pOjzw8g==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id usJsubco3wsh; Tue,  2 Jun 2026 17:18:24 +0000 (UTC)
Received: from [100.119.48.131] (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4gVHbf5mcXzlh2fl;
	Tue,  2 Jun 2026 17:18:22 +0000 (UTC)
Message-ID: <6eebccef-022e-417a-b0e8-c9a665685e1b@acm.org>
Date: Tue, 2 Jun 2026 10:18:21 -0700
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 9/9] ata: Annotate the code that uses the host lock
To: Marco Elver <elver@google.com>
Cc: Niklas Cassel <cassel@kernel.org>, linux-ide@vger.kernel.org,
 Damien Le Moal <dlemoal@kernel.org>, Mikael Pettersson
 <mikpelinux@gmail.com>, Geert Uytterhoeven <geert+renesas@glider.be>,
 Magnus Damm <magnus.damm@gmail.com>
References: <20260521173347.2079560-1-bvanassche@acm.org>
 <20260521173347.2079560-10-bvanassche@acm.org> <ahW5MI_05l2bpKBN@ryzen>
 <e1e8b05d-6dc1-47c9-8b85-bfb2d756a204@acm.org>
 <CANpmjNMU4nwg==7pn0UAXY9Z5s-4dZFgPwxEHHhwvhiynSi_cA@mail.gmail.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <CANpmjNMU4nwg==7pn0UAXY9Z5s-4dZFgPwxEHHhwvhiynSi_cA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/26/26 3:40 PM, Marco Elver wrote:
>> I chose __assume_ctx_lock() because it is evaluated only at compile time
>> and a compile time annotation is sufficient in this context.
> 
> There's a real risk that your assumption may become stale, and if it
> were my codebase, I'd prefer lockdep_assert_held() just to make sure
> we check our assumption at runtime. This is not my subsystem -- just
> my 2c.

Agreed that it is risky to tell the compiler that a lock is held without
performing a runtime check.

BTW, options (A) and (B) from your email are not the only options. A
third possibility (C) is as follows:
* lockdep_assert_held() only performs a runtime check and does not
   include __assume_ctx_lock().
* __assume_ctx_lock() is modified such that it performs a runtime check
   next to making the compiler assuming that a lock is held.

The advantages of this approach compared to (A) and (B) are as follows:
* The compiler will complain if lockdep_assert_held() is used without
   using __must_hold().
* Whether lockdep_assert_held() or __assume_ctx_lock() are used, a
   runtime check is performed if CONFIG_PROVE_LOCKING is enabled.

Thanks,

Bart.
