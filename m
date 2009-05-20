From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 13345] panic when reading data from IDE CDROM with >= 2.6.29
 kernels
Date: Wed, 20 May 2009 09:18:17 GMT
Message-ID: <200905200918.n4K9IHa0015015@demeter.kernel.org>
References: <bug-13345-11633@http.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from demeter.kernel.org ([140.211.167.39]:43291 "EHLO
	demeter.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756681AbZETJSQ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 20 May 2009 05:18:16 -0400
Received: from demeter.kernel.org (localhost.localdomain [127.0.0.1])
	by demeter.kernel.org (8.14.2/8.14.2) with ESMTP id n4K9IHEl015016
	for <linux-ide@vger.kernel.org>; Wed, 20 May 2009 09:18:17 GMT
In-Reply-To: <bug-13345-11633@http.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=13345


Borislav Petkov <bbpetkov@yahoo.de> changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |bbpetkov@yahoo.de




--- Comment #4 from Borislav Petkov <bbpetkov@yahoo.de>  2009-05-20 09:18:16 ---
Hi,

can you also send the bootlogs of a working kernel (<= 2.6.28) and of the
borked one (30-rc5). For the last one, it would be very useful to see the whole
of the initial OOPS which is cut off on the photo. Can you catch the output
with a serial console (netconsole might do too if its not too early in the boot
process and the machine doesn't die before some data can be transferred over
the network)?

Also, on the 30-rc5 do 

objdump -d drivers/ide/ide-io.o > ide-io.dsm

and

make drivers/ide/ide-io.s

and send me the .dsm and .s files.

Thanks,
Boris.

-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are watching the assignee of the bug.
