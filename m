Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0C7418A
	for <linux-ide@vger.kernel.org>; Sun, 21 Jan 2024 00:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705797430; cv=none; b=Hig2czigyNf/yUePMH/lEw8s1Ts7eWojDsb7JrXAsKUxiRRKOHAa3NX4vOSQRvmgZ/ovdifl8gM4czreSG70ZgVzOBTTXQPWXhS29J692tMg4iEbv/aKSPw6i4UQt2OcgkKWgSEYKRlvmaqPvvCpkWGxBNrsou2iCiKw0Np88Us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705797430; c=relaxed/simple;
	bh=oiNCLCK3RIi9mouM7HVihyneVVikw4OErDzcjVl5EtM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lF4kvRY5xGLPvXllRZRa3J5SY4uo2Wuv29E0tZb6Z2SM/AOmk3b4hJlIKJJfUnDcjaudmbcwhuHYxHT4IynO4uPjHmOBoc0r3THOMzslfQUzr398stYI7FV79g1n51M3OMI6CX1gCepMZoyAD7a0RnDEJcGBE8xFioBUeyhUiCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=muoAO45i; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="muoAO45i"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE8F0C43390;
	Sun, 21 Jan 2024 00:37:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705797430;
	bh=oiNCLCK3RIi9mouM7HVihyneVVikw4OErDzcjVl5EtM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=muoAO45iV7LQyV7p0GN15i6lVZyXiKTco0ooxaYhY2zxFsp3vgihRUQQsukSEGUEe
	 Qy7D4h6arvPUpjLLvtwMMmPxBKnnE9Pc/Vfl+Sc10iczdNu915BKAVjUTxzbQywXj3
	 FRrm3fTznebhSEaxKMWvynxeFW1iGatVWjeWZ2LVkYOyIUl9R5TGeMtAupxDuNwPzb
	 YRVdF5t9WbDWuPYgxDOlOKqXcNC9WJCe+ttez/SE5JFV4nno9GSA3N3eK5SnrfQdPJ
	 Et2/u2EopXZ7GsK8rLtBnu6MIHX4yd3ZXu6OmS315Qs3mtbkPwU5vsXDJAEbfjdyKI
	 /fi+e4zG+qf4w==
Message-ID: <d058a699-2929-4829-859b-8450f4bf497e@kernel.org>
Date: Sun, 21 Jan 2024 09:37:07 +0900
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
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <878r4l12c5.fsf@vps.thesusis.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/20/24 05:43, Phillip Susi wrote:
> Phillip Susi <phill@thesusis.net> writes:
> 
>> The block layer also would need patched to avoid turning a barrier into
>> a FLUSH CACHE if the disk is runtime suspended, and also the sync()
>> path.  Is that even sensible to do?  It is true that for all block
>> devices, their caches do not need flushed while they are runtime
>> suspended?  It seems like it may be, but I'm not certain.
> 
> I was trying to do this.  I think the right place is in
> blkdev_issue_flush(), but apparently bdev->bd_device is not the same
> struct device that gets suspended.  I can't seem to work out where the
> right struct device is to pass to pm_runtime_suspended() and skip the
> flush operation.

Flush issuing is a lot more complicated than just blkdev_issue_flush(). There is
a whole file dedicated to handling flushes (block/blk-flush.c).

But that is beside the point, which is that trying to not execute flush is
simply completely wrong. Please stop trying.

For your case, which is a drive put to sleep with hdparm -Y, only libata is
aware that the drive is sleeping. That first needs to change if you want the
kernel overall to be able to do anything. As I proposed already, using runtime
PM with sleep mode instead of standby would be a good start.

Regarding the flushes and other commands you see that are waking up the drive
for no *apparent* good reasons, please identify what application/component is
issuing these commands and look there to see why the commands are being issued
and if that is done with awareness for the device power state.

Then we can patch properly instead of trying to "hack".

-- 
Damien Le Moal
Western Digital Research

