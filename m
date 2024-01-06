Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29FC3101E3
	for <linux-ide@vger.kernel.org>; Sat,  6 Jan 2024 23:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f7sivgM8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39262C433C7;
	Sat,  6 Jan 2024 23:06:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704582364;
	bh=DJsABvSe6QgdpoB1HrWG3e3vhEHAaeHpVob5vCJQkrM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=f7sivgM8yC02cTqHH/TVsK4gJzuca2bz+8kbRLU4UJ1MT+GaRN+njyw5gnRBAL0bi
	 U8T6VBDjSvvnjToO7VTbNXCks3223Z+DnoVe6c9gwvfD41NlgcUfI7jYlf+4TTY0fp
	 aUHEER+R8QWnO0gia83PGAv21fqhL4XR8HCW+KqKdxRxrrp9SSE2o4HPe2kI4sLbx5
	 vBWp45qj5hsbhEB9ZkidUwsgiJiMnm+gjGC4KG4/CgqLVZ5VaTZSNXro8Qkod31G6a
	 pfzBdPFIVY9eh3obOyPgqxXyMgkX/FGOkgXLsl9QCWUQxdcyevn9ldMrPohg5nvTwJ
	 mk6sCDNYfQQCg==
Message-ID: <bbebb0b7-0e1b-4df5-87d5-76f3c59918dd@kernel.org>
Date: Sun, 7 Jan 2024 08:06:03 +0900
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] libata: only wake a drive once on system resume
Content-Language: en-US
To: Phillip Susi <phill@thesusis.net>
Cc: linux-ide@vger.kernel.org
References: <87y1d5kxcc.fsf@vps.thesusis.net>
 <20240104223940.339290-1-phill@thesusis.net>
 <f47ef1a9-3bd4-48c2-a7de-2c0e74c55647@kernel.org>
 <87y1d3sof0.fsf@vps.thesusis.net>
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <87y1d3sof0.fsf@vps.thesusis.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/6/24 02:03, Phillip Susi wrote:
> Damien Le Moal <dlemoal@kernel.org> writes:
> 
>>> -		return;
>>> +		return AC_ERR_OTHER;
>>
>> Nope. This is wrong. ata_dev_power_init_tf() returns a bool, not an error. The
>> bool indicates if the drive supports power management.
> 
> Are you saying it should return AC_ERR_OK?  If the drive doesn't support
> power management at all, isn't it an error to try to change its power
> management state?

That is why the function returns doing nothing if ata_dev_power_init_tf()
returns false, meaning "do not do power management". See that function. It
includes ATAPI devices (e.g. CD/DVD) which do not have power management.

>> But beside this, I still do not understand what this fixes... Calling again
>> ata_dev_power_set_active() will do nothing but issue a check power mode command
>> if the drive is already active. So I do not see the need for this added complexity.
> 
> If the drive is NOT active because it is PuiS, it would try to start the drive
> anyhow, despite the PuiS actively clearing the ATA_EH_SET_ACTVE flag.
> Then the VERIFY command fails if the drive requires the SET FEATURES
> command to leave PuiS.

Define a device flag to indicate that the drive has PUIS "on" and so woke up in
standby, e.g. ATA_DFLAG_PUIS_STANDBY. Check that flag in
ata_dev_power_set_active(), similarly to the ATA_DFLAG_SLEEPING flag and return
doing nothing if the puis flag is set. Way easier than playing games with the
return value.

> My goal here was to make sure that when the PuiS patch clears
> ATA_EH_SET_ACTIVE, that it does not get turned back on during a second
> round of EH.  Then you pointed out that it SHOULD try on the second
> round, if the first attempt failed, so I changed the return to be able
> to detect the error, and turn ATA_EH_SET_ACTIVE on for the second round.

See above.

> It occurs to me now that I only ran into this issue once I changed to
> actually giving the drive the SLEEP command instead of just setting the
> sleeping flag.  Once the drive actually went to sleep, it shut down the
> sata link, which caused an error interrupt, which triggered a second
> round of EH, which then issued the failing VERIFY command until all 5
> rounds were used and it gave up.  So if I go back to just setting the
> sleeping flag instead of actually putting the drive to sleep, I would
> not get the error interrupt and would be fine without this patch.  But I
> can imagine some other cause for a second round of EH on some system
> that would still run into this problem.

Please separate handling of sleep and puis. The former can be used even if puis
is off.

-- 
Damien Le Moal
Western Digital Research

