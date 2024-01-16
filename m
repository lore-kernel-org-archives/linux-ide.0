Received: from vps.thesusis.net (vps.thesusis.net [34.202.238.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE5DA1CA94
	for <linux-ide@vger.kernel.org>; Tue, 16 Jan 2024 17:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thesusis.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thesusis.net
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705424820; cv=none; b=Vj8EuV3U46I/Mwj2PiMvKHbC9VEl5OioCroGRG3LM6rX4/RElyvcINJ4ORqMLpKfoPVZ3V4M6ssqEVGm9suhgpG2+Ue+C0jOo3PFENNY8es8QRAf6GB/ULh2n/V+SefdJ1UlA50QgCBsLe9SiOZJZRlEha1BbE7OZbuDhDaymw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705424820; c=relaxed/simple;
	bh=9fwHPBgGZpNoj3LJkuDp4jckED6R3uSBCpDAm4rEQU4=;
	h=Received:From:To:Cc:Subject:In-Reply-To:References:Date:
	 Message-ID:MIME-Version:Content-Type; b=KXSTXuu83gxOdsrunaPo5jLrZGwa1iDe9y9SX8y0Ooj/jZVjnJ0U9HFz4AVs/wDWugcOZ2CSTGbmmIvbLnc/p5LBGSIfFmWs4WmS05+7k5OosBFE1hgImuSA+AWAnmTYAuzlVN3Ywdloc0tWJ0po/xeq65x1WSHFzgtc7wS5Kqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; none
Received: by vps.thesusis.net (Postfix, from userid 1000)
	id E1F5B1537A6; Tue, 16 Jan 2024 12:06:57 -0500 (EST)
From: Phillip Susi <phill@thesusis.net>
To: Damien Le Moal <dlemoal@kernel.org>, linux-ide@vger.kernel.org
Cc: Sergey Shtylyov <s.shtylyov@omp.ru>
Subject: Re: [PATCH 1/3] libata: avoid waking disk for several commands
In-Reply-To: <abd85855-0767-4e48-a8a7-8046cd339f9c@kernel.org>
References: <87msthdo11.fsf@vps.thesusis.net>
 <20240107180258.360886-1-phill@thesusis.net>
 <20240107180258.360886-2-phill@thesusis.net>
 <f6110204-338d-42b5-8ec2-153dd862e799@kernel.org>
 <878r50uf97.fsf@vps.thesusis.net>
 <abd85855-0767-4e48-a8a7-8046cd339f9c@kernel.org>
Date: Tue, 16 Jan 2024 12:06:57 -0500
Message-ID: <87a5p5b426.fsf@vps.thesusis.net>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Damien Le Moal <dlemoal@kernel.org> writes:

> I did propose to allow for runtime suspend to to use sleep state instead of
> standby. That would be fairly easy to do and replace manual "hdparm -Y" with a
> well integrated control of the disk power state up to the block layer.
> You never commented back about this.

That would be nice.  I assume that would involve changing how
libata-scsi.c translates SYNCHRONIZE CACHE from the scsi layer?

> What is this legacy standby timer ? What control path does it trigger ? Do
> udisks2/gnome-disk-utility use that timer to issue commands like "hdparm -Y"  ?
> Or does that timer tigh into the regular runtime suspend ?

The ATA disk internal auto standby timer, i.e. hdparm -S.

> No. As said many times now, I am not going to do anything about the hdparm -Y
> hacking. If a user want better power management features, he/she should enable
> power management in their kernels.

So you are saying that we need to patch the kernel to make runtime pm
work better, then patch smartd and udisks2 to check for runtime pm
before issuing their SMART commands, and patch udsisks2 to enable
runtime pm rather than using the legacy ATA standby timer?

> No. The scsi layer issues a FLUSH CACHE whenever a disk is removed, goes to
> sleep or the system shutdown. And there is no need to do that if the disk is
> already in standby. If you see that happening, then we need to fix that.

I'm almost certain that I have seen this happen, and I don't currently
see any code in sd.c that would would prevent it from issuing a FLUSH
CACHE to a disk that is runtime suspended when the system suspends or
shuts down.

The block layer also would need patched to avoid turning a barrier into
a FLUSH CACHE if the disk is runtime suspended, and also the sync()
path.  Is that even sensible to do?  It is true that for all block
devices, their caches do not need flushed while they are runtime
suspended?  It seems like it may be, but I'm not certain.
