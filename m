From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 15445] pata_jmicron incorrectly downgrades CompactFlash to
 UDMA/33
Date: Thu, 11 Mar 2010 00:14:25 GMT
Message-ID: <201003110014.o2B0EPh3002179@demeter.kernel.org>
References: <bug-15445-11633@http.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from demeter.kernel.org ([140.211.167.39]:60617 "EHLO
	demeter.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932963Ab0CKAO0 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 10 Mar 2010 19:14:26 -0500
Received: from demeter.kernel.org (localhost.localdomain [127.0.0.1])
	by demeter.kernel.org (8.14.3/8.14.3) with ESMTP id o2B0EPK4002180
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-ide@vger.kernel.org>; Thu, 11 Mar 2010 00:14:25 GMT
In-Reply-To: <bug-15445-11633@http.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=15445





--- Comment #4 from Robert Hancock <hancockrwd@gmail.com>  2010-03-11 00:14:18 ---
That would be the PCIe->CF adapter.. it should have the hardware set up to look
like there's an 80-wire cable if it can supports speeds greater than UDMA/33.

-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are watching the assignee of the bug.
