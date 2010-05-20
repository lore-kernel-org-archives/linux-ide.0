From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 3094] POOR I/O perfomance on VIA chipsets
Date: Thu, 20 May 2010 05:28:30 GMT
Message-ID: <201005200528.o4K5SUpY008448@demeter.kernel.org>
References: <bug-3094-11633@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from demeter.kernel.org ([140.211.167.39]:32882 "EHLO
	demeter.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752425Ab0ETF2c (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 20 May 2010 01:28:32 -0400
Received: from demeter.kernel.org (localhost.localdomain [127.0.0.1])
	by demeter.kernel.org (8.14.3/8.14.3) with ESMTP id o4K5SUoG008449
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-ide@vger.kernel.org>; Thu, 20 May 2010 05:28:30 GMT
In-Reply-To: <bug-3094-11633@https.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3094





--- Comment #24 from Artem S. Tashkinov <t.artem@mailcity.com>  2010-05-20 05:28:07 ---
(In reply to comment #22)
> It is how load average is defined in the standards, and how it has been defined
> since the 1970s. Tools rely on that exact behaviour
> 

Alan, IO wait should not consume 100% of (even imaginary) CPU time - that's
_wrong_, in fact I don't know any other OS that treats IO activity this way.

CPU is _not_ 100% busy waiting for IO operations to complete, however people
using Linux are made believe it _is_ the case.

-- 
Configure bugmail: https://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are watching the assignee of the bug.
