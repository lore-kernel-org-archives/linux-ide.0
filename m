From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 13921] No CD-ROM ATAPI driver on kernels higher than 2.6.24.x
Date: Wed, 5 Aug 2009 23:47:50 GMT
Message-ID: <200908052347.n75NloUC006407@demeter.kernel.org>
References: <bug-13921-11633@http.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from demeter.kernel.org ([140.211.167.39]:39611 "EHLO
	demeter.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751338AbZHEXrt (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 5 Aug 2009 19:47:49 -0400
Received: from demeter.kernel.org (localhost.localdomain [127.0.0.1])
	by demeter.kernel.org (8.14.2/8.14.2) with ESMTP id n75Nlo9g006408
	for <linux-ide@vger.kernel.org>; Wed, 5 Aug 2009 23:47:50 GMT
In-Reply-To: <bug-13921-11633@http.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=13921


Robert Hancock <hancockrwd@gmail.com> changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |hancockrwd@gmail.com




--- Comment #3 from Robert Hancock <hancockrwd@gmail.com>  2009-08-05 23:47:48 ---
Won't be an IDE issue as Fedora 11 (and likely others in that list) uses
libata.

Yes, bootup messages would be useful (or at least some kind of hardware
description).

-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are watching the assignee of the bug.
