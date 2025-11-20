Received: from pasta.tip.net.au (mx1.tip.net.au [203.10.76.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80EF131BCB8
	for <linux-ide@vger.kernel.org>; Thu, 20 Nov 2025 11:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.10.76.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763638695; cv=none; b=r48CPSTkyySF5KgVoLvsg1oOYHdTRLE72kmUEQY/hW5A1He4gx+PZxQPufz6agq//RRp+HkFdQ1ewfb3Hs0HFeSoyMGsgE7PZbqw7cwrqXDlbsy+bNDDb4MSYkrbbcxo9gDgK0hGUJHdy+msgYzVOUB/gsfq4raZ6bDBfnNHLIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763638695; c=relaxed/simple;
	bh=4axZplz3iqw+aznepYtglvIqveK1LwzmEvY9IQPR4P4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kcSRisIjnjE+puVGvmwY30dnc/w0HIsJw+juC1WgeOGVXP+KbVKxuMoEv0e3ly8YXRDyBR9KZPhw4MhIpuLQvtrfn5p2O0VaqxpA+3R/mZPVRqhfuZWW73DnaMojhM6Zc6yBIf2wk4MrK8lyvubjhXJbWabTBE4JZSi8cDAl+PM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eyal.emu.id.au; spf=pass smtp.mailfrom=eyal.emu.id.au; arc=none smtp.client-ip=203.10.76.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eyal.emu.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eyal.emu.id.au
Received: from [192.168.2.7] (unknown [101.115.72.242])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mailhost.tip.net.au (Postfix) with ESMTPSA id 4dBxDV0Gb4z8vBY;
	Thu, 20 Nov 2025 22:38:01 +1100 (AEDT)
Message-ID: <4f30c170-e5c8-4961-94a7-d903acdb9633@eyal.emu.id.au>
Date: Thu, 20 Nov 2025 22:38:01 +1100
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: eyal@eyal.emu.id.au
Subject: Re: ata timeout exceptions
To: Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>
Cc: list linux-ide <linux-ide@vger.kernel.org>
References: <acf2fa9f-f98d-4eb0-b18b-a04aa123201b@eyal.emu.id.au>
 <4f0fa70c-b259-4998-bf94-c6c6fd8c733c@eyal.emu.id.au>
 <aRyOFRCQ_nSWtmsh@ryzen>
 <f8eebba8-176b-44b8-877c-75de8b00db38@eyal.emu.id.au>
 <7cf8b035-c884-4691-a35b-ee8a2e149e03@kernel.org>
 <5f690ea7-5e10-4129-87be-ba4b618e65b8@eyal.emu.id.au>
 <3accb08b-73bd-4281-9cad-069f512c7f9c@kernel.org>
Content-Language: en-US
From: Eyal Lebedinsky <eyal@eyal.emu.id.au>
In-Reply-To: <3accb08b-73bd-4281-9cad-069f512c7f9c@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Thanks again Damien,

On 20/11/25 14:34, Damien Le Moal wrote:
> On 11/19/25 10:37 PM, Eyal Lebedinsky wrote:
>> Thanks Damien,
>>
>> On 19/11/25 16:41, Damien Le Moal wrote:
>>> On 11/19/25 08:05, Eyal Lebedinsky wrote:
>>>> I still suspect the disk itself it at fault (I have a replacement synced and
>>>> ready). >> 12:15:14+11:00 kernel: ata2.00: failed command: WRITE DMA EXT
>>>>>> 12:15:14+11:00 kernel: ata2.00: cmd 35/00:00:00:68:4e/00:20:77:00:00/e0
>>>>>> tag 28 dma 4194304 out res 40/00:00:00:4f:c2/00:00:00:00:00/40 Emask 0x4
>>>>>> (timeout) 12:15:14+11:00 kernel: ata2.00: status: { DRDY }
>>>>>> 12:15:14+11:00 kernel: ata2: hard resetting link 12:15:15+11:00 kernel:
>>>>>> ata2: SATA link up 6.0 Gbps (SStatus 133 SControl 300) 12:15:15+11:00
>>>>>> kernel: ata2.00: configured for UDMA/133 12:15:15+11:00 kernel: ata2: EH
>>>>>> complete
>>>>>
>>>>> It is a 4194304 byte write that is failing, i.e. 4 MiB write.
>>>>
>>>> Yes, this is the size of almost all commands. With NCQ enabled the sizes are
>>>> very variable and often less that 1 MiB.
>>>
>>> Yes, because there will be more requests queued in the block layer, which
>>> increases the chances of merging sequential requests. That's why the average
>>> command size goes up.
>>>
>>>>
>>>>> This sounds very much like a recent bug report we have received: https://
>>>>> bugzilla.kernel.org/show_bug.cgi?id=220693
>>>>>
>>>>> In fact, a lot of the failing commands in that bug report is also a read
>>>>> or write of size 4 MiB.
>>>>>
>>>>> I guess you could try reverting 459779d04ae8 ("block: Improve read ahead
>>>>> size for rotational devices") and see if that improves things for you
>>>>> (while keeping NCQ enabled).I read it. I never had I/O errors reported for
>>>>> this disk so it looks different to me.
>>>>
>>>> Regardless, I am not set up to build a kernel (I used to), and being my main
>>>> server I hesitate to fiddle with it. I will keep this disk active and
>>>> observe the situation.
>>>
>>> No, reverting this commit will not do anything to the max command size that a
>>> disk can see. But you could try this:
>>>
>>> echo 1280 > /sys/block/sdX/queue/max_sectors_kb
>>>
>>> to reduce the maximum command size that the disk will receive.

Done.

>> I will try this.
>>
>>> On the other hand, if all drives in your RAID6 array are the same and only this
>>> drive is misbehaving, then I would be tempted to say the same you are: that the
>>> disk is turning bad and replacing it is the best solution.
>>
>> "this drive" is NOT part of the RAID, it is just a scratch disk used when space is
>> needed or for some local backups. It is old and it will not be any drama if it
>> fails.
>> This is why I am comfortable trying more options before replacing it.
>>
>> My main interest is to understand what actually is happening inside the disk.
>> I assume that copying the data from the CRM part to the SMR part is going on.
> 
> Ah ! This is a drive-managed SMR drive ? I missed that point. Yeah, with these
> drives, the performance profile (throughpu & command latency) can be all over
> the place depending on the internal state of the drive. So all bets are off in
> terms of timeout... In your case, this seems extreme though, so there is likely
> a head going bad and lots of internal retries going on that make latency even
> worse than usual. Maybe have a look at SMART output to see if you lots of bad
> sectors remapped ?

Nothing bad in smart report.

Another positive: After setting a lower max_sectors_kb as suggested, the drive is
running smoothly. I also added --fsync to the rsync which probably also regulated
the pace a bit.

So far today there was no reset required, and also no pause at all.

Maybe after the disk was used for a long while, and as a large amount of data was
replaced regularly, the data is now distributed wildly.

Is there an equivalent to 'trim' that can be used to tell the drive what blocks
can be discarded (and reused)? If so, worth a try?

Regards,
	Eyal

-- 
Eyal at Home (eyal@eyal.emu.id.au)
