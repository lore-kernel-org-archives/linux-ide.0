From: bugme-daemon@bugzilla.kernel.org
Subject: [Bug 10296] System freezes after I/O on pata_jmicron device
Date: Fri, 21 Mar 2008 03:13:26 -0700 (PDT)
Message-ID: <20080321101326.C980F11D109@picon.linux-foundation.org>
References: <bug-10296-11633@http.bugzilla.kernel.org/>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:41916 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753186AbYCUKN3 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 21 Mar 2008 06:13:29 -0400
Received: from picon.linux-foundation.org (picon.linux-foundation.org [140.211.169.79])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m2LADQ1r011493
	for <linux-ide@vger.kernel.org>; Fri, 21 Mar 2008 03:13:28 -0700
In-Reply-To: <bug-10296-11633@http.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=10296


bunk@kernel.org changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |bunk@kernel.org
         AssignedTo|io_ide@kernel-bugs.osdl.org |jgarzik@pobox.com
          Component|IDE                         |Serial ATA
         Regression|0                           |1




-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are the assignee for the bug, or are watching the assignee.
You are the assignee for the bug, or are watching the assignee.
