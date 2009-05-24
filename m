From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 13371] New: s2disk hangs with kernel 2.6.29 and later, SATA,
 Gigabyte EG45M-DS2H
Date: Sun, 24 May 2009 20:29:38 GMT
Message-ID: <bug-13371-11633@http.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from demeter.kernel.org ([140.211.167.39]:42554 "EHLO
	demeter.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751820AbZEXU3g (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 24 May 2009 16:29:36 -0400
Received: from demeter.kernel.org (localhost.localdomain [127.0.0.1])
	by demeter.kernel.org (8.14.2/8.14.2) with ESMTP id n4OKTc6L003301
	for <linux-ide@vger.kernel.org>; Sun, 24 May 2009 20:29:38 GMT
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=13371

           Summary: s2disk hangs with kernel 2.6.29 and later, SATA,
                    Gigabyte EG45M-DS2H
           Product: IO/Storage
           Version: 2.5
    Kernel Version: 2.6.29
          Platform: All
        OS/Version: Linux
              Tree: Mainline
            Status: NEW
          Severity: normal
          Priority: P1
         Component: IDE
        AssignedTo: io_ide@kernel-bugs.osdl.org
        ReportedBy: rjw@sisk.pl
            Blocks: 7216,13070
        Regression: Yes


Subject    : s2disk hangs with kernel >=2.6.29, SATA, Gigabyte EG45M-DS2H
(bisected)
Submitter  : Richard Atterer <richard@2009.atterer.net>
Date       : 2009-05-16 22:51
References : http://marc.info/?l=linux-kernel&m=124251446428166&w=4
Handled-By : Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

Caused by:

commit 295f00042aaf6b553b5f37348f89bab463d4a469
Author: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Date:   Fri Jan 2 16:12:48 2009 +0100

    ide: don't execute the next queued command from the hard-IRQ context (v2)

First-Bad-Commit : 295f00042aaf6b553b5f37348f89bab463d4a469

This entry is being used for tracking a regression from 2.6.28.  Please don't
close it until the problem is fixed in the mainline.

-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are watching the assignee of the bug.
