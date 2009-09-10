From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 13399] kernel crash SONY DVD-ROM with cd
Date: Thu, 10 Sep 2009 13:20:36 GMT
Message-ID: <200909101320.n8ADKaN4018172@demeter.kernel.org>
References: <bug-13399-11633@http.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from demeter.kernel.org ([140.211.167.39]:59601 "EHLO
	demeter.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754256AbZIJWEY (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 10 Sep 2009 18:04:24 -0400
Received: from demeter.kernel.org (localhost.localdomain [127.0.0.1])
	by demeter.kernel.org (8.14.2/8.14.2) with ESMTP id n8AM4692021183
	for <linux-ide@vger.kernel.org>; Thu, 10 Sep 2009 22:04:27 GMT
In-Reply-To: <bug-13399-11633@http.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=13399





--- Comment #50 from David Woodhouse <dwmw2@infradead.org>  2009-09-10 13:19:47 ---
More useful backtrace at http://david.woodhou.se/cimg2780.jpg

It looks like hwif->rq is NULL when ide_complete_rq() runs.  And then it oopses
when looking at rq->cmd_flags.

If I put in a quick hack to avoid calling id_complete_rq() if !drive->hwif->rq,
then it no longer oopses. I get this:

[ 1091.428321] would oops. rq->bio (null)
[ 1091.428323] hdb: request sense failure: status=0x51 { DriveReady
SeekComplete Error }
[ 1091.428329] hdb: request sense failure: error=0x20 { LastFailedSense=0x02 }
[ 1091.428332] hdb: possibly failed opcode: 0xa0

-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are watching the assignee of the bug.
