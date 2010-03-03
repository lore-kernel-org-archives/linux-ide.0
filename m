From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 14438] IDE Probe fails to find CD drive
Date: Wed, 3 Mar 2010 12:07:22 GMT
Message-ID: <201003031207.o23C7Moc005083@demeter.kernel.org>
References: <bug-14438-11633@http.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from demeter.kernel.org ([140.211.167.39]:50321 "EHLO
	demeter.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753742Ab0CCMHX (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 3 Mar 2010 07:07:23 -0500
Received: from demeter.kernel.org (localhost.localdomain [127.0.0.1])
	by demeter.kernel.org (8.14.3/8.14.3) with ESMTP id o23C7MgE005084
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-ide@vger.kernel.org>; Wed, 3 Mar 2010 12:07:22 GMT
In-Reply-To: <bug-14438-11633@http.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=14438


Thomas Jarosch <thomas.jarosch@intra2net.com> changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |thomas.jarosch@intra2net.co
                   |                            |m




--- Comment #8 from Thomas Jarosch <thomas.jarosch@intra2net.com>  2010-03-03 12:07:18 ---
Same issue here on vmware server 1.08: The IDE cdrom is not detected anymore on
kernel 2.6.32.9. I've reapplied the patch to 2.6.32.9 and will attach it here
for easier access.

-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are watching the assignee of the bug.
