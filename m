From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 16382] driver 'pata_hpt37x' attempts to run HPT device x0006
 subd x0001. Doesn't work! 'pata_hpt3x2n' works well.
Date: Wed, 14 Jul 2010 19:50:11 GMT
Message-ID: <201007141950.o6EJoBr1005270@demeter.kernel.org>
References: <bug-16382-11633@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from demeter.kernel.org ([140.211.167.39]:57832 "EHLO
	demeter.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754973Ab0GNTuM (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 14 Jul 2010 15:50:12 -0400
Received: from demeter.kernel.org (localhost.localdomain [127.0.0.1])
	by demeter.kernel.org (8.14.4/8.14.3) with ESMTP id o6EJoBtj005271
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-ide@vger.kernel.org>; Wed, 14 Jul 2010 19:50:11 GMT
In-Reply-To: <bug-16382-11633@https.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=16382





--- Comment #5 from Rick Stockton <rickstockton@reno-computerhelp.com>  2010-07-14 19:50:08 ---
OK! There's a comment "check this" in the initialization code of (at line 843
within the current version of pata_hpt37x, V0.6.15), and that made me
suspicious.

But, per your suggestion, I rebuilt initrd with BOTH drivers included -- and I
installed hpt37x first. This worked exactly as as you said it should: hpt37x
was assigned to handle the interrupt, but it bailed out immediately. hpt3x2n
was tried next, and was able to grab the interface.

So please feel free to close this as 'invalid'. There's one TINY nitpick which
I saw in pata_3x2n, but it would be a different bug (if someone wants to
bother): Source code lines 536-537 (in the current version, V0.3.10)are as
follows,

536         printk(KERN_INFO "pata_hpt37x: bus clock %dMHz, using 66MHz
DPLL.\n",
537                pci_mhz);

And you saw this in my clip from dmesg (in the bug description, above). Driver
"pata_3x2n" should not print a message listing itself as "pata_hpt37x"; there's
an old copy/paste mistake in there.


THANKS for hand-holding the newby, you've been awesome.

-- 
Configure bugmail: https://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are watching the assignee of the bug.
