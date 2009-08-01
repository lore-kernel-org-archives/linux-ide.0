From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 13882] Cannot read CD: "Logical unit communication CRC error"
Date: Sat, 1 Aug 2009 22:06:00 GMT
Message-ID: <200908012206.n71M606O000600@demeter.kernel.org>
References: <bug-13882-11633@http.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from demeter.kernel.org ([140.211.167.39]:41581 "EHLO
	demeter.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752488AbZHAWGA (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 1 Aug 2009 18:06:00 -0400
Received: from demeter.kernel.org (localhost.localdomain [127.0.0.1])
	by demeter.kernel.org (8.14.2/8.14.2) with ESMTP id n71M60PK000601
	for <linux-ide@vger.kernel.org>; Sat, 1 Aug 2009 22:06:00 GMT
In-Reply-To: <bug-13882-11633@http.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=13882





--- Comment #16 from Sergei Shtylyov <sshtylyov@ru.mvista.com>  2009-08-01 22:06:00 ---
--- Comment #15 from Alan <alan@lxorguk.ukuu.org.uk> 2009-08-01 21:30:26 ---
> I have complete documentation for them. They are set by the BIOS to indicate
> whether the cable is 40 or 80 wire. We cannot do drive side detect as there is
> no guarantee the boards support it.
>   

I wonder how boards can support (or not) *drive side* cable detection...

-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are watching the assignee of the bug.
