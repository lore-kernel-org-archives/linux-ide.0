From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 13365] 2.6.28+ cannot read a hard-drive properly through an
 "82801DB (ICH4) IDE Controller"
Date: Sat, 23 May 2009 02:58:33 GMT
Message-ID: <200905230258.n4N2wXc8021165@demeter.kernel.org>
References: <bug-13365-11633@http.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from demeter.kernel.org ([140.211.167.39]:37506 "EHLO
	demeter.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755553AbZEWC6b (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 22 May 2009 22:58:31 -0400
Received: from demeter.kernel.org (localhost.localdomain [127.0.0.1])
	by demeter.kernel.org (8.14.2/8.14.2) with ESMTP id n4N2wXVv021166
	for <linux-ide@vger.kernel.org>; Sat, 23 May 2009 02:58:33 GMT
In-Reply-To: <bug-13365-11633@http.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=13365


Felix Miata <mrmazda@ij.net> changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|mrmazda@ij.net              |




--- Comment #5 from Felix Miata <mrmazda@ij.net>  2009-05-23 02:58:32 ---
It just occurred to me that boards with 845 chipsets were mostly made during
the plague of defective capacitors. My 845 Intel board developed bad caps,
which I replaced when bad things started happening, and the errors stopped.

-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are watching the assignee of the bug.
