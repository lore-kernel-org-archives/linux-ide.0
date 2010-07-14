From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 16382] driver 'pata_hpt37x' attempts to run HPT device x0006
 subd x0001. Doesn't work! 'pata_hpt3x2n' works well.
Date: Wed, 14 Jul 2010 02:26:14 GMT
Message-ID: <201007140226.o6E2QExh031012@demeter.kernel.org>
References: <bug-16382-11633@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from demeter.kernel.org ([140.211.167.39]:41592 "EHLO
	demeter.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751137Ab0GNC0O (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 13 Jul 2010 22:26:14 -0400
Received: from demeter.kernel.org (localhost.localdomain [127.0.0.1])
	by demeter.kernel.org (8.14.4/8.14.3) with ESMTP id o6E2QEGa031013
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-ide@vger.kernel.org>; Wed, 14 Jul 2010 02:26:14 GMT
In-Reply-To: <bug-16382-11633@https.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=16382





--- Comment #2 from Rick Stockton <rickstockton@reno-computerhelp.com>  2010-07-14 02:26:10 ---
Thanks, Robert!

But, if pata_3x2n can support all known versions of the chip, why not just use
that exclusively? (It is the driver which HighPoint doco makes reference too --
although that doco is from 2001.)

-- 
Configure bugmail: https://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are watching the assignee of the bug.
