Received: from pasta.tip.net.au (mx1.tip.net.au [203.10.76.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 808AEA945
	for <linux-ide@vger.kernel.org>; Tue, 13 Jan 2026 01:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.10.76.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768268065; cv=none; b=nyUD27iGKvaa+fhKBFmVXW2zPzA8FeCikbSs9qLNJUgaiMWlKT6G8vcJmT5311ra1OiUhhCEXSsioIWKxPlCFdzk5O7zfFT26+u5cGynvl16H1MLLfSlJbgT34HIECwq8J7cAK55Qulf4uePPWricuBsi6AbsIPRorzXxVY0gEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768268065; c=relaxed/simple;
	bh=MCYTfvJQSwgxn7vNzUKXGOO6I6Ru/uziJlHi0xaWI0k=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=gzYwVnxvfAnQEYeti38+sn1TylUONMvx4+1XBXB9dCACFJ+PWaX3huQu+FuJFc8WHk1RRgFpbpKQWVQ3Ni2W4H3z72x+fvgWeAcXo6iA70dGSg4vchW0PgFyOQKM7cR+bIIPG0ziuvTC8kcM4776sv1CwdooO1v86ta5e4pNPqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eyal.emu.id.au; spf=pass smtp.mailfrom=eyal.emu.id.au; arc=none smtp.client-ip=203.10.76.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eyal.emu.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eyal.emu.id.au
Received: from [192.168.2.7] (unknown [101.115.26.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mailhost.tip.net.au (Postfix) with ESMTPSA id 4dqsGt0z30z8vFT;
	Tue, 13 Jan 2026 12:34:14 +1100 (AEDT)
Message-ID: <fbd27438-3f2d-4777-8e7d-f9df2bc83b80@eyal.emu.id.au>
Date: Tue, 13 Jan 2026 12:34:13 +1100
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Eyal Lebedinsky <eyal@eyal.emu.id.au>
Subject: Re: Why do Pending sectors disappear without writing to them?
Reply-To: eyal@eyal.emu.id.au
To: list linux-ide <linux-ide@vger.kernel.org>
Cc: Damien Le Moal <dlemoal@kernel.org>
References: <a41dafec-2ab8-4e6f-83f6-628104ee9b7b@eyal.emu.id.au>
 <211e1d4e-7ecd-4f83-b437-a4a09ebcf035@kernel.org>
Content-Language: en-US
In-Reply-To: <211e1d4e-7ecd-4f83-b437-a4a09ebcf035@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 13/1/26 01:05, Damien Le Moal wrote:
> On 1/10/26 01:35, Eyal Lebedinsky wrote:
>> This happens with some regularity. This disk (/dev/sdf1) is part of a raid6. It seems to be unhealthy (another story).
>> What I saw, a few times recently, is a smart report like
>> 	197 Current_Pending_Sector  -O--C-   100   100   000    -    8
>> 	198 Offline_Uncorrectable   ----C-   100   100   000    -    8
>> and at the end of the smart report
>> 	Pending Defects log (GP Log 0x0c)
>> 	Index                LBA    Hours
>> 	    0        22791960168    54593
>> 	    1        22791960169    54593
>> 	    2        22791960170    54593
>> 	    3        22791960171    54593
>> 	    4        22791960172    54593
>> 	    5        22791960173    54593
>> 	    6        22791960174    54593
>> 	    7        22791960175    54593
>> This stays for some time. For example this morning it started just after midnight
>> until I checked the logs this morning.
>>
>> I reacted by running
>> 	$ sudo raid6check /dev/md127 $(((22791960168-2048-262144)/1024-1)) 2
>> BTW, I convert sector number to fs block:
>> 	2048   (sdf1 start from fdisk)
>> 	262144 'Data Offset : 262144 sectors' from 'mdadm --examine'
>> 	1024   'Chunk Size : 512K' [1024s]    from 'mdadm --examine'
>> I expected an issue to be reported, but none were.
>> However ... the above 197/198 smart attributes went to zero, and the 'Pending Defects log' was cleared.
>>
>> My question is: raid6check is running in read-only mode, yet the disk cleared the pending reports. Why?
>> I thought that you need to write to it for that.
> 
> Most likely, the drive was slow to remap the failed sectors, so they showed up
> in the smart report. Your raid6check may have rewritten these and the drive
> these time remapped the sectors and the error went away. Probably, your remapped
> sector count increased. Not sure if you have the old values.

Here is a recent example of the situation:

... gone to bed
Jan 10 00:44:24 smartd[1254]: Device: /dev/sdf [SAT], 8 Currently unreadable (pending) sectors
	Current_Pending_Sector	0->8
	Reallocated_Sector_Ct	648 -> 656
... reports continue every 30m until the morning
... started my day
... noticed a smart report
Jan 10 08:44:30 smartd[1254]: Device: /dev/sdf [SAT], 8 Currently unreadable (pending) sectors
        08:45:24 ran: smartctl and the errors are still showing.
        08:55:49 ran: sudo raid6check /dev/md127 $(((22791960168-2048-262144)/1024-1)) 2
		22791960168 is first LBA in list of 8 consecutive "Pending Defects", so one fs block.
        08:56:22 ran: smartctl and all errors are gone.
Jan 10 09:14:25 smartd[1254]: Device: /dev/sdf [SAT], No more Currently unreadable (pending) sectors, warning condition reset after 1 email

BTW, there was no increase in Reallocated_Sector_Ct during this time.
It seems that the Reallocated goes up at the same time Uncorrectable goes up and defects are listed. Upfront.
Uncorrectable and defects list are cleared at the same time (with raid6check) without more Reallocated counted.
And I did not do any writes that I know of.

So two unexplained:
	1 No errors in system log when the sectors failed, and reported by smartctl.
	2 raid6check in read-only mode clears the errors.
I guess my understanding and Seagate's are different.

>> Maybe the disk attempts to read the block (8 sectors) anyway and decides it is actually good?
>> 	In other words: first read failure is logged as Pending, a following good read clears it?
>> 	A failed write counts it as Reallocated_Sector_Ct.
>>
>> Interestingly, there is no indication of the reason for the initial failure (197/198 0->8).
>> No i/o error. No md report. No program failure.
>> The first log is from a regular 30m smart check.
> 
> That is odd. I would have expected a failed write. But that said, these days, if
> you get a failed write from a disk, you can pretty much consider the disk dead
> since bad sector remapping inside the disk is automatic and you'll get a failed
> write only if that fails.

Agreed, this disk is on its last leg (since Nov/25), a spare is available.

>> TIA
>>
> 
> 


-- 
Eyal at Home (eyal@eyal.emu.id.au)
