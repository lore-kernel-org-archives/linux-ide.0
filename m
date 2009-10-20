From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 14438] IDE Probe fails to find CD drive
Date: Tue, 20 Oct 2009 06:58:39 GMT
Message-ID: <200910200658.n9K6wdsh015800@demeter.kernel.org>
References: <bug-14438-11633@http.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from demeter.kernel.org ([140.211.167.39]:47849 "EHLO
	demeter.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751612AbZJTG6f (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 20 Oct 2009 02:58:35 -0400
Received: from demeter.kernel.org (localhost.localdomain [127.0.0.1])
	by demeter.kernel.org (8.14.2/8.14.2) with ESMTP id n9K6wdES015801
	for <linux-ide@vger.kernel.org>; Tue, 20 Oct 2009 06:58:39 GMT
In-Reply-To: <bug-14438-11633@http.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=14438


Borislav Petkov <bbpetkov@yahoo.de> changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |bbpetkov@yahoo.de




--- Comment #4 from Borislav Petkov <bbpetkov@yahoo.de>  2009-10-20 06:58:38 ---
Hi,

does libata also fail to detect your drive? I.e., turn off CONFIG_IDE and
enable CONFIG_PATA_VIA.

-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are watching the assignee of the bug.
