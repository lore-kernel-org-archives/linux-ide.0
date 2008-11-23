From: bugme-daemon@bugzilla.kernel.org
Subject: [Bug 10216] kernel from different versions hangs with some CD/DVD drives
Date: Sun, 23 Nov 2008 04:12:31 -0800 (PST)
Message-ID: <20081123121231.1E59E10800C@picon.linux-foundation.org>
References: <bug-10216-11633@http.bugzilla.kernel.org/>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:52576 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756102AbYKWMMd (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 23 Nov 2008 07:12:33 -0500
Received: from picon.linux-foundation.org (picon.linux-foundation.org [140.211.169.79])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id mANCCVTj023277
	for <linux-ide@vger.kernel.org>; Sun, 23 Nov 2008 04:12:32 -0800
In-Reply-To: <bug-10216-11633@http.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=10216


lars.winterfeld@tu-ilmenau.de changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
             Status|NEW                         |RESOLVED
         Resolution|                            |PATCH_ALREADY_AVAILABLE




------- Comment #10 from lars.winterfeld@tu-ilmenau.de  2008-11-23 04:12 -------
you are my hero! ;-)
it worked. i tried it with the original source of linux-2.6.25.9
without the patch the described problem appears, with the patch (and nothing
else changed) the kernel boots just fine, /dev/cdrom gets created and i can
read files from it.
i'm now going to attach some files (dmesg, maybe from other kernel versions,
etc.) just for references...
i think, afterwords you can mark this bug as closed or resolved...
would like to see this in the next kernel version... :-)


-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are the assignee for the bug, or are watching the assignee.
