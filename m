Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32890156C1
	for <linux-ide@vger.kernel.org>; Sun, 21 Jan 2024 00:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705797477; cv=none; b=XCuccXP0HJkMJiLGyUBvQcc8kjldXIrM4PbqN4hdHT5wkr5pvccf0s7Dqq02Uwc5qMH21wTPcL2urYX9pm7B0Pa6758Od7o2x/xVEH2lS4EE71fk6b/18ZbLLdLB60m6RvLkoMAMzV8RJ+w7vUPRm6BchA82hU4oKEjZlF3v7OE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705797477; c=relaxed/simple;
	bh=Id9adSf/xrm7uFuNgauf5bsOud7KJF4d3tLXAKtnYHs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cSp+pSACqYU3RbUx6PRmopjYtb9S4nIU1BaHI5VPvcL8OoV2uThgf6BRvyU/B+FfRtHEO4z6F/y+/d3c2TLxyY2DhkHfIwNIuJYa/R/6QjC3OdSwwhsNvcMa4cvU7ZZKN1msll2FeyiCDy35Y5wRnTejuGr2UTfFneSXnUkhR/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D3ZkLo9A; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D3ZkLo9A"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 540F0C43394;
	Sun, 21 Jan 2024 00:37:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705797477;
	bh=Id9adSf/xrm7uFuNgauf5bsOud7KJF4d3tLXAKtnYHs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=D3ZkLo9AppiiHYeVQKPuRAo9YKe6LmuYQKFN1EntJIsspAPxUJ2kssUzwKUtZc7QB
	 /OQzR9YbtvwEUm5usz0Q+6lI2OJrMYAMAfWq8A1r5gFm8ox3T7SnQOi6saPs5gCn3p
	 jgxATyGy31T7mYqma5+zLijgsChKD1o3nvZkJqMNu+edzIh84+cdFDaYaWhljY0pxh
	 zjp2tr808Kt2Cls4daOJKTd4U5gjxQagKvvA5qetQvGQB85xr0RGv4/g93YD/1X8qa
	 4klQe8qOFGASbEBLgxp6s9cgkcw7QarvooF5oPbQyBDSj8trCZXtRItHBtuyGNNlIw
	 ST6QZvqs1N/DA==
Message-ID: <1f0aaf07-f2f4-41a7-a15d-7074a8be7f5f@kernel.org>
Date: Sun, 21 Jan 2024 09:37:56 +0900
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
 <87plxvnahn.fsf@vps.thesusis.net>
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <87plxvnahn.fsf@vps.thesusis.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/21/24 03:08, Phillip Susi wrote:
> Phillip Susi <phill@thesusis.net> writes:
> 
>> I was trying to do this.  I think the right place is in
>> blkdev_issue_flush(), but apparently bdev->bd_device is not the same
>> struct device that gets suspended.  I can't seem to work out where the
>> right struct device is to pass to pm_runtime_suspended() and skip the
>> flush operation.
> 
> I don't know what I was thinking yesterday.  It can't rely on
> pm_runtime_suspended() because it would continue to flush and reset the
> suspend timer before it ever gets suspended.  I wonder if it could use
> the performance counters?  Whenever a flush is done, and also when
> suspending, store the value of the write counter, and only if it has
> changed, issue the flush, otherwise skip it?

See my reply to your previous comment.
What you are trying to do is not the correct approach.

-- 
Damien Le Moal
Western Digital Research

