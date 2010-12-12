From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 24702] Possible bug - crash during IDE interface probing.
Date: Sun, 12 Dec 2010 12:24:57 GMT
Message-ID: <201012121224.oBCCOv1e012149@demeter2.kernel.org>
References: <bug-24702-11633@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from demeter2.kernel.org ([140.211.167.42]:46106 "EHLO
	demeter2.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752687Ab0LLMY6 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 12 Dec 2010 07:24:58 -0500
Received: from demeter2.kernel.org (localhost.localdomain [127.0.0.1])
	by demeter2.kernel.org (8.14.4/8.14.3) with ESMTP id oBCCOvPj012156
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-ide@vger.kernel.org>; Sun, 12 Dec 2010 12:24:57 GMT
In-Reply-To: <bug-24702-11633@https.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=24702


Borislav Petkov <bp@alien8.de> changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |bp@alien8.de




--- Comment #1 from Borislav Petkov <bp@alien8.de>  2010-12-12 12:24:50 ---
Hi,

first of all, how did you update from .1 to .2? I'd like to rule out
the use of some stale .o objects from the 36.1 build. Can you copy
your .config to a safe place, do "make mrproper" and then copy it back
(mrproper removes the .config too) and then build 36.2 and try booting.

Then, if it crashes again, can you catch the oops somehow, provided
there is one? Either serial console, netconsole or if those are not an
option, make a readable photo of the oops and upload it to bugzilla.

Thanks.

-- 
Configure bugmail: https://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are watching the assignee of the bug.
