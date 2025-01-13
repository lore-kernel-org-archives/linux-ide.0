Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D0961B422D;
	Mon, 13 Jan 2025 20:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736800113; cv=none; b=sGToXN6Y1oIgac4cEWbZ+yAA7eLYE88c/w8BiumydvV/yoXGUR0CIXcZLyV9a9L3FTtVzld2fRfFSgx3EhQWWqlX1+OUt5q2zZZqXwmycT0C9D1WJ/PzAExaa7iTUv//gxL6UpOwmMqNtohJdfHBZxGcbrj53nM664hSiO/zrOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736800113; c=relaxed/simple;
	bh=XeNrRsA6g13x1OOCcgAU7LRbjxkf6N2oxIhKVHnOsj4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q3U+iKabKP8Dww58i79B6hyLzi5FkQYdkzY7UY5DDwYO5/O7jYAD56g+AQKDa+kpH182sVD3dvSc09AGE4SahSlm/2CbFzywAlEFEsHwuCY89QL/SXNCZWNJ1H0OmbWGRUn64CQHdDuggt13+RzNPmJCyZZIVxIPZZCJfI4KoRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CxUA5IYc; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CxUA5IYc"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3862f32a33eso2071362f8f.3;
        Mon, 13 Jan 2025 12:28:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736800110; x=1737404910; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YZUPKPodQRA9UKLrw7YC46HAo7cQohPbJabF4rZYVbI=;
        b=CxUA5IYc522VpmS0gSCN2bf1MPCf+0MrnKVsN5WPAcma4WyB2aDfi4JOU5r1lAmarm
         QV1Gv3Kqt1Rl5i94z7EER3cY/NfOmat8w+9SSpJSXC0wEt7ap5a7Rjw40jZ72csd0LeX
         hygQeSFbvhmE6nIKESQ0aeTNNJzHH3Sk4m0wJswTuAvhfp78/3MPNbK5pIyUlnD1oK/6
         VXBkbJyMVldumckZ9bPYGlLORyvAeiqIl3Ft+nzmlTShmDZRvTayVji7GqaIUtKTXXBx
         oDs3536OWCrLdYat1ns0UiYrdORiHdzYp4u+bkpapzrjxeM1vcU0vnYtOfzQxzFOzRVT
         uGkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736800110; x=1737404910;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YZUPKPodQRA9UKLrw7YC46HAo7cQohPbJabF4rZYVbI=;
        b=COoc/32UeD7pR80N7n5bFkb4NlqTFbTSvQBgHrmt+dwu/D6OU78zNobmywJovpAtjd
         4kIBMzpRm1CpWkQangd/nM2wpkJ41yKdYMrMjLN5pc/TgCrvUfKr0d8lj51AWG8a4kEd
         bPuiboOATnPUdhPNHL8J2HpkTyMw6QXnxaldLpKB3d1ghzh4ThcmFdBI8m8o9+luRXsA
         qIhm410WbL0OePJaCtXVZKDjmiuNB95LbI6fiRu4KjwTkMJKqR/C4zTHPflAGY/Ka7K6
         SdvlZRqOJgKhSSESc2D6Mq1XSG7O1G6J7adYYcJ5AbYKjUKsI8G3dj8RynDRR3oeNCPI
         6TSQ==
X-Forwarded-Encrypted: i=1; AJvYcCU3z8oC9Zf0bxZ0HBH2w0F2Qy49EFQTGRTnWb04CEH/ADbURbANx0DEx+yOmaqqhmFVbH1zixj+5oTcVlqX@vger.kernel.org, AJvYcCVVS3pYkniRkisDYDJqWOgeBXXTrXlY/rHgkRQ+WmOassPpcg2nVDwG1c9CW1g8UprLFVLNtI4AJpA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7a7qbWq2oXFGP/6hiCwcPTbGkXZVlcmZPQQdx1c0Hi5SGjXcU
	FmggS4sn2aaf8aO/OyBHodlJOBbb9yPGy4lkrX3XeyDnqiHuWD6x
X-Gm-Gg: ASbGncuaAuDZ15niXCDr6Cog2ky1siVflC5pgAaknKz3BVpYkWVxFiyhLaCA3usjHm2
	6kE/ZnL0z+FQLw2hEZ6+j6BUgO2luUFxCBjJF2m/VW+7U8sAyFuY0GFTvPQUyCc4PO9I7Ab3E9u
	KBXxC3dAuk6hV6rwKClvpDSJYAF7ELZpINjTrr74OdN3oTxsqUOCUXCZGIqXXQHfDgReCxuMvH/
	JF964jCSlAVIIU8oNoxiVDTD/WyYGI1IaJr2/0CQs0S68DRWa8DR31W6CDqGBLj+d06SwfLRPsK
	Et4BIB1baInYQKgbKVkH/kOJ+w==
