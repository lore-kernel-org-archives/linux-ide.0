From: bugme-daemon@bugzilla.kernel.org
Subject: [Bug 11742] Device buffer on a DVD multi standard writer runs out burning a CD
Date: Thu, 16 Oct 2008 01:54:41 -0700 (PDT)
Message-ID: <20081016085441.ECECA108040@picon.linux-foundation.org>
References: <bug-11742-11633@http.bugzilla.kernel.org/>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:47018 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753166AbYJPIzO (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 16 Oct 2008 04:55:14 -0400
Received: from picon.linux-foundation.org (picon.linux-foundation.org [140.211.169.79])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m9G8sgJL021699
	for <linux-ide@vger.kernel.org>; Thu, 16 Oct 2008 01:54:43 -0700
In-Reply-To: <bug-11742-11633@http.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=11742





------- Comment #14 from valerio.p@libero.it  2008-10-16 01:54 -------
I have blacklisted piix in Debian and so scsi emulation has been activated
instead of "native" ide-cd (a couple of errors at boot time, but nothing
serious). Thus the drive is listed as /dev/scd0 instead of /dev/hda
The result is that burning a CD in simulation and real mode produces no buffer
under runs. :)
Now that we have found who is guilty, what are we going to do next?


-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are the assignee for the bug, or are watching the assignee.
