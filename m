From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 13120] New: BUG: using rootfstype=ext4 causes oops
Date: Thu, 16 Apr 2009 23:39:43 GMT
Message-ID: <bug-13120-11633@http.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from demeter.kernel.org ([140.211.167.39]:57793 "EHLO
	demeter.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754667AbZDPXjo (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 16 Apr 2009 19:39:44 -0400
Received: from demeter.kernel.org (localhost.localdomain [127.0.0.1])
	by demeter.kernel.org (8.14.2/8.14.2) with ESMTP id n3GNdhlL010934
	for <linux-ide@vger.kernel.org>; Thu, 16 Apr 2009 23:39:43 GMT
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=13120

           Summary: BUG: using rootfstype=ext4 causes oops
           Product: IO/Storage
           Version: 2.5
    Kernel Version: 2.6.30-rc2
          Platform: All
        OS/Version: Linux
              Tree: Mainline
            Status: NEW
          Severity: normal
          Priority: P1
         Component: IDE
        AssignedTo: io_ide@kernel-bugs.osdl.org
        ReportedBy: rjw@sisk.pl
            Blocks: 13070
        Regression: Yes


Subject    : BUG: using rootfstype=ext4 causes oops
Submitter  : Andrew Price <andy@andrewprice.me.uk>
Date       : 2009-04-15 20:59
References : http://marc.info/?l=linux-kernel&m=123982932807371&w=4
Handled-By : Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Patch      : http://marc.info/?l=linux-kernel&m=123989762527684&w=4

This entry is being used for tracking a regression from 2.6.29.  Please don't
close it until the problem is fixed in the mainline.

-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are watching the assignee of the bug.
