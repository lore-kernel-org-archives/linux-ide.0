From: bugme-daemon@bugzilla.kernel.org
Subject: [Bug 11732] Oops while mounting a DVD-ROM
Date: Wed, 15 Oct 2008 16:01:06 -0700 (PDT)
Message-ID: <20081015230106.AA9FA108056@picon.linux-foundation.org>
References: <bug-11732-11633@http.bugzilla.kernel.org/>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:53256 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753370AbYJOXBk (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 15 Oct 2008 19:01:40 -0400
Received: from picon.linux-foundation.org (picon.linux-foundation.org [140.211.169.79])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m9FN1869018503
	for <linux-ide@vger.kernel.org>; Wed, 15 Oct 2008 16:01:09 -0700
In-Reply-To: <bug-11732-11633@http.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=11732


tglx@linutronix.de changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |axboe@kernel.dk
         AssignedTo|platform_x86_64@kernel-     |io_ide@kernel-bugs.osdl.org
                   |bugs.osdl.org               |




------- Comment #6 from tglx@linutronix.de  2008-10-15 16:01 -------
> IDE gets arguments for dma_map_sg() from blk_rq_map_sg() so everything should
> be sweet...

Adding Jens to the mix :)


-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are the assignee for the bug, or are watching the assignee.
