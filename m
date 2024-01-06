Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D2E9101DF
	for <linux-ide@vger.kernel.org>; Sat,  6 Jan 2024 23:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jXadiMY6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 466FBC433C8;
	Sat,  6 Jan 2024 23:14:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704582849;
	bh=fTYlIm9ZB4QJvH8mScebRfJCQkUJ/lKN6O5FlxDM1qY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=jXadiMY6EsJFLbktpMHhfb0Zu09Xkk9LiVtAzjbribit9N4Vema17zbAOa/8762bD
	 Uy5WiyzDh9gSxj6CmkprN1AiP20CZBUBJbk5cBB2bX2HBjQlxL5Kv9me/xpJXX8nxr
	 VfDfBLTkpGkVmLLJLWWjHxGonOmyJW+mD6lxUpec7E3k1SR2FU64NyMYcmsylkH5Hs
	 Q/Hz/dAFS9SLrkRD70QU/5rpTH4qdyUs2Uxm3hK9gLkZB+Fce/dzahLrwW+4EzcEuq
	 bA7TGR7iXN2lRvv1MepwEdoG1BRvaiGHAejoGiqAvqNmDo6oggACFr3hpfASLanhUG
	 jaPL54WtVUsDQ==
Message-ID: <6517e642-c218-4dcf-9169-6d0bea61174f@kernel.org>
Date: Sun, 7 Jan 2024 08:14:08 +0900
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] libata: avoid waking disk for several commands
Content-Language: en-US
To: Phillip Susi <phill@thesusis.net>
Cc: linux-ide@vger.kernel.org
References: <87y1d5kxcc.fsf@vps.thesusis.net>
 <20240104223940.339290-1-phill@thesusis.net>
 <20240104223940.339290-3-phill@thesusis.net>
 <96e45a4c-06b2-4610-abcd-153ef2a48c5e@kernel.org>
 <874jfru4hz.fsf@vps.thesusis.net>
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <874jfru4hz.fsf@vps.thesusis.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/6/24 01:30, Phillip Susi wrote:
> Damien Le Moal <dlemoal@kernel.org> writes:
> 
>> What ? If you wake up the drive, it will not be in standby... So I do not get
>> your point here. Can you clarify ? What is the problem you are trying to solve
>> here ? Is it related to system or runtime suspend/resume ?
> 
> The whole point is that we don't want to spin up the drive.  A drive
> that is in standby simply treats these commands as a NOOP.  One that is
> in SLEEP can not do that, so we must do it for the drive.

But who is issuing these commands ? If it is systemd/udev, then *that* need to
be patched to avoid it issuing these commands when the drive is sleeping.
Otherwise, there is no end to this. Next time systemd/udev is modified and start
issuing another command, we'll need to ignore that one as well. This is a
dangerous path that I am not willing to accept.

That would mean having a sysfs attribute indicating that the device is sleeping
though. So the sleep case needs more work.

> Without this patch, SLEEP mode is basically useless since the drive will
> be woken up by one of these commands quite soon after you put it to
> SLEEP.>
> This is just to make hdparm -Y not useless.  It has nothing to do with
> suspend/resume.  I was thinking of splitting this patch series into two
> parts, one with just the patches related to SLEEP and one with the
> patches related to suspend/resume.

As long as you can only set sleep mode with hdparm, there is not much we can do.
hdparm uses passthrough commands, and so handling whatever that tool does in the
kernel becomes a nightmare as libata would need to parse the issued commands and
handle their result. Only a few cases are done now. Extending that would be
difficult and fragile.

Rather, I would recommend improving the runtime pm code to allow for "going to
sleep" instead of "going to standby". A sysfs attribute switch can be used for
that, with the default being standby like now.

And yes, please split the series ! One for what you want to do for puis and
another for improved sleep handling. Everything together is simply too confusing.

-- 
Damien Le Moal
Western Digital Research

