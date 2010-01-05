From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 7735] DriveReady SeekComplete Error every 5 minutes by plextor
 CD-R/RW 40/12/40A
Date: Tue, 5 Jan 2010 17:15:30 GMT
Message-ID: <201001051715.o05HFU9k017272@demeter.kernel.org>
References: <bug-7735-11633@http.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from demeter.kernel.org ([140.211.167.39]:43003 "EHLO
	demeter.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754986Ab0AERPb (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 5 Jan 2010 12:15:31 -0500
Received: from demeter.kernel.org (localhost.localdomain [127.0.0.1])
	by demeter.kernel.org (8.14.3/8.14.2) with ESMTP id o05HFUDT017273
	for <linux-ide@vger.kernel.org>; Tue, 5 Jan 2010 17:15:30 GMT
In-Reply-To: <bug-7735-11633@http.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=7735


Bartlomiej Zolnierkiewicz <bzolnier@gmail.com> changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
         AssignedTo|bzolnier@gmail.com          |io_ide@kernel-bugs.osdl.org
         Regression|---                         |No




--- Comment #28 from Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>  2010-01-05 17:15:12 ---
I traced it to the smartctl misbehavior (which tries IDENTIFY on ATAPI when it
shouldn't).  Can be closed as 'not a kernel bug'..

-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are watching the assignee of the bug.
