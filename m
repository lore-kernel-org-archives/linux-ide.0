Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67F0E7765D
	for <linux-ide@vger.kernel.org>; Fri,  2 Feb 2024 23:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706915877; cv=none; b=qEbWo4b8Q1Z/hfe6k/vO6eU/gi3XyXyLBNQT4GGUPvPDxNr6RRkusUGEL7fwIWjBgQ9xp6wvneP+FD679kIgexZ47M4OO9HCaREsUGNzfii5IDvMNw++occjHOOL7WJBtrLEZTM40dv6kf7DP8Z+OpY7ntt1EVZeByaiZysxjsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706915877; c=relaxed/simple;
	bh=IFK/wYKoAyG9G+RyXEmmiKzR3XB+mEx08zm8XiL5UxE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a6OfW1QHQ/DigBKVlRr1xlMgZMksBflI1ReUOENX9Y6FNxaiMgE8ohsEtMgslR2EY1l+wIqMLruEz++uS2yNO0IpdEFyPOZCDr+b8DqWwpvEvGJ4yk0ghG+MgXMCL+BuhY5Qc+IIPpZ2zGGjyXt2SwPkRXa9IeAwV6gXMFxtmlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ix1xj7B/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ix1xj7B/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30B84C433F1;
	Fri,  2 Feb 2024 23:17:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706915876;
	bh=IFK/wYKoAyG9G+RyXEmmiKzR3XB+mEx08zm8XiL5UxE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ix1xj7B/vCEYrp6sm8bTENMrNSmG0sqT9yVjufJfWMpfzqwXzBhPtSKamuosr792i
	 vpbX/9JUdMQdQX7rxygNZSoOlcBdL1t6ezfgSX1nCP4f/rftJxmrnpYiNfKVJer63w
	 Lsm8a5cwIYr9UWMuPM5S6z2spUKON28pDa4hWyRNxDCogEeSAi0AcAKzHHosBQzBR8
	 nWxLgGNKIwymbness72E6VXxXxt1a39euaqHO14KgOnB/pivG5r8rbQmD2m7fmEsfk
	 +WjlA9qlBPw4x2kvGeTCcVVUsdM/9pm27LS/idSqWruO3SC0OYVrT2SLSZULZY39FC
	 v+W0txD3XVWYw==
Message-ID: <c12cc683-1fbd-4f9b-92f4-dba01ae235bf@kernel.org>
Date: Sat, 3 Feb 2024 08:17:54 +0900
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] libata: avoid waking disk for several commands
Content-Language: en-US
To: Phillip Susi <phill@thesusis.net>, linux-ide@vger.kernel.org
Cc: Sergey Shtylyov <s.shtylyov@omp.ru>
References: <87msthdo11.fsf@vps.thesusis.net>
 <20240107180258.360886-1-phill@thesusis.net>
 <20240107180258.360886-2-phill@thesusis.net>
 <f6110204-338d-42b5-8ec2-153dd862e799@kernel.org>
 <878r50uf97.fsf@vps.thesusis.net>
 <abd85855-0767-4e48-a8a7-8046cd339f9c@kernel.org>
 <87a5p5b426.fsf@vps.thesusis.net> <878r4l12c5.fsf@vps.thesusis.net>
 <d058a699-2929-4829-859b-8450f4bf497e@kernel.org>
 <875xziiuou.fsf@vps.thesusis.net>
 <7e324bce-9984-4291-8b5f-0907483e7bc1@kernel.org>
 <87sf2ct0ma.fsf@vps.thesusis.net>
 <58834dd7-0946-45ad-8ada-303c0d735164@kernel.org>
 <87fryafxs5.fsf@vps.thesusis.net>
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <87fryafxs5.fsf@vps.thesusis.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/3/24 04:53, Phillip Susi wrote:
> Damien Le Moal <dlemoal@kernel.org> writes:
> 
>> Yes, but only for drives that report full identify data when PUIS is enabled.
>> For drives that report incomplete identify data, we have no choice but to wake
>> them up. And yes, we need integration with runtime pm to set the
>> initial power
> 
> Why was that again?  I think you said something about needing to set the
> speed correctly so you at least need to know if this drive requires a
> lower speed than the other in the PATA master/slave pair?  Wouldn't that
> only require the speed information, not all identify data?

See ata_dev_revalidate() and ata_dev_configure() and all the drive features that
are checked using the identify data. We need to preserve that to ensure that
nothing changed on the drive so that its representation in libata is kept in
sync with the drive config. That is why drive starting with PUIS and not giving
full identify data *must* be woken up, which is the current libata behavior.

>> state of the drive to standby (instead of "on") for both the ata device and its
>> scsi device.
> 
> You mean if the whole device hierarchy were changed so that instead of
> the scsi_host being a child of the port with the links and devices
> hanging off to the side, the scsi_host would be the child of the ata device?

You do not need to change the hierarchy of devices. An ata_dev is already a
child of its scsi_dev. So if you want to set the ata device to runtime suspend
state, you have to have the parent in the same state too. runtime suspend work
top-to-bottom in the device chain. You cannot have random device in the middle
of the chain going to suspend without the devices above it also being suspended.

Also, the user does not use ata devices directly. They use the scsi device
representing the ata device. You must thus have that in sync with the ata device
state.

>> I need to check that. I think there may be a better/easier way to get the
>> current power state of a drive. Will get back to you on that.
> 
> That would be good.  At one point that was the way I found, and also I
> think it was in the SAT-3 spec that is how REQUEST SENSE should be
> implemented for ATA disks.

TEST UNIT READY is the command to use. I need to check the specs again about how
it reports the device state though. I think it is through sense data. The scsi
disk driver issues that command already to check that the drive is spun-up. See
sd_revalidate_disk() calling sd_spinup_disk(). So that will also need to change
to be aware of the initial power state to not spinup the drive if not wanted.
That will need to be done extremely carefully though to only affect ata devices
with PUIS. Likely some additional scsi device flag will be needed for this. I
have not looked into that yet.

-- 
Damien Le Moal
Western Digital Research

