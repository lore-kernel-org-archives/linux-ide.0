Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50BFF2E5B1B
	for <linux-ide@vger.kernel.org>; Sun, 12 Apr 2026 18:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776018136; cv=none; b=d99i9AN7ohpB+JUc6caJ3I1aYfh2u7ZFJSiCLo06jXATFxOyqIQg+oSid0KMgVv610WupIOYqUWhuJrgEFl1LB3X06cNqHe37KGHitR0gts49LFdDZh5EHglyo+k9uV0o+McKmtSNRlvL4Ba9q71Kfwg/HOQdHmMUbCqOTyAH+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776018136; c=relaxed/simple;
	bh=NodZCqZW0PgvPg6CzvrNBUK3HBipxUXwUFQpvYOhnKA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fKfF4Sj07wHcTkEo3uBF59PL/w0DkGWeaYlbw2vbAWTn34gCnuCeHhsN2uXib/+3KqWk3wAUwOulN6zbcWRbifdafjQBpqDiKODhgIg4RvHXmfSFSw5HpPTDfAKzWISqAZNWl5gVr1kJBFvJJXCzYODUsVLJKZsB87DPGBIChqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H3rgrI5b; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H3rgrI5b"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C89FDC19424;
	Sun, 12 Apr 2026 18:22:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776018135;
	bh=NodZCqZW0PgvPg6CzvrNBUK3HBipxUXwUFQpvYOhnKA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=H3rgrI5bxPQbxXh9HpfF/ui1Lv4bYewQjvznNzZW/SZ7BaXv92wnoGcuZrV53ZXlz
	 6DcWifzhJR5/2vY+yH/T0z2PyT1mOYY0uXxnZSY7Ggo290d1F4I2MzledC+C4aXJeL
	 3KUbQnqzE6bmn1lfIQYuho3mYohWByrjs/LUskH+fw98AFBQ17i7QO2P9JO2Py8s0/
	 w18Yzvc9E/XGC1siiSgptJOOfmuNyEFFueY/u8OUBShvFWA3Jekwr1hlW68shkpFdB
	 XipPeGXXJwtLQejZ1KphfryCGRJo5r9Z2gwissdw5vM3vaW1qzBOXw5AYRxG7CXzVT
	 C1fTelPObUzRg==
Date: Sun, 12 Apr 2026 20:22:12 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Tommy Kelly <linux@tkel.ly>
Cc: dlemoal@kernel.org, linux-ide@vger.kernel.org,
	Igor Pylypiv <ipylypiv@google.com>
Subject: Re: [PATCH v2 0/2] ATA port deferred qc fixes
Message-ID: <advi1OGShxsjdrCL@ryzen>
References: <20260220221439.533771-1-dlemoal@kernel.org>
 <ce09cc21-a8e9-4845-b205-35411e22fba9@tkel.ly>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ce09cc21-a8e9-4845-b205-35411e22fba9@tkel.ly>

On Thu, Apr 02, 2026 at 02:22:49AM -0700, Tommy Kelly wrote:
> On 2/20/26 14:14, Damien Le Moal wrote:
> > The first patch addresses a use-after-free issue when a deferred qc
> > times out. The second patch avoids a call to a potentially sleeping
> > function while a port spinlock is held.
> > 
> > Changes from v1:
> >  - Corrected typo in patch 1 message, improved comment in code and added
> >    a WARN_ON_ONCE() call to verify that a timed out qc is not active.
> >  - Fixed patch 2 to not call ata_scsi_requeue_deferred_qc() without the
> >    port lock held. This call is in fact removed: it is not needed as
> >    ata_scsi_requeue_deferred_qc() is called in EH, which is always run
> >    when removing a port.
> > 
> > Damien Le Moal (2):
> >   ata: libata-eh: correctly handle deferred qc timeouts
> >   ata: libata-core: fix cancellation of a port deferred qc work
> > 
> >  drivers/ata/libata-core.c |  8 +++-----
> >  drivers/ata/libata-eh.c   | 22 +++++++++++++++++++---
> >  2 files changed, 22 insertions(+), 8 deletions(-)
> > 
> 
> 
> Hello, this is my first message on the LKML so please forgive me for
> likely not following etiquette.
> 
> I have what might be a regression from somewhere in the recent series of
> NCQ / QC patches.
> 
> I have a peculiar setup that might reveal the source of the bug. I'm
> using a SATA Port Multiplier (PMP), powered by JMB575, which expands 1
> SATA port to 5 drives.
> The device/driver/subsystem tree looks like rk3568-dwc-ahci -> scsi -> sda.
> The platform does not (yet) support FIS-Based Switching (FBS), so it is
> using Command-Based Switching (CBS). FBS support may land in Linux 7.1.
> 
> > kernel: ahci-dwc fc800000.sata: flags: ncq sntf pm led clo only pmp fbs pio slum part ccc apst
> > kernel: ahci-dwc fc800000.sata: port 0 is not capable of FBS
> 
> When switching from kernel 6.18.13 to 6.19.7, drive access became
> extremely slow, causing lock timeouts at the filesystem level. I solved
> the problem by changing /sys/block/sd*/device/queue_depth from 32 to 1.
> 
> I also looked through the recent LPM patches, but the drives'
> performance didn't improve after changing LPM settings for the scsi host
> in sysfs.
> 
> Let me know if I need to provide more details or logs. I can see
> COMRESET a lot in each device's SMART logs but they aren't timestamped
> so I haven't proved that they are recent. Perhaps the slow drive
> switching is causing command starvation.

Hello Tommy,

Igor recently found a bug in the deferred QC feature:
https://lore.kernel.org/linux-ide/20260412153637.475606-1-ipylypiv@google.com/

His fix patch has been queued up on libata/for-next, so perhaps you could try
the libata/for-next branch:
https://git.kernel.org/pub/scm/linux/kernel/git/libata/linux.git/log/?h=for-next

And see if you can still reproduce the problem there.


Kind regards,
Niklas
