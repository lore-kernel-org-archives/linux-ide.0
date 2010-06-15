From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 16142] r8169: Kernel Panic when a lot of data is transferred
 through network interface
Date: Tue, 15 Jun 2010 11:17:57 GMT
Message-ID: <201006151117.o5FBHvbf006933@demeter.kernel.org>
References: <bug-16142-11633@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from demeter.kernel.org ([140.211.167.39]:44913 "EHLO
	demeter.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752225Ab0FOLR6 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 15 Jun 2010 07:17:58 -0400
Received: from demeter.kernel.org (localhost.localdomain [127.0.0.1])
	by demeter.kernel.org (8.14.3/8.14.3) with ESMTP id o5FBHwrj006934
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-ide@vger.kernel.org>; Tue, 15 Jun 2010 11:17:58 GMT
In-Reply-To: <bug-16142-11633@https.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=16142





--- Comment #10 from Hans42Mueller@googlemail.com  2010-06-15 11:17:33 ---
First of all: Thank you all for your quick responses.


Switching to libdata solved the problem for me.
(at least until now  ;) )

----
But:
If you are still interested in the bug, I would try to help you as far as I
can.

Answers to your questions:
1. Proprietary drivers: I am using the nvidia driver, but it was not loaded
when the bug occurred. (for the 2.6.34 kernel I didn't even installed them)

2. Serial console: sorry this computer does not have an serial port (there is
one on the motherboard, but I don't have the matching adapter.)

3. Netconsole: I tried to use it; normal dmesg logging worked, but I did not
receive the oops messages.


Right now my questions are:
1. Do you still want to take care of this bug?
2. If so, is there a possibility to use firewire to capture the oops messages?

-- 
Configure bugmail: https://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are watching the assignee of the bug.
