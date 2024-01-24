Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9653E1353F6
	for <linux-ide@vger.kernel.org>; Wed, 24 Jan 2024 21:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706133102; cv=none; b=LRV8cAaX2+39wnNAdKcyK8rZG1t5/svixgRhi/M5vPZzYsmSsfZAGeCtKOlxsR1Kr9xS+jS69S9kTXOFcizcuRrX4qvRu8Wh6hYyJIKFi8sJ4E9r5nf7o3W2sOOUVH9BNk1hna/JCPU5C+O5kaSohxWdrpZpgjkkXb1/3kCQzSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706133102; c=relaxed/simple;
	bh=1O4h8TS240cT8KDphk5sYO+XemTd4am8IGjC1FqVAAU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gp0RJGBWmAbN+/wthRkFGLzlHKEKpf/nq1SEY/YJ+NSaQ38eI/LBp/5ij6O7GA6ffW3T+DvavpgbSFNwkC04rV2LeUrpbjlFA/LO3HNQXCYsZDgm6NiEWv75q0UDqAm3drFoEME1WlVkKLVY3xo1PMyj04eUubTyrCDWQbL9lz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aku6Vx5y; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aku6Vx5y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A772C433C7;
	Wed, 24 Jan 2024 21:51:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706133102;
	bh=1O4h8TS240cT8KDphk5sYO+XemTd4am8IGjC1FqVAAU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=aku6Vx5yNLDg8zqNL/UE0E5pBrxxul0tTrPEV2WuLkfRzG8sb2AxGLRXjHHYwh5SC
	 7OzOtIiscs0fh8jNyAIFzm1jCOW/CeSiqqxtnMtEwKWyYMre4L6+wmAHTX5agr02AH
	 dZNtaXnJ8AUv/RM2ydrAFImzyYEv1Zv7dA9JVU49DxQiejSs31Ke0ZxBjfg8Kv2QIS
	 hzEGcGvHf/hWg1K1oQzah7YKu6s3xpVQpRh2uIOHLdNalU5nGzMckmU31cwdEUOtNi
	 kXQLbt+JFAjQ+ezzxEyt/FaLrmFuxtZQ9p1AwJL6sPDDZxg79qK3rlEcd0zgjf4/pE
	 /jlcpd8O0Mpaw==
Message-ID: <7e324bce-9984-4291-8b5f-0907483e7bc1@kernel.org>
Date: Thu, 25 Jan 2024 06:51:39 +0900
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
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <875xziiuou.fsf@vps.thesusis.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/25/24 01:04, Phillip Susi wrote:
> Damien Le Moal <dlemoal@kernel.org> writes:
> 
>> Flush issuing is a lot more complicated than just blkdev_issue_flush(). There is
>> a whole file dedicated to handling flushes (block/blk-flush.c).
>>
>> But that is beside the point, which is that trying to not execute flush is
>> simply completely wrong. Please stop trying.
> 
> I tried before to have libata ignore the useless flush and you said to
> stop the flush from happening in the first place.  Now you say that's wrong?

No, not wrong. But you are looking at the wrong layer. Do not try to prevent
flushes from being issued at the block layer level but *above* it. That is,
FSes, applications etc.

>> For your case, which is a drive put to sleep with hdparm -Y, only libata is
>> aware that the drive is sleeping. That first needs to change if you want the
>> kernel overall to be able to do anything. As I proposed already, using runtime
>> PM with sleep mode instead of standby would be a good start.
> 
> No, I'm working on runtime pm now, as you suggested.  If you try using
> runtime pm with disks, you quickly see that it does not work.

What does not work ? Everything is fine with my testing: the drive is always
woken up whenever someone (FS, applications etc) issue a block IO (including
flush) to the block layer. That is the expected behavior. If you want to have
the disk keep sleeping, the device users must stop poking at the drive.

> 
>> Regarding the flushes and other commands you see that are waking up the drive
>> for no *apparent* good reasons, please identify what application/component is
>> issuing these commands and look there to see why the commands are being issued
>> and if that is done with awareness for the device power state.
> 
> Filesystems flush every few seconds.  So does anyone calling sync(),
> which the kernel does when you suspend to ram.

Filesystems issue flush only if they have dirty data to flush, normally. I have
not looked at ext4/xfs code in a while, but if the FS has not committed any
transaction in the last cycle, there should be no flush issued. If there is,
then someone is reading or writing files (for reading, if you have atime
enabled, that will cause a metadata change and so a transaction commit).

> Either the filesystems need to keep track of whether a flush is needed
> and skip it, or if they all call the same place ( blkdev_issue_flush ),
> then it only needs done once in that place.

See above. That is why I am telling you to run blktrace or any tracer to figure
out the command sequence and who is doing what. There is absolutely no clarity
to what you are describing and so we cannot plan for a solution.

> The core logic needs to be "if nothing has been written, then nothing
> needs to be flushed".  Right now filesystems just flush periodically or
> when their sync method is called to make sure that anything that has
> been written is stable.

I do not think that the periodic flush happens if nothing has been written. For
"sync", someone issues that, not the FS on its own. So trace it to find out who
is doing that.

> In userspace you have smartd and udisks2 to worry about.  The
> information they need to know is whether the disk has otherwise been in
> recent use and so they should not poll the SMART data.  I don't see
> anything exported in the power/ directory that would give an indication
> of the current *remaining* time until autosuspend, or how long it has
> been since the last access.  Either one would be useful for userspace to
> decide that nobody else seems to be using the disk, so I'll leave it
> alone for now so it can go to sleep.

-- 
Damien Le Moal
Western Digital Research

