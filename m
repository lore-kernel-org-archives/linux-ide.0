From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 6883] ide-probe.c attempts to use polling designed for ancient
 Seagate drives on some compact flash disks
Date: Thu, 26 Mar 2009 11:29:34 GMT
Message-ID: <200903261129.n2QBTYm4011122@demeter.kernel.org>
References: <bug-6883-11633@http.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from demeter.kernel.org ([140.211.167.39]:57464 "EHLO
	demeter.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753224AbZCZL3f (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 26 Mar 2009 07:29:35 -0400
Received: from demeter.kernel.org (localhost.localdomain [127.0.0.1])
	by demeter.kernel.org (8.14.2/8.14.2) with ESMTP id n2QBTYW9011123
	for <linux-ide@vger.kernel.org>; Thu, 26 Mar 2009 11:29:34 GMT
In-Reply-To: <bug-6883-11633@http.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=6883


Alan <alan@lxorguk.ukuu.org.uk> changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |alan@lxorguk.ukuu.org.uk
     Kernel Version|2.6.16, 2.6.17, 2.6.18-rc2  |2.6.25
         Regression|---                         |No




-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are watching the assignee of the bug.
