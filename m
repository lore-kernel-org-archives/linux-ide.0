From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 15815] pata_legacy causes machine check
Date: Wed, 21 Apr 2010 08:56:59 GMT
Message-ID: <201004210856.o3L8uxIJ025777@demeter.kernel.org>
References: <bug-15815-11633@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from demeter.kernel.org ([140.211.167.39]:51933 "EHLO
	demeter.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752134Ab0DUI5A (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 21 Apr 2010 04:57:00 -0400
Received: from demeter.kernel.org (localhost.localdomain [127.0.0.1])
	by demeter.kernel.org (8.14.3/8.14.3) with ESMTP id o3L8uxlU025778
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-ide@vger.kernel.org>; Wed, 21 Apr 2010 08:56:59 GMT
In-Reply-To: <bug-15815-11633@https.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=15815


Alan <alan@lxorguk.ukuu.org.uk> changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |alan@lxorguk.ukuu.org.uk




--- Comment #2 from Alan <alan@lxorguk.ukuu.org.uk>  2010-04-21 08:56:55 ---
Generally no - there are some platforms with legacy ATA mappings however.

Probably the VLB probes should only be done on x86.

I'm tempted to close the bug as "So don't do that then" ?

-- 
Configure bugmail: https://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are watching the assignee of the bug.
