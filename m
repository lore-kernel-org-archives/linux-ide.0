Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6253A26ADC
	for <linux-ide@vger.kernel.org>; Tue, 13 Jan 2026 07:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768287755; cv=none; b=ZWRWo/ojT9pohGMk6MuH8+XaQG57/DxQdSW7qIwtW6oN6/DMfk/RQHoELnCiE+fIllVgsRL3IRJqC4rjfDeAm3NAKLby1M91hAb603dhWrn32GvuInVy4VfXmHE/Q8wH50ELLwp+LJQHCipMZWYSaQFZvz71NaVo2aX+7qgdXnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768287755; c=relaxed/simple;
	bh=1x9hW7agi676wDU7uZ2CLv64zzPoNROmpWVJ+A4fEOU=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Wqqb4Kf+gcspcVmtaCwjdi0vAtkV5fM4KVriQdFa4uYDOXrXotpn6iz+Zj75mUaGEDjxLNlW4JQ8iQn6lxvbGvJn2magPpD57m1HPvUH2x7t3J7L7yObUFoDqu5ugAv7gKUkGxu2oMM2P4OmpwP5qILSLaloErSdjB3uKKx6TnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KqrmbILP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KqrmbILP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 727FEC116C6;
	Tue, 13 Jan 2026 07:02:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768287755;
	bh=1x9hW7agi676wDU7uZ2CLv64zzPoNROmpWVJ+A4fEOU=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=KqrmbILP70E/1wVz124VEtNkG3QoSIB/iouL9Osh8xTWXJnXE8asy21QsE6Sb3j2C
	 bdxQ43JQ/MGqQU1ww0k6qqR72lZL+37tt94tCid01sfTyaEACPvXub4KNZ+H48goyC
	 POBGiL58V8Ujy6t3OHV7DQNU0do+Mtei7tdxNy31APtrdp7Dj9roYeZAe1cVra4MSI
	 szBXgBqKcQzZk0ArKRVQOr/zMEPWYImJHGAl/TUIWzQpzFHAoKiPlQ8LwO/DWSOmwU
	 nnzKS2aEbfYNsugZqw55sM5ORuk7FqmMI7GFq5NHXAggPZQM9MkXoezAzWCvBF0LOZ
	 e6K3mH/SpwbeA==
Message-ID: <37c3a9de-768f-4ef5-88d0-6b6ae5c49524@kernel.org>
Date: Tue, 13 Jan 2026 08:02:32 +0100
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Why do Pending sectors disappear without writing to them?
To: eyal@eyal.emu.id.au, list linux-ide <linux-ide@vger.kernel.org>
References: <a41dafec-2ab8-4e6f-83f6-628104ee9b7b@eyal.emu.id.au>
 <211e1d4e-7ecd-4f83-b437-a4a09ebcf035@kernel.org>
 <fbd27438-3f2d-4777-8e7d-f9df2bc83b80@eyal.emu.id.au>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <fbd27438-3f2d-4777-8e7d-f9df2bc83b80@eyal.emu.id.au>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2026/01/13 2:34, Eyal Lebedinsky wrote:
> On 13/1/26 01:05, Damien Le Moal wrote:
>> On 1/10/26 01:35, Eyal Lebedinsky wrote:
>>> This happens with some regularity. This disk (/dev/sdf1) is part of a raid6. It seems to be unhealthy (another story).
>>> What I saw, a few times recently, is a smart report like
>>> 	197 Current_Pending_Sector  -O--C-   100   100   000    -    8
>>> 	198 Offline_Uncorrectable   ----C-   100   100   000    -    8
>>> and at the end of the smart report
>>> 	Pending Defects log (GP Log 0x0c)
>>> 	Index                LBA    Hours
>>> 	    0        22791960168    54593
>>> 	    1        22791960169    54593
>>> 	    2        22791960170    54593
>>> 	    3        22791960171    54593
>>> 	    4        22791960172    54593
>>> 	    5        22791960173    54593
>>> 	    6        22791960174    54593
>>> 	    7        22791960175    54593
>>> This stays for some time. For example this morning it started just after midnight
>>> until I checked the logs this morning.
>>>
>>> I reacted by running
>>> 	$ sudo raid6check /dev/md127 $(((22791960168-2048-262144)/1024-1)) 2
>>> BTW, I convert sector number to fs block:
>>> 	2048   (sdf1 start from fdisk)
>>> 	262144 'Data Offset : 262144 sectors' from 'mdadm --examine'
>>> 	1024   'Chunk Size : 512K' [1024s]    from 'mdadm --examine'
>>> I expected an issue to be reported, but none were.
>>> However ... the above 197/198 smart attributes went to zero, and the 'Pending Defects log' was cleared.
>>>
>>> My question is: raid6check is running in read-only mode, yet the disk cleared the pending reports. Why?
>>> I thought that you need to write to it for that.
>>
>> Most likely, the drive was slow to remap the failed sectors, so they showed up
>> in the smart report. Your raid6check may have rewritten these and the drive
>> these time remapped the sectors and the error went away. Probably, your remapped
>> sector count increased. Not sure if you have the old values.
> 
> Here is a recent example of the situation:
> 
> ... gone to bed
> Jan 10 00:44:24 smartd[1254]: Device: /dev/sdf [SAT], 8 Currently unreadable (pending) sectors
> 	Current_Pending_Sector	0->8
> 	Reallocated_Sector_Ct	648 -> 656
> ... reports continue every 30m until the morning
> ... started my day
> ... noticed a smart report
> Jan 10 08:44:30 smartd[1254]: Device: /dev/sdf [SAT], 8 Currently unreadable (pending) sectors
>         08:45:24 ran: smartctl and the errors are still showing.
>         08:55:49 ran: sudo raid6check /dev/md127 $(((22791960168-2048-262144)/1024-1)) 2
> 		22791960168 is first LBA in list of 8 consecutive "Pending Defects", so one fs block.
>         08:56:22 ran: smartctl and all errors are gone.
> Jan 10 09:14:25 smartd[1254]: Device: /dev/sdf [SAT], No more Currently unreadable (pending) sectors, warning condition reset after 1 email
> 
> BTW, there was no increase in Reallocated_Sector_Ct during this time.
> It seems that the Reallocated goes up at the same time Uncorrectable goes up and defects are listed. Upfront.
> Uncorrectable and defects list are cleared at the same time (with raid6check) without more Reallocated counted.
> And I did not do any writes that I know of.
> 
> So two unexplained:
> 	1 No errors in system log when the sectors failed, and reported by smartctl.
> 	2 raid6check in read-only mode clears the errors.
> I guess my understanding and Seagate's are different.

It may be that you do have bad sectors which take a lot of time to be read as
they need deep error corrections (HDDs have different ways of reading sectors
that get slower and slower if the sector is not easy to read). So reading these
sector is slow and smartctl reports that, but raid6check finally succeeds in
getting the data and the temporary error clears.

Guessing here. This would need a drive log analysis to fully understand this,
but only the disk vendor can do that.

You could try rewriting these bad sectors (copy them over themselves) to see if
this pattern goes away.

-- 
Damien Le Moal
Western Digital Research
