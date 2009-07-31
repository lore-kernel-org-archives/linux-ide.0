From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 13882] Cannot read CD: "Logical unit communication CRC error"
Date: Fri, 31 Jul 2009 18:49:16 GMT
Message-ID: <200907311849.n6VInGAT024162@demeter.kernel.org>
References: <bug-13882-11633@http.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from demeter.kernel.org ([140.211.167.39]:59181 "EHLO
	demeter.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752827AbZGaStP (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 31 Jul 2009 14:49:15 -0400
Received: from demeter.kernel.org (localhost.localdomain [127.0.0.1])
	by demeter.kernel.org (8.14.2/8.14.2) with ESMTP id n6VInGLn024163
	for <linux-ide@vger.kernel.org>; Fri, 31 Jul 2009 18:49:16 GMT
In-Reply-To: <bug-13882-11633@http.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=13882





--- Comment #9 from Robert Hancock <hancockrwd@gmail.com>  2009-07-31 18:49:15 ---
Can you rerun the lspci output for 2.6.30 as root? When run as normal user it
omits the part of the PCI configuration space that contains the cable detection
bits.

-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are watching the assignee of the bug.
