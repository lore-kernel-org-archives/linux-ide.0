Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 806F7185B
	for <linux-ide@vger.kernel.org>; Thu,  4 Jan 2024 01:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G3ZZznb/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2688C433C8;
	Thu,  4 Jan 2024 01:21:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704331295;
	bh=AG9lEKobFY6Oa+slRnQNCGw1sepD3bi+6smEXbO1FVA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=G3ZZznb/qYQT4ooZQmh0AKQy2qPJk1qusGN45q44c/UQXv2GN5op2VR5s2pO/1VmG
	 6HBOn7lrBqB24b1WjCqJGIyGbyNu1FuWHIoA8NiT8yNPFt1VstT/GmINz2RRrp7J12
	 uJcK3aXz8vx7AHfcjCoBTgZEAhPEIhypEb8n0nD1QH5QXTYRnOncxuBuogBFe0We/e
	 YoN+RnYErFuLp3KWxqpVYiiQIzSN54x4tzL4apkN//1cNT/73wc5uz8TugsTK8ameM
	 Xr3GJ4gJIH4nh0WxvETHZX8JtVpBxPgH1T+tkEC3q+6He+5C2bZBpHY58/9OuM+hqn
	 9fGsMhRE+Jt1A==
Message-ID: <0f53d7b2-9980-4223-92f5-519207e9b486@kernel.org>
Date: Thu, 4 Jan 2024 10:21:32 +0900
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] libata: only wake a drive once on system resume
Content-Language: en-US
To: Phillip Susi <phill@thesusis.net>
Cc: linux-ide@vger.kernel.org
References: <20231225151915.258816-1-phill@thesusis.net>
 <20231230182128.296675-1-phill@thesusis.net>
 <20231230182128.296675-2-phill@thesusis.net>
 <decd3317-ed44-4ddc-b6b3-5b33bc72727c@kernel.org>
 <87il4am8tn.fsf@vps.thesusis.net>
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <87il4am8tn.fsf@vps.thesusis.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/4/24 06:00, Phillip Susi wrote:
> Damien Le Moal <dlemoal@kernel.org> writes:
> 
>> This is not an improvement... What if the verify command that wakes-up the drive
>> fails to be issued, or EH does not reach the call to ata_dev_power_set_active()
>> on the first run ? You would want to retry it but your patch will prevent that.
> 
> Perhaps if it fails, then it should set the flag to request it be tried
> again?  As long as it succeeds, then there's no need to do it again?

Correct, if it succeeds, no need to do it again. The problem with clearing the
flag though is that ATA_EH_SET_ACTIVE is for the device and that is set only if
ATA_PFLAG_RESUMING is set, but that one is for the port. So if resume for the
device succeeds, you can clear the ATA_PFLAG_RESUMING flag *only* if there is
only a single link/device for that port. If not, other devices on the port may
need a retry so we cannot clear ATA_PFLAG_RESUMING.

> 
>> I do not really see any fundamental issue here given that calling
>> ata_dev_power_set_active() is indeed useless if the drive is already active, but
>> that does not hurt either. The only overhead is issuing a check power mode
>> command (see the call to ata_dev_power_is_active() in ata_dev_power_set_active()).
>>
>> Are you seeing different behavior with your system ? Any error ?
> 
> My main issue with it was that it caused errors with my PuiS patch.  I

Ah, now I think I understand: is it your patch that prevents resuming a drive if
it has PUIS on ? If yes, then sure, the verify command to spin-up the drive will
indeed fail immediately if the drive is in standby from PUIS, since getting out
of standby state driven by PUIS requires a set features spinup. So... with your
patch, things will not work.

> tried canceling the SET_ACTIVE flag when PuiS was detected, but then the
> flag got turned back on for the second pass of EH, but not the flag for
> revalidate_and_attach, so it didn't detect the PuiS and clear the
> SET_ACTIVE flag the second time.  Since the SET FEATURES command was not
> issued, the VERIFY command failed, and after the 5th attempt, eh gave
> up.  Without PuiS, it would also be nice to not waste time with a second
> VERIFY command.

If PUIS is not enabled, the only thing wasted is a check power mode command. If
the drive confirms that it is active, verify command is not issued.

With PUIS enabled though, if you leave the drive in standby mode, when/how do
you actually wake it up ?

Scratching my head about this, I think that doing this cleanly should be
possible if:
1) The dive gives complete identify data when that command is issued with the
drive in standby state driven by PUIS.
2) The call to ata_dev_configure() executed by ata EH started from system resume
does not spinup the device if requested not to (libata module & sysfs parameter
can do that). But I think this requires that the drive be instead put into a
state equivalent to *runtime* suspend, that is, with the scsi disk associated
with the device must also be in runtime suspend state.

With that, it would only be a matter of adding a device flag to remember that
the drive is in "PUIS stnadby" instead of regular standby, and then have
ata_dev_power_set_active() use a set feature spinup command instead of a verify.
Drive spinup will then be cleanly driven by accesses to the scsi disk, similarly
to a regular runtime suspend.

With such changes, everything would be cleaner and safer and all work as
expected. The exception will be drives that do not give complete identify data
when PUIS is on. For these, it is too risky to not wake them up to get the full
information first.

Do you want to try to tackle this ? If you do not feel like it, I can give it a
try too.

-- 
Damien Le Moal
Western Digital Research

