From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: libata: implement on-demand HPA unlocking
Date: Wed, 9 Feb 2011 15:37:14 +0000
Message-ID: <20110209153714.558133d7@lxorguk.ukuu.org.uk>
References: <4D51A648.20707@cfl.rr.com>
	<20110209085935.GE6558@htj.dyndns.org>
	<4D52B0B3.40900@cfl.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:60000 "EHLO
	localhost.localdomain" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751563Ab1BIPdv (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 9 Feb 2011 10:33:51 -0500
In-Reply-To: <4D52B0B3.40900@cfl.rr.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Phillip Susi <psusi@cfl.rr.com>
Cc: Tejun Heo <tj@kernel.org>, Ben Hutchings <ben@decadent.org.uk>, Jeff Garzik <jgarzik@redhat.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

> better solution because aside from the problems it causes to fakeraid,
> unlocking the HPA defies the relevant standards and will trash whatever

Unlocking the HPA is actually necessary for sanity on a lot of systems
too, and there are really no standards. Remember the primary use of HPA
has actually been to hide most of the disk from buggy BIOSen so that the
OS can then unlock it after the BIOS has stopped looking.

> data the bios is storing there, which is not good either.  Hence why I
> am in favor of the idea of only unlocking the HPA if it is clear that
> the disk was partitioned with a previously broken kernel and so it must

We cannot create a situation where any system that now unlocks the HPA
ceases to do so, that breaks back compat in a potentially catastrophic
way.

> be unlocked to access existing user data.  That is why I like this
> commit, but it misses the mark in raid situations where the MBR is
> visible on the raw disk, but really is supposed to apply to the whole raid.

Probably the fakeraid layers need a way to see the geometry reported
before unlock, then they can make their own decisions. The lock/unlock in
hardware is just a hardware hack. We can still do the unlocking of
hardware and using whatever values we choose in software at different
points.

"Should we unlock" is almost an academic debate given we are the OS and
control the commands sent to the drive anyway.

Alan
