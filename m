From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 13345] panic when reading data from IDE CDROM with >= 2.6.29
 kernels
Date: Sat, 20 Jun 2009 19:58:03 GMT
Message-ID: <200906201958.n5KJw3Ps023285@demeter.kernel.org>
References: <bug-13345-11633@http.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from demeter.kernel.org ([140.211.167.39]:35994 "EHLO
	demeter.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751953AbZFTT6B (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 20 Jun 2009 15:58:01 -0400
Received: from demeter.kernel.org (localhost.localdomain [127.0.0.1])
	by demeter.kernel.org (8.14.2/8.14.2) with ESMTP id n5KJw3Ip023286
	for <linux-ide@vger.kernel.org>; Sat, 20 Jun 2009 19:58:03 GMT
In-Reply-To: <bug-13345-11633@http.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=13345





--- Comment #19 from Ethan Grammatikidis <eekee57@fastmail.fm>  2009-06-20 19:58:00 ---
2.6.30 final fixes my issue with my newer drive.

-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are watching the assignee of the bug.
