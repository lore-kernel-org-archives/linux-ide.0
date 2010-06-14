From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 16142] r8169: Kernel Panic when a lot of data is transferred
 through network interface
Date: Mon, 14 Jun 2010 22:17:41 GMT
Message-ID: <201006142217.o5EMHfR1010394@demeter.kernel.org>
References: <bug-16142-11633@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from demeter.kernel.org ([140.211.167.39]:56366 "EHLO
	demeter.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751481Ab0FNWRm (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 14 Jun 2010 18:17:42 -0400
Received: from demeter.kernel.org (localhost.localdomain [127.0.0.1])
	by demeter.kernel.org (8.14.3/8.14.3) with ESMTP id o5EMHfRE010395
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-ide@vger.kernel.org>; Mon, 14 Jun 2010 22:17:41 GMT
In-Reply-To: <bug-16142-11633@https.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=16142


Andrew Morton <akpm@linux-foundation.org> changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
          Component|Network                     |IDE
         AssignedTo|drivers_network@kernel-bugs |io_ide@kernel-bugs.osdl.org
                   |.osdl.org                   |
            Product|Drivers                     |IO/Storage




--- Comment #8 from Andrew Morton <akpm@linux-foundation.org>  2010-06-14 22:17:35 ---
Seems to be an oops in ide_complete_rq(), unrelated to the network driver.

I'll recategorise the bug to IDE, thanks.

-- 
Configure bugmail: https://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are watching the assignee of the bug.
