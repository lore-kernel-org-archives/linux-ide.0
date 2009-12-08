From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 14583] SSD system stall, HSM Violation
Date: Tue, 8 Dec 2009 06:27:14 GMT
Message-ID: <200912080627.nB86REex001534@demeter.kernel.org>
References: <bug-14583-11633@http.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from demeter.kernel.org ([140.211.167.39]:48839 "EHLO
	demeter.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935827AbZLHG1I (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 8 Dec 2009 01:27:08 -0500
Received: from demeter.kernel.org (localhost.localdomain [127.0.0.1])
	by demeter.kernel.org (8.14.2/8.14.2) with ESMTP id nB86REpi001535
	for <linux-ide@vger.kernel.org>; Tue, 8 Dec 2009 06:27:14 GMT
In-Reply-To: <bug-14583-11633@http.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=14583





--- Comment #24 from Andrew Simpson <andrewnz.simpson@gmail.com>  2009-12-08 06:27:11 ---
Comment from Ubuntu bug report:

"I can confirm kernel 2.6.30 works fine with my netbook (Acer Aspire One with 8
GB SSD) using a Jaunty userland. I am running 2.6.30-02063009-generic.
I am somewhat reluctant to try a karmic kernel since once I started getting the
errors after installing karmic to get rid of them in any distro/kernel
combination I had to write all zeros to the SSD. If it's truly necessary I will
try."

https://bugs.launchpad.net/ubuntu/+source/linux/+bug/445852 with comment #66

Other comments show that the bug is still present in 2.6.32.

-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are watching the assignee of the bug.
