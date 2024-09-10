Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A2681A4B84
	for <linux-ide@vger.kernel.org>; Tue, 10 Sep 2024 22:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726006926; cv=none; b=rqcEY95XwdH54unfeZUMTM1p3Ht1s/DICYpXGxg2ZmJ6rEMQXHpyc9OCYs1UQWxwpF1HlmpcOC0N83EeYuFDUMXRFxmsuLg+P6A/XF3mGWccyLKpxJz7pM7idB5LoK38WhOxPxt+La2lUs09alfRmwtUUL5WBZS9P5penSJLo7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726006926; c=relaxed/simple;
	bh=yFI8t+vnipKHLmuT5hZf3Rb/2SGsG1z1WoNKlE0mBMk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MKsZKKvWuEqJEzAE2QZvI7f11CCzPoiEcyygwDJOCjXijGhKE99in3QKjXJbjbhLgDVLydAiah7IU2NJs5uanxxQKh7uv9ma5KVVeiQhhuIet7ZBAn7mStiU4meU6J/6FlrhEIctWiwvHHYlOXe6Pa4QOR9BMC+YLlPEaeukpL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WmFeM5wc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WmFeM5wc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37CDBC4CECC;
	Tue, 10 Sep 2024 22:22:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726006925;
	bh=yFI8t+vnipKHLmuT5hZf3Rb/2SGsG1z1WoNKlE0mBMk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=WmFeM5wcvAyrTtKG194EVLIb6JKFDbo1c9kZTEvVMekXoAQILjhO15LrRfs8sqZKO
	 u8e0+RmQjUpDJVuzLsRoVKZgS+wsgxoTP2im/RYNF2KnOTTeXqJfI1EHN5gjyBJCI4
	 ReSUS/7xVxj41mnF1+VM/JVcBiDEoLinBqFttuktG7Un9vyfnOpnEacHv1r77QCpXP
	 CAzrIoZF0SCKhpZfYTNbS0baKUxmMVl/Xb1h88H2y9uw++Ek/hh+kdU4on9q5pDAa/
	 03fj0GhRwm4A6I171Olpc+2LFzr7vgiknTAUHVSNWqgBRhZgBoT6ngQti7IGe8bk5J
	 wTnRKexnLQ1+w==
Message-ID: <9d7e0d4f-1445-4729-9e4d-9058c35db1b2@kernel.org>
Date: Wed, 11 Sep 2024 07:22:04 +0900
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ata: ata_generic: use IS_ENABLED() macro
To: Sergey Shtylyov <s.shtylyov@omp.ru>, linux-ide@vger.kernel.org,
 Niklas Cassel <cassel@kernel.org>
Cc: lvc-project@linuxtesting.org
References: <d9c0acab-909e-da06-decf-be5de59d23bf@omp.ru>
 <87f85704-656d-4c08-b729-87c9b2e6d686@kernel.org>
 <4414c20f-7e0e-de47-8311-4a8948f2504d@omp.ru>
 <f5209cc3-a0c6-4722-92b7-533c0b244527@kernel.org>
 <65e70327-62e1-3b1a-7b69-eae765241b5c@omp.ru>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <65e70327-62e1-3b1a-7b69-eae765241b5c@omp.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/10/24 23:36, Sergey Shtylyov wrote:
> [Resending after adding the missed test, please ignore the previus reply.)
> 
> On 9/10/24 4:09 PM, Damien Le Moal wrote:
> [...]
> 
>>>>> Replace now gone out of fashion defined(CONFIG_PATA_TOSHIBA[_MODULE])
> 
>    I'll probably rephrase this a bit in v2...
> 
>>>>> with the new-fangled IS_ENABLED() macro in the ata_generic[] definition.
>>>>
>>>> Please mention that CONFIG_PATA_TOSHIBA_MODULE actually does not exist at all
>>>> and so can be removed.
>>>
>>>    Huh? =)
>>>    CONFIG_PATA_TOSHIBA is a tristate option, so CONFIG_PATA_TOSHIBA_MODULE
>>> does exist; else there would be no point in using IS_ENABLED() at all...
>>
>> Oops... Indeed. Got confused with something else :)
> 
>    There's something to be confused about this driver vs its Kconfig option
> naming: the driver is called pata_piccolo.c and its option CONFIG_PATA_TOSHIBA.
> However, Toshiba seemingly has more than one family of the PATA controllers:
> there's also TC86C001 PCI multi-function chip (dubbed GOKU-S by Toshiba) which
> supports up to UDMA66 and doesn't seem compatible with Piccolo, judging by the
> driver code and Toshiba GOKU-S datasheet I have: the timing regs are mapped @
> AR5 and not in the PCI config space, like with the Piccolo chips.
>    If somebody like me (it was me who submitted the reworked Toshiba's TC86C001
> driver for drivers/ide/ back in 2007) added TC86C001 libata driver, the confusion
> would probably worsen... :-/ Luckily, the chip is a bit tricky (I had to somewhat
> abuse drivers/ide/ to work around some "limitations", as Toshiba calls their errata)
> and I don't have access to the chip to properly test the driver anymore.  Obviously, there should be a little interest now in adding the "new" PATA drivers... :-)
>    Any thoughts on the naming confusion?

Maybe rename the option to CONFIG_PATA_TOSHIBA_PICCCOLO ?

> 
>>>>> Signed-off-by: Sergey Shtylyov <s.shtylyov@omp.ru>
>>>
>>> [...[
>>>
>>>>> Index: linux/drivers/ata/ata_generic.c
>>>>> ===================================================================
>>>>> --- linux.orig/drivers/ata/ata_generic.c
>>>>> +++ linux/drivers/ata/ata_generic.c
>>>>> @@ -220,7 +220,7 @@ static struct pci_device_id ata_generic[
>>>>>  	{ PCI_DEVICE(PCI_VENDOR_ID_OPTI,   PCI_DEVICE_ID_OPTI_82C558), },
>>>>>  	{ PCI_DEVICE(PCI_VENDOR_ID_CENATEK,PCI_DEVICE_ID_CENATEK_IDE),
>>>>>  	  .driver_data = ATA_GEN_FORCE_DMA },
>>>>> -#if !defined(CONFIG_PATA_TOSHIBA) && !defined(CONFIG_PATA_TOSHIBA_MODULE)
>>>>> +#if !IS_ENABLED(CONFIG_PATA_TOSHIBA)
>>>>
>>>> I do not understand the negation here... It seems very wrong. If the driver is
>>>> indeed enabled, we need to add its PCI ID, no ? and the reverse when not defined...
>>>
>>>    The separate driver was added by Alan Cox in 2009, before that
>>> Toshiba Piccolo controllers were handled by this generic driver...
>>
>> OK, makes sense now. Maybe we should add a comment above that IS_ENABLED() to
>> say so ?
> 
>    Makes sense, indeed. Do you think this is acceptable to be done in v2 of this
> patch?

Yep, that is fine and would fit with the config option renaming.

> 
> MBR, Sergey

-- 
Damien Le Moal
Western Digital Research

