From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 13882] Cannot read CD: "Logical unit communication CRC error"
Date: Sat, 1 Aug 2009 18:40:25 GMT
Message-ID: <200908011840.n71IePl6000617@demeter.kernel.org>
References: <bug-13882-11633@http.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from demeter.kernel.org ([140.211.167.39]:44914 "EHLO
	demeter.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751864AbZHASkZ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 1 Aug 2009 14:40:25 -0400
Received: from demeter.kernel.org (localhost.localdomain [127.0.0.1])
	by demeter.kernel.org (8.14.2/8.14.2) with ESMTP id n71IePIo000618
	for <linux-ide@vger.kernel.org>; Sat, 1 Aug 2009 18:40:25 GMT
In-Reply-To: <bug-13882-11633@http.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=13882





--- Comment #14 from Robert Hancock <hancockrwd@gmail.com>  2009-08-01 18:40:24 ---
Alan, do you have access to any documentation that indicates what those bits
are supposed to actually mean?

For the original reporter, you can try just deleting those lines from
drivers/ata/pata_via.c and see if the cable detection then reports 40-wire..

-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are watching the assignee of the bug.
