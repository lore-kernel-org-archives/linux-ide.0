Received: from vps.thesusis.net (vps.thesusis.net [34.202.238.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 421B528E15
	for <linux-ide@vger.kernel.org>; Fri,  5 Jan 2024 16:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thesusis.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thesusis.net
Received: by vps.thesusis.net (Postfix, from userid 1000)
	id 5D524151F72; Fri,  5 Jan 2024 11:44:51 -0500 (EST)
From: Phillip Susi <phill@thesusis.net>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: linux-ide@vger.kernel.org
Subject: Re: [PATCH 4/4] libata: don't start PuiS disks on resume
In-Reply-To: <9d75da13-de73-4156-8ef4-5fbadd6e56b4@kernel.org>
References: <87y1d5kxcc.fsf@vps.thesusis.net>
 <20240104223940.339290-1-phill@thesusis.net>
 <20240104223940.339290-4-phill@thesusis.net>
 <9d75da13-de73-4156-8ef4-5fbadd6e56b4@kernel.org>
Date: Fri, 05 Jan 2024 11:44:51 -0500
Message-ID: <871qavu3uk.fsf@vps.thesusis.net>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Damien Le Moal <dlemoal@kernel.org> writes:

> Why ? The drive is in standby. What is the point of putting it into
> sleep state

I just figured it would save a little more power than just *pretending*
the drive was asleep ( which is what I did at first ).  I guess I can go
back to just setting the sleeping flag without telling the drive to
actually go to sleep.

> ? Furthermore, if you check ACS-6 specs, you will see that there is no
> transitions defined from PUIS state to sleep state. You have to spin-up the
> drive first. So the above is outside the specified behavior and thus not
> reliable (even though many drive may actually allow this transition).

Oh poo.  Though now I'm curious if it actually does fail on any.  It
seems like a pretty obvious thing to do and an oversight on the part of
the spec.  The kernel certainly doesn't do anything to prevent the user
from running hdparm -Y on a drive that is already in standby.

Wait, is that specifically from PuiS to sleep, or standby to sleep in general?

> Rather than playing with the return values, it may be easier to use a device
> flag (similar to ATA_DFLAG_SLEEPING) to track standby/spun-down state.

You mean change each if (rc == -EAGAIN) to if (ATA_DFLAG_SLEEPING)? That
doesn't seem any easier to me, but I'm not opposed to it.

>> +			pm_runtime_resume(&dev->sdev->sdev_gendev);
>
> What does this do ??? This look really out of place.

Darnit, I thought I had removed all of the runtime pm stuff.  My bad.
