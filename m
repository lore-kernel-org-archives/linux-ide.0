From: Christopher Lansdown <chris@powerblogs.com>
Subject: sata spindown
Date: Mon, 7 Nov 2005 17:05:05 -0500
Message-ID: <20051107220452.GD25098@chrislansdown.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from kitsune.onegeek.org ([207.44.199.176]:36757 "EHLO
	highsorcery.com") by vger.kernel.org with ESMTP id S964937AbVKGWFl
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 7 Nov 2005 17:05:41 -0500
Received: from localhost.localdomain (cpe-24-59-194-226.twcny.res.rr.com [24.59.194.226])
	by highsorcery.com (Postfix) with ESMTP id DF98A10E1F6
	for <linux-ide@vger.kernel.org>; Mon,  7 Nov 2005 17:05:31 -0500 (EST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hi,

Having a laptop with a SATA hard drive (with an intel ICH6M chipset), I've
been trying to find out the status both of spindown (a la 'hdparm -S') and
suspend/resume. Suspend/resume I've come to find out that Randy Dunlap is
working on (and I'm looking forward to being able to help out with testing
the patch when he posts it here).

So this leaves automatic inactivity spindown. Now, I did track down that in
recent kernels, one can do 'sdparm -C stop' to cause the drive to spin down
immediately, but this isn't a (direct) replacement for the IDE standby
timeout.

So I'm writing to inquire if this ability currently exists, or if not, if
anyone is working on it and, if so, if I can be of help with testing
patches. I'm a programmer and know a little bit about kernel drivers, though
I have no experience with scsi or ide drivers.

Thanks,
Chris Lansdown

-- 
"Let us endeavor so to live that when we come to die even the undertaker 
will be sorry."  -- Mark Twain, "Pudd'nhead Wilson's Calendar"
========== Evil Overlord Quote of the Day (www.eviloverlord.com) =========
222. I reserve the right to execute any henchmen who appear to be a little
too intelligent, powerful, or devious. However if I do so, I will not
at some subsequent point shout "Why am I surrounded by these
incompetent fools?!" 
