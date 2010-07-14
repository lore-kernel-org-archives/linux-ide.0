From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 16382] driver 'pata_hpt37x' attempts to run HPT device x0006
 subd x0001. Doesn't work! 'pata_hpt3x2n' works well.
Date: Wed, 14 Jul 2010 01:40:45 GMT
Message-ID: <201007140140.o6E1ejZN024496@demeter.kernel.org>
References: <bug-16382-11633@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from demeter.kernel.org ([140.211.167.39]:49240 "EHLO
	demeter.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751137Ab0GNBkq (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 13 Jul 2010 21:40:46 -0400
Received: from demeter.kernel.org (localhost.localdomain [127.0.0.1])
	by demeter.kernel.org (8.14.4/8.14.3) with ESMTP id o6E1ejcc024497
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-ide@vger.kernel.org>; Wed, 14 Jul 2010 01:40:45 GMT
In-Reply-To: <bug-16382-11633@https.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=16382


Robert Hancock <hancockrwd@gmail.com> changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |hancockrwd@gmail.com




--- Comment #1 from Robert Hancock <hancockrwd@gmail.com>  2010-07-14 01:40:44 ---
It looks like pata_hpt37x supports the HPT302 chip, but only revision 1.
Revision 2 and higher (which you have) is supported by the pata_hpt3x2n driver
(which doesn't support revision 1). The module device table can't contain
dependencies on revision number, therefore both devices are considered eligible
to drive the device. However, the one that doesn't support that revision of the
chip just won't attach to the device. Loading both drivers should therefore be
harmless.

The problem in your case seems to be that the distro installer is only trying
to load one of the drivers which happens to not be the one that you need. This
isn't right - it should try and load ALL drivers that match the PCI IDs and see
what sticks.

-- 
Configure bugmail: https://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are watching the assignee of the bug.
