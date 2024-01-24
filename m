Received: from vps.thesusis.net (vps.thesusis.net [34.202.238.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3F0D7A725
	for <linux-ide@vger.kernel.org>; Wed, 24 Jan 2024 16:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.238.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706112297; cv=none; b=gWOKjK4U6CdFX+28JRUzrsHkRYTVVI0qkOD2ovshQn6gSaIO96j/bopMBw1yGH7ElDO1NJLXAfujjlCJo4GEl7hsCVuNrvX5TxXTbBHibYcd0FjYaVzltgPJC1xqtIBjOdI/fA2eSwUg4tojNSGY0kokXuMsDhNO7t1eZaOyFMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706112297; c=relaxed/simple;
	bh=DHd/pO85Gwkr4NYm0+YPCVhjb2Gq584joeqot/5TXvs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=AwQHnwwdof1VFagoaoh+6ZsJzgYN/X7RN4PJP/D3ZWKcJHulzTvmQtSIYpsS4sioo5tPk87quo3Zr5SagawWdxmshIR9tiIO4k63diHl4rCu8xA+YDkjkrAei0dCRk8ZkC9nNwYYBsa4vs36XXTGzLDHVvJZUMoTHPgibo0133E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thesusis.net; spf=pass smtp.mailfrom=thesusis.net; arc=none smtp.client-ip=34.202.238.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thesusis.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thesusis.net
Received: by vps.thesusis.net (Postfix, from userid 1000)
	id 99A60154BD8; Wed, 24 Jan 2024 11:04:49 -0500 (EST)
From: Phillip Susi <phill@thesusis.net>
To: Damien Le Moal <dlemoal@kernel.org>, linux-ide@vger.kernel.org
Cc: Sergey Shtylyov <s.shtylyov@omp.ru>
Subject: Re: [PATCH 1/3] libata: avoid waking disk for several commands
In-Reply-To: <d058a699-2929-4829-859b-8450f4bf497e@kernel.org>
References: <87msthdo11.fsf@vps.thesusis.net>
 <20240107180258.360886-1-phill@thesusis.net>
 <20240107180258.360886-2-phill@thesusis.net>
 <f6110204-338d-42b5-8ec2-153dd862e799@kernel.org>
 <878r50uf97.fsf@vps.thesusis.net>
 <abd85855-0767-4e48-a8a7-8046cd339f9c@kernel.org>
 <87a5p5b426.fsf@vps.thesusis.net> <878r4l12c5.fsf@vps.thesusis.net>
 <d058a699-2929-4829-859b-8450f4bf497e@kernel.org>
Date: Wed, 24 Jan 2024 11:04:49 -0500
Message-ID: <875xziiuou.fsf@vps.thesusis.net>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Damien Le Moal <dlemoal@kernel.org> writes:

> Flush issuing is a lot more complicated than just blkdev_issue_flush(). There is
> a whole file dedicated to handling flushes (block/blk-flush.c).
>
> But that is beside the point, which is that trying to not execute flush is
> simply completely wrong. Please stop trying.

I tried before to have libata ignore the useless flush and you said to
stop the flush from happening in the first place.  Now you say that's wrong?

> For your case, which is a drive put to sleep with hdparm -Y, only libata is
> aware that the drive is sleeping. That first needs to change if you want the
> kernel overall to be able to do anything. As I proposed already, using runtime
> PM with sleep mode instead of standby would be a good start.

No, I'm working on runtime pm now, as you suggested.  If you try using
runtime pm with disks, you quickly see that it does not work.

> Regarding the flushes and other commands you see that are waking up the drive
> for no *apparent* good reasons, please identify what application/component is
> issuing these commands and look there to see why the commands are being issued
> and if that is done with awareness for the device power state.

Filesystems flush every few seconds.  So does anyone calling sync(),
which the kernel does when you suspend to ram.

Either the filesystems need to keep track of whether a flush is needed
and skip it, or if they all call the same place ( blkdev_issue_flush ),
then it only needs done once in that place.

The core logic needs to be "if nothing has been written, then nothing
needs to be flushed".  Right now filesystems just flush periodically or
when their sync method is called to make sure that anything that has
been written is stable.

In userspace you have smartd and udisks2 to worry about.  The
information they need to know is whether the disk has otherwise been in
recent use and so they should not poll the SMART data.  I don't see
anything exported in the power/ directory that would give an indication
of the current *remaining* time until autosuspend, or how long it has
been since the last access.  Either one would be useful for userspace to
decide that nobody else seems to be using the disk, so I'll leave it
alone for now so it can go to sleep.
