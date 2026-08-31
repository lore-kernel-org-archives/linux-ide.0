Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F7FB3C5DCD
	for <linux-ide@vger.kernel.org>; Mon, 31 Aug 2026 07:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788162180; cv=none; b=oarwKEckvVvCCxXbL7mKFbI4tS50/Wkvdgxl/uFtGoQ6OvtirniZh+9ih2A6dWu4mTqTQsFhdzQLH4qMKvaBrBQYJtWz50E96y942N6XnZARhy62P338lWqTrwileQtvWc6x2B30blWdfKckHcoH89raaBpfM1yZi1sIqfz5ySM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788162180; c=relaxed/simple;
	bh=cjcN0dM96aEMykXSEnId+MYis8KhpRc9PuwgWp2k1qI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S52j0Of5T5eoirlSM9QRWvmHutjpRt06OGJc2kHqGCM0EIudkfjGfSKjyEGgc2jpIIa8W5+kmBcv34P2JRo0N94x2M0VD/sfWUQqv3JtClVkOhp9MZeyGikZTg0HW/Co4hurMxxZG9UiZHH7Aet3R3LSsl82lH2WsaT28ipFQps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nIgITmfN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nIgITmfN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77EF71F000E9;
	Mon, 31 Aug 2026 07:42:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788162179;
	bh=nCFxRnRqFatatOwLyNtkqfBUbuHR3/98kpnosHNQKgw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=nIgITmfNTBIVD+vwVxcdANBqt383RI8F+EkQ4Em92YiCvMNzCNBdRNSIStcTIDM/n
	 btyZNPl2dAw8ConcU5hxYrZFi5BlCFaKmrtJFgPUKuNp5N4Epb7b5UZnXZEUdlQW1W
	 GzjpBXyGKek0kzcRrWP+v64EZcPh840YxtZP9AIlTu3atO5FE+AczJJp2K9qaVlFLx
	 mFVzx5pgeOZtPo7A5+U1ekdyHKbuH3ijydNH9PX2JctU+iqXRwJ8QeXC/KR86O+c/U
	 bkQKb0kNNzYUp/sZFGYEp9rFleMJ26L8hcLp4pPovkuS8+Q3K3VuRi9n7iVWZAxL9t
	 4phGm7tDk+MIg==
Date: Mon, 31 Aug 2026 09:42:55 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Hank Barta <hbarta@gmail.com>
Cc: linux-ide@vger.kernel.org
Subject: Re: "ata2.00: Enabling discard_zeroes_data" in dmesg 1/minute
Message-ID: <apUwf-BOc0pJe3Ic@ryzen>
References: <CABTDG8-3oiR+P7ebTx2PY-OQNGoMod3CRSk9uMaTHKW4FnRKbA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABTDG8-3oiR+P7ebTx2PY-OQNGoMod3CRSk9uMaTHKW4FnRKbA@mail.gmail.com>

Hello Hank,

On Fri, Jul 31, 2026 at 02:11:56PM -0500, Hank Barta wrote:
> Good afternoon,
> This message is being posted to the kernel ring buffer 1/minute on one
> of my servers. I just spent a few minutes with ChatGPT tracking this
> down and ChatGPT has suggested that it may be due to a regression in
> libata. Full details of the interaction can be viewed at
> https://chatgpt.com/share/6a6cef79-9bac-83ea-86d6-5de28f09e70a
> 
> As near as I can tell, the message is harmless aside from flushing the
> kernel rung buffer. Some brief details regarding this host:
> 
> Debian Trixie
> Linux oak 6.12.96+deb13-amd64 #1 SMP PREEMPT_DYNAMIC Debian 6.12.96-1
> (2026-07-20) x86_64 GNU/Linux
> ZFS version   zfs-kmod-2.3.2-2
> 
> I searched to see if this had already been reported and found nothing,
> though that might reflect more WRT my search capabilities.
> 
> Is this something I should submit as a bug? If so, kernel bug list or Debian?
> 
> I appreciate instructions for how best to proceed if I can be of any
> assistance. (And if that's "go away" I will take no offense.)

ZFS is an out of tree filesystem incompatible with the license used by
Linux, thus we don't spend any time looking into issues related to ZFS.

If you can reproduce the error with any filesystem included in Linux,
please send an email that includes your full details in the email itself
(rather than linking to an URL).


Kind regards,
Niklas
