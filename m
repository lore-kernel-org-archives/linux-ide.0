From: bugme-daemon@bugzilla.kernel.org
Subject: [Bug 10803] Kernel freeze on accesing CD-ROM or HDD
Date: Thu, 29 May 2008 13:39:01 -0700 (PDT)
Message-ID: <20080529203901.91E4B108060@picon.linux-foundation.org>
References: <bug-10803-11633@http.bugzilla.kernel.org/>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:42739 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751585AbYE2Uj2 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 29 May 2008 16:39:28 -0400
Received: from picon.linux-foundation.org (picon.linux-foundation.org [140.211.169.79])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m4TKd1jI022392
	for <linux-ide@vger.kernel.org>; Thu, 29 May 2008 13:39:02 -0700
In-Reply-To: <bug-10803-11633@http.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=10803


bzolnier@gmail.com changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
         AssignedTo|io_ide@kernel-bugs.osdl.org |bzolnier@gmail.com
             Status|NEW                         |ASSIGNED




------- Comment #4 from bzolnier@gmail.com  2008-05-29 13:39 -------
Please try to reproduce it without proprietary module - Alan and Roland
correctly suggest that it may be the root cause of the problem.

PS your system uses pata_via driver (part of libata SCSI->ATA layer) for IDE
support so I'm changing the component to libata


-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are the assignee for the bug, or are watching the assignee.
You are the assignee for the bug, or are watching the assignee.
