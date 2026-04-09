Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7FC53C343F
	for <linux-ide@vger.kernel.org>; Thu,  9 Apr 2026 11:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775735735; cv=none; b=aFTx+H8MdE6Eej0UdSPhOvqqRFkvN/HgjjmtNUUbWtlnUQWBFWp5tPGL6VlAgUqxfbDbPfrcVMdsP3id267mH7JFoRbJmdYtAKFayN34kbNhrLN0+TPylUZ7dBI+oiUlq6Lt3QiGqH5CBQVjKbBvbm5Llf8RT9WUDzriE6nAUSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775735735; c=relaxed/simple;
	bh=pX8f11S9H4O0txHaccZRA6GAQVG1+dPSbQTfyBrEXVI=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=PCT7KOAYnFsRujgQjIvZYGRkDuE8dsyNxFHwC5P5DvRTtNAiKB02JJEzQsGGTzvSJhgGWgouAqtRHXZqEzrhtiDpgY2jREw203pr9yHaGFS5tw2UP8ASvADZlaQdscgcJtKIpMZH4NWYt2FUVrLCCpVYBWScEbBchqc0RSPP5xQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uTIMYAdv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uTIMYAdv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C372C2BC87;
	Thu,  9 Apr 2026 11:55:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775735735;
	bh=pX8f11S9H4O0txHaccZRA6GAQVG1+dPSbQTfyBrEXVI=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=uTIMYAdvI66nFOiFkrAGrGnIngEv1/V5swfmqymyLjAtpxRyg7nlJDuhvhBYvar8O
	 3PYdfokMxOhKdm3lBRuV0fhDajYA+hr1U3f8of+g+dFxXGfkhwl+zpOmuyiNpXowCx
	 MyTuq6qJuYos1GUTDSTazYmgpkRCMG6vLtB7ftElh67igix8fCGh9ksrN1TNabj6mg
	 ShNUXVhbTEFSKBCnz6Da7/9ajdL11Uy7r+rSHbJZb+AB7+R5U5so9PplLLhAUrPE+J
	 oUmvyMEoXx8Hq5MTIg5XNpdeR+5+AHVdERRXQDLL0+elCEo7FlkIIs4ReLLIrL5Vay
	 ehW2vrlzjg9vg==
Message-ID: <4b000b96-b9cc-4acf-93b0-6f76ea03cd1b@kernel.org>
Date: Thu, 9 Apr 2026 13:55:33 +0200
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Default IDENTIFY timeout is 5000ms which is too short for
 enterprise disks
To: AlanCui4080 <me@alancui.cc>, linux-ide@vger.kernel.org
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

Elsewhere ? I have not seen any complaints/problem reports on the linux-ide list
recently. So I do not know where "elsewhere" is.

And no, we should not quirk the disk but rather improve resume from suspend to
issue identify with increasing timeouts, like regular probe does, or to issue
identify only once we see the drive ready, which is a check that exist for
spundown startups. That should solve the issue.




-- 
Damien Le Moal
Western Digital Research
