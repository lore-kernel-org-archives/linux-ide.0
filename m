Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A32C83D6CC1
	for <linux-ide@vger.kernel.org>; Fri,  6 Mar 2026 15:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772811294; cv=none; b=kGF/QsM7OHeTzL+BJjerDOaTAi6wNz7J5N6nA3mO37Jkn9UOzsNaSCyWGsEQ/rCyiW3NOtXARMqD71+g9EoL24SrzhkiOdHAp/SzcCDekXJFNrMFSpQEhHnkeZg94+wi5NY3XtFE3aZJHsAz3jwdVtnsHQUTyU6OWbzWHhW3VAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772811294; c=relaxed/simple;
	bh=yqlVQnOQzxCUdcKIB9vusNzOBvV1LjzEhAxZTvB7ppE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NwjPzuUoQCbQvmHyHchx157fGZ4Jr0yZQmom/kMfIb/7yzeVPW6ToDnEY+wDUG+j3Mda/emgMwiljseZ3XZKCjU80wIxpknM2dBdTHU3jImt/nJ1C5aeREZEid9Fx5PYk4o1qEHQ6l05GIdQzR/bG4Mer6zXaHaEctMDVTM3KGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I7sAY0Av; arc=none smtp.client-ip=74.125.82.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I7sAY0Av"
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-2be1b5fe11cso5622146eec.0
        for <linux-ide@vger.kernel.org>; Fri, 06 Mar 2026 07:34:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772811293; x=1773416093; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=JQZKl5PyDH94ywD5rtNtQzoiVTk8ZecqP+MrUiWUmD4=;
        b=I7sAY0AvWpk10pyqeS2oruavJTYGzaokWAR/mPHoMtfJMc8Rh2vDLQ74u32ljTe6Ls
         X9mrcs0pcMzklzrBg0U3PCt73luwz8KkYhaMYzY7JaOwVegFaQmni1d1fsSI52yf3eyZ
         ocLI7eEXI2N5y02boxsL+TPP7ZwBGj4CM/ghA9it9z3VrqZSS8+j/DAt+ju+h59HkpMd
         rDIiG9Z6Qn/2AWm3Dxwh4KeYFZKDEYZ/VL6akMCfFfxpcL7sELL1uMJikSNgC6uU2Rg6
         jh7p4PK5L6ojsOA/JmBQX7CXTl2+T+vo5Tv6/c1mnso2Qf4/3T5jMZfYL1hsVbfvR8cv
         mHPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772811293; x=1773416093;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JQZKl5PyDH94ywD5rtNtQzoiVTk8ZecqP+MrUiWUmD4=;
        b=FTDfnTM/oQbGlVcLOoj0wFxmu/D/48kPaefizWpwDe1WmYmTx7nxm+FBC0xLjaBmxh
         RjbDE7W7Cgu6MGt8r1S3WTTfo3Hg+HFXPY2Gs5Px6COgCAfbTDKnVq5o3x+2gsa8WkPg
         /PF+jLJ3sTXyml0y5GDPfAjXpRTkn1VjdThQohMSxkqpDcOegE6tMo3ODKrb7Nt1mIAD
         BBGNXOhgGVI4jv9mq8Q+P5Igeiwk4pBtzQCL7JU42MRodSGHem64ko3vnKl91q1A726p
         tCzqRArSwPtmFY8qfx4BCHtdXewZfxhvMk40APoa3psAfnWZB+3H4ASKhqjoPNjhjmXP
         irBw==
X-Forwarded-Encrypted: i=1; AJvYcCUcWLmpzzn1ebV0DOmZOFlQZKQXhG/Ek2FKhFpVUB4qtl0VlTm+Mmmvh9UuiyP9DrJa5NcmGYXRanM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBS2fCl+ihwsGVHyofuZynZF4NltZLTEhoNgtZ1seIGePDSO6j
	VIJK8VwbSr/UJlTURBAFRS/QwW8fEN1vQLbP+Jgkjy5sFhFBnx9qfWTZ
X-Gm-Gg: ATEYQzwN0auUR0e1G+Ok4x//OTAq8ODpsQ7KVlPWNBg8E0aO+NjKkZnHCumdu1pum/H
	uN8SeBqkqr8Nvazx9OWva3SwCnof/lMRkTCbW/2hDqJzb5eHsG15szzi3FvEKGbUycZNgT8Fr62
	8Gsr9cE3LSe8RiHs6dnreAsiCS+MK5hCn51huG5CcPfCz8k9/rb9hIlhIjQKnD4g+a3dF6v9eRj
	wNZTBGlxANjTbI78DoS9PNiWRlKoDKIfvV61tx6MqcoU3kWVTzMkP0SzXqxQSW20X6jYLXsho+C
	QqvBLQS8FBOZK6UZelJkh6jbcSPRHYziKMKry47Sf1G+eUYVHw8VWqFLcJcKcuMZ+CZ9+lshmWK
	PVrOWuDZbIhotJAnDz0gQAje4yffNGVAx/Sgqmpl/5wl4vm3kWq0a8bv/ndSw0UTVluHw+axqjG
	EkTkD7UXZHu3YF3Yw0CPoNe5Bie38/RNdyqetInqvKcnyBXFtqnB93ycy0PrP3iYTJxh1+cxyS
X-Received: by 2002:a05:693c:3113:b0:2ba:6723:503d with SMTP id 5a478bee46e88-2be4e08f9edmr871444eec.20.1772811292460;
        Fri, 06 Mar 2026 07:34:52 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2be4f82851esm1337085eec.10.2026.03.06.07.34.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Mar 2026 07:34:51 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <b184ec58-415b-4311-b3d4-33231ddd47d0@roeck-us.net>
Date: Fri, 6 Mar 2026 07:34:50 -0800
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ata: libata-eh: Fix detection of deferred qc timeouts
To: Niklas Cassel <cassel@kernel.org>
Cc: Damien Le Moal <dlemoal@kernel.org>, linux-ide@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260306024805.2877513-1-linux@roeck-us.net>
 <aaqY24cG5ezFlEE6@ryzen>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
In-Reply-To: <aaqY24cG5ezFlEE6@ryzen>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/6/26 01:05, Niklas Cassel wrote:
> On Thu, Mar 05, 2026 at 06:48:05PM -0800, Guenter Roeck wrote:
>> If the `ata_qc_for_each_raw()` loop finishes without finding a matching
>> `scmd`, `qc` will hold a pointer to the last element examined, which is
>> accociated with `i == ATA_MAX_QUEUE - 1`. This element can match
>> `ap->deferred_qc`. If that happens, the condition `qc == ap->deferred_qc`
>> evaluates to true despite the loop not breaking on a scmd match.
>> In that case, the error handler mistakenly intercepts a command that
>> completed normally after an unrelated SCSI timeout, returning a timeout
>> error instead of success.
>>
>> [...]
> 
> Applied commit log changes from Damien and myself.
> 
> 
> Applied to libata/linux.git (libata-for-7.0-fixes), thanks!
> 

Thanks!

Guenter