X-Google-Smtp-Source: AGHT+IGaFO3Fpq1npGkSd3mTkGaOivTVZj4V4/IbIrGsqAJL175KbCIlc0anhQ+1WKG7VXpnfzGkjQ==
X-Received: by 2002:a05:6000:2a3:b0:386:3684:c97e with SMTP id ffacd0b85a97d-38a87309ca0mr21715051f8f.23.1736800109422;
        Mon, 13 Jan 2025 12:28:29 -0800 (PST)
Received: from ?IPV6:2001:861:3385:e20:6384:4cf:52c5:3194? ([2001:861:3385:e20:6384:4cf:52c5:3194])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a8e38c1d6sm13247251f8f.50.2025.01.13.12.28.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Jan 2025 12:28:29 -0800 (PST)
Message-ID: <261f9fac-82de-4f39-bf5c-cdfcee917588@gmail.com>
Date: Mon, 13 Jan 2025 21:28:28 +0100
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] ahci: st: Switch from CONFIG_PM_SLEEP guards to
 pm_sleep_ptr()
To: Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>
Cc: Patrice Chotard <patrice.chotard@foss.st.com>,
 linux-arm-kernel@lists.infradead.org, linux-ide@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250109175427.64384-1-rgallaispou@gmail.com>
 <07a7177d-7705-4eb5-a11e-02a9429ffac2@kernel.org>
 <Z4EDKUb+hO0ovV2i@x1-carbon>
 <cfecaa65-f6bc-48c1-9295-9bfe18f13db3@kernel.org>
Content-Language: en-US, fr
From: =?UTF-8?Q?Rapha=C3=ABl_Gallais-Pou?= <rgallaispou@gmail.com>
In-Reply-To: <cfecaa65-f6bc-48c1-9295-9bfe18f13db3@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 10/01/2025 à 13:02, Damien Le Moal a écrit :
> On 1/10/25 20:23, Niklas Cassel wrote:
>>>> -#ifdef CONFIG_PM_SLEEP
>>>>   static int st_ahci_suspend(struct device *dev)
>>>>   {
>>>>   	struct ata_host *host = dev_get_drvdata(dev);
>>>> @@ -221,9 +220,8 @@ static int st_ahci_resume(struct device *dev)
>>>>   
>>>>   	return ahci_platform_resume_host(dev);
>>>>   }
>>>> -#endif
>>>
>>> I do not think you can remove the ifdef here. Otherwise, there is going to be a
>>> compilation warning when CONFIG_PM_SLEEP is not enabled. No ?
>>
>> Look at the pm_sleep_ptr macro:
>> include/linux/pm.h:#define pm_sleep_ptr(_ptr) PTR_IF(IS_ENABLED(CONFIG_PM_SLEEP), (_ptr))
>>
>> I would expect the function should be optimized out by the compiler
>> using dead code elimination.
> 
> Indeed. Just tried and no warning. I was expecting a "defined but not used"
> warning, but none showed up. So all good.
> 
>> Raphael, perhaps you could show the before and after output
>> using ./scripts/bloat-o-meter ?
>> (When the config is not enabled: before and after your patch.)
Hi,

I have not used the bloat-o-meter until now, thanks ! :)
Here are my results:


   * with the configuration

$ ./scripts/bloat-o-meter ahci_st_no_patch_pm.o ahci_st_patch_pm.o
add/remove: 1/1 grow/shrink: 0/0 up/down: 4/-4 (0)
Function                                     old     new   delta
__initcall__kmod_ahci_st__384_241_st_ahci_driver_init6       -       4 
    +4
__initcall__kmod_ahci_st__384_243_st_ahci_driver_init6       4       - 
    -4
Total: Before=2200, After=2200, chg +0.00%


   * without the configuration

$ ./scripts/bloat-o-meter ahci_st_no_patch_no_pm.o ahci_st_patch_no_pm.o
add/remove: 1/2 grow/shrink: 0/0 up/down: 4/-96 (-92)
Function                                     old     new   delta
__initcall__kmod_ahci_st__383_241_st_ahci_driver_init6       -       4 
    +4
__initcall__kmod_ahci_st__383_243_st_ahci_driver_init6       4       - 
    -4
st_ahci_pm_ops                                92       -     -92
Total: Before=1904, After=1812, chg -4.83%


Looks like the patch shrinks a bit more the driver. I also tested, so we 
should be fine I think.
> 
> No need to do that I guess. But there are 17 other ata driver that set .pm
> operations. What about these ? Don't they need the same treatment as ahci_st ?
> 15 of these also use SIMPLE_DEV_PM_OPS() which can be replaced with
> DEFINE_SIMPLE_DEV_PM_OPS() also, no ?
> 
> Do you want us to do that cleanup ? (fine with me).

Regarding the other ata drivers, if you have the patience I can do this 
in a few weeks.  There is other things on the stove I would like to do.

Regards,
Raphaël
> 

