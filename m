Received: from vps.thesusis.net (vps.thesusis.net [34.202.238.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D43CC1D554
	for <linux-ide@vger.kernel.org>; Wed,  3 Jan 2024 21:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thesusis.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thesusis.net
Received: by vps.thesusis.net (Postfix, from userid 1000)
	id D37EC151A63; Wed,  3 Jan 2024 16:00:04 -0500 (EST)
From: Phillip Susi <phill@thesusis.net>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: linux-ide@vger.kernel.org
Subject: Re: [PATCH 1/1] libata: only wake a drive once on system resume
In-Reply-To: <decd3317-ed44-4ddc-b6b3-5b33bc72727c@kernel.org>
References: <20231225151915.258816-1-phill@thesusis.net>
 <20231230182128.296675-1-phill@thesusis.net>
 <20231230182128.296675-2-phill@thesusis.net>
 <decd3317-ed44-4ddc-b6b3-5b33bc72727c@kernel.org>
Date: Wed, 03 Jan 2024 16:00:04 -0500
Message-ID: <87il4am8tn.fsf@vps.thesusis.net>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Damien Le Moal <dlemoal@kernel.org> writes:

> This is not an improvement... What if the verify command that wakes-up the drive
> fails to be issued, or EH does not reach the call to ata_dev_power_set_active()
> on the first run ? You would want to retry it but your patch will prevent that.

Perhaps if it fails, then it should set the flag to request it be tried
again?  As long as it succeeds, then there's no need to do it again?

> I do not really see any fundamental issue here given that calling
> ata_dev_power_set_active() is indeed useless if the drive is already active, but
> that does not hurt either. The only overhead is issuing a check power mode
> command (see the call to ata_dev_power_is_active() in ata_dev_power_set_active()).
>
> Are you seeing different behavior with your system ? Any error ?

My main issue with it was that it caused errors with my PuiS patch.  I
tried canceling the SET_ACTIVE flag when PuiS was detected, but then the
flag got turned back on for the second pass of EH, but not the flag for
revalidate_and_attach, so it didn't detect the PuiS and clear the
SET_ACTIVE flag the second time.  Since the SET FEATURES command was not
issued, the VERIFY command failed, and after the 5th attempt, eh gave
up.  Without PuiS, it would also be nice to not waste time with a second
VERIFY command.
