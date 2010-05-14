From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 15884] cd-burning reduces other simultaneous IO performance
Date: Fri, 14 May 2010 01:20:26 GMT
Message-ID: <201005140120.o4E1KQFN023150@demeter.kernel.org>
References: <bug-15884-11633@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from demeter.kernel.org ([140.211.167.39]:35559 "EHLO
	demeter.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753375Ab0ENBU1 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 13 May 2010 21:20:27 -0400
Received: from demeter.kernel.org (localhost.localdomain [127.0.0.1])
	by demeter.kernel.org (8.14.3/8.14.3) with ESMTP id o4E1KQ8w023151
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-ide@vger.kernel.org>; Fri, 14 May 2010 01:20:26 GMT
In-Reply-To: <bug-15884-11633@https.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=15884


Dan Hollocher <danielhollocher@gmail.com> changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
             Status|NEW                         |RESOLVED
         Resolution|                            |INVALID




--- Comment #10 from Dan Hollocher <danielhollocher@gmail.com>  2010-05-14 01:20:19 ---
Tested and confirmed.

Here are directions on how to apply this to k3b (for others that may stop by):
Settings > Configure K3b... > Programs > User Parameters
Click near cdrecord, and add the option -immed.

You may need to ensure that cdrecord is selected by:
Settings > Configure K3b... > Advanced > Show advanced GUI elements
During the burning setup, you will have an option to select cdrecord.

-- 
Configure bugmail: https://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are watching the assignee of the bug.
