Received: from vps.thesusis.net (vps.thesusis.net [34.202.238.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F6B3224CA
	for <linux-ide@vger.kernel.org>; Thu,  4 Jan 2024 14:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thesusis.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thesusis.net
Received: by vps.thesusis.net (Postfix, from userid 1000)
	id 4EA13151C63; Thu,  4 Jan 2024 09:05:39 -0500 (EST)
From: Phillip Susi <phill@thesusis.net>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: linux-ide@vger.kernel.org
Subject: Re: [PATCH 1/1] libata: only wake a drive once on system resume
In-Reply-To: <0f53d7b2-9980-4223-92f5-519207e9b486@kernel.org>
References: <20231225151915.258816-1-phill@thesusis.net>
 <20231230182128.296675-1-phill@thesusis.net>
 <20231230182128.296675-2-phill@thesusis.net>
 <decd3317-ed44-4ddc-b6b3-5b33bc72727c@kernel.org>
 <87il4am8tn.fsf@vps.thesusis.net>
 <0f53d7b2-9980-4223-92f5-519207e9b486@kernel.org>
Date: Thu, 04 Jan 2024 09:05:39 -0500
Message-ID: <87y1d5kxcc.fsf@vps.thesusis.net>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Damien Le Moal <dlemoal@kernel.org> writes:

> Correct, if it succeeds, no need to do it again. The problem with clearing the
> flag though is that ATA_EH_SET_ACTIVE is for the device and that is set only if
> ATA_PFLAG_RESUMING is set, but that one is for the port. So if resume for the
> device succeeds, you can clear the ATA_PFLAG_RESUMING flag *only* if there is
> only a single link/device for that port. If not, other devices on the port may
> need a retry so we cannot clear ATA_PFLAG_RESUMING.

Rather than clear ATA_PFLAG_RESUMING, I was thinking of keeping my
previus change to specify ATA_EH_SET_ACTIVE in the request_pm path
rather than by setting it based on ATA_PFLAG_RESUMING, but just adding a
check to see if the VERIFY fails, and if so, set ATA_EH_SET_ACTIVE again.

> Ah, now I think I understand: is it your patch that prevents resuming a drive if
> it has PUIS on ? If yes, then sure, the verify command to spin-up the drive will
> indeed fail immediately if the drive is in standby from PUIS, since getting out
> of standby state driven by PUIS requires a set features spinup. So... with your
> patch, things will not work.

Right... unless you also apply this patch to make sure that
ATA_EH_SET_ACTIVE isn't turned on again after it is cleared when PuiS is detected.

> If PUIS is not enabled, the only thing wasted is a check power mode command. If
> the drive confirms that it is active, verify command is not issued.

Ahh, right... I forgot you did add a CHECK POWER MODE first.

> With PUIS enabled though, if you leave the drive in standby mode, when/how do
> you actually wake it up ?

Initially I just set the ATA_DFLAG_SLEEPING flag as if the drive had been
put into SLEEP mode, which triggers EH to wake it up when the drive is
accessed.  I have since switched to actually putting the drive to SLEEP
mode when PuiS is detected since it will save a little more power than
leaving it in STANDBY.

> Scratching my head about this, I think that doing this cleanly should be
> possible if:
> 1) The dive gives complete identify data when that command is issued with the
> drive in standby state driven by PUIS.

I think you can do it even if the IDENTIFY data is incomplete, as long
as a revalidate_and_attach is done eventually, when waking the drive up.

> 2) The call to ata_dev_configure() executed by ata EH started from system resume
> does not spinup the device if requested not to (libata module & sysfs parameter
> can do that). But I think this requires that the drive be instead put into a
> state equivalent to *runtime* suspend, that is, with the scsi disk associated
> with the device must also be in runtime suspend state.

Yea, I was trying to make it work with runtime suspend before, but you
indicated that the current device hierarchy seems to make that
impossible, so I put that aside for now.  Currently runtime pm thinks
the drive is running even though it isn't, but that isn't any different
than when you hdparm -y or hdparm -Y, or hdparm -S and let the drive
decide to auto standby.  Eventually I'll try to get the runtime pm
sorted but I figured I'd try to get the basic concept working first.

> With that, it would only be a matter of adding a device flag to remember that
> the drive is in "PUIS stnadby" instead of regular standby, and then have
> ata_dev_power_set_active() use a set feature spinup command instead of a verify.
> Drive spinup will then be cleanly driven by accesses to the scsi disk, similarly
> to a regular runtime suspend.

Right now I'm using the SLEEP flag to do this, and when the disk is
accessed, it triggers a round of EH that does the revalidate_and_attach
and in the process, issues the SET FEATURES command to wake the drive.

> With such changes, everything would be cleaner and safer and all work as
> expected. The exception will be drives that do not give complete identify data
> when PUIS is on. For these, it is too risky to not wake them up to get the full
> information first.
>
> Do you want to try to tackle this ? If you do not feel like it, I can give it a
> try too.

I've already got it working ;)

I think I sent you an earlier version of the patch a few weeks ago.
I'll post my whole series tonight, after I fix the case of retrying the
VERIFY if it fails.

