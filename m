From: bugme-daemon@bugzilla.kernel.org
Subject: [Bug 10943] machine doesn't shutdown when ahci sata driver is compiled as module
Date: Fri, 27 Jun 2008 07:34:23 -0700 (PDT)
Message-ID: <20080627143423.23B35108045@picon.linux-foundation.org>
References: <bug-10943-11633@http.bugzilla.kernel.org/>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:58070 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754865AbYF0OeZ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 27 Jun 2008 10:34:25 -0400
Received: from picon.linux-foundation.org (picon.linux-foundation.org [140.211.169.79])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m5REYNnX030450
	for <linux-ide@vger.kernel.org>; Fri, 27 Jun 2008 07:34:24 -0700
In-Reply-To: <bug-10943-11633@http.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=10943





------- Comment #8 from gfpadovan@gmail.com  2008-06-27 07:34 -------
 Are you sure it's a kernel problem?
I think that for system doesn't mind if ahci is built-in or module. So the
problem must be on kernel.

Does "halt -f" work?
No. The kernel says:
md:stopping all md drivers
sd 1:0:0:0: [sdb] Synchronizing SCSI cache
sd 1:0:0:0: [sdb] Stopping disk

These are the last words of kernel. And the machine stay on.


-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are on the CC list for the bug, or are watching someone who is.
