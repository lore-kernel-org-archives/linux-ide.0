Received: from vps.thesusis.net (vps.thesusis.net [34.202.238.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A9A85F46B
	for <linux-ide@vger.kernel.org>; Thu,  1 Feb 2024 20:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.238.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706817702; cv=none; b=VACLavf5k50gbsqT+LiWsYsY8kvQGoNbkm2twxZJLH95RbVZzlkaZZ00P95yVpO0ELtoGVT0XYfzKsTW5asq1owbFkHTYA+RnWLWOrgmoW/NliacxhVGIM3Iz/KRBfL961CuotpiaRZMucPyvRsDY8MqIz3L1TYIWGfkyzZBm24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706817702; c=relaxed/simple;
	bh=EwKp8SSoxueur/4zBtrhCsAnhyGyxtxx60R1SDuAgtc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qKO0xR/8+0mod48DI6MHqugCBafgzEXvEI2yMES9/QtGB6WEyuoLnByP0ddy6xaT3n7D+u5U2QP5Ktlu/rkULCglODp/TAV2iLBBXw9tg58kU64HVf509LTWN7OcFmEH0AHadA8SGFeVwxJNfC7uybbL7l3oyB9txqPlA7D1ug0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thesusis.net; spf=none smtp.mailfrom=vps.thesusis.net; arc=none smtp.client-ip=34.202.238.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thesusis.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=vps.thesusis.net
Received: by vps.thesusis.net (Postfix, from userid 1000)
	id DB2C921C14; Thu,  1 Feb 2024 15:01:33 -0500 (EST)
From: Phillip Susi <phill@thesusis.net>
To: Damien Le Moal <dlemoal@kernel.org>, linux-ide@vger.kernel.org
Cc: Sergey Shtylyov <s.shtylyov@omp.ru>
Subject: Re: [PATCH 1/3] libata: avoid waking disk for several commands
In-Reply-To: <7e324bce-9984-4291-8b5f-0907483e7bc1@kernel.org>
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
Date: Thu, 01 Feb 2024 15:01:33 -0500
Message-ID: <87sf2ct0ma.fsf@vps.thesusis.net>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Damien Le Moal <dlemoal@kernel.org> writes:

> What does not work ? Everything is fine with my testing: the drive is always
> woken up whenever someone (FS, applications etc) issue a block IO (including
> flush) to the block layer. That is the expected behavior. If you want to have
> the disk keep sleeping, the device users must stop poking at the drive.

It seems that I have put my foot in my mouth.  When I first started
working on these patches way back when, I did see flushes without any
writes in the blktrace keeping the drive awake.  I assumed that was
still a problem that I needed to tackle.  I should have tested it
first.  It seems this problem has been fixed already.

ext4 does still seem to issue a flush with no writes in the sync path
though, causing a drive to spin up for no reason, then right back down
when you suspend-to-ram.  I guess I'll ask about this on the ext4 list.

Circling back to the PuiS patch, did I understand correctly that you are
fine with that as long as it integrates with runtime pm?

I had tried at one point to add support for REQUEST SENSE to libata so
that sd can issue that to find out if the disk is powered up or not, and
set the runtime_pm status of the disk accordingly.  Does that make sense
to you?

