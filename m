Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AD344EB32
	for <linux-ide@vger.kernel.org>; Mon, 18 Mar 2024 14:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710771717; cv=none; b=fNmZ/cT9Zy6Ta2KIOXc6Rb6ff0dqyl8Gm/5WEfAR8K+l7LCVjD6yKx6G3WGpUxmzisSXBT8jgwWzNJySqaYI0/ijeFOHCBegMmc2WhZ0cKe0vqMwgpS4PNEmdkTMtlD/VjUDchknq9+pqdumuKrgbMWAqlS1ll8YBMviF9C44s0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710771717; c=relaxed/simple;
	bh=hJpWov2OyVRGT4KURZgcwiuKIMawGHfWkdd7WZWAUuU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OwmBcz2oYsKWXDsuTzk1l9l4jd+qwstHQIRioCpsYmlCE69COur8CuxfOuIt4fI0E2j4nL9f7wT8lmBUzuoF1+wOLtR43I/WXV6Y1JIASxackg/gsHCe37MmJBkQ768iB7AvGGLWwFiGNnQzawHldneuI05KFMrqr4SFYN1KZQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ThtYSdnr; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ThtYSdnr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710771715;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vepLZqj58dFirTjez5P7Snq1llEjVKUHBjGULsHus9o=;
	b=ThtYSdnr3mb0UK+I9+FMo0kXOwrhjcEUWgZix8glEmmjpchVIdFKs2wcBFIaofOO0xeXed
	/oVj/MC3OgUjaK9hP/U7IaMW+omqBwRtXYYoKkRcPhNCWlkQqiGZyMlwKsn39APHvbOBYd
	0zXIT2KbR69yQf7mPFvEe7Za4r3bJgk=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-119-ADa3AdWoNhKloKcR6JAgPA-1; Mon, 18 Mar 2024 10:21:51 -0400
X-MC-Unique: ADa3AdWoNhKloKcR6JAgPA-1
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-2d449d68bc3so44152531fa.3
        for <linux-ide@vger.kernel.org>; Mon, 18 Mar 2024 07:21:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710771710; x=1711376510;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vepLZqj58dFirTjez5P7Snq1llEjVKUHBjGULsHus9o=;
        b=wsbunznqFgEKYpE9DFUfNivKFsg9NgzpgCaplk7OjmLKt/zZSa8CyVpc16g7o3reiz
         tExDxh7tGQzlbn3LZzdN1n7RRyOQMk8BWRM5iEoD7QCfxR7nQctc+gTVxK1C8dRYn6RH
         QRKfHDQGC9KexLFHTtv3XxUqSFuMyhGcnQN3W3W6q3y936cAa3SnxpYQeDoIP8u9Dpgo
         EIwghfhQxeZ0/UACE4hlhNY9i7l3pI5NBR4lUrIHTrFI+BsnMRFGULsekCz14QtnDore
         0wb3D0r0vSPGvUF3z9tlgHzvxiAt+cvaldueWlK4LsR6mphef8xTKLXL8FnJMyYoT1OZ
         /RDA==
X-Forwarded-Encrypted: i=1; AJvYcCWwA0mz0FANsMotStgcI/5oliMKirF75vyVFpYzUg3VdEHKtthAMMujbm2T5p/A3ekYFDRO71Vl13GX0VXTG0P0wNQX21HFqYV1
X-Gm-Message-State: AOJu0YwbqPkXwO+g0HiO77s+vZigz2ShI9hiO8uThXiVUTBmCQ+89zbw
	Cfc5mzGgKa23qz02SzMxvMJiKnnjpUr7OsVJvjrSFYLNP2K1Hq+D+c3rFe4JbbLOAYQglVSgU06
	v3tWv/Y8DVahhO3j+59bwsy/6wdpMHYSkOSD7kvPmiRS25zw8z3WxIejaqA==
X-Received: by 2002:a05:6512:3283:b0:513:bed1:5069 with SMTP id p3-20020a056512328300b00513bed15069mr5176322lfe.13.1710771710309;
        Mon, 18 Mar 2024 07:21:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFqazInsCIZiar139D/o9LMZ4SYVM7BGuk3ooBZngOU4DhxmfKym30m1MbmvtG9EYkF3A3kbQ==
