From: Tejun Heo <tj@kernel.org>
Subject: Re: Frozen drives when using SiI3726
Date: Mon, 29 Dec 2008 18:13:15 +0900
Message-ID: <495894AB.8010404@kernel.org>
References: <20E60A0E-48E9-4942-851D-E20C012F5B89@ibink.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:34542 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752687AbYL2JNW (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 29 Dec 2008 04:13:22 -0500
In-Reply-To: <20E60A0E-48E9-4942-851D-E20C012F5B89@ibink.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tim Nufire <linux_ide_tim@ibink.com>
Cc: linux-ide@vger.kernel.org

Hi,

Tim Nufire wrote:
> Hello,
> 
> I'm building a server using 9 SiI3726 based port multiplier backplanes
> connected to cards using SiI3132 (PCI Express) and SiI3124 (PCI). The
> drives are configured into 5 RAID6 groups of 9 drives each such that
> each array has 1 drive from each backplane. During the initial RAID
> synchronization one of the backplanes failed and restarted (see dmesg
> output below). While this did not disrupt the RAID groups this time, the
> reset took about 25 seconds and could easily have caused one or more
> drives to fail.
> 
> Is there anything I can do to prevent failures like this?

The reset was triggered by a timeout which probably have taken around
or more than 30 secs, so the array probably experienced disruption
which is about a minute long.  The failure latency is a bit
unfortunate at the moment.  :-(

Also, the timeout is one of the most generic failure mode there is.
It can be triggered by virtually anything including transmission
failure, power quality issues, drive problems and whatnot.  So, it's
impossible to tell what went wrong with the provided information.  It
could be an one-time fluke - e.g. bad sectors which developed during
storage and shipping and RAID sync makes the firmware think what to do
about it for a long time - or something more systematic -
e.g. slightly bad connection on the backplane side or sub-par power
which slightly chokes when all drives are pulling juice out of it.

Unfortunately, the only way to debug would be keeping an eye on
whether such failures repeat and if so when and where - whether it
always happen on the same chassis, slot or drive (by exchaning
drives), etc...

Please let us know when you find out more.

Happy new year.

-- 
tejun
