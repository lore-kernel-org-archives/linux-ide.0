From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 13882] Cannot read CD: "Logical unit communication CRC error"
Date: Fri, 31 Jul 2009 02:39:42 GMT
Message-ID: <200907310239.n6V2dg18011903@demeter.kernel.org>
References: <bug-13882-11633@http.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from demeter.kernel.org ([140.211.167.39]:50809 "EHLO
	demeter.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751244AbZGaCjl (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 30 Jul 2009 22:39:41 -0400
Received: from demeter.kernel.org (localhost.localdomain [127.0.0.1])
	by demeter.kernel.org (8.14.2/8.14.2) with ESMTP id n6V2dgTA011904
	for <linux-ide@vger.kernel.org>; Fri, 31 Jul 2009 02:39:42 GMT
In-Reply-To: <bug-13882-11633@http.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=13882


Robert Hancock <hancockrwd@gmail.com> changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |hancockrwd@gmail.com




--- Comment #2 from Robert Hancock <hancockrwd@gmail.com>  2009-07-31 02:39:41 ---
It looks like you're indeed getting UDMA CRC errors. The drive is getting
configured for UDMA/66. Is it using an 80-wire PATA cable? If not then that
would explain why as 40-wire are only good to UDMA/33, however in that case it
would point to the cable detection not working properly.

-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are watching the assignee of the bug.