X-Received: by 2002:a05:6512:3283:b0:513:bed1:5069 with SMTP id p3-20020a056512328300b00513bed15069mr5176296lfe.13.1710771709915;
        Mon, 18 Mar 2024 07:21:49 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id sd9-20020a170906ce2900b00a4628cacad4sm4887849ejb.195.2024.03.18.07.21.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Mar 2024 07:21:49 -0700 (PDT)
Message-ID: <b318971e-4748-49e0-a2ae-a1fba9267d82@redhat.com>
Date: Mon, 18 Mar 2024 15:21:48 +0100
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Fwd: Re[2]: ASMedia ASM1166/ASM1064 port restrictions will break
 cards with port-multipliers
To: Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>,
 Cryptearth <cryptearth@googlemail.com>
Cc: temnota.am@gmail.com, linux-ide@vger.kernel.org, conikost@gentoo.org
References: <CAFDm6W19R3KHDO09c94Uwry9mdG+whAVy=u4Sdpt30A2MK1KPA@mail.gmail.com>
 <CA+PODjqxYcBMc=R792uOava1u0EYZtrWTOw9HvKUBG4=zYbzcg@mail.gmail.com>
 <CAFDm6W2dWu5+Dz2DiWG_9L-VatM6Wj=pMHM2th74Wh144kvqvg@mail.gmail.com>
 <ZfMerqAmWoyu66/5@x1-carbon>
 <2e471c2b-8432-4501-b093-4295529a4d38@redhat.com>
 <CAFDm6W0zP=Yw_OA9_qJ17Np=px=sR69m9hGF3D96A9gyS5PLTQ@mail.gmail.com>
 <em260ca711-2dd7-490f-b401-eeac6c172e98@c8aae956.com>
 <CAFDm6W2nCj+qw=-7Sb9xcJTYZ8sitwUriR+Qdh9fo9+ET1Oo=g@mail.gmail.com>
 <CAFDm6W3c7UUHRVG_WzEUK+pmHQNUywFpJZtkeWVVxrX-oBKpqw@mail.gmail.com>
 <Zfgd4gjQS0Cmexeq@ryzen> <65cd50b1-4f54-4f47-89d8-65b4ef2c0549@redhat.com>
 <db682ed0-3ccf-46f0-bdbc-e9d694f48e6d@kernel.org>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <db682ed0-3ccf-46f0-bdbc-e9d694f48e6d@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Damien,

