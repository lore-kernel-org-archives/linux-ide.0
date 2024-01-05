Received: from vps.thesusis.net (vps.thesusis.net [34.202.238.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD6EF321B7
	for <linux-ide@vger.kernel.org>; Fri,  5 Jan 2024 16:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thesusis.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thesusis.net
Received: by vps.thesusis.net (Postfix, from userid 1000)
	id F285A151F5C; Fri,  5 Jan 2024 11:30:48 -0500 (EST)
From: Phillip Susi <phill@thesusis.net>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: linux-ide@vger.kernel.org
Subject: Re: [PATCH 3/4] libata: avoid waking disk for several commands
In-Reply-To: <96e45a4c-06b2-4610-abcd-153ef2a48c5e@kernel.org>
References: <87y1d5kxcc.fsf@vps.thesusis.net>
 <20240104223940.339290-1-phill@thesusis.net>
 <20240104223940.339290-3-phill@thesusis.net>
 <96e45a4c-06b2-4610-abcd-153ef2a48c5e@kernel.org>
Date: Fri, 05 Jan 2024 11:30:48 -0500
Message-ID: <874jfru4hz.fsf@vps.thesusis.net>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Damien Le Moal <dlemoal@kernel.org> writes:

> What ? If you wake up the drive, it will not be in standby... So I do not get
> your point here. Can you clarify ? What is the problem you are trying to solve
> here ? Is it related to system or runtime suspend/resume ?

The whole point is that we don't want to spin up the drive.  A drive
that is in standby simply treats these commands as a NOOP.  One that is
in SLEEP can not do that, so we must do it for the drive.

Without this patch, SLEEP mode is basically useless since the drive will
be woken up by one of these commands quite soon after you put it to
SLEEP.

This is just to make hdparm -Y not useless.  It has nothing to do with
suspend/resume.  I was thinking of splitting this patch series into two
parts, one with just the patches related to SLEEP and one with the
patches related to suspend/resume.

