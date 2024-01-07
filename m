Received: from vps.thesusis.net (vps.thesusis.net [34.202.238.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D70413FE5
	for <linux-ide@vger.kernel.org>; Sun,  7 Jan 2024 17:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thesusis.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thesusis.net
Received: by vps.thesusis.net (Postfix, from userid 1000)
	id 71DE71522FC; Sun,  7 Jan 2024 12:57:46 -0500 (EST)
From: Phillip Susi <phill@thesusis.net>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: linux-ide@vger.kernel.org
Subject: Re: [PATCH 3/4] libata: avoid waking disk for several commands
In-Reply-To: <6517e642-c218-4dcf-9169-6d0bea61174f@kernel.org>
References: <87y1d5kxcc.fsf@vps.thesusis.net>
 <20240104223940.339290-1-phill@thesusis.net>
 <20240104223940.339290-3-phill@thesusis.net>
 <96e45a4c-06b2-4610-abcd-153ef2a48c5e@kernel.org>
 <874jfru4hz.fsf@vps.thesusis.net>
 <6517e642-c218-4dcf-9169-6d0bea61174f@kernel.org>
Date: Sun, 07 Jan 2024 12:57:46 -0500
Message-ID: <87msthdo11.fsf@vps.thesusis.net>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Damien Le Moal <dlemoal@kernel.org> writes:

> But who is issuing these commands ? If it is systemd/udev, then *that* need to
> be patched to avoid it issuing these commands when the drive is sleeping.
> Otherwise, there is no end to this. Next time systemd/udev is modified and start
> issuing another command, we'll need to ignore that one as well. This is a
> dangerous path that I am not willing to accept.

I have seen both smartd and udisks2 do this when they attempt to check
the SMART status of the drive.  They already issue a CHECK POWER MODE
command first and skip the SMART read if the drive is in standby, but
even this causes a drive that is in SLEEP mode to be woken up.

Also filesystems often issue FLUSH CACHE even though they have not
written anything to the disk, and there is nothing in the cache.  Drives
in standby just treat this as a NOOP, but a drive in SLEEP can not.

> That would mean having a sysfs attribute indicating that the device is sleeping
> though. So the sleep case needs more work.

Having a sysfs attribute that smartd/udisks2 could check before issuing
CHECK POWER MODE would help that case, but not the FLUSH CACHE case.

> As long as you can only set sleep mode with hdparm, there is not much we can do.
> hdparm uses passthrough commands, and so handling whatever that tool does in the
> kernel becomes a nightmare as libata would need to parse the issued commands and
> handle their result. Only a few cases are done now. Extending that would be
> difficult and fragile.

It already does that.  When the SLEEP command is issued, libata sets
ATA_DFLAG_SLEEPING.

> And yes, please split the series ! One for what you want to do for puis and
> another for improved sleep handling. Everything together is simply too confusing.

I realized that one of the patches was redundant anyhow, and just
finished writing up a good cover letter for the remaining 3.  Incoming.
