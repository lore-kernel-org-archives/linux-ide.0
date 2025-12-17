Received: from pasta.tip.net.au (mx1.tip.net.au [203.10.76.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3651123EAA4
	for <linux-ide@vger.kernel.org>; Wed, 17 Dec 2025 11:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.10.76.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765972574; cv=none; b=TOU70UtGRSHKxJnF66hcciQMMQQ+IUChKBMatKH9rcPVK4JiY9l8lnzzwD+s5J27MQU4KWp90dSumAw12OKY9o2c/oPTTRAO2Gmta+BYkhzYuiZu8mLPP4F6DtVgMYJDY2/e6+tPu8yHlGKoeC91ysW6uVTftXvYGkYIsf22j18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765972574; c=relaxed/simple;
	bh=TN0Yh1Mjj/EFtEpLjcYTeuD4B8Z6yk4IitYXWVRSCr8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=BfVwJS4XT/7/wPdiLRXLnSqH1OyApS/nn6sww3M/+U17VK3HGwaTnuH1RhH2GVRvIWl01zfofLVFAlT9O9+urgawRTSisgKjuoT4mNtS1q9qYM8h2eTWTrowoRYJdFjeyArly5V93saESEUs8XcV8m4t41ui1CMKvvfpwD6Y3yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eyal.emu.id.au; spf=pass smtp.mailfrom=eyal.emu.id.au; arc=none smtp.client-ip=203.10.76.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eyal.emu.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eyal.emu.id.au
Received: from [192.168.2.7] (unknown [101.115.78.36])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mailhost.tip.net.au (Postfix) with ESMTPSA id 4dWXLw2swDz8vCt;
	Wed, 17 Dec 2025 22:56:08 +1100 (AEDT)
Message-ID: <79fcb2f0-d09b-4649-bda0-55f309b20985@eyal.emu.id.au>
Date: Wed, 17 Dec 2025 22:56:07 +1100
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: eyal@eyal.emu.id.au
Subject: Re: ata timeout exceptions
To: list linux-ide <linux-ide@vger.kernel.org>
References: <acf2fa9f-f98d-4eb0-b18b-a04aa123201b@eyal.emu.id.au>
 <080383fe-63cf-4198-966a-b32d798bea06@eyal.emu.id.au>
 <13bf2e98-1774-4444-bc56-38a39d539d8e@kernel.org>
Content-Language: en-US
From: Eyal Lebedinsky <eyal@eyal.emu.id.au>
Cc: Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>
In-Reply-To: <13bf2e98-1774-4444-bc56-38a39d539d8e@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 17/12/25 12:35, Damien Le Moal wrote:
> On 12/17/25 08:39, Eyal Lebedinsky wrote:
>> Resolved.
>>
>> Limiting disk access bandwidth (as suggested by Damien Le Moal <dlemoal@kernel.org>)
>> 	# echo 1280 > /sys/block/sdX/queue/max_sectors_kb
>> did the trick. No pauses/resets anymore for over a month.
> 
> We now have patches queued up to limit max_sectors_kb for devices and
> controllers behaving badly. If you send us your device information (hdparm -I)
> and controller info (PCI ID of your AHCI adapter), we can add a permanent quirk.
> 
> Though we would need to determine if is is the device or the adapter that is
> mis-behaving, and also ideally, the command size at which things break.
> We had another case with a device breaking above 4MiB commands. A quirk setting
> max hw sectors to 8191 sectors solved the issue.

The machine is: Gigabyte Z390 UD, BIOS AMI F8

The disk is, according to smartctl:
	Model Family:     Seagate Archive HDD (SMR)
	Device Model:     ST8000AS0002-1NA17Z
	Firmware Version: AR13
	User Capacity:    8,001,563,222,016 bytes [8.00 TB]
	Sector Sizes:     512 bytes logical, 4096 bytes physical
There was no hw change during this period.

Here is what I think:

This disk did not exhibit the problem for the last 1.5 years when it was in constant use.
	[before that, since Jan/2016, it was used every few months as a backup disk]
Then, last month it started to show the problem.

Being an early SMR disk, is it possible that it reached a state where all block updates require a track read/write
(no more unused tracks) and at high bandwidth it gets into trouble. It did not matter how high I set the timeout
(I tested up to 240) it always timed out if any pause was encountered.

Being a rather old disk (a 2014 model?)
	Maybe a fw bug?
	Maybe an SMR design misfeature?

Do you want me to try different max_sectors_kb values to see where it breaks?

Regards,
	Eyal

>>
>> Setting
>> 	# echo 180 >/sys/block/sda/device/timeout
>> did not help, only made the pauses longer before the reset.
>>
>> Thanks everyone.
>> 	Eyal
>>
>> On 3/11/25 15:13, Eyal Lebedinsky wrote:
>>> I have a sata disk that is probably on its last legs.
>>> It is a plain disk (no RAID or such). If it matters, it is an old 8TB Seagate SMA disk.
>>> It sees very little activity.
>>>
>>> Every two hours a small rsync copies a directory into this disk. A few 100s of files are copied each time, a few 10s of GB in total.
>>>
>>> For the last few weeks it started to log timeout errors (not always) like this:
>>>
>>>     kernel: ata2.00: exception Emask 0x0 SAct 0x2020 SErr 0x0 action 0x6 frozen
>>>     kernel: ata2.00: failed command: WRITE FPDMA QUEUED
>>>     kernel: ata2.00: cmd 61/80:28:a0:10:df/00:00:d1:01:00/40 tag 5 ncq dma 65536 out
>>>                      res 40/00:00:00:4f:c2/00:00:00:00:00/40 Emask 0x4 (timeout)
>>>     kernel: ata2.00: status: { DRDY }
>>>     kernel: ata2.00: failed command: WRITE FPDMA QUEUED
>>>     kernel: ata2.00: cmd 61/00:68:18:15:30/20:00:20:01:00/40 tag 13 ncq dma 4194304 out
>>>                      res 40/00:01:00:4f:c2/00:00:00:00:00/00 Emask 0x4 (timeout)
>>>     kernel: ata2.00: status: { DRDY }
>>>     kernel: ata2: hard resetting link
>>>     kernel: ata2: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
>>>     kernel: ata2.00: configured for UDMA/133
>>>     kernel: ata2: EH complete
>>
>> [trimmed]
>>
> 
> 


-- 
Eyal at Home (eyal@eyal.emu.id.au)
