From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 16142] r8169: Kernel Panic when a lot of data is transferred
 through network interface
Date: Sat, 3 Jul 2010 08:26:10 GMT
Message-ID: <201007030826.o638QAb3012199@demeter.kernel.org>
References: <bug-16142-11633@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from demeter.kernel.org ([140.211.167.39]:37257 "EHLO
	demeter.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751484Ab0GCI0M (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 3 Jul 2010 04:26:12 -0400
Received: from demeter.kernel.org (localhost.localdomain [127.0.0.1])
	by demeter.kernel.org (8.14.4/8.14.3) with ESMTP id o638QAQu012200
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-ide@vger.kernel.org>; Sat, 3 Jul 2010 08:26:11 GMT
In-Reply-To: <bug-16142-11633@https.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=16142





--- Comment #17 from Borislav Petkov <bbpetkov@yahoo.de>  2010-07-03 08:26:01 ---
See thread at http://marc.info/?l=linux-ide&m=127676206925930 for how it all
turns out. In short:

> But as I wrote in my original bugreport, I tested with a PCI NIC. (But
> the onboard NIC was not completely disabled, it was only disabled via
> ifconfig ... down)
> When using the PCI NIC, the whole problem (kernel panik) did not occure.

Ok, this confirms my suspicion that it is shared-irq related. Also, we
already verified that switching to libata does fix the issue for you so
you are good to go. Considering the DEPRECATED status of ide, I have a
very little incentive in hunting this thing further down, so let's leave
it at that.

-- 
Configure bugmail: https://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are watching the assignee of the bug.
