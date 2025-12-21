Received: from pasta.tip.net.au (mx1.tip.net.au [203.10.76.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA3F51A5B8A
	for <linux-ide@vger.kernel.org>; Sun, 21 Dec 2025 12:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.10.76.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766319143; cv=none; b=pQCYY6CIUJWmBvXUuzBDIR2M2TCVBiz2Xy1hD0YMxsy7S8aKCZoaW5Lci0+zpn8ysrd3XODbSDBauQMir9QbcAu2ewv+ENe8qcva2LccPHAlq6FhVoaiaks07wsEqxdsLxnVQrQjPFBB88ECOCahb/y4x7YGZ44WR8F16eXDUG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766319143; c=relaxed/simple;
	bh=/ZUl9TCIDXFs03vKE2g9knQELFDi+1jlIEVV8wTBD7I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k4eiFJTQIZLEdwpHVMDYESNx3obhlUUQmjnMqnnwIHU1RL/ZwbEnU6H8p2iD30yII164lhpzMw5kxQ49fCDRyVAp0w3XWvN8FsXS2F146AUzLg/O7GeoiC1gFYwD4FlpgWFfCtc5qbbq6MhKLl3y+9uSUPcTTNLjMh38POvGAK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eyal.emu.id.au; spf=pass smtp.mailfrom=eyal.emu.id.au; arc=none smtp.client-ip=203.10.76.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eyal.emu.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eyal.emu.id.au
Received: from [192.168.2.7] (unknown [101.115.78.36])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mailhost.tip.net.au (Postfix) with ESMTPSA id 4dZ0Wb25vgz8v29;
	Sun, 21 Dec 2025 23:12:11 +1100 (AEDT)
Message-ID: <9933af72-944e-4bb3-bab9-fdbd4fb0fad0@eyal.emu.id.au>
Date: Sun, 21 Dec 2025 23:12:04 +1100
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
Content-Language: en-US
From: Eyal Lebedinsky <eyal@eyal.emu.id.au>
In-Reply-To: <3d476e67-31a9-4e7d-b8cc-5bb298a6d62f@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 21/12/25 19:34, Damien Le Moal wrote:
> On 12/20/25 13:03, Eyal Lebedinsky wrote:
>> On 17/12/25 23:02, Niklas Cassel wrote:
>>> On 17 December 2025 20:56:07 GMT+09:00, Eyal Lebedinsky <eyal@eyal.emu.id.au> wrote:
>>
>> [trimmed]
>>
>>>> Do you want me to try different max_sectors_kb values to see where it breaks?
>>>>
>>>
>>> You can also try this:
>>>
>>> https://github.com/floatious/max-sectors-quirk
>>>
>>> It tries these max_sector_kb values:
>>> declare -a sizes=(128 1024 2048 3072 4095 4096)
>>>
>>> You can simply modify the script if you want to try more intermediate sizes.
>>
>> After testing the script on a sacrificial disk, I got brave and ran it on the offending disk.
>> See comments after the test report.
> 
>>From your test results, it seems that the drive actually correctly handles very
> large write commands, but because it is a drive-managed SMR disk, such commands
> can take a very long time to process (due to the drive needing internal garbage
> collection first), which triggers a timeout and a reset as the ata subsystem
> assumes that the drive has stopped responding.
> 
> Limiting write commands to smaller sizes seems to mostly avoid this issue, even
> though I do not think that gives any guarantees that the same issue will not
> happen for small writes too.
> 
> So my suggestion is that you run with something like "libata.force=[<port
> ID>:]max_sec=1024" for that drive. We can also add a permanent quirk for it too,
> but that would be a really more of a big hammer solution.

I mostly agree. However, extending the timeout did not help in the past.
I found that even setting it to 240 was not enough.
If there is no response in 30s then none is coming. I never saw a pause longer than 30s that came back later.
The pause is either up to 30s or unlimited (until timeout is reached and a reset).

ATM I have the setting of timeout=120 in rc.local.

I also have in my boot cmd:
	libata.force=2.00:noncq
This is because with ncq, if a pause reaches a timeout then the disk records a Command_Timeout.
In the smart log it is now up to 34360262682 (8,8,26) but stable since ncq was disabled (at 1/Nov)
despite many timeout resets since.

I suspect a fw bug or a design fault(*), but just for fun I will run with max_sectors_kb=4096 and timeout=1024.

BTW, for the last few days I am running with max_sectors_kb=3584 and saw no pauses at all.
with 4096 and 4095 I did get a long pause/reset.

Regards,
	Eyal

(*) smart shows 180TB written so far in 1.6y on. I see a workload limit of 180TB/y listed but
I also saw an older spec that said 55TB/y. I do not know if I have a v1, v2 or v3 of this model.

-- 
Eyal at Home (eyal@eyal.emu.id.au)
