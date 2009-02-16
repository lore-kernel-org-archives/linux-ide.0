From: bugme-daemon@bugzilla.kernel.org
Subject: [Bug 12714] [pata_ali] ATAPI UltraDMA on secondary channel broken
Date: Sun, 15 Feb 2009 16:51:31 -0800 (PST)
Message-ID: <20090216005131.4E57010803F@picon.linux-foundation.org>
References: <bug-12714-11633@http.bugzilla.kernel.org/>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:59075 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755570AbZBPAve (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 15 Feb 2009 19:51:34 -0500
Received: from picon.linux-foundation.org (picon.linux-foundation.org [140.211.169.79])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id n1G0pVlF020858
	for <linux-ide@vger.kernel.org>; Sun, 15 Feb 2009 16:51:32 -0800
In-Reply-To: <bug-12714-11633@http.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=12714


akpm@osdl.org changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
         AssignedTo|io_ide@kernel-bugs.osdl.org |alan@lxorguk.ukuu.org.uk
          Component|IDE                         |Serial ATA
         Regression|0                           |1




------- Comment #1 from akpm@osdl.org  2009-02-15 16:51 -------
Reassigned to sata/pata, marked as a regression.


-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are the assignee for the bug, or are watching the assignee.
You are the assignee for the bug, or are watching the assignee.
