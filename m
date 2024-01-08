Received: from vps.thesusis.net (vps.thesusis.net [34.202.238.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D533E44C7E
	for <linux-ide@vger.kernel.org>; Mon,  8 Jan 2024 13:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thesusis.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thesusis.net
Received: by vps.thesusis.net (Postfix, from userid 1000)
	id F3BE61524D1; Mon,  8 Jan 2024 08:27:32 -0500 (EST)
From: Phillip Susi <phill@thesusis.net>
To: Damien Le Moal <dlemoal@kernel.org>, linux-ide@vger.kernel.org
Cc: Sergey Shtylyov <s.shtylyov@omp.ru>
Subject: Re: [PATCH 1/3] libata: avoid waking disk for several commands
In-Reply-To: <f6110204-338d-42b5-8ec2-153dd862e799@kernel.org>
References: <87msthdo11.fsf@vps.thesusis.net>
 <20240107180258.360886-1-phill@thesusis.net>
 <20240107180258.360886-2-phill@thesusis.net>
 <f6110204-338d-42b5-8ec2-153dd862e799@kernel.org>
Date: Mon, 08 Jan 2024 08:27:32 -0500
Message-ID: <878r50uf97.fsf@vps.thesusis.net>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Damien Le Moal <dlemoal@kernel.org> writes:

> sleep and standby are different power states. So saying that a disk that is
> sleeping is in standby does not make sense. And if you wake up a drive from

There is no way to answer CHECK POWER MODE and say the drive is in
sleep.  It can only be either active, or standby, so standby is the
closest fit.  At least it gets smartd and udisks2 to leave the drive
alone.

> The problem here is that ATA_DFLAG_SLEEPING is a horrible hack to not endup with
> lots of timeout failures if the user execute "hdparm -Y". Executing such
> passthrough command with a disk being used by an FS (for instance) is complete
> nonsense and should not be done.

I'm not sure what you propose be done instead.  Regardless, this is how
it has always been done, so I don't think there is any changing it now.
You also have the legacy standby timer that is exposed to users through
udisks2/gnome-disk-utility that still has to be supported.

> So I would rather see this handled correctly, through the kernel pm runtime
> suspend/resume:

I'd eventually like to as well, but it should also work in kernels that
aren't built with runtime pm enabled.

> Now, the annoying thing is the drive being randomly woken-up due to commands
> being issued, like the ones you mention. This is indeed bad, and seeing news
> like this:
>
> https://www.phoronix.com/news/Linux-PM-Regulatory-Bugs
>
> I think we really should do better...

That sounds like broken firmware to me.  When you ask the firmware to
power off the system, it should really be powered off.

> For FSes issued commands like flush, these are generally not random at all. If
> you see them appearing randomly, then there is a problem with the FS and
> patching the FS may be needed. Beside flush, there are other things to
> consider

I'm not sure the filesystem maintainers will see it that way.  They
generally issue barriers as part of a commit at regular intervals, and
that gets turned into FLUSH CACHE.  Also the kernel issues one during
system suspend, and I think that happens even if no filesystem is
mounted.  I think systemd also issues a sync() during shutdown, which
would wake up a sleeping disk only to shut down.

I don't think it is up to all of these other sources to be patched to
avoid this.  libata knows the disk is in sleep mode, so that is the
place to handle it.

> here. Ex: FSes using zoned block devices (SMR disks) doing garbage collection
> while idle. We cannot prevent this from happening, which is why I seriously
> dislike the idea of faking any command for a sleeping disk.

I don't see the connection.  If the FS issues IO in the background, the
disk will wake up, just like it does when in standby.  The faking of the
commands simply replicates the behavior you get from standby in sleep
mode.  With this patch, as far as anyone can tell, a sleeping disk is
exactly the same as one in standby.
