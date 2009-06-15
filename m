From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 13520] WARNING: at lib/dma-debug.c:576
 check_for_illegal_area+0xd3/0xfd()
Date: Mon, 15 Jun 2009 08:41:25 GMT
Message-ID: <200906150841.n5F8fPfX013737@demeter.kernel.org>
References: <bug-13520-11633@http.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from demeter.kernel.org ([140.211.167.39]:57964 "EHLO
	demeter.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759634AbZFOIlX (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 15 Jun 2009 04:41:23 -0400
Received: from demeter.kernel.org (localhost.localdomain [127.0.0.1])
	by demeter.kernel.org (8.14.2/8.14.2) with ESMTP id n5F8fPw5013738
	for <linux-ide@vger.kernel.org>; Mon, 15 Jun 2009 08:41:25 GMT
In-Reply-To: <bug-13520-11633@http.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=13520


Joerg Roedel <joro@8bytes.org> changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |joro@8bytes.org




--- Comment #1 from Joerg Roedel <joro@8bytes.org>  2009-06-15 08:41:24 ---
I currently think this is a driver bug. But to be sure can you please upload
the vmlinux file of the failing kernel somewhere so I can have a look at the
addresses of the segment boundary symbols?

-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are watching the assignee of the bug.
