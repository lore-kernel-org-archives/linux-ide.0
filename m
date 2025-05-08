Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00AAB283FD5
	for <linux-ide@vger.kernel.org>; Thu,  8 May 2025 19:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746732247; cv=none; b=cXo7IPjTAR8e7DPnpPxILhdpq5jnCLW2ulFmOF20oH6z62Ty85E0hcCgafd7s5o+sYIFKeChc/MUHwBSr4C/piiBElrIVT3RVhX6KOOxBQQ0lnfc1L0w8cPDvJrBhAbxsRMxI2aNNIRuyDe1/A+Da2pMVEDJs/jxK6MREpVRBZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746732247; c=relaxed/simple;
	bh=bQfxLnW85YQjzEWAlYr56Q/bPCIFGRSQMB899uGD704=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FVBAvvvKvgcUme7eNfDtkQ60kjj3RVIWiyc81k4sCMRQSboPORFt51S4YdrLlaVNY7CJZCDIo13gV2vMiR25vwY/Uh4oVQKdow26UZUUXCstGQBXYKXC9zh2oer31N8NC4UK5LmY4HzlfpTtuLEPGF2sP5GhyJ3i45yxr+JBj1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VJHhj64K; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VJHhj64K"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07300C4CEE7;
	Thu,  8 May 2025 19:24:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746732246;
	bh=bQfxLnW85YQjzEWAlYr56Q/bPCIFGRSQMB899uGD704=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=VJHhj64KWfrw28fNohqhx3F4wnvuceHEOhy4zMCSK8M2CcKueWoKzZ12pack+fRuv
	 PdOZ6FbRkMiXZ6nF7f13yV5ZKo5Rkiuey6IwIMk4LtV+4Sb8NUqIPTIIyDh75db6eV
	 rhyo7OS1lIsMJDWH/XceWBnNtq8byVRvuEdmxX2AOXiYh2wcUPQ7CTZ5fQ6RfZ2Uzf
	 Pd3higFtoDxHBZuxtm8D7BzETQyqVbZrP/KxhD1N3/v03Tsy6ine0HaI9Sum6AiYOG
	 JlvHFmGlu7Y7YKiyrm/TaDrWJHyJZgrQP45sob55HCDtkdq+Iui4T8eJG1dupFpqM9
	 v8b1qi4eQ0RbA==
Message-ID: <87aadf1a-e4f5-49c0-be7f-9d524b207357@kernel.org>
Date: Thu, 8 May 2025 14:24:05 -0500
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] ata: libata: disable LPM for WDC WD20EFAX-68FB5N0 hard
 drives
To: Niklas Cassel <cassel@kernel.org>
Cc: Damien Le Moal <dlemoal@kernel.org>, Ioannis Barkas <jnyb.de@gmail.com>,
 linux-ide@vger.kernel.org, Basavaraj Natikar <Basavaraj.Natikar@amd.com>,
 Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
References: <CADUzMVbneDW06V4vd8si8k=NN_6df3JeejaF3fVk2U=LVC1UHA@mail.gmail.com>
 <fe406980-f230-4060-9b1a-16295b6cfa48@kernel.org>
 <88a6fb5f-dc85-41e0-a65d-92704b4c8499@kernel.org>
 <CAAZ0mTeepp7G9CtLFq+U_n0h2+SF8V8j2K=0hkNAp0Fzdc7TAQ@mail.gmail.com>
 <aBjbSt5hTaUP_JhG@ryzen>
 <CAAZ0mTctoC5UCsDVH56x5OS_500URheBU66USNuq+rwktLrEiw@mail.gmail.com>
 <aBsg4aKYK3lfGASx@ryzen>
Content-Language: en-US
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <aBsg4aKYK3lfGASx@ryzen>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

+ Shyam and Basavaraj for comments

On 5/7/2025 3:59 AM, Niklas Cassel wrote:
> On Mon, May 05, 2025 at 08:09:44PM +0300, Mikko Juhani Korhonen wrote:
>> ma 5.5.2025 klo 18.37 Niklas Cassel (cassel@kernel.org) kirjoitti:
>>
>>> On Mon, May 05, 2025 at 10:58:22AM +0300, Mikko Juhani Korhonen wrote:
>>>>>> On 5/1/25 05:36, Ioannis Barkas wrote:
>>>>>>> It would be better to have more details on this since only the 2TB
>>>>>>> model is targeted.
>>>> I have two WD20EFAX-68FB5N0 and both behave consistently, unusable
>>>> from 6.9.0 on as they just keep resetting the SATA link , but they
>>>> have worked flawlessly with 6.8.x for a year and also now with the
>>>> quirk applied.
>>>> I have also tested a different WDC model with med_power_with_dipm on
>>>> the same SATA port and there are no problems.
>>>> But after you guys got suspicious I found there is in fact a SATA port
>>>> on my motherboard where the WD20EFAX-68FB5N0 works with LPM on
>>> This motherboard looks to be AMD chipset, so I assume AMD AHCI controller.
>>>
>>> Could you send the output of:
>>> $ lspci -nn | grep -E "SATA|AHCI"
>>
>> mjkorhon@taavi:~$ sudo lspci -nn | grep -E "SATA|AHCI"
>> 01:00.1 SATA controller [0106]: Advanced Micro Devices, Inc. [AMD] 500
>> Series Chipset SATA Controller [1022:43eb]
> 
> 
> Hello Mario,
> 
> We are seeing some LPM issues with an AMD AHCI controller when using a
> (fairly recent) WD drive (so I would be slightly surprised if LPM wasn't)
> implemented correctly.
> 
> The AMD AHCI controller is however something that I haven't seen before:
> AMD 500 Series Chipset SATA Controller [1022:43eb]
> 
> For AMD, I have mostly seen:
> 
> PCI_VDEVICE(AMD, 0x7800)
> PCI_VDEVICE(AMD, 0x7801)
> PCI_VDEVICE(AMD, 0x7900)
> PCI_VDEVICE(AMD, 0x7901)
> 
> 
> I have never seen any 0x43eb before.
> Is this AHCI chip less common than the others?
> 
> 
> We did add a quirk that disables LPM (when used with Samsung drives) for
> ATI AHCI controllers recently:
> https://lore.kernel.org/linux-ide/20250317170348.1748671-2-cassel@kernel.org/
> 
> 
> Could perhaps this 0x43eb be a rebranded ATI AHCI controller?

Looking up this controller it seems that it should be part of chipsets 
starting in ~2019.

Somewhat a shot in the dark but could this maybe also be fixed by

https://lore.kernel.org/linux-pci/20250424043232.1848107-1-superm1@kernel.org/

That was specifically with storage attached to the chipset on desktops 
instead of to the APU.

> 
> 
> If we had LPM problems with AMD 0x78XX/0x79XX AHCI controllers,
> I'm quite sure that we would have seen way more bug reports by now.
> 
> 
> Kind regards,
> Niklas

