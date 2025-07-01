Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69085264F87
	for <linux-ide@vger.kernel.org>; Tue,  1 Jul 2025 09:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751362055; cv=none; b=lPMQjYhD+lFNLpvP7x2Rt542PFXtM71O3kGpJJ/UoqXmeIXNB3JpI0GBf/n7g2vyvCnlMOswM/tlWuASVXU/MSSX8tNPwA9wLZzdo7M3TB0MPz3r4erQghzBEqoGxon9HLRZkxnoRP9k5XINkVfIa6uT3bngHu0q8GRVh7tuL6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751362055; c=relaxed/simple;
	bh=xamULk3ouQa8EWtbEBlN65vRPG6L9u/qDMC2nMGmKfw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Jv5hEWleD9BBL0LF0wDs3zxQCuUlZyxUm+F8qddjYTkFK7v8pP030UB7RsQawMYXETt/rd66x+1TDWR7yEUC5tgcoYk72azHyGKtRrVoyW4ZFY8OBTZspuBObNeTaSoJg0eQD2FOnmYO3BoIad7sDIR+SeOjVxkXjec31buWu+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A7HerQOH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A7HerQOH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72CF4C4CEEB;
	Tue,  1 Jul 2025 09:27:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751362054;
	bh=xamULk3ouQa8EWtbEBlN65vRPG6L9u/qDMC2nMGmKfw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=A7HerQOHF4TZXRzGuMMRZNBvVjRdtzSbqgak5d1+3XOeDHOxHQen70ckhFV6keq24
	 svxTojblX5tq8kR0yx5KLL6jXHLoF67CK5mk0pdOpzRCkoLjsGR2FYHTeSckvSvmYr
	 Yrya6fG0O0kc0qSpSnRXw9DOfDqnXEQuoGv6KZwT4dxlhh5o327NmBr+84tuDQMl8d
	 /RPqd/OBPmquSwUKAsxRvFg6hv8VtsiaqQj3P5oXW5YVehylDybbEHsU7m4p6VMUWV
	 IZqleE99GlnnQwrkqrzekFugT8qOkRW24HG+QwmjUj2UBg6EkFSBLiQyj/LM/KaOQ9
	 nVyE5H/XufUhg==
Message-ID: <75031003-7816-4e2c-9cfc-57822a9f3321@kernel.org>
Date: Tue, 1 Jul 2025 18:25:24 +0900
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/10] ata: libata-eh: Avoid unnecessary resets when
 revalidating devices
To: Niklas Cassel <cassel@kernel.org>
Cc: Hannes Reinecke <hare@suse.de>, linux-ide@vger.kernel.org
References: <20250630062637.258329-1-dlemoal@kernel.org>
 <20250630062637.258329-5-dlemoal@kernel.org>
 <60dd0013-20a3-4b10-a60b-0e567526e0f9@suse.de>
 <097726fe-638a-4336-8427-3eb3055de5b7@kernel.org> <aGOpQtkxF1FehZ9G@ryzen>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <aGOpQtkxF1FehZ9G@ryzen>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/1/25 6:24 PM, Niklas Cassel wrote:
> On Tue, Jul 01, 2025 at 03:48:15PM +0900, Damien Le Moal wrote:
>>
>> There is a 10ms wait already in sata_link_scr_lpm() but it seems to not always
>> be enough. The specs say that transitions out of HIPM "shall not take more than
>> 10ms", but hey, we all know how devices always follow the specs, right ? :)
> 
> HIPM / ALPM includes Partial, Slumber and DevSleep.
> 
> 10 ms is for Slumber.

Oops. Yes, I meant slumber when I said HIPM...
My brain is in lower power state today :)

> DevSleep can be much longer than that:
>           - DevSleep: The Phy logic may be powered down. The exit latency from
>                       this state is no longer than 20 ms, unless otherwise
>                       specified by DETO in the device Identify Device Data log.
> 
> 
> From PxDEVSLP.DETO:
>   Device Sleep Exit Timeout (DETO): This field specifies the maximum duration (in
>   approximate 1ms granularity) from DEVSLP de-assertion until the device is ready to
>   accept OOB. The nominal value is 20ms while the max value is 255ms depending
>   on device identification information.
> 
> 
> So technically it can be 255 ms :)

Yep. Hence why the 10ms sleep is sometimes not enough.

> Note that we do actually read and save DETO:
> https://github.com/torvalds/linux/blob/v6.16-rc4/drivers/ata/libahci.c#L2293-L2295
> 
> But like you said below, with this patch, we should be able to remove the sleep
> if we wanted, so I don't think that we necessarily need to increase it.

I definitely do not want to increase it !


-- 
Damien Le Moal
Western Digital Research
