From: bugme-daemon@bugzilla.kernel.org
Subject: [Bug 10723] linux 2.6.24 fails to mount ext3 rootfs on FUJITSU MHK2060AT
Date: Wed, 28 May 2008 15:13:52 -0700 (PDT)
Message-ID: <20080528221352.91BED108047@picon.linux-foundation.org>
References: <bug-10723-11633@http.bugzilla.kernel.org/>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:44450 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753389AbYE1WOY (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 28 May 2008 18:14:24 -0400
Received: from picon.linux-foundation.org (picon.linux-foundation.org [140.211.169.79])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m4SMDqS5029619
	for <linux-ide@vger.kernel.org>; Wed, 28 May 2008 15:13:53 -0700
In-Reply-To: <bug-10723-11633@http.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=10723


bzolnier@gmail.com changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
         AssignedTo|io_ide@kernel-bugs.osdl.org |bzolnier@gmail.com
             Status|NEW                         |ASSIGNED




------- Comment #10 from bzolnier@gmail.com  2008-05-28 15:13 -------
Could you please send output of "lspci -s 14.0 -vvv -xxx" command for good and
bad kernel?

Also please verify that booting good kernel with "hda=autotune" reproduces a
bug.

Thanks.


-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are the assignee for the bug, or are watching the assignee.
You are the assignee for the bug, or are watching the assignee.
