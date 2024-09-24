Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F329178367
	for <linux-ide@vger.kernel.org>; Tue, 24 Sep 2024 10:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727174542; cv=none; b=RbR3losdftk2AEgsNwlwKtO8GUlZcUphToEW1hg8uwpI0MDBlVjUCnlMdZVoch1H75VO5d/6jfdlJxWjwJCV8XguNw1i8FFmc7tzmF8z/L6LT37kysibbedR0YLQSv7oh9I8I2u1dGaQEw5XRGzc3TZbb2CQV9NZ0hu3PwKSW/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727174542; c=relaxed/simple;
	bh=gNiD6RLu1udb2gce4oMZpCu+Uu4vn9C8ETKra82Zijc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sj2WL0YyOGRErFGY6tLCYhHGQddwEI34qvnIjxrR3KO1er/J3equpvSVmhYa0MT4BMchl8svwnTHzXTNf2s4ocMGrNPHUJg7sJ6+zquAYxJKEox56ytZB69/6y373GjMQnul9EWX8n+OkNCtCL9GeJ1QSiyUEJXYN5r2pYO1rl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BaIev0w+; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BaIev0w+"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5c5c3a1f474so2353749a12.0
        for <linux-ide@vger.kernel.org>; Tue, 24 Sep 2024 03:42:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727174539; x=1727779339; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2YPfsEe5Gz4fZvfLrXom6jdcA+WUr3fEVrXW3twv6Dg=;
        b=BaIev0w+CAJyGasIzGK1hrloxH/LUYfz6Wb7S2EBRl/w2eoumcqHzZqvJY4vQPegZT
         6eF8/gkTUMXM7joXzcqsNnrqFYzpNu+zsUrsi7ArJZasi3XKQf9vaX4FlJvBkywGrDS3
         beg/d5DQsxfCVlF8xP2Q4tKJamwpIJSKdg2OeYizxZubVV5UGx5WUYQCVRVxV4z16m3F
         ts/UYmANycfzvCa32bSUDJzz7Yipaj+x1PSPlbI1+tKJW7P6TT6UkpDATmA3V4ZJGDkR
         EIvO5xOttxGjQAPjbDdYjUO+mr7rqplP+CsgL5Q2UMY8szsc5g0MH1ls9dQnqXPs/O1p
         sfHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727174539; x=1727779339;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2YPfsEe5Gz4fZvfLrXom6jdcA+WUr3fEVrXW3twv6Dg=;
        b=CJlwdXR09gq6bmF2tDiIFh0YvGWSReqo6aGudORM2mP9/RLLKR0SW6zDC4vCqfJA02
         249xVX2x7O+02UiwzqNfJO/bJjfDQWC3sj/y+9vKw4Yy38YIsrgQz2YDJ4mSEO5a6HSd
         2Fc5vJL8h/dD6DfpM8G52SwrUubeWFJJbY+6/2lPa7DCk5Vmw9NifWbbWTHAvJeTBj0O
         5ogiXZa+L5MfEBImgwp2sud2ppHpMB0TrOZCKNWmSWmiVB/G/RF5963HF7wulJBf+OBE
         njA2NWDWHsN7TbOsBfVBfITVp1RzsgyF3xSaE/Q6GP6/aUlOd3dr0v81IhEtVq2owigO
         o4Og==
X-Gm-Message-State: AOJu0YzilwaOX+2bIO0ZKDvNHAW+GkjPvumLE2oZ4oZ5f4hgDaoeEytA
	9jNlVo5YIkSMtEmFSFfIUatXSziJ/MoLoyOWl74vDCyynkF4WlFC
X-Google-Smtp-Source: AGHT+IGDTNsufgUNEyj6IFdnJ8uN6sQZGuWyKHa5urVmmKCJM+STKaOPFvBlEfsBtkrRMmNozCaZJA==
X-Received: by 2002:a05:6402:510e:b0:5c4:6568:735b with SMTP id 4fb4d7f45d1cf-5c4656873a5mr10559030a12.11.1727174539079;
        Tue, 24 Sep 2024 03:42:19 -0700 (PDT)
Received: from [192.168.1.64] ([91.231.32.85])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c5cf4d7926sm601482a12.93.2024.09.24.03.42.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Sep 2024 03:42:18 -0700 (PDT)
Message-ID: <a0c34406-3bb3-4880-9513-0876aacd4de6@gmail.com>
Date: Tue, 24 Sep 2024 12:42:10 +0200
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: libahci driver and power switching HDD on newer kernels
Content-Language: en-US
To: Damien Le Moal <dlemoal@kernel.org>,
 Linux regressions mailing list <regressions@lists.linux.dev>
