From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 15445] pata_jmicron incorrectly downgrades CompactFlash to
 UDMA/33
Date: Wed, 10 Mar 2010 16:25:20 GMT
Message-ID: <201003101625.o2AGPKQE013706@demeter.kernel.org>
References: <bug-15445-11633@http.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from demeter.kernel.org ([140.211.167.39]:60145 "EHLO
	demeter.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756366Ab0CJQZW (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 10 Mar 2010 11:25:22 -0500
Received: from demeter.kernel.org (localhost.localdomain [127.0.0.1])
	by demeter.kernel.org (8.14.3/8.14.3) with ESMTP id o2AGPLgf013709
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-ide@vger.kernel.org>; Wed, 10 Mar 2010 16:25:21 GMT
In-Reply-To: <bug-15445-11633@http.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=15445





--- Comment #3 from Solomon Peachy <pizza@shaftnet.org>  2010-03-10 16:24:35 ---
When you say 'the card doesn't implement cable detection properly' do you mean
the expresscard PCIe->CF/PATA adapter and/or the CF card itself?

Neanwhile, using "libata.force=short40c,1:sata,2:sata" seems to do the trick,
and I see ~44MB/s sustained throughput off of this CF card now, even though the
device ID changes with each hotplug cycle.  So I have a workaround in place,
but it would be nice if a proper solution could be concocted so things will
JustWork for others down the line...

-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are watching the assignee of the bug.