On 3/18/24 12:53 PM, Damien Le Moal wrote:
> On 3/18/24 20:07, Hans de Goede wrote:
>> Hi,
>>
>> On 3/18/24 11:56 AM, Niklas Cassel wrote:
>>> Hello Matt,
>>>
>>> On Sun, Mar 17, 2024 at 11:58:14PM +0100, Cryptearth wrote:
>>>> Sorry folks - GMail somehow not send my reply to all of you but only
>>>> one. My bad - haven't noticed it.
>>>>
>>>> Anyway - tldr: The provided patch doesn't work.
>>>> I build the 6.8.1-arch with a simple fix of commenting out the ASMedia block.
>>>> No matter how it's dealt with - I do understand the issue this change
>>>> is about to fix - but there has to be some override. Forcing users
>>>> like me building the entire kernel (and additional modules like ZFS or
>>>> nVidia gpu drivers) on thier own just for 4 characters in 2 lines
>>>> (namely /* and */ before and after the block) just isn't acceptable.
>>>>
>>>> Greetings
>>>>
>>>> Matt
>>>>
>>>> ---------- Forwarded message ---------
>>>> Von: Cryptearth <cryptearth@googlemail.com>
>>>> Date: Sa., 16. März 2024 um 14:47 Uhr
>>>> Subject: Re: Re[2]: ASMedia ASM1166/ASM1064 port restrictions will
>>>> break cards with port-multipliers
>>>> To: Conrad Kostecki <conikost@gentoo.org>
>>>
>>> Please be respectful on the mailing list.
>>> https://docs.kernel.org/process/code-of-conduct.html
>>>
>>>
>>>> @Niklas
>>>> I tested the patch - but unfortunately it does not work with my card.
>>>> See the attached log - the fun starts around line 760. This time I
>>>> also attached the output of lspci -vvv -nn. I haven't checked for any
>>>> differences.
>>>> As Hans wrote my card seem to do something way different and out of
>>>> spec of standards.
>>>
>>> Is CONFIG_SATA_PMP set to y in your .config?
>>>
>>>
>>> Looking at your logs, we can see that port0-port3 all don't have a link:
>>> [    0.919020] ata7: SATA link down (SStatus 0 SControl 330)
>>> [    2.787201] ata8: SATA link down (SStatus 0 SControl 330)
>>> [    3.100522] ata9: SATA link down (SStatus 0 SControl 330)
>>> [    3.413890] ata10: SATA link down (SStatus 0 SControl 330)
>>>
>>> I looked at your v6.7.xx log as well, and it is the same there.
>>>
>>> So Hans's theory that port0-port3 is each connected to a
>>> JMB575 Port Multipliers does seem less plausible.
>>>
>>> Because if that was the case, I would expect to see link up on these ports
>>> and that it detects a PMP class code when probing these ports.
>>>
>>> So I have honestly no idea how this works...
>>>
>>> Perhaps the ASMedia firmware takes the command to port0-port3,
>>> and instead of sending it to the PMP, it sends back some faked
>>> reply instead?
>>
>> Yes I believe that this is what is happening, the physical-ports 0-3
>> are obviously connected to the JMB575 Port Multipliers, but I believe
>> the "emulated" ports seen by the OS are mapped like this:
>>
>> 0-3  Only show as connected to the OS is connected directly to a disk
>>      without a PMP
>> 4-19 Only show as connected to the OS when PMPs are used and the mapped
>>      port on the PMP has a disk connected
>>
>> Because of this emulation it does make sense that we cannot reach
>> the PMPs since ports 0-3 are faked as disconnected when the controller
>> has detected a PMP. And ports 4-19 map to the ports on the "other side"
>> of the PMP. So there is no way for the kernel to talk to the upstream
>> port of the PMP I guess.
>>
>>> This piece of hardware really seems to do not care at all about
>>> following specifications...
>>
>> Ack. I think we should just go back to also probing the emulated
>> extra ports so as to not regress systems where this was all working
>> before and then add a module option to allow skipping the emulated
>> ports to speed-up probing.
>>
>> Note in other part of the thread it was suggested to make this
>> speed-up probing option enabled by default. I'm strongly against
>> enabling this by default. A slow boot is much less of a problem
>> then systems all of a sudden no longer finding disks.
>>
>>> Fun fact:
>>> https://www.asmedia.com.tw/product/A58yQC9Sp5qg6TrF/58dYQ8bxZ4UR9wG5
>>> Claims that it supports AHCI 1.4.
>>> That is impressive, especially considering that the latest version
>>> of AHCI is 1.3.1:
>>> https://en.wikipedia.org/wiki/Advanced_Host_Controller_Interface
>>>
>>> I will send an email to some ASMedia developers on the list and see
>>> if we can get any clarification.
>>
>> If we can get some insights on how to deal with this from ASMedia
>> and maybe come up with a better fix that would be great.
>>
>> So lets hold of on adding the module option.
>>
>> But can we please drop the problematic quirk to lower the number
>> of ports for now, to avoid more people getting bitten by this
>> regression ?
> 
> I am strongly against reverting that fix/improvement because of a problem with a
> badly broken hardware that does not respect the AHCI specifications. Such
> regression was bound to happen with such hardware and likely will happen again
> in the future if we touch anything that does not fit with the adapters weird use
> of PMP or other feature. I do not want libata code to be stuck as it is for fear
> of breaking support for adapters that are already broken in the first place...
> 
> So let's go the other way around and add a libata.force parameter that allows
> disabling the port count fix, or allows specifying a port mask. That will allow
> users of these broken adapters to get them running again. Ideally, we would use
> a quirk but it seems that the same controller chip is used in both correct
> setups and broken-PMP setups. So unless ASMedia indicates some black-magic
> register we can look at to know what to do, it will have to be a "manual" module
> parameter.

The kernel has a clear no regressions policy and there is ample documented
cases where needing to set a module option to undo the regression was
considered not acceptable.

So there really is no discussion here. We must not regress and thus the default
behavior must be behavior which works out of the box on the boards with
the PMP chips on them.

Also we really want Linux to "just work" having to set a module option
just to make things work very much goes against that.

Regards,

Hans



