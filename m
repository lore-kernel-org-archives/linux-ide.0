Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCF8237140
	for <linux-ide@vger.kernel.org>; Mon, 18 Mar 2024 11:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710762813; cv=none; b=osNPKeFG1rVk3Ao7M2GRi7CvIfaTC2AuzTsyzWh0RT6uFG3nnppM4me3ngq2J0gzLbWiWilBI5Ochv6XvWdd6W/CkVaLaej0ZGlQ9QwXDBCPa1Vgz3XJgdAc5uyVILH7U1fb7qltXQ+2rNavBx/cjpebbojvHlC6LCScTr8IMOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710762813; c=relaxed/simple;
	bh=1EHVerfqEAl4t7VvMpL+BzGLFJqpU9XN7EV6xABZK5k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ot4MhlRrtTMDklfO+BCPGtbL/kbTatj+02iz/dLqAIarPnLovtbpelRHZCNC3bJKoT33+auSIhsPp/BuMQyEhB1P3lsBCgnuimqfGHw+oRF9wisBD2tVW8FIcXcIWb324HFMTYYsGZBIOKIFItPdzjXCuxTvNFEklvaNCT2qBJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R3KSfVEQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R3KSfVEQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B71DC433F1;
	Mon, 18 Mar 2024 11:53:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710762813;
	bh=1EHVerfqEAl4t7VvMpL+BzGLFJqpU9XN7EV6xABZK5k=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=R3KSfVEQvIt1pFczFdbPurtPvSq+vehaAPsdGzF88VrLGm4mE3Ejec9hSl682aLYq
	 mnyb/lV3nU5wfMhaIo1qpdwFuy2fFaVmC27Wrp4BKcgZvXMVVjoXVPSejhJgkfgg1/
	 IpCxOnyrCiltzSUAMqcoQ1kCAzR8LOBJjSF+KaE31uoHcSq3hGlVeVUCMonAVPM4kc
	 z5E+eoXtvLawzK/jPJekq8mvlMWQyeHpX2t5minlmNdo5/JlSTm816gul2dWyi+2nF
	 zuTrf8gzlqHLMyIcFImpviXIsj3OwW+Y50EJR7FmiQrL0F6J1dV7iG6oF1YqIDG9my
	 XWokZJwY8XE1Q==
Message-ID: <db682ed0-3ccf-46f0-bdbc-e9d694f48e6d@kernel.org>
Date: Mon, 18 Mar 2024 20:53:31 +0900
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Fwd: Re[2]: ASMedia ASM1166/ASM1064 port restrictions will break
 cards with port-multipliers
