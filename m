From: Joseph Harvell <jharvell@dogpad.net>
Subject: corruption problem with 2.6.10 patch for Promise SATAII TX4
Date: Tue, 08 Mar 2005 08:58:07 -0600
Message-ID: <422DBD7F.9030500@dogpad.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Received: from dingo.dogpad.net ([65.70.180.33]:10115 "EHLO dingo.dogpad.net")
	by vger.kernel.org with ESMTP id S261389AbVCHPAU (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 8 Mar 2005 10:00:20 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: greve@fsfeurope.org, jgarzik@pobox.com, linux-ide@vger.kernel.org

A couple of months ago I grabbed Georg's patch from his 2004.12.28 post to linux-ide
(http://marc.theaimsgroup.com/?l=linux-ide&m=110426005503319&w=2).  I partitioned the disk,
created logical volumes and filesystems and copied my OS into it from a utility boot environment.

This all worked just fine, but when I started my first kernel build, the ext3 filesystem code
in the kernel found an inconsistency and remounted the filesystem read only.  When I ran e2fsck,
it found errors.  I copied out the data, re-created the filesystem and copied back in.  As soon as I
tried to build the kernel again the same thing happened again.  I tried several times and
could never get a clean build.  I also think I remember seeing complaints in syslog about some of
the other filesystems.

I ended up downgrading the kernel to the latest 2.4 and am currently using the Promise driver
(source code version since I'm running Gentoo).

If Jeff's recent contribution to the 2.6.11 kernel is based on this driver, I think others may have
similar problems.  In my case I had a copy of all my data to revert to.  But if the error had taken
much longer to manifest I probably would not have had the backup anymore.

I wonder if Promise would give permission for someone to port their driver to 2.6 and include it in
the official kernel source tree?  I made a feeble attempt to port it (mostly integrating with kbuild),
but I saw a traceback when the module loaded and I decided not to go any further.

---
Joe Harvell

