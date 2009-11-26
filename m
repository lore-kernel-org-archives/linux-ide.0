From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 14583] SSD system stall, HSM Violation
Date: Thu, 26 Nov 2009 04:33:49 GMT
Message-ID: <200911260433.nAQ4XnBe018531@demeter.kernel.org>
References: <bug-14583-11633@http.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from demeter.kernel.org ([140.211.167.39]:36024 "EHLO
	demeter.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932223AbZKZEdm (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 25 Nov 2009 23:33:42 -0500
Received: from demeter.kernel.org (localhost.localdomain [127.0.0.1])
	by demeter.kernel.org (8.14.2/8.14.2) with ESMTP id nAQ4XnUb018532
	for <linux-ide@vger.kernel.org>; Thu, 26 Nov 2009 04:33:49 GMT
In-Reply-To: <bug-14583-11633@http.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=14583





--- Comment #21 from Andrew Simpson <andrewnz.simpson@gmail.com>  2009-11-26 04:33:48 ---
I will ask on the Ubuntu bug report whether anyone has tried 2.6.29 and/or
2.6.30.

I have already been comparing Mandriva and Ubuntu kernels.  The patches that
Mandriva apply to the 2.6.31 kernel source are, I believe, here:

http://svn.mandriva.com/svn/packages/cooker/kernel/current/PATCHES/

I have also diff-ed the Ubuntu and Mandriva kernel configs for comparison.  I
have yet to see any 'interesting differences'.

-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are watching the assignee of the bug.
