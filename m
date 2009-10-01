From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 14294] New: kernel BUG at drivers/ide/ide-disk.c:187
Date: Thu, 1 Oct 2009 21:54:27 GMT
Message-ID: <bug-14294-11633@http.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from demeter.kernel.org ([140.211.167.39]:54843 "EHLO
	demeter.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752235AbZJAVyX (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 1 Oct 2009 17:54:23 -0400
Received: from demeter.kernel.org (localhost.localdomain [127.0.0.1])
	by demeter.kernel.org (8.14.2/8.14.2) with ESMTP id n91LsRh6009546
	for <linux-ide@vger.kernel.org>; Thu, 1 Oct 2009 21:54:27 GMT
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=14294

           Summary: kernel BUG at drivers/ide/ide-disk.c:187
           Product: IO/Storage
           Version: 2.5
    Kernel Version: 2.6.31
          Platform: All
        OS/Version: Linux
              Tree: Mainline
            Status: NEW
          Severity: normal
          Priority: P1
         Component: IDE
        AssignedTo: io_ide@kernel-bugs.osdl.org
        ReportedBy: rjw@sisk.pl
            Blocks: 13615
        Regression: Yes


Subject    : kernel BUG at drivers/ide/ide-disk.c:187 (2.6.31)
Submitter  : Santiago Garcia Mantinan <manty@manty.net>
Date       : 2009-09-30 11:05
References : http://marc.info/?l=linux-kernel&m=125430926311466&w=4
Handled-By : David Miller <davem@davemloft.net>
Notify-Also : Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

This entry is being used for tracking a regression from 2.6.30.  Please don't
close it until the problem is fixed in the mainline.

-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are watching the assignee of the bug.
