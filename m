From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 16142] r8169: Kernel Panic when a lot of data is transferred
 through network interface
Date: Tue, 15 Jun 2010 06:39:07 GMT
Message-ID: <201006150639.o5F6d7lX027123@demeter.kernel.org>
References: <bug-16142-11633@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from demeter.kernel.org ([140.211.167.39]:50297 "EHLO
	demeter.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750874Ab0FOGjI (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 15 Jun 2010 02:39:08 -0400
Received: from demeter.kernel.org (localhost.localdomain [127.0.0.1])
	by demeter.kernel.org (8.14.3/8.14.3) with ESMTP id o5F6d7uf027125
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-ide@vger.kernel.org>; Tue, 15 Jun 2010 06:39:07 GMT
In-Reply-To: <bug-16142-11633@https.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=16142


Borislav Petkov <bbpetkov@yahoo.de> changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |bbpetkov@yahoo.de




--- Comment #9 from Borislav Petkov <bbpetkov@yahoo.de>  2010-06-15 06:38:58 ---
Hi,

ok, here's what you can do:

1. Switch to libata and done, no bug. IDE is deprecated anyways.

If you'd still like to help us fix this and keep using ide, here are
some more things to do :)

1. Can you connect your machine to another over a serial
console so that you can catch a clean OOPS. If you don't have
a serial cable, you can try doing this with a netconsole, see
<Documentation/networking/netconsole.txt> in the kernel sources. And
if even that is not an option, try making a picture which contains the
first oops from the beginning and doesn't cut off the register dump.
Something like your https://bugzilla.kernel.org/attachment.cgi?id=26730
but without the shaky effects :)

2. Go to your kernel source tree and do

objdump -d drivers/ide/ide-io.o | less

then look for the line similar to

"000000000000070b <ide_complete_rq>:"

and copy/paste here the whole block all the way to the end of that
function, i.e. line that looks like

" 755:   c3                      retq"

3. Just to make sure, I think your "shaky" picture showed that there
are no proprietary kernel modules your using, e.g. nvidia GPU drivers,
but let me make sure I see it correctly: you're not installing any
closed-source, proprietary crap, right?

I think this is all for now, thanks for your help.

Regards,
Boris.

-- 
Configure bugmail: https://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are watching the assignee of the bug.
