Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8538B1DE3CA
	for <linux-ide@vger.kernel.org>; Wed,  2 Apr 2025 08:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743582753; cv=none; b=lkI2mkB0VfUAjBymj8zmSwrz7ACv/PztHEGoBwIRC561yYpqcNNrC4rAgWeC/1RmhEOyvX++cbXsYUI+yB25kzXYyfGlcq/3ObRaR4rnS3TKib+C+TzB4vUxJASNaELLoLWCmIxc30oZu0Y5VlgqxRU/5KEiLAtL3vECW3oCdAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743582753; c=relaxed/simple;
	bh=b8LrI9hivCdUoKn3Avnse17nK6eNNlDVI1ROximYvPI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j/ewSgfDgwA8RLcMi1lXE43pVPJVNgFxrPrP37qhgpiKI8YsmCaUHrC7BroA5HC4GcedK+EZVCffpwU/ZwDJwNJZ9cNR0JeQnZ852QYD3L77G1pK8Ul9agC3Z0ffWLacuchHMg5H6u9FbBrdGbW7f8r+5Y00Zw2DIH+VtvLH2Z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kg+9+eU8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kg+9+eU8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B353C4CEE5;
	Wed,  2 Apr 2025 08:32:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743582753;
	bh=b8LrI9hivCdUoKn3Avnse17nK6eNNlDVI1ROximYvPI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=kg+9+eU8nAjWbh4laV+PWy4VGlUkw1OersoLgEPLvfdOwGMrBbVkwADJnxuxmYFYX
	 TBgtuiHYFFNwJSJRJAG/D6jSyxrMBVMhLXfv1BzRaEjycE1OsW8f1bykSNhOxvqqMR
	 MOjHZDT5oLN8SnY0Ck1YIXRSbyf9FYGXf+NsJwlZS9X5RxU2AenAJDvZKd9w87nJcS
	 UNPxmtrSY0k6Ypxsro5Tca2K3a36UF7SDRkCZfC4tAX8QG64B2kOqxf0K8Muvh5ewH
	 aa6FMWyZlgfeciDoZk3qOOPq2E+FmnZgBllfWIF+jVxM8KJE2591jbbQLcJNqWZwjD
	 0VFqNDbUgVxow==
Message-ID: <ab296d3f-f9ca-4f9f-9d26-fa9898cf4b66@kernel.org>
Date: Wed, 2 Apr 2025 17:32:31 +0900
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: ATA WRITE DMA Timeouts and Link Reset Issues
To: Naveen Kumar P <naveenkumar.parna@gmail.com>
Cc: cassel@kernel.org, linux-ide@vger.kernel.org
References: <CAMciSVX_wQNM9NQeOsvC=OwcqFhfa3=eBoNZ_TX1YVqbxBNMpQ@mail.gmail.com>
 <a9b1ae13-7ecd-41bd-b549-35185b7e701e@kernel.org>
 <CAMciSVVw_mQpZ-PVUM8NmVqacK8E_EioHUC-ZzWWgcTX3hCO0A@mail.gmail.com>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <CAMciSVVw_mQpZ-PVUM8NmVqacK8E_EioHUC-ZzWWgcTX3hCO0A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 4/2/25 17:21, Naveen Kumar P wrote:
> On Wed, Apr 2, 2025 at 1:29 PM Damien Le Moal <dlemoal@kernel.org> wrote:
>>
>> On 4/2/25 15:40, Naveen Kumar P wrote:
>>> Questions:
>>> 1. What could cause periodic WRITE DMA timeouts followed by link resets?
>>
>> The drive not responding (drive failing for whatever reasons)
>>
>>> 2. Could this be a hardware-related issue (e.g., cabling, drive aging)
>>> or a kernel bug?
>>
>> It always can be a bug, but it looks like this is with a kernel version 4.4,
>> which is really old. Please try with the latest kernel. We do not debug older
>> kernels.
>>
>> Hardware (SSD) failing is more likely though. Your SSD is being operated with
>> NCQ turned off:
> Thank you for your response. Would re-enabling NCQ (if possible) help
> improve performance, or would it likely introduce instability?

NCQ was disabled for this SSD + adapter because it was deemed unstable. So
re-enabling it (removing the quirk) will likely make things worse.

> I observed that when the system is in this state (frequent WRITE DMA
> timeouts and link resets), running aplay from alsa-utils debian
> package results in the following error:
> aplay: pcm_write:2086: write error: Input/output error
> 
> Could these storage timeouts be affecting aplay? Is there a known
> relationship between these two failures?

This sounds like a hardware problem. Maybe your power supply is not adequate or
unstable ?

In any case, unless you retest with a recent kernel, nothing much we can do.


-- 
Damien Le Moal
Western Digital Research
