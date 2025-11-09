Received: from pasta.tip.net.au (mx1.tip.net.au [203.10.76.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB0641D6DA9
	for <linux-ide@vger.kernel.org>; Sun,  9 Nov 2025 22:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.10.76.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762728107; cv=none; b=JZf/FoXm7gIeOC6Bvh5hZQrazPqKYvcIM7h8YxbVPQgZrDyXLu5bh3SYf3zs0V1vQQ5qWa9UAQR+aMqVdR9GJmVlrGA6kGAXcKd27r00KilHD7QvT1fg9HszirIyofUWfm4x2HMaHEv4bsRPZ9C6gIvVkTqkNXtc1dokgoOKDsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762728107; c=relaxed/simple;
	bh=aM3ZeWOaVGGH46lwT+i0bxJL3icIbW7/DCLAtaW8GmY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=VMWYOUVtqb+c+sEhKWXZeIB3IoooWeLUZC1zwixl9DSanrWXzdTiJwkSe7UB7zdWEXUkhgk/iusdhWI4WQOYOO4YXF+FPTUZDt+6b36ZBKo2apOdiYdwXlKmmPI26uRDtMenmCQto3raA8B1YsykaextXKkRQ/h06QlsWo4m8us=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eyal.emu.id.au; spf=pass smtp.mailfrom=eyal.emu.id.au; arc=none smtp.client-ip=203.10.76.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eyal.emu.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eyal.emu.id.au
Received: from [192.168.2.7] (unknown [101.115.72.242])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mailhost.tip.net.au (Postfix) with ESMTPSA id 4d4STC1xh1z8txJ;
	Mon, 10 Nov 2025 09:41:35 +1100 (AEDT)
Message-ID: <1d86c6d3-a944-422a-9b96-7a768d7e89d8@eyal.emu.id.au>
Date: Mon, 10 Nov 2025 09:41:29 +1100
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
 <aRD8OoDwE2fyP_JM@ryzen>
Content-Language: en-US
From: Eyal Lebedinsky <eyal@eyal.emu.id.au>
Cc: Niklas Cassel <cassel@kernel.org>
In-Reply-To: <aRD8OoDwE2fyP_JM@ryzen>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello Niklas,

On 10/11/25 07:40, Niklas Cassel wrote:
> Hello Eyal,
> 
> On Mon, Nov 03, 2025 at 03:13:34PM +1100, Eyal Lebedinsky wrote:
>>
>> I want to understand what is going on:
>>
>> 1) Why do I not see an I/O error and the writes to the disk (rsync) seem to complete?
>>     Which layer absorbs the errors, hiding them from the application?
> 
> SCSI layer.

I now understand this, the error does not originate from the disk itself which may be unaware of it.

> For a timed out command, libata will set DID_TIME_OUT:
> https://github.com/torvalds/linux/blob/v6.18-rc4/drivers/ata/libata-eh.c#L652-L654
> 
> For most commands SCSI layer, SCSI will set cmd->allowed to sdkp->max_retries:
> https://github.com/torvalds/linux/blob/v6.18-rc4/drivers/scsi/sd.c#L1411
> 
> which by default is 5:
> https://github.com/torvalds/linux/blob/v6.18-rc4/drivers/scsi/sd.c#L3962
> 
> Thus, most commands will be retried up to 5 times:
> https://github.com/torvalds/linux/blob/v6.18-rc4/drivers/scsi/scsi_error.c#L2225
> 
> Thus, the user will only see the I/O as an error if the command failed
> 6 times.
> 
> (Note that if the command returns sense data instead of timeout, depending on
> the sense data returned, we might report an I/O error to the user immediately.

Initially, after a series of failures ncq was internally disabled
	ata2.00: NCQ disabled due to excessive errors
after which I forced it off, in the boot command
	ata2.00: FORCE: modified (noncq)
and no Command_Timeout was counted since.

after which I set command
>>
>> 2) Why do I get only one command_timeout counted (originally, with ncq active) and none when ncq is disabled?
> 
> You are right that even if it is only a single command that times out,
> the whole queue will be drained and retried.
> (Because we always do a hard reset after a command timeout.)
> 
> command_timeout is most likely increased only by one because it was
> only a single command that timed out. (The other commands might have
> been queued but were never executed/finished.)
> 
> I have no idea why a command timeout, when NCQ has been disabled,
> does not increase the command_timeout counter. My expectation would
> have been for the counter to still be increased by one.
This is an older SMA disk, and I will not be surprised if the disk was not even executing the command yet
but was doing some housekeeping when it was reset. After raising the timeout 30s to 180s I still had one
case where a reset was invoked. I see (iostat was running) that there was no activity on the disk that whole time.

Or maybe it is just a fw bug in the disk (ST8000AS0002-1NA17Z from 2016)?
Is it possible that a reset when a command is pending is not counted in the smart log?

Interestingly, after repeated consecutive resets the link speed was downshifted 6.0->3.0->1.5g.
Now it boots at 3.0g when it used to always boot at 6.0g.
There must be a real issue there which is why the disk will be replaced anyway.

Regardless, I now have a better understanding of the i/o path.

Regards,
	Eyal

> Kind regards,
> Niklas
-- 
Eyal at Home (eyal@eyal.emu.id.au)
