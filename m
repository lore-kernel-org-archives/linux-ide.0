From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 13882] Cannot read CD: "Logical unit communication CRC error"
Date: Sun, 9 Aug 2009 22:41:15 GMT
Message-ID: <200908092241.n79MfFiV029952@demeter.kernel.org>
References: <bug-13882-11633@http.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from demeter.kernel.org ([140.211.167.39]:42069 "EHLO
	demeter.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751519AbZHIWlP (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 9 Aug 2009 18:41:15 -0400
Received: from demeter.kernel.org (localhost.localdomain [127.0.0.1])
	by demeter.kernel.org (8.14.2/8.14.2) with ESMTP id n79MfFWk029953
	for <linux-ide@vger.kernel.org>; Sun, 9 Aug 2009 22:41:15 GMT
In-Reply-To: <bug-13882-11633@http.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=13882





--- Comment #20 from checkit <python.dev.9@gmail.com>  2009-08-09 22:41:14 ---
I just replaced my 40-wire cable with an 80-wire cable, reran the md5sum test
using 2.6.27.14, and it looks like my DVD drive is working fine now.

I don't have the inclination to spend any more time on the original bug. 
Perhaps somebody else with more time and inclination will want to look into
this further.

-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are watching the assignee of the bug.
