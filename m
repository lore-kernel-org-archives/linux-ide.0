From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 14583] SSD system stall, HSM Violation
Date: Wed, 18 Nov 2009 06:49:01 GMT
Message-ID: <200911180649.nAI6n1Wu015843@demeter.kernel.org>
References: <bug-14583-11633@http.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from demeter.kernel.org ([140.211.167.39]:52086 "EHLO
	demeter.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752014AbZKRGsz (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 18 Nov 2009 01:48:55 -0500
Received: from demeter.kernel.org (localhost.localdomain [127.0.0.1])
	by demeter.kernel.org (8.14.2/8.14.2) with ESMTP id nAI6n1hs015844
	for <linux-ide@vger.kernel.org>; Wed, 18 Nov 2009 06:49:01 GMT
In-Reply-To: <bug-14583-11633@http.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=14583





--- Comment #15 from Andrew Simpson <andrewnz.simpson@gmail.com>  2009-11-18 06:48:59 ---
Ummm... a case of bad timing.  I just spent the last hour wiping the Ubuntu
9.04 install and putting on Mandriva 2010.0

Yes, I have previously inspected Ubuntu 9.04 very carefully - and more than
once.  Also others in the referenced Ubuntu bug report are finding the same as
me.  I will do a LiveCD (on usb stick) and confirm again for you shortly.

BTW - there is a 2.6.28 boot dmesg that I attached previously in the
attachments. 

For what it's worth:  Mandriva 2010.0 (2.6.31) shows no sign of this bug (yet).
 Fedora 12 Beta (again LiveCD on USB stick) showed the same bug in dmesg (I
didn't investigate any further than this).  No bug reports in Fedora bugzilla
that I could find.

-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are watching the assignee of the bug.
