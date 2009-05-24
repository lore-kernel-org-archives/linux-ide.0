From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 13345] panic when reading data from IDE CDROM with >= 2.6.29
 kernels
Date: Sun, 24 May 2009 06:29:35 GMT
Message-ID: <200905240629.n4O6TZp7007783@demeter.kernel.org>
References: <bug-13345-11633@http.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from demeter.kernel.org ([140.211.167.39]:38481 "EHLO
	demeter.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750935AbZEXG3d (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 24 May 2009 02:29:33 -0400
Received: from demeter.kernel.org (localhost.localdomain [127.0.0.1])
	by demeter.kernel.org (8.14.2/8.14.2) with ESMTP id n4O6TZp4007784
	for <linux-ide@vger.kernel.org>; Sun, 24 May 2009 06:29:35 GMT
In-Reply-To: <bug-13345-11633@http.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=13345





--- Comment #13 from Modestas Vainius <modestas@vainius.eu>  2009-05-24 06:29:35 ---
BIOS setup tells me "UltraDMA Mode 2" (UDMA/33) for CD drive so Linux is
obviously misdetecting here. I'll probably have to get a 80-conductor cable as
hdparm -X udma2 does not seem to work :/

-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are watching the assignee of the bug.
