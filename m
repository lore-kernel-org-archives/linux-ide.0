From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 14622] Second IDE device not found
Date: Fri, 20 Nov 2009 13:45:52 GMT
Message-ID: <200911201345.nAKDjqbb003481@demeter.kernel.org>
References: <bug-14622-11633@http.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from demeter.kernel.org ([140.211.167.39]:52113 "EHLO
	demeter.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753093AbZKTNpq (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 20 Nov 2009 08:45:46 -0500
Received: from demeter.kernel.org (localhost.localdomain [127.0.0.1])
	by demeter.kernel.org (8.14.2/8.14.2) with ESMTP id nAKDjqTh003482
	for <linux-ide@vger.kernel.org>; Fri, 20 Nov 2009 13:45:52 GMT
In-Reply-To: <bug-14622-11633@http.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=14622





--- Comment #2 from Zeno R.R. Davatz <zdavatz@gmail.com>  2009-11-20 13:45:51 ---
Disable _all_ IDE when you use ATA and do not become confused by

ATA/ATAPI/MFM/RLL support

because that is actually all IDE!

http://lkml.org/lkml/2009/11/20/148

-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are watching the assignee of the bug.
