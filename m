From: bugme-daemon@bugzilla.kernel.org
Subject: [Bug 12734] ide-iops.c insists on doing 80-wire check
Date: Wed, 18 Feb 2009 11:03:59 -0800 (PST)
Message-ID: <20090218190359.3CEEF108041@picon.linux-foundation.org>
References: <bug-12734-11633@http.bugzilla.kernel.org/>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:39626 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752745AbZBRTER (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 18 Feb 2009 14:04:17 -0500
Received: from picon.linux-foundation.org (picon.linux-foundation.org [140.211.169.79])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id n1IJ3xM3017198
	for <linux-ide@vger.kernel.org>; Wed, 18 Feb 2009 11:04:00 -0800
In-Reply-To: <bug-12734-11633@http.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=12734


bzolnier@gmail.com changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
         AssignedTo|io_ide@kernel-bugs.osdl.org |bzolnier@gmail.com
             Status|NEW                         |ASSIGNED




------- Comment #4 from bzolnier@gmail.com  2009-02-18 11:03 -------
There is no way to detect 80-wires cable for CF cards and some hosts don't
implement host-side cable detection so this is not really a kernel bug.

[ Please try using "ide_core.ignore_cable=[interface_number]" boot option
  to override the cable detection ("ide_core.ignore_cable=0" for /dev/hda). ]


-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are the assignee for the bug, or are watching the assignee.
You are the assignee for the bug, or are watching the assignee.
