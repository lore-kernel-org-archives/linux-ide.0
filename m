From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 13663] New: suspend to ram regression (IDE related)
Date: Sun, 28 Jun 2009 22:57:16 GMT
Message-ID: <bug-13663-11633@http.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from demeter.kernel.org ([140.211.167.39]:37348 "EHLO
	demeter.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752261AbZF1W5N (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 28 Jun 2009 18:57:13 -0400
Received: from demeter.kernel.org (localhost.localdomain [127.0.0.1])
	by demeter.kernel.org (8.14.2/8.14.2) with ESMTP id n5SMvG2k022958
	for <linux-ide@vger.kernel.org>; Sun, 28 Jun 2009 22:57:16 GMT
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=13663

           Summary: suspend to ram regression (IDE related)
           Product: IO/Storage
           Version: 2.5
    Kernel Version: 2.6.30
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


Subject    : [REGRESSION] 2.6.29=>2.6.30 suspend to ram regression (IDE
related)
Submitter  : Etienne Basset <etienne.basset@numericable.fr>
Notify-Also : Jeff Chua <jeff.chua.linux@gmail.com>
Date       : 2009-06-26 17:40
References : http://lkml.org/lkml/2009/6/26/242
Handled-By : Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Patch      : http://patchwork.kernel.org/patch/32719/

This entry is being used for tracking a regression from 2.6.29.  Please don't
close it until the problem is fixed in the mainline.

-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are watching the assignee of the bug.
