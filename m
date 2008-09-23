From: bugme-daemon@bugzilla.kernel.org
Subject: [Bug 11602] cdrom drive cannot open the tray, but reported this badly in /proc/sys/dev/cdrom/info
Date: Tue, 23 Sep 2008 06:56:08 -0700 (PDT)
Message-ID: <20080923135610.69543108057@picon.linux-foundation.org>
References: <bug-11602-11633@http.bugzilla.kernel.org/>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:60474 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756465AbYIWN4b (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 23 Sep 2008 09:56:31 -0400
Received: from picon.linux-foundation.org (picon.linux-foundation.org [140.211.169.79])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m8NDuAwY015419
	for <linux-ide@vger.kernel.org>; Tue, 23 Sep 2008 06:56:11 -0700
In-Reply-To: <bug-11602-11633@http.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=11602


bbpetkov@yahoo.de changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
         AssignedTo|io_ide@kernel-bugs.osdl.org |bbpetkov@yahoo.de
             Status|NEW                         |ASSIGNED




------- Comment #7 from bbpetkov@yahoo.de  2008-09-23 06:56 -------
Hi,

can you please try the following quick'n'dirty fix to see whether it fixes the
problem for you?

Thanks.


-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are the assignee for the bug, or are watching the assignee.
You are the assignee for the bug, or are watching the assignee.