Content-Language: en-US
To: Hans de Goede <hdegoede@redhat.com>, Niklas Cassel <cassel@kernel.org>,
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
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <65cd50b1-4f54-4f47-89d8-65b4ef2c0549@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 3/18/24 20:07, Hans de Goede wrote:
> Hi,
> 
> On 3/18/24 11:56 AM, Niklas Cassel wrote:
>> Hello Matt,
>>
>> On Sun, Mar 17, 2024 at 11:58:14PM +0100, Cryptearth wrote:
>>> Sorry folks - GMail somehow not send my reply to all of you but only
>>> one. My bad - haven't noticed it.
>>>
>>> Anyway - tldr: The provided patch doesn't work.
>>> I build the 6.8.1-arch with a simple fix of commenting out the ASMedia block.
>>> No matter how it's dealt with - I do understand the issue this change
>>> is about to fix - but there has to be some override. Forcing users
>>> like me building the entire kernel (and additional modules like ZFS or
>>> nVidia gpu drivers) on thier own just for 4 characters in 2 lines
>>> (namely /* and */ before and after the block) just isn't acceptable.
>>>
>>> Greetings
>>>
>>> Matt
>>>
>>> ---------- Forwarded message ---------
>>> Von: Cryptearth <cryptearth@googlemail.com>
>>> Date: Sa., 16. März 2024 um 14:47 Uhr
>>> Subject: Re: Re[2]: ASMedia ASM1166/ASM1064 port restrictions will
>>> break cards with port-multipliers
>>> To: Conrad Kostecki <conikost@gentoo.org>
>>
>> Please be respectful on the mailing list.
>> https://docs.kernel.org/process/code-of-conduct.html
>>
>>
>>> @Niklas
>>> I tested the patch - but unfortunately it does not work with my card.
>>> See the attached log - the fun starts around line 760. This time I
>>> also attached the output of lspci -vvv -nn. I haven't checked for any
>>> differences.
>>> As Hans wrote my card seem to do something way different and out of
>>> spec of standards.
>>
>> Is CONFIG_SATA_PMP set to y in your .config?
>>
>>
>> Looking at your logs, we can see that port0-port3 all don't have a link:
>> [    0.919020] ata7: SATA link down (SStatus 0 SControl 330)
>> [    2.787201] ata8: SATA link down (SStatus 0 SControl 330)
>> [    3.100522] ata9: SATA link down (SStatus 0 SControl 330)
>> [    3.413890] ata10: SATA link down (SStatus 0 SControl 330)
>>
>> I looked at your v6.7.xx log as well, and it is the same there.
>>
>> So Hans's theory that port0-port3 is each connected to a
>> JMB575 Port Multipliers does seem less plausible.
>>
>> Because if that was the case, I would expect to see link up on these ports
>> and that it detects a PMP class code when probing these ports.
>>
>> So I have honestly no idea how this works...
>>
>> Perhaps the ASMedia firmware takes the command to port0-port3,
>> and instead of sending it to the PMP, it sends back some faked
>> reply instead?
> 
> Yes I believe that this is what is happening, the physical-ports 0-3
> are obviously connected to the JMB575 Port Multipliers, but I believe
> the "emulated" ports seen by the OS are mapped like this:
> 
> 0-3  Only show as connected to the OS is connected directly to a disk
>      without a PMP
> 4-19 Only show as connected to the OS when PMPs are used and the mapped
>      port on the PMP has a disk connected
> 
> Because of this emulation it does make sense that we cannot reach
> the PMPs since ports 0-3 are faked as disconnected when the controller
> has detected a PMP. And ports 4-19 map to the ports on the "other side"
> of the PMP. So there is no way for the kernel to talk to the upstream
> port of the PMP I guess.
> 
>> This piece of hardware really seems to do not care at all about
>> following specifications...
> 
> Ack. I think we should just go back to also probing the emulated
> extra ports so as to not regress systems where this was all working
> before and then add a module option to allow skipping the emulated
> ports to speed-up probing.
> 
> Note in other part of the thread it was suggested to make this
> speed-up probing option enabled by default. I'm strongly against
> enabling this by default. A slow boot is much less of a problem
> then systems all of a sudden no longer finding disks.
> 
>> Fun fact:
>> https://www.asmedia.com.tw/product/A58yQC9Sp5qg6TrF/58dYQ8bxZ4UR9wG5
>> Claims that it supports AHCI 1.4.
>> That is impressive, especially considering that the latest version
>> of AHCI is 1.3.1:
>> https://en.wikipedia.org/wiki/Advanced_Host_Controller_Interface
>>
>> I will send an email to some ASMedia developers on the list and see
>> if we can get any clarification.
> 
> If we can get some insights on how to deal with this from ASMedia
> and maybe come up with a better fix that would be great.
> 
> So lets hold of on adding the module option.
> 
> But can we please drop the problematic quirk to lower the number
> of ports for now, to avoid more people getting bitten by this
> regression ?

I am strongly against reverting that fix/improvement because of a problem with a
badly broken hardware that does not respect the AHCI specifications. Such
regression was bound to happen with such hardware and likely will happen again
in the future if we touch anything that does not fit with the adapters weird use
of PMP or other feature. I do not want libata code to be stuck as it is for fear
of breaking support for adapters that are already broken in the first place...

So let's go the other way around and add a libata.force parameter that allows
disabling the port count fix, or allows specifying a port mask. That will allow
users of these broken adapters to get them running again. Ideally, we would use
a quirk but it seems that the same controller chip is used in both correct
setups and broken-PMP setups. So unless ASMedia indicates some black-magic
register we can look at to know what to do, it will have to be a "manual" module
parameter.

> 
> Regards,
> 
> Hans
> 
> 
> 
> 

-- 
Damien Le Moal
Western Digital Research

