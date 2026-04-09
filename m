Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A929253950
	for <linux-ide@vger.kernel.org>; Thu,  9 Apr 2026 12:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775736065; cv=none; b=E/lgbAXlAPWl79Dl2sWtOc/xy3T2CaPZa54R9+SiznJzA0Vxc2z49AwE0d+bfN5tLipSNC3eRC1j7zB+zyO8SynCdGcGwOxMz4EOsYylnAoWDXsomi9fcrMTS8D5neR99ZSI7w04QS8b08VGURNDm7P/YuIpA0TU1usBWF0ohWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775736065; c=relaxed/simple;
	bh=IjedEjDP3FdStqBRXrEIMdj000ozJiSCEyExXCYsWek=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=NXJQ3ac8IGCDEPp9W9E4slQrC+jwMyOnHYTdxGOIDoocUv0dUlMMRWhUci4dM/vFWKA4zp37719WBhbLSwPpAJvehg8L4tL+s3IhzKzBSSjmimFGdH5n8H/pq8ryGIPv4GqJd2yI+ITeRApsS9yZwyAM6pcoI6M6dWka3pw4kIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bi7JOeuz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bi7JOeuz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 700BDC4CEF7;
	Thu,  9 Apr 2026 12:01:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775736065;
	bh=IjedEjDP3FdStqBRXrEIMdj000ozJiSCEyExXCYsWek=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=Bi7JOeuzffhYauR0ccOL0oyGM0zxO00FkGW1K4VbFyRbmhHgPb+d7h4pFwVzAmQaY
	 1HB0QHzjPSOCnEhZBqJ2lARVgXPm/o+5Id4dxnpjvOLI4rdgaWyaVJGK8CMoeDiGsK
	 k2UpthDZ9C7sTvTNzrM0efF6N80fu35F70PubcVJx7G1MCx9R4m+jnlm+cHnh8hYZ9
	 r2IdgmJvi5BKDtXVMje4/g5FUreURKmGeefVB5oD1MZvhhXHRepgQZSDCf4eeGc/dZ
	 aoKgkoToeRkHGF3/fDOOPUNnC4jkhaYYwr74Q9sfD01kkGvNlJEf/GEXGIplBA0bNA
	 N8EpUYkmoF5cQ==
Message-ID: <6740c3b7-c63c-4181-b36e-962e07bb468f@kernel.org>
Date: Thu, 9 Apr 2026 14:01:03 +0200
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Default IDENTIFY timeout is 5000ms which is too short for
 enterprise disks
To: AlanCui4080 <me@alancui.cc>, linux-ide@vger.kernel.org,
 Niklas Cassel <cassel@kernel.org>
References: <14015677.uLZWGnKmhe@alanarchdesktop>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <14015677.uLZWGnKmhe@alanarchdesktop>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2026/04/09 12:21, AlanCui4080 wrote:
> Hi,
> 
> I have two ST4000NM000A-2HZ100 on my computer which is of seagate enterprise 
> line.  But when i recovery from suspend, the kernel complains about that and 
> the zpool kicks the disk off:

We do not deal with out of tree code. So mentioning something that ZFS does is
not helping. Please check with an upstream file system. E.g. XFS, ext4 or BTRFS.

> 
> ```
> ata2: found unknown device (class 0)
> ata4: found unknown device (class 0)
> ata2: found unknown device (class 0)
> ata2: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
> ata4: found unknown device (class 0)
> ata4: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
> ata4.00: qc timeout after 5000 msecs (cmd 0xec)
> ata4.00: qc timeout after 5000 msecs (cmd 0xec)
> ata4.00: failed to IDENTIFY (I/O error, err_mask=0x4)
> ata4.00: revalidation failed (errno=-5)
> ata2.00: qc timeout after 5000 msecs (cmd 0xec)
> ata2.00: failed to IDENTIFY (I/O error, err_mask=0x4)
> ata2.00: revalidation failed (errno=-5)
> ata2: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
> ata4: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
> ata2.00: configured for UDMA/133
> ata4.00: configured for UDMA/133
> ```
> I think that's cause by the too slow spinup for my disk.
> After make libata to wait longer, the warning disappeared.

What kernel version is this ? Did you test with the latest mainline (7.0-rc7) ?

> 
> ```
> # cat /proc/cmdline
> libata.ata_probe_timeout=10
> ```
> 
> ```
> ata2: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
> sd 1:0:0:0: [sda] Starting disk
> ata2.00: configured for UDMA/133
> ata4: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
> sd 3:0:0:0: [sdb] Starting disk
> ata4.00: configured for UDMA/133
> ```
> 
> 
> Meanwhile, the seachest reports that the startup time from standby is 9sec, 
> which is longer that the default ATA IDENTIFY timeout.

Your drive is very slow/old. Most modern drives can reply to identify even when
they are not fully spun up.

> 
> ```
> /dev/sg0 - ST4000NM000A-2HZ100 - **** - TN04 - ATA
> 
> Standby Z : Recovery Time : 90 (in 100msecs)
> ```
> 
> ```
> static const unsigned int ata_eh_identify_timeouts[] = {
>          5000,  /* covers > 99% of successes and not too boring on failures */
>         10000,  /* combined time till here is enough even for media access */
>         30000,  /* for true idiots */
>         UINT_MAX,
> };
> ```
> 
> I tested the hard drive, and as long as it's never set to STANDBY_Z (disk 
> stops spinning, requiring 9 seconds to recover) and kept in IDLE_C (platter 
> slows down, requiring 3.2 seconds to recover), this error never occurs.
> 
> It's been seen many users complaining about this elsewhere, should we quirk 
> for those "heavy" disk? Or print some warnings about how to relax this 
> problem.

Elsewhere ? That certainly was not on this list as we have seen no problem
reports recently.

And no, we should not introduce a quirk for this. Rather, we should do the same
3-steps timeout for revalidation after a resume from suspend in the same manner
as a regular probe does. Or add a check/wait for "drive ready" when resuming,
similar to the PUIS handling (power up in standby).


-- 
Damien Le Moal
Western Digital Research
