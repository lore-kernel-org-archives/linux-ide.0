Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 927B92F5478
	for <linux-ide@vger.kernel.org>; Thu, 20 Nov 2025 03:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763609907; cv=none; b=KWMqH1VAILQq3h+RtULfvmjVYR+j9TfqwmoTc4FlIyGhpv4FwCxeIeJK58O7ZIPnRt6IdNlG4Mm69y7NjyIjJmCQSATxcs6Q//nBBrtqwwJqHcuDP/49gFmTCO8dEwhp5q4+s6wfA9I88jwWCUY2cqEeY2uiZHpiY4v/9Yzz7+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763609907; c=relaxed/simple;
	bh=CcTmtfT/7dVstMajdZlks8GvKHFwaxakxS8el/gYjj8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=No44tG6yZSBguAtuz+tkOjyzbOanYaBVegPEmMEC7dqZoa1MlhDffEzA+GOdeSYj64O/9HFQb1C3V1kfIZz6lmKnZGCb0uUTWpQ45ppUN9F7zuXQ4WuFJsQmbmdSRqO278I0b/72PbMeI/5niJH6r/mcHy/msFstUUSZNg+1AzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CqPhCZo5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CqPhCZo5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C877C4CEF5;
	Thu, 20 Nov 2025 03:38:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763609907;
	bh=CcTmtfT/7dVstMajdZlks8GvKHFwaxakxS8el/gYjj8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=CqPhCZo5s0L6lFBYTw0qEP+AglD6VA6y9IvwXQKAO8V2ltDEqNSZiwiAx1p59+vPb
	 U4bfbXFUf0YVUvg/JyM3BzDbM/mAgP9Vn7aFPLMEwK360cSinAiHJw1ED5YBogg4t8
	 qTxVKm1BWXfENdR8ef66SEwlPVVL5oR4BSxfWlZ4QZyg86tQS1hm2htdj8zts6qSwE
	 AJFwDt1QM0U0WvljdUEv5sqV9VVRWJrGJEfSDktRSL6MOKNb1EXi/6L6cvVioXw46d
	 j+2l7Cj5ZsgjLW0rMsMvvFtGUZIzWzNsY4qPDaM+A6SeAZCri5FNAvfbggpsTGGAjD
	 OLCysRs1hyRJA==
Message-ID: <3accb08b-73bd-4281-9cad-069f512c7f9c@kernel.org>
Date: Thu, 20 Nov 2025 12:34:20 +0900
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: ata timeout exceptions
To: eyal@eyal.emu.id.au, Niklas Cassel <cassel@kernel.org>
Cc: list linux-ide <linux-ide@vger.kernel.org>
References: <acf2fa9f-f98d-4eb0-b18b-a04aa123201b@eyal.emu.id.au>
 <4f0fa70c-b259-4998-bf94-c6c6fd8c733c@eyal.emu.id.au>
 <aRyOFRCQ_nSWtmsh@ryzen>
 <f8eebba8-176b-44b8-877c-75de8b00db38@eyal.emu.id.au>
 <7cf8b035-c884-4691-a35b-ee8a2e149e03@kernel.org>
 <5f690ea7-5e10-4129-87be-ba4b618e65b8@eyal.emu.id.au>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <5f690ea7-5e10-4129-87be-ba4b618e65b8@eyal.emu.id.au>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/19/25 10:37 PM, Eyal Lebedinsky wrote:
> Thanks Damien,
> 
> On 19/11/25 16:41, Damien Le Moal wrote:
>> On 11/19/25 08:05, Eyal Lebedinsky wrote:
>>> I still suspect the disk itself it at fault (I have a replacement synced and
>>> ready). >> 12:15:14+11:00 kernel: ata2.00: failed command: WRITE DMA EXT
>>>>> 12:15:14+11:00 kernel: ata2.00: cmd 35/00:00:00:68:4e/00:20:77:00:00/e0
>>>>> tag 28 dma 4194304 out res 40/00:00:00:4f:c2/00:00:00:00:00/40 Emask 0x4
>>>>> (timeout) 12:15:14+11:00 kernel: ata2.00: status: { DRDY }
>>>>> 12:15:14+11:00 kernel: ata2: hard resetting link 12:15:15+11:00 kernel:
>>>>> ata2: SATA link up 6.0 Gbps (SStatus 133 SControl 300) 12:15:15+11:00
>>>>> kernel: ata2.00: configured for UDMA/133 12:15:15+11:00 kernel: ata2: EH
>>>>> complete
>>>>
>>>> It is a 4194304 byte write that is failing, i.e. 4 MiB write.
>>>
>>> Yes, this is the size of almost all commands. With NCQ enabled the sizes are
>>> very variable and often less that 1 MiB.
>>
>> Yes, because there will be more requests queued in the block layer, which
>> increases the chances of merging sequential requests. That's why the average
>> command size goes up.
>>
>>>
>>>> This sounds very much like a recent bug report we have received: https://
>>>> bugzilla.kernel.org/show_bug.cgi?id=220693
>>>>
>>>> In fact, a lot of the failing commands in that bug report is also a read
>>>> or write of size 4 MiB.
>>>>
>>>> I guess you could try reverting 459779d04ae8 ("block: Improve read ahead
>>>> size for rotational devices") and see if that improves things for you
>>>> (while keeping NCQ enabled).I read it. I never had I/O errors reported for
>>>> this disk so it looks different to me.
>>>
>>> Regardless, I am not set up to build a kernel (I used to), and being my main
>>> server I hesitate to fiddle with it. I will keep this disk active and
>>> observe the situation.
>>
>> No, reverting this commit will not do anything to the max command size that a
>> disk can see. But you could try this:
>>
>> echo 1280 > /sys/block/sdX/queue/max_sectors_kb
>>
>> to reduce the maximum command size that the disk will receive.
> 
> I will try this.
> 
>> On the other hand, if all drives in your RAID6 array are the same and only this
>> drive is misbehaving, then I would be tempted to say the same you are: that the
>> disk is turning bad and replacing it is the best solution.
> 
> "this drive" is NOT part of the RAID, it is just a scratch disk used when space is
> needed or for some local backups. It is old and it will not be any drama if it
> fails.
> This is why I am comfortable trying more options before replacing it.
> 
> My main interest is to understand what actually is happening inside the disk.
> I assume that copying the data from the CRM part to the SMR part is going on.

Ah ! This is a drive-managed SMR drive ? I missed that point. Yeah, with these
drives, the performance profile (throughpu & command latency) can be all over
the place depending on the internal state of the drive. So all bets are off in
terms of timeout... In your case, this seems extreme though, so there is likely
a head going bad and lots of internal retries going on that make latency even
worse than usual. Maybe have a look at SMART output to see if you lots of bad
sectors remapped ?


-- 
Damien Le Moal
Western Digital Research