Cc: linux-ide@vger.kernel.org, Niklas Cassel <cassel@kernel.org>
References: <7882faa8-d5ec-4868-b158-0b942b669cc0@gmail.com>
 <c4f1c690-6e97-44de-985f-dc9eadd18d23@leemhuis.info>
 <c7880a6f-04d4-4572-9255-1575f6668b4e@kernel.org>
From: W <linuxcdeveloper@gmail.com>
In-Reply-To: <c7880a6f-04d4-4572-9255-1575f6668b4e@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

W dniu 24.09.2024 o 9:31 AM, Damien Le Moal pisze:
> On 2024/09/24 7:20, Linux regression tracking (Thorsten Leemhuis) wrote:
>> Hi!

Hi
>> On 15.09.24 14:44, W wrote:
>>>
>>> I've got some problems with newer kernels during hibernation and
>>> waking up from hibernation.
>>> The symptom of the issue is that there is HDD power switching executed
>>> after I run pm-hibernate command and the same HDD power switching
>>> during the wake up process from hibernation.
>>
>> Thx for the report. I CCed Damien and Niklas (and the regressions list),
>> maybe they have an idea. If they do not reply you most likely need to
>> perform a bisection to raise interest in your report.
> 
> Thanks for that. Niklas and I will look at this (I thought we already had fixed
> that issue...). However, this week may be difficult as Niklas and I are
> attending a conference and we may not have time to do much. But this will be our
> highest priority next week.
> 
>>
>> And FWIW, there is one important info that afaics is missing from your
>> report: If the latest mainline kernel (e.g. 6.11) still affected?
> 
> Yes, please check that.

I've already reported the issue here:
https://bugzilla.kernel.org/show_bug.cgi?id=219296
and unfortunately the issue exists also on 6.11.

>>> 4. system is ready to use and working fine
>>>
>>> So to sum up - in both processes described above the problematic step
>>> is the step 3.
>>>
>>> I noticed this issue when I switched kernel 6.4.12 to 6.7.5. So far I
>>> haven't used git bisect yet to find the exact offending commit so the
>>> change might be introduced somewhere between 6.4.12 and 6.7.5.
> 
> It would really be helpful if you could bisect this !

I did it and placed the log from bisect in my bugzilla report: 
https://bugzilla.kernel.org/show_bug.cgi?id=219296

>>> In 6.4.12 I have not such an issues with HDD power switching. The
>>> issues exist in 6.7.5 and newer ones and probably somewhere between
>>> 6.4.12 and 6.7.5.
>>>
>>> I noticed some errors in dmesg coming from ahci driver like these:
>>> Sep 11 15:49:30 localhost kernel: ahci 0000:00:17.0: port does not
>>> support device sleep
> 
> This is relevant. This is not really an error but rather a statement that your
> device does not support sleep. This could be the reason for the behavior. (hence
> my request that if you could test with a different device, it would be help).
> 
>>> and ACPI BIOS errors like these:
>>> Sep 11 15:49:30 localhost kernel: ACPI BIOS Error (bug): Could not
>>> resolve symbol [\_SB.PCI0.SAT0.PRT0._GTF.DSSP], AE_NOT_FOUND
>>> (20240322/psargs-330)
> 
> Yeah... I see these all the time on different machines. That comes from the BIOS
> not being great :) Not sure if that one relates to SATA though ?

I was trying to report this issue to American Megatrends Inc. as the 
BIOS maintainer but their website form didn't accept any of my emails :) 
So eventually I couldn't let them know about these issues.

>>> Please take a look at included dmesg in the attachment.
>>>
>>> The mainboard I use is: Gigabyte Z370 HD3P with the newest available
>>> BIOS update.
>>>
>>> I'd like to ask if this is known issue and if yes how could I fix it?
>>> I'm not quite sure where exactly is the issue: in kernel or in my
>>> Gigabyte BIOS?
> 
> Given that you had 6.4.12 working OK, it is likely some commit that introduced a
> regression. If you can git bisect it, we will have a better idea how to remove
> the regression.

Please take a look at bugzilla report: 
https://bugzilla.kernel.org/show_bug.cgi?id=219296 - there are the details.

I'm wondering what is the better way for communication - here on mailing 
list or put the comments in bugzilla ticket?
Probably here will be better idea...

W

