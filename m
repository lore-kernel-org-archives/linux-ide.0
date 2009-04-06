From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 13026] New: cs5536 is broken
Date: Mon, 6 Apr 2009 20:34:21 GMT
Message-ID: <bug-13026-11633@http.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from demeter.kernel.org ([140.211.167.39]:58163 "EHLO
	demeter.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752630AbZDFUeX (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 6 Apr 2009 16:34:23 -0400
Received: from demeter.kernel.org (localhost.localdomain [127.0.0.1])
	by demeter.kernel.org (8.14.2/8.14.2) with ESMTP id n36KYL9F007092
	for <linux-ide@vger.kernel.org>; Mon, 6 Apr 2009 20:34:21 GMT
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=13026

           Summary: cs5536 is broken
           Product: IO/Storage
           Version: 2.5
    Kernel Version: 2.6.29.1
          Platform: All
        OS/Version: Linux
              Tree: Mainline
            Status: NEW
          Severity: normal
          Priority: P1
         Component: IDE
        AssignedTo: io_ide@kernel-bugs.osdl.org
        ReportedBy: rjw@sisk.pl
            Blocks: 12398
        Regression: No


Subject    : 2.6.29.1 BUG: unable to handle kernel NULL pointer dereference at
(null)
Submitter  : Arnd Hannemann <hannemann@nets.rwth-aachen.de>
Date       : 2009-04-06 18:11
References : http://marc.info/?l=linux-kernel&m=123904159829771&w=4
Handled-By : Sergei Shtylyov <sshtylyov@ru.mvista.com>
Patch      : http://marc.info/?l=linux-kernel&m=123904273731477&w=4

This entry is being used for tracking a regression from 2.6.28.  Please don't
close it until the problem is fixed in the mainline.

-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are watching the assignee of the bug.
