Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1D11523E
	for <linux-ide@vger.kernel.org>; Fri,  2 Feb 2024 01:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706836107; cv=none; b=BUXc7lwjAvOm7/WVlYWBhM1YdK5CFCvSCClbEzh3rk+396H9XuuEiaEGeOB6bLhulyPVbpA+vsD3YvIcILIwO1J2z7wVZagw8IG67gCSDxMYMWKOlJkOQV3IDJs3IyifG0Y1MaBuyXLCO2M1BsgeFAP0THa0hy4oHbaWw8J0nic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706836107; c=relaxed/simple;
	bh=X0l7ktbWO0WFhgPBB/sD25WB4T0sUC+0tzuXIRlBwv8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sQds4lb65ojW9exRqMyrQEQxyZDpux8MXNw7kYzvRV1lqegle7GUAZWiYt4sNFlyEezuaXYBiOdtpCN4Z3qZwrn2BTSONF6fTtFytFB5zKs7P99tUi9Br8XaBoGN9nQ3NjTCc+TZhykq4pbBypJGEtZPNobdmw0RGR0ieMN2TVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LKe+swRY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LKe+swRY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9728DC433F1;
	Fri,  2 Feb 2024 01:08:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706836107;
	bh=X0l7ktbWO0WFhgPBB/sD25WB4T0sUC+0tzuXIRlBwv8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=LKe+swRYx6At4HUlzlV+bZRQAReR+Th26r1S12wmnSn509PzPZzlmqt0PZKdSZnSI
	 m/DrNO8rRxX9I8aoPTIefqB+8+uMXBEKfggEK/89152JiZylTdE5jfNuujrHgf3N09
	 cl6ZaXRw4nFKTsIICPVA263hG1Zr4VSYKBUWHiy+HcL5OMDUYz2E/WjcfRwc1CJD6A
	 cjl38F0tH8I9kZs81IE40mIIvOt1RHZlg83wdlskoBfJMCZCLjxy4yb8qetweG5RGU
	 mI0g669vWrLAzd+Ku2iq6ywXphcUwCxLTw6CNv5717yVGPu12d9W/s7eG6JTRZwxNv
	 mMm2XVDEMvcAw==
Message-ID: <58834dd7-0946-45ad-8ada-303c0d735164@kernel.org>
Date: Fri, 2 Feb 2024 10:08:24 +0900
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
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <87sf2ct0ma.fsf@vps.thesusis.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/2/24 05:01, Phillip Susi wrote:
> Damien Le Moal <dlemoal@kernel.org> writes:
> 
>> What does not work ? Everything is fine with my testing: the drive is always
>> woken up whenever someone (FS, applications etc) issue a block IO (including
>> flush) to the block layer. That is the expected behavior. If you want to have
>> the disk keep sleeping, the device users must stop poking at the drive.
> 
> It seems that I have put my foot in my mouth.  When I first started
> working on these patches way back when, I did see flushes without any
> writes in the blktrace keeping the drive awake.  I assumed that was
> still a problem that I needed to tackle.  I should have tested it
> first.  It seems this problem has been fixed already.
> 
> ext4 does still seem to issue a flush with no writes in the sync path
> though, causing a drive to spin up for no reason, then right back down
> when you suspend-to-ram.  I guess I'll ask about this on the ext4 list.
> 
> Circling back to the PuiS patch, did I understand correctly that you are
> fine with that as long as it integrates with runtime pm?

Yes, but only for drives that report full identify data when PUIS is enabled.
For drives that report incomplete identify data, we have no choice but to wake
them up. And yes, we need integration with runtime pm to set the initial power
state of the drive to standby (instead of "on") for both the ata device and its
scsi device.

> I had tried at one point to add support for REQUEST SENSE to libata so
> that sd can issue that to find out if the disk is powered up or not, and
> set the runtime_pm status of the disk accordingly.  Does that make sense
> to you?

I need to check that. I think there may be a better/easier way to get the
current power state of a drive. Will get back to you on that.

-- 
Damien Le Moal
Western Digital Research

