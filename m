Received: from pasta.tip.net.au (mx1.tip.net.au [203.10.76.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA4CC2FE582
	for <linux-ide@vger.kernel.org>; Mon, 22 Dec 2025 02:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.10.76.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766369432; cv=none; b=TNWdo7KED28i75eLrdjFJFswrhXKY4JkqQPg1wWcNwX7+L/uT3HHnosnQzfU+FhI8twxrOKfqeS0H+4eecqtVWmyC1Y060Z9tCEH7tRb+6AImi0hjo45Ok5tRcHcXAcdk7OwajlbtTwx8140WJqgaqHm7xATUcTZHk0HxQTxzH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766369432; c=relaxed/simple;
	bh=vDEVPDliXgTLjoDTbT/eR65wnkArv9tAMcDI6KFj+mw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ex1Ax5msdxv0qMBIK5lEQyGRAQMGq5+BxBDfx2GGz4XBIvpij8hYXEY2zNpK9IEGg0kwuzTiqmOsRAFu4prt7R4MS9r9E6OkTcG2Qb6lI64RsMeXpYkLIskxxqSz7lnMd8W9NCeI7HWWiZ0/BO/sHEY0R4e0Lhqfs8eRsb1NpOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eyal.emu.id.au; spf=pass smtp.mailfrom=eyal.emu.id.au; arc=none smtp.client-ip=203.10.76.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eyal.emu.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eyal.emu.id.au
Received: from [192.168.2.7] (unknown [101.115.78.36])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mailhost.tip.net.au (Postfix) with ESMTPSA id 4dZM6q1NfMz8tfw;
	Mon, 22 Dec 2025 13:10:27 +1100 (AEDT)
Message-ID: <0239be44-cfc7-4c99-b245-636e376df037@eyal.emu.id.au>
Date: Mon, 22 Dec 2025 13:10:19 +1100
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
Cc: Niklas Cassel <cassel@kernel.org>, Damien Le Moal <dlemoal@kernel.org>
References: <acf2fa9f-f98d-4eb0-b18b-a04aa123201b@eyal.emu.id.au>
 <080383fe-63cf-4198-966a-b32d798bea06@eyal.emu.id.au>
 <13bf2e98-1774-4444-bc56-38a39d539d8e@kernel.org>
 <79fcb2f0-d09b-4649-bda0-55f309b20985@eyal.emu.id.au>
 <746FB9BB-5945-415F-915F-3F05D8A6B063@kernel.org>
 <582e748c-3e29-4f21-af7c-c799fb457e59@eyal.emu.id.au>
 <3d476e67-31a9-4e7d-b8cc-5bb298a6d62f@kernel.org>
 <9933af72-944e-4bb3-bab9-fdbd4fb0fad0@eyal.emu.id.au>
 <3e81e6ae-1ef0-454c-935f-eee2bba91176@eyal.emu.id.au>
 <cda2a663-10a5-4212-8725-8c780a2c291d@kernel.org>
Content-Language: en-US
From: Eyal Lebedinsky <eyal@eyal.emu.id.au>
In-Reply-To: <cda2a663-10a5-4212-8725-8c780a2c291d@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 22/12/25 10:14, Damien Le Moal wrote:
> On 12/22/25 07:43, Eyal Lebedinsky wrote:
>> On 21/12/25 23:12, Eyal Lebedinsky wrote:
>>> On 21/12/25 19:34, Damien Le Moal wrote:
>>>> On 12/20/25 13:03, Eyal Lebedinsky wrote:
>>>>> On 17/12/25 23:02, Niklas Cassel wrote:
>>>>>> On 17 December 2025 20:56:07 GMT+09:00, Eyal Lebedinsky <eyal@eyal.emu.id.au> wrote:
>>>>>
>>>>> [trimmed]
>>>>>
>>>>>>> Do you want me to try different max_sectors_kb values to see where it breaks?
>>>>>>>
>>>>>>
>>>>>> You can also try this:
>>>>>>
>>>>>> https://github.com/floatious/max-sectors-quirk
>>>>>>
>>>>>> It tries these max_sector_kb values:
>>>>>> declare -a sizes=(128 1024 2048 3072 4095 4096)
>>>>>>
>>>>>> You can simply modify the script if you want to try more intermediate sizes.
>>>>>
>>>>> After testing the script on a sacrificial disk, I got brave and ran it on the offending disk.
>>>>> See comments after the test report.
>>>>
>>>>>  From your test results, it seems that the drive actually correctly handles very
>>>> large write commands, but because it is a drive-managed SMR disk, such commands
>>>> can take a very long time to process (due to the drive needing internal garbage
>>>> collection first), which triggers a timeout and a reset as the ata subsystem
>>>> assumes that the drive has stopped responding.
>>>>
>>>> Limiting write commands to smaller sizes seems to mostly avoid this issue, even
>>>> though I do not think that gives any guarantees that the same issue will not
>>>> happen for small writes too.
>>>>
>>>> So my suggestion is that you run with something like "libata.force=[<port
>>>> ID>:]max_sec=1024" for that drive. We can also add a permanent quirk for it too,
>>>> but that would be a really more of a big hammer solution.
>>>
>>> I mostly agree. However, extending the timeout did not help in the past.
>>> I found that even setting it to 240 was not enough.
>>> If there is no response in 30s then none is coming. I never saw a pause longer than 30s that came back later.
>>> The pause is either up to 30s or unlimited (until timeout is reached and a reset).
>>>
>>> ATM I have the setting of timeout=120 in rc.local.
>>>
>>> I also have in my boot cmd:
>>>       libata.force=2.00:noncq
>>> This is because with ncq, if a pause reaches a timeout then the disk records a Command_Timeout.
>>> In the smart log it is now up to 34360262682 (8,8,26) but stable since ncq was disabled (at 1/Nov)
>>> despite many timeout resets since.
>>>
>>> I suspect a fw bug or a design fault(*), but just for fun I will run with max_sectors_kb=4096 and timeout=1024.
>>
>> Have just ran the test, failed quickly, see below.
>> It shows a 17 minutes pause followed by a reset and a resumption and completion of the test.
>>
>> The important question is: do we need a quirk?
>> 	Is this an inherent problem with this model? If so then a quirk is justified.
>> 	Is this an inherent problem after this model had many writes? Again, a quirk is justified.
>> 	Is this a fault with my specific disk? No quirk, I will keep my safe settings.
>>
>> Let me know if further testing, or more information, is required.
>>
>> Regards,
>> 	Eyal

[trimmed]

> Can you try with NCQ enabled and a max sectors of 2048 (1 MiB
> commands max) ? I suspect this should work. Otherwise, if NCQ also causes
> issues, we can quirk both NCQ and max sectors for this drive.

To be clear, set "max_sectors_kb=1024"? This always worked, no pause (or timeout).
	"this should work" meaning "no trouble" or "will reproduce the problem"?

With ncq enabled, I had the same numbers of timeouts, with the difference being that the disk
logged many errors (one for each tag) and also registered a Command_Timeout which it did not otherwise.

Question: will setting
	$ sudo sh -c 'echo 32 >/sys/block/sda/device/queue_depth'
be the same as booting without
	libata.force=2.00:noncq
or do I actually need to reboot?

Thanks
	Eyal

-- 
Eyal at Home (eyal@eyal.emu.id.au)
