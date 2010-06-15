From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 16142] r8169: Kernel Panic when a lot of data is transferred
 through network interface
Date: Tue, 15 Jun 2010 11:50:06 GMT
Message-ID: <201006151150.o5FBo6jE014160@demeter.kernel.org>
References: <bug-16142-11633@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from demeter.kernel.org ([140.211.167.39]:58807 "EHLO
	demeter.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752626Ab0FOLuH (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 15 Jun 2010 07:50:07 -0400
Received: from demeter.kernel.org (localhost.localdomain [127.0.0.1])
	by demeter.kernel.org (8.14.3/8.14.3) with ESMTP id o5FBo6WE014161
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-ide@vger.kernel.org>; Tue, 15 Jun 2010 11:50:06 GMT
In-Reply-To: <bug-16142-11633@https.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=16142





--- Comment #11 from Borislav Petkov <bbpetkov@yahoo.de>  2010-06-15 11:49:59 ---
(In reply to comment #10)
> If you are still interested in the bug, I would try to help you as far as I
> can.

Cool.

> Answers to your questions:
> 1. Proprietary drivers: I am using the nvidia driver, but it was not loaded
> when the bug occurred. (for the 2.6.34 kernel I didn't even installed them)

Ok, please remove the proprietary drivers when reproducing the oops.

> 2. Serial console: sorry this computer does not have an serial port (there is
> one on the motherboard, but I don't have the matching adapter.)
> 
> 3. Netconsole: I tried to use it; normal dmesg logging worked, but I did not
> receive the oops messages.

was the netconsole built-in or a module? Try building it into the kernel if
not.

> Right now my questions are:
> 1. Do you still want to take care of this bug?

Sure, I'll give it a try.

> 2. If so, is there a possibility to use firewire to capture the oops messages?

There is something related in <Documentation/debugging-via-ohci1394.txt>
but I haven't tried it yet.

Ok, so what we need now is a cleaner OOPS. If nothing else works, try
making a picture but make sure it is readable and complete. Also, send me the
objdump part I asked you for in the earlier message.

Thanks,
Boris.

-- 
Configure bugmail: https://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are watching the assignee of the bug.
