From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 17982] Cannot see devices on IDE controller
Date: Thu, 9 Sep 2010 15:56:04 GMT
Message-ID: <201009091556.o89Fu4sL015702@demeter1.kernel.org>
References: <bug-17982-11633@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from demeter.kernel.org ([140.211.167.39]:32992 "EHLO
	demeter1.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752101Ab0IIP4G (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 9 Sep 2010 11:56:06 -0400
Received: from demeter1.kernel.org (localhost.localdomain [127.0.0.1])
	by demeter1.kernel.org (8.14.4/8.14.3) with ESMTP id o89Fu4Xi015703
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-ide@vger.kernel.org>; Thu, 9 Sep 2010 15:56:04 GMT
In-Reply-To: <bug-17982-11633@https.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=17982


Tejun Heo <tj@kernel.org> changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |tj@kernel.org




--- Comment #4 from Tejun Heo <tj@kernel.org>  2010-09-09 15:55:56 ---
Does "rmmod ata_generic; modprobe ata_generic all_generic_ide=1" make the drive
come up?  If so, can you please post the output of "dmesg" and "hdparm -I
/dev/sdX" and "hdparm -t /dev/sdX"?

Thanks.

-- 
Configure bugmail: https://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are watching the assignee of the bug.
