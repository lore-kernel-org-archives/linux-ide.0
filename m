Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E6347F9
	for <linux-ide@vger.kernel.org>; Wed, 10 Jan 2024 02:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fz22UMzH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F7FDC433C7;
	Wed, 10 Jan 2024 02:39:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704854373;
	bh=iIJZRYszUKmB8yn0Z2BDwIcca1jEwSJoDaeOfzE7LkA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Fz22UMzHkpxiCLKdfJdijZu9tomsEwllQrgzNdFsg03kGLy18mVL0LmmTUu/JWwJy
	 OWJPnYtyk9DwSeJf2JfFB3A796hCvZo1DrpBhljv6jMtnp1YiSVl8Mmhniz3Mcw73c
	 K0DvJrUv+Ijz6l6Ry2hO7I0iaVAFjXAzFVbEPHz2raRXZ3qrVyERTCHPKlM4bFNGfb
	 4FB61w+ZSyyblE218ya2WWD2lgK2rpt/FQj1kXZzjdrnMNP6uWi1O1j5ZtquJVP+Tf
	 ZQjEQb3FxrbUa+sfGMQtbyZsh/z12Zo15rjFs9F5zN/usNFFIcFA3XiwAc8cJ6zBhb
	 Q0GIuLld59YbQ==
Message-ID: <abd85855-0767-4e48-a8a7-8046cd339f9c@kernel.org>
Date: Wed, 10 Jan 2024 11:39:31 +0900
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
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <878r50uf97.fsf@vps.thesusis.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/8/24 22:27, Phillip Susi wrote:
> Damien Le Moal <dlemoal@kernel.org> writes:
> 
>> sleep and standby are different power states. So saying that a disk that is
>> sleeping is in standby does not make sense. And if you wake up a drive from
> 
> There is no way to answer CHECK POWER MODE and say the drive is in
> sleep.  It can only be either active, or standby, so standby is the
> closest fit.  At least it gets smartd and udisks2 to leave the drive
> alone.

I was not commenting about what to do about your problem, but about the fact
that your sentence was very hard to understand because it was not technically
accurate.

>> The problem here is that ATA_DFLAG_SLEEPING is a horrible hack to not endup with
>> lots of timeout failures if the user execute "hdparm -Y". Executing such
>> passthrough command with a disk being used by an FS (for instance) is complete
>> nonsense and should not be done.
> 
> I'm not sure what you propose be done instead.  Regardless, this is how
> it has always been done, so I don't think there is any changing it now.

I never proposed to change that in any way. That is fine and can stay as it is.
What I do NOT want to do is expand upon this to try to solve issues. The reason
for that, which I already stated, is that hdparm issue passthrough commands. And
if the user wants to use passthrough commands, then most of the time, he/she
will have to deal with the consequences of not using kernel-provided management
methods.

I did propose to allow for runtime suspend to to use sleep state instead of
standby. That would be fairly easy to do and replace manual "hdparm -Y" with a
well integrated control of the disk power state up to the block layer.
You never commented back about this.

> You also have the legacy standby timer that is exposed to users through
> udisks2/gnome-disk-utility that still has to be supported.

What is this legacy standby timer ? What control path does it trigger ? Do
udisks2/gnome-disk-utility use that timer to issue commands like "hdparm -Y"  ?
Or does that timer tigh into the regular runtime suspend ?

>> So I would rather see this handled correctly, through the kernel pm runtime
>> suspend/resume:
> 
> I'd eventually like to as well, but it should also work in kernels that
> aren't built with runtime pm enabled.

No. As said many times now, I am not going to do anything about the hdparm -Y
hacking. If a user want better power management features, he/she should enable
power management in their kernels.

>> For FSes issued commands like flush, these are generally not random at all. If
>> you see them appearing randomly, then there is a problem with the FS and
>> patching the FS may be needed. Beside flush, there are other things to
>> consider
> 
> I'm not sure the filesystem maintainers will see it that way.  They
> generally issue barriers as part of a commit at regular intervals, and
> that gets turned into FLUSH CACHE.  Also the kernel issues one during
> system suspend, and I think that happens even if no filesystem is
> mounted.  I think systemd also issues a sync() during shutdown, which
> would wake up a sleeping disk only to shut down.

No. The scsi layer issues a FLUSH CACHE whenever a disk is removed, goes to
sleep or the system shutdown. And there is no need to do that if the disk is
already in standby. If you see that happening, then we need to fix that.

If the device is in sleep state from "hdparm -Y", then only libata knows that
the device is sleeping with the ATA_DFLAG_SLEEPING flag. That is the fundamental
problem here: pm-core, scsi and the block layer do not know that the block
device is sleeping (and so already had its write cache flushed). Your patches
are not solving this root cause issue. They are only hidding it by faking the
commands. This is a hack, wich likely will need more hacks in the future for
different cases. See my point ? I do not want to go down such route. Let's fix
things properly.

> I don't think it is up to all of these other sources to be patched to
> avoid this.  libata knows the disk is in sleep mode, so that is the
> place to handle it.

Not that simple. See above.


-- 
Damien Le Moal
Western Digital Research

