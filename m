From: bugme-daemon@bugzilla.kernel.org
Subject: [Bug 11635] strange message in dmesg for IDE HDD: cannot use LBA48 DMA - PIO mode will be used for accessing sectors > 268435456
Date: Wed, 24 Sep 2008 03:27:03 -0700 (PDT)
Message-ID: <20080924102703.DB4BD10805A@picon.linux-foundation.org>
References: <bug-11635-11633@http.bugzilla.kernel.org/>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:43445 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751359AbYIXK1w (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 24 Sep 2008 06:27:52 -0400
Received: from picon.linux-foundation.org (picon.linux-foundation.org [140.211.169.79])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m8OAR3nJ001169
	for <linux-ide@vger.kernel.org>; Wed, 24 Sep 2008 03:27:04 -0700
In-Reply-To: <bug-11635-11633@http.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=11635


alan@lxorguk.ukuu.org.uk changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
             Status|NEW                         |REJECTED
         Resolution|                            |WILL_NOT_FIX




------- Comment #2 from alan@lxorguk.ukuu.org.uk  2008-09-24 03:27 -------
This is a hardware limit.


-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are the assignee for the bug, or are watching the assignee.
