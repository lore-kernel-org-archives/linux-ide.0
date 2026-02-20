Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B761B31D362;
	Fri, 20 Feb 2026 09:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771579671; cv=none; b=CNBILWLioKPjkq2aLQS7a/BJM57m3ZwUVWA15kmZd6byUA62rqZmgfmlSqd1d57WjCI+i0EtfF/xm5fPa637MQabek5MLjwY8HZ5RWw4Fc3VPXSkPCn7sMCzwP0lE9ysRLc7e8CNxIsfpay7VWWkmkaEFk0hazmLf/HWQgLk1v8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771579671; c=relaxed/simple;
	bh=I7UNspIyMVhVihxDlbk2K0TUAau99aZFPaQScaeFWp4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V1niSjC+zCE87SxHEC4doXrVea9gthYqm7gSIb5QpTRr6nzbI5f014hueQQKJpIWrLnjRPf6C4n1etmlaR4mdpY1ouxabQoftqsL37Xj+/CBRnnCsVYZVllpJwC4NiYhbC3lG5RkFmYT23D+3cCZCwWXOUWG9jVYiHRz3prWabA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KI3rPHbP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KI3rPHbP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9B95C116C6;
	Fri, 20 Feb 2026 09:27:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771579671;
	bh=I7UNspIyMVhVihxDlbk2K0TUAau99aZFPaQScaeFWp4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KI3rPHbPfsVSKXil7uicVY93yDDKVzHCBAm9LehOUL4PvUqmxI2p0qyAO2R9fq114
	 Kkph+ChAFOFI43aMtnEny/abTO6X9jo09eE7cK8LU0GwuKEZl4U0NprXhRmoVGhn0i
	 +1OInIIrgtc+UHDEZIUf4zg1XKjyZbfPa7ksPtnpJt7nXuzOHCSFpVkEOEmjeS8pj9
	 wlAqDKnXmZbScXG2v3HtlOMtz2BUdQZWzcCSpQ5vTPmooY/aCmYnTp3Lc0MHfWGaJO
	 Q0pJHU17osgPFvQ6Q8iTMcYvPDtzDyU/OkVmbRFywvvxLQ7oLh3b//yIpWIBPMdsIS
	 2GAsBqVbI9QGg==
Date: Fri, 20 Feb 2026 10:27:43 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Dmitry Vyukov <dvyukov@google.com>
Cc: Damien Le Moal <dlemoal@kernel.org>,
	syzbot <syzbot+1f77b8ca15336fff21ff@syzkaller.appspotmail.com>,
	linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com,
	syzkaller <syzkaller@googlegroups.com>
Subject: Re: [syzbot] [ide?] UBSAN: shift-out-of-bounds in ata_qc_issue
Message-ID: <aZgo7wa9_eOv7No6@ryzen>
References: <6994d5c7.a70a0220.2c38d7.010b.GAE@google.com>
 <aZWKRkTVIJuLS_Y7@ryzen>
 <1e4e903b-143f-4f95-a41d-2a87cdcaf2c4@kernel.org>
 <aZeubyGHf1GX0HPA@ryzen>
 <d49ebdba-9925-414f-8889-877adbad6052@kernel.org>
 <CACT4Y+bASk262w_axUwpYdS=sNgnaXfhDEJ0S3JFCBVdwJidOA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACT4Y+bASk262w_axUwpYdS=sNgnaXfhDEJ0S3JFCBVdwJidOA@mail.gmail.com>

Hello Dmitry,

On Fri, Feb 20, 2026 at 10:17:05AM +0100, Dmitry Vyukov wrote:
> Some info I can infer from these 4 crashes.
> 
> There is some kind of race, or very rare timing is likely to be
> involved. Only 4 crashes is not much. Usually the fuzzer triggers them
> more often.
> 
> The crash happens in kworker, this makes it impossible to infer when
> test programs may be involved.
> 
> In all 4 cases there is a preceding USB disconnect message:
> [  644.391966][ T5992] usb 11-1: USB disconnect, device number 24
> It may be related. These devices can be connected via USB, right?
> 
> Unfortunately, I cannot infer much more.
> These USB device numbers may theoretically allow to infer the test
> program, but I think it's currently not possible.
> 
> It may be possible to reply these logs for longer to see if they
> trigger the crash.

It seems that my suspicion that the bug occurs after a block layer timeout,
was correct.

Damien managed to reproduce the bug and have sent a fix:
https://lore.kernel.org/linux-ide/20260220050053.390135-1-dlemoal@kernel.org/T/#t

A lot of thanks to syzbot for finding this bug that we failed to find
during review.


Kind regards,
Niklas
