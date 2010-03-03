From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 14438] [PATCH] IDE Probe fails to find CD drive
Date: Wed, 3 Mar 2010 12:22:54 GMT
Message-ID: <201003031222.o23CMsDK008691@demeter.kernel.org>
References: <bug-14438-11633@http.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from demeter.kernel.org ([140.211.167.39]:35697 "EHLO
	demeter.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753212Ab0CCMWz (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 3 Mar 2010 07:22:55 -0500
Received: from demeter.kernel.org (localhost.localdomain [127.0.0.1])
	by demeter.kernel.org (8.14.3/8.14.3) with ESMTP id o23CMtqO008692
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-ide@vger.kernel.org>; Wed, 3 Mar 2010 12:22:55 GMT
In-Reply-To: <bug-14438-11633@http.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=14438





--- Comment #11 from Thomas Jarosch <thomas.jarosch@intra2net.com>  2010-03-03 12:22:52 ---
Thanks for the tip, Alan. The patch was meant as a hint or PoC, there must be a
reason why the IDE controller is returning "no devices attached". Just added it
for the IDE maintainer to get an idea what might be wrong.

I also can't sign the patch as I didn't write it in the first place, can I?

Reverting the commit mentioned above should do the same trick:
http://kerneltrap.org/mailarchive/git-commits-head/2009/6/12/5948973

btw: I guess it's a good idea to add the original author as CC:.

-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are watching the assignee of the bug.
