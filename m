Received: from pasta.tip.net.au (mx1.tip.net.au [203.10.76.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4A5227E1D5
	for <linux-ide@vger.kernel.org>; Tue, 18 Nov 2025 23:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.10.76.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763507171; cv=none; b=a/LhtAUrlIvUvUV6lpB85wAx9G+IV2R9bxcKZbW8be1IJygxu2rdh08/nRoPmI9TwAVN6dPKIkUy/qxknSFddyQwGGZwxse0Bj244OlQ8Jf2JqhWyV1GR7Gstb4pzvaz8nn2y/jV/Rc3EEIpiwEkBsaflWFzaWnTehrct4Z7dGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763507171; c=relaxed/simple;
	bh=MXHZis+2XQ1n5Tw/4nZM38uXIMKHB/rhe5jXqWbI8QI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hjKvu/Ci0e4ehJW+YC9ChQdwLYCRWcvHqAortqKA+f10jL+ma+h9soj50+bYJMcdlJ63Xj4vNRVkgn2GJMSt86Q5L2FoQ/3vkv7/2feMzz9ecpLuyhkmcH7re425dMLUXQB/AjrY8Z3dfSAF82hizxHDFBPDI20/kUKvvsVnQ9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eyal.emu.id.au; spf=pass smtp.mailfrom=eyal.emu.id.au; arc=none smtp.client-ip=203.10.76.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eyal.emu.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eyal.emu.id.au
Received: from [192.168.2.7] (unknown [101.115.72.242])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mailhost.tip.net.au (Postfix) with ESMTPSA id 4dB0b85HpKz8vKD;
	Wed, 19 Nov 2025 10:05:56 +1100 (AEDT)
Message-ID: <f8eebba8-176b-44b8-877c-75de8b00db38@eyal.emu.id.au>
Date: Wed, 19 Nov 2025 10:05:56 +1100
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: eyal@eyal.emu.id.au
Subject: Re: ata timeout exceptions
To: Niklas Cassel <cassel@kernel.org>
Cc: list linux-ide <linux-ide@vger.kernel.org>, dlemoal@kernel.org
References: <acf2fa9f-f98d-4eb0-b18b-a04aa123201b@eyal.emu.id.au>
 <4f0fa70c-b259-4998-bf94-c6c6fd8c733c@eyal.emu.id.au>
 <aRyOFRCQ_nSWtmsh@ryzen>
Content-Language: en-US
From: Eyal Lebedinsky <eyal@eyal.emu.id.au>
In-Reply-To: <aRyOFRCQ_nSWtmsh@ryzen>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Thanks Niklas,

On 19/11/25 02:17, Niklas Cassel wrote:
> On Fri, Nov 14, 2025 at 03:32:20PM +1100, Eyal Lebedinsky wrote:
>>> For the last few weeks it started to log timeout errors (not always) like this:
>>
>> For the last two weeks I was monitoring the activity on the disk and here is what I did:
>>
>> - added to boot command line:	libata.force=2.00:noncq
>> 	now smartmon sees no more Command_Timeout errors since
> 
> To be honest, I don't think you should need to disable NCQ.

Disabling NCQ caused the disk to NOT count a smart Command_Timeout, it did not stop the actual pauses/resets.
>> This disk was used for a few years without such errors. The first report is recent (from 25/Oct this year).
> 
> Which kernel version are you running?

This is happening for a while now, using:
	6.17.6-200.fc42.x86_64
	6.17.7-200.fc42.x86_64
Before the start it was running without a problem:
	6.16.3 - 6.16.12	since Aug 23
	6.17.4-200.fc42.x86_64	since Oct 24 20:48:40	
First timeout/reset a day later	at    Oct 25 20:09:27

I did set the timeout as high at 240s and found that if a pause is longer than 30s then it will always continue and timeout.
I can set it higher if there is a possibility that it WILL complete the write. Is it worth it? How long?

The system runs off nvme and includes a 7 disk raid6.

Maybe relevant:
	for a while (recently) following a reset this disk would downshift (6.0->3.0->1.5Gbps).
	For a period it would actually boot up at 3.0Gbps.
	It is back to 6.0Gbps for about 2 weeks (and many resets).

I still suspect the disk itself it at fault (I have a replacement synced and ready).
	>> 12:15:14+11:00 kernel: ata2.00: failed command: WRITE DMA EXT
>> 12:15:14+11:00 kernel: ata2.00: cmd 35/00:00:00:68:4e/00:20:77:00:00/e0 tag 28 dma 4194304 out
>>                                  res 40/00:00:00:4f:c2/00:00:00:00:00/40 Emask 0x4 (timeout)
>> 12:15:14+11:00 kernel: ata2.00: status: { DRDY }
>> 12:15:14+11:00 kernel: ata2: hard resetting link
>> 12:15:15+11:00 kernel: ata2: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
>> 12:15:15+11:00 kernel: ata2.00: configured for UDMA/133
>> 12:15:15+11:00 kernel: ata2: EH complete
> 
> It is a 4194304 byte write that is failing, i.e. 4 MiB write.

Yes, this is the size of almost all commands. With NCQ enabled the sizes are very variable and often less that 1 MiB.

> This sounds very much like a recent bug report we have received:
> https://bugzilla.kernel.org/show_bug.cgi?id=220693
> 
> In fact, a lot of the failing commands in that bug report is also a read
> or write of size 4 MiB.
> 
> I guess you could try reverting 459779d04ae8 ("block: Improve read ahead
> size for rotational devices") and see if that improves things for you
> (while keeping NCQ enabled).I read it. I never had I/O errors reported for this disk so it looks different to me.

Regardless, I am not set up to build a kernel (I used to), and being my main server I hesitate to fiddle with it.
I will keep this disk active and observe the situation.

Regards,
	Eyal

> Kind regards,
> Niklas
-- 
Eyal at Home (eyal@eyal.emu.id.au)
