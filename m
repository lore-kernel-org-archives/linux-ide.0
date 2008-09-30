From: Tejun Heo <tj@kernel.org>
Subject: better solution for frequent head unload problem
Date: Wed, 01 Oct 2008 02:58:45 +0900
Message-ID: <48E268D5.2090709@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:42189 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752061AbYI3SAy (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 30 Sep 2008 14:00:54 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bruce Allen <ballen@gravity.phys.uwm.edu>, IDE/ATA development list <linux-ide@vger.kernel.org>
Cc: Robert Krawitz <rlk@alum.mit.edu>, Carlos Bessa <carlos.bessa@gmail.com>, aladin7501-01@yahoo.de, webmaster@dragontower.de, "Ivan N. Zlatev" <contact@i-nz.net>, aliencoder@gmail.com, pascal@asmodeus.be, andrew.vaselaar@trinity.edu"Ivan N. Zlatev" <contact@i-nz.net>, aklitzing@online.de, Christian Wolf <wolfchri@gmail.com>

Hello, Bruce and cc'd reporters.

I'm having a second thought about storage-fixup as solution for frequent
head unload problem.  Initially, I thought there would be only a handful
of affected machines but it doesn't look like that anymore and
storage-fixup is too inflexible.

IMHO, this can be best dealt with by smartd if it can do the followings.

* smartd knows about most drive families - their l/ul limits and which
value to use to disable APM.

* it monitors u/ul limits and if the load count increases fast enough
that the drive reaches the limit before 1.5 years of uptime (or some
other value), it warns and automatically disables APM.

By doing the above, we don't have to maintain list of combinations of
system and harddrives which can never be complete and later when the
disk workload becomes different due to FS or VM changes, the powersaving
feature can be left enabled.

Obstacles are...

* How to build rather complete SMART database?  I think vendor
cooperation is necessary.  If we can work out something, it will also
improve general usefulness of SMART.

* Making distros enable smartd by default.  smartd might need a bit of
adjustment but I think this shouldn't be too difficult.

What do you think?

Till we can figure out something, I'll keep building storage-fixup.conf.

Thanks.

-- 
tejun
