Received: from vps.thesusis.net (vps.thesusis.net [34.202.238.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2996F31A69
	for <linux-ide@vger.kernel.org>; Fri,  5 Jan 2024 17:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thesusis.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thesusis.net
Received: by vps.thesusis.net (Postfix, from userid 1000)
	id 3FB33151F84; Fri,  5 Jan 2024 12:03:31 -0500 (EST)
From: Phillip Susi <phill@thesusis.net>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: linux-ide@vger.kernel.org
Subject: Re: [PATCH 1/4] libata: only wake a drive once on system resume
In-Reply-To: <f47ef1a9-3bd4-48c2-a7de-2c0e74c55647@kernel.org>
References: <87y1d5kxcc.fsf@vps.thesusis.net>
 <20240104223940.339290-1-phill@thesusis.net>
 <f47ef1a9-3bd4-48c2-a7de-2c0e74c55647@kernel.org>
Date: Fri, 05 Jan 2024 12:03:31 -0500
Message-ID: <87y1d3sof0.fsf@vps.thesusis.net>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Damien Le Moal <dlemoal@kernel.org> writes:

>> -		return;
>> +		return AC_ERR_OTHER;
>
> Nope. This is wrong. ata_dev_power_init_tf() returns a bool, not an error. The
> bool indicates if the drive supports power management.

Are you saying it should return AC_ERR_OK?  If the drive doesn't support
power management at all, isn't it an error to try to change its power
management state?

> But beside this, I still do not understand what this fixes... Calling again
> ata_dev_power_set_active() will do nothing but issue a check power mode command
> if the drive is already active. So I do not see the need for this added complexity.

If the drive is NOT active because it is PuiS, it would try to start the drive
anyhow, despite the PuiS actively clearing the ATA_EH_SET_ACTVE flag.
Then the VERIFY command fails if the drive requires the SET FEATURES
command to leave PuiS.

My goal here was to make sure that when the PuiS patch clears
ATA_EH_SET_ACTIVE, that it does not get turned back on during a second
round of EH.  Then you pointed out that it SHOULD try on the second
round, if the first attempt failed, so I changed the return to be able
to detect the error, and turn ATA_EH_SET_ACTIVE on for the second round.

It occurs to me now that I only ran into this issue once I changed to
actually giving the drive the SLEEP command instead of just setting the
sleeping flag.  Once the drive actually went to sleep, it shut down the
sata link, which caused an error interrupt, which triggered a second
round of EH, which then issued the failing VERIFY command until all 5
rounds were used and it gave up.  So if I go back to just setting the
sleeping flag instead of actually putting the drive to sleep, I would
not get the error interrupt and would be fine without this patch.  But I
can imagine some other cause for a second round of EH on some system
that would still run into this problem.
