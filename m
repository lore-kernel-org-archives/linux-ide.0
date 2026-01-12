Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 684FA50097D
	for <linux-ide@vger.kernel.org>; Mon, 12 Jan 2026 14:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768226733; cv=none; b=riATYS0tPAwRmG1xRgsUZz+zZf3HpngPeATW74r77Y0YS5prMG1IqFYMwGjhy0N3wsyPqRXA3TwFWCt64NeAEYmhXHJlyXOHJrY3e1jt3tKER+4mAD5EW8XrYhGPOLRyhB2IG4VPPo7QnI9GOssTcfoJh8+byS+0zw24bR2kIsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768226733; c=relaxed/simple;
	bh=ttZsueivq7uT9AjR0hcKkSPz3IaH4/xI7MKRaTPXhOU=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=nbfQp96LMX4o0+PKfh5YXga/dn1iEM8UoYVvXL2x1QN9O83pLb8zhBb7dSmZR4ZMhP7jTTl1ZC4YSLKOaS2qrNcye7bPsWItcskIRMNOdIOU5VPtOgBZXr3+4vlq0h0w5KtSbCe35WCn5smU+dZXpdFnObSBeM1EfQMEH+4UTVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CJgM2CJF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CJgM2CJF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66E80C16AAE;
	Mon, 12 Jan 2026 14:05:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768226733;
	bh=ttZsueivq7uT9AjR0hcKkSPz3IaH4/xI7MKRaTPXhOU=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=CJgM2CJFwCkcxHDv/JTo/K2scaIta+k0xDfI/7fQ4QvTtWJV5CqwXFLPYomootG6S
	 uVA3Gj9DqQBil5h79CZMBQORV/0EKAcOM39JIGjMV8wCdvRelWDVcNoqrTBqf2FZwF
	 JEWeHHr8A9ZsguSMp5uBbcGvLLzP26ZEiIdTuBS5Cin3UIsErQyDML/8ytCptI9V0R
	 6LNNRcZpEnL4hMmCP9G+Hgj8AC7A+V6jHJq7iVgNooWW+G4SMlUZQJgxmda5IbQM9b
	 q3hWuLJwejowOsmxad/OsEUZViTO4t2qsdtaee3xDmbccST64rsaa4jK+Gm8vqQUJD
	 Yd6HcE4Q50FVQ==
Message-ID: <211e1d4e-7ecd-4f83-b437-a4a09ebcf035@kernel.org>
Date: Mon, 12 Jan 2026 15:05:30 +0100
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Why do Pending sectors disappear without writing to them?
To: "Eyal Lebedinsky (emu)" <eyal@eyal.emu.id.au>,
 list linux-ide <linux-ide@vger.kernel.org>
References: <a41dafec-2ab8-4e6f-83f6-628104ee9b7b@eyal.emu.id.au>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <a41dafec-2ab8-4e6f-83f6-628104ee9b7b@eyal.emu.id.au>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/10/26 01:35, Eyal Lebedinsky wrote:
> This happens with some regularity. This disk (/dev/sdf1) is part of a raid6. It seems to be unhealthy (another story).
> What I saw, a few times recently, is a smart report like
> 	197 Current_Pending_Sector  -O--C-   100   100   000    -    8
> 	198 Offline_Uncorrectable   ----C-   100   100   000    -    8
> and at the end of the smart report
> 	Pending Defects log (GP Log 0x0c)
> 	Index                LBA    Hours
> 	    0        22791960168    54593
> 	    1        22791960169    54593
> 	    2        22791960170    54593
> 	    3        22791960171    54593
> 	    4        22791960172    54593
> 	    5        22791960173    54593
> 	    6        22791960174    54593
> 	    7        22791960175    54593
> This stays for some time. For example this morning it started just after midnight
> until I checked the logs this morning.
> 
> I reacted by running
> 	$ sudo raid6check /dev/md127 $(((22791960168-2048-262144)/1024-1)) 2
> BTW, I convert sector number to fs block:
> 	2048   (sdf1 start from fdisk)
> 	262144 'Data Offset : 262144 sectors' from 'mdadm --examine'
> 	1024   'Chunk Size : 512K' [1024s]    from 'mdadm --examine'
> I expected an issue to be reported, but none were.
> However ... the above 197/198 smart attributes went to zero, and the 'Pending Defects log' was cleared.
> 
> My question is: raid6check is running in read-only mode, yet the disk cleared the pending reports. Why?
> I thought that you need to write to it for that.

Most likely, the drive was slow to remap the failed sectors, so they showed up
in the smart report. Your raid6check may have rewritten these and the drive
these time remapped the sectors and the error went away. Probably, your remapped
sector count increased. Not sure if you have the old values.

> Maybe the disk attempts to read the block (8 sectors) anyway and decides it is actually good?
> 	In other words: first read failure is logged as Pending, a following good read clears it?
> 	A failed write counts it as Reallocated_Sector_Ct.
> 
> Interestingly, there is no indication of the reason for the initial failure (197/198 0->8).
> No i/o error. No md report. No program failure.
> The first log is from a regular 30m smart check.

That is odd. I would have expected a failed write. But that said, these days, if
you get a failed write from a disk, you can pretty much consider the disk dead
since bad sector remapping inside the disk is automatic and you'll get a failed
write only if that fails.

> 
> TIA
> 


-- 
Damien Le Moal
Western Digital Research
