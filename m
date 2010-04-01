From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 15639] 2.6.34-rc1 breaks via82cxxx Host Protected Area
Date: Thu, 1 Apr 2010 01:07:32 GMT
Message-ID: <201004010107.o3117WUV013272@demeter.kernel.org>
References: <bug-15639-11633@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from demeter.kernel.org ([140.211.167.39]:41588 "EHLO
	demeter.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758174Ab0DABHi (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 31 Mar 2010 21:07:38 -0400
Received: from demeter.kernel.org (localhost.localdomain [127.0.0.1])
	by demeter.kernel.org (8.14.3/8.14.3) with ESMTP id o3117YQp013294
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-ide@vger.kernel.org>; Thu, 1 Apr 2010 01:07:34 GMT
In-Reply-To: <bug-15639-11633@https.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=15639


Rafael J. Wysocki <rjw@sisk.pl> changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
             Status|NEW                         |RESOLVED
                 CC|                            |rjw@sisk.pl
         Resolution|                            |CODE_FIX




--- Comment #1 from Rafael J. Wysocki <rjw@sisk.pl>  2010-04-01 01:05:59 ---
Fixed in 2.6.34-rc3 (by reverting the commit in question).

-- 
Configure bugmail: https://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are watching the assignee of the bug.
