From: bugme-daemon@bugzilla.kernel.org
Subject: [Bug 10239] PLEXTOR DVDR PX-740A drive not ready for command
Date: Sun, 16 Mar 2008 07:02:35 -0700 (PDT)
Message-ID: <20080316140235.5FBBA108066@picon.linux-foundation.org>
References: <bug-10239-11633@http.bugzilla.kernel.org/>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:44263 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751832AbYCPOCh (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 16 Mar 2008 10:02:37 -0400
Received: from picon.linux-foundation.org (picon.linux-foundation.org [140.211.169.79])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m2GE3dtB015595
	for <linux-ide@vger.kernel.org>; Sun, 16 Mar 2008 07:03:40 -0700
In-Reply-To: <bug-10239-11633@http.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=10239





------- Comment #7 from bzolnier@gmail.com  2008-03-16 07:02 -------
Thanks.

I've rechecked with the known ATAPI errata but so far I don't see a reason for
drive getting stuck - I wonder whether it could be controller related.

Could you try using ide_pci_generic driver instead of amd74xx (you need to
disable CONFIG_BLK_DEV_AMD74XX, enable CONFIG_BLK_DEV_GENERIC and boot kernel
with "ide_pci_generic.all_generic_ide" option) and see if it helps?


-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are the assignee for the bug, or are watching the assignee.
