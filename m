From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 15884] cd-burning reduces other simultaneous IO performance
Date: Thu, 6 May 2010 01:09:00 GMT
Message-ID: <201005060109.o46190GG002190@demeter.kernel.org>
References: <bug-15884-11633@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from demeter.kernel.org ([140.211.167.39]:49472 "EHLO
	demeter.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750812Ab0EFBJE (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 5 May 2010 21:09:04 -0400
Received: from demeter.kernel.org (localhost.localdomain [127.0.0.1])
	by demeter.kernel.org (8.14.3/8.14.3) with ESMTP id o461904R002192
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-ide@vger.kernel.org>; Thu, 6 May 2010 01:09:01 GMT
In-Reply-To: <bug-15884-11633@https.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=15884


Dan Hollocher <danielhollocher@gmail.com> changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
  Attachment #26235|0                           |1
        is obsolete|                            |




--- Comment #6 from Dan Hollocher <danielhollocher@gmail.com>  2010-05-06 01:08:32 ---
Created an attachment (id=26252)
 --> (https://bugzilla.kernel.org/attachment.cgi?id=26252)
fresh boot dmesg

oops, I'm sorry.  I didn't realize that kern.log would contain so little.

-- 
Configure bugmail: https://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are watching the assignee of the bug.
