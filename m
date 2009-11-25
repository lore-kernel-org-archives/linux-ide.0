From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 14583] SSD system stall, HSM Violation
Date: Wed, 25 Nov 2009 10:57:43 GMT
Message-ID: <200911251057.nAPAvhx0006431@demeter.kernel.org>
References: <bug-14583-11633@http.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from demeter.kernel.org ([140.211.167.39]:48105 "EHLO
	demeter.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751476AbZKYK5h (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 25 Nov 2009 05:57:37 -0500
Received: from demeter.kernel.org (localhost.localdomain [127.0.0.1])
	by demeter.kernel.org (8.14.2/8.14.2) with ESMTP id nAPAvhrM006432
	for <linux-ide@vger.kernel.org>; Wed, 25 Nov 2009 10:57:43 GMT
In-Reply-To: <bug-14583-11633@http.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=14583





--- Comment #18 from Alan <alan@lxorguk.ukuu.org.uk>  2009-11-25 10:57:42 ---
No obvious thought. The interesting thing to me is that the newer kernels
double check for a lost IRQ but are not seeing one in this case. Some of the
SSD devices are very fast responding and I wonder if in fact somewhere between
2.6.28-31 we've introduced a case where we can clear the IRQ in error if it is
raised extremely fast ?

-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are watching the assignee of the bug.
