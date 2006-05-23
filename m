From: "Yu, Luming" <luming.yu@intel.com>
Subject: RE: 2.6.16-rc5: known regressions [TP 600X S3, vanilla DSDT]
Date: Tue, 23 May 2006 21:29:36 +0800
Message-ID: <554C5F4C5BA7384EB2B412FD46A3BAD11206E3@pdsmsx411.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:61606 "EHLO
	orsmga101-1.jf.intel.com") by vger.kernel.org with ESMTP
	id S932209AbWEWN3o convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 23 May 2006 09:29:44 -0400
Content-class: urn:content-classes:message
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: trenn@suse.de, Sanjoy Mahajan <sanjoy@mrao.cam.ac.uk>
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>, Tom Seeley <redhat@tomseeley.co.uk>, Dave Jones <davej@redhat.com>, Jiri Slaby <jirislaby@gmail.com>, michael@mihu.de, mchehab@infradead.org, v4l-dvb-maintainer@linuxtv.org, video4linux-list@redhat.com, Brian Marete <bgmarete@gmail.com>, Ryan Phillips <rphillips@gentoo.org>, gregkh@suse.de, linux-usb-devel@lists.sourceforge.net, "Brown, Len" <len.brown@intel.com>, linux-acpi@vger.kernel.org, Mark Lord <lkml@rtr.ca>, Randy Dunlap <rdunlap@xenotime.net>, jgarzik@pobox.com, linux-ide@vger.kernel.org, Duncan <1i5t5.duncan@cox.net>, Pavlik Vojtech <vojtech@suse.cz>, linux-input@atrey.karlin.mff.cuni.cz, Meelis Roos <mroos@linux.ee>, Carl-Daniel Hailfinger <c-d.hailfinger.devel.2006@gmx.net>


>> exregion-0185 [36] ex_system_memory_space: system_memory 0 
>(32 width) Address=0000000023FDFFC0
>> exregion-0185 [36] ex_system_memory_space: system_memory 1 
>(32 width) Address=0000000023FDFFC0
>> exregion-0290 [36] ex_system_io_space_han: system_iO 1 (8 
>width) Address=00000000000000B2
>> 
>> repeated endlessly.

Hmm.. interesting.  This looks like same error with TP600X.

>
>This sounds like the problem Daniel had on his Samsung P35 recently.
>He could fix it by getting rid of some asus_unhide_smbus stuff or the
>otherway around, adding asus_unhide_smbus quirks in the S3 resume code.
>
>This thread was recently posted on lkml:
>Re: [patch] smbus unhiding kills thermal management
>
>Here are some more details, for me that sounds related...:
>https://bugzilla.novell.com/show_bug.cgi?id=173420
>

But this Samsung P35 don't have _GLK. So, I think TP 600x has
a different problem with Samsung P35.

Actually, Sanjoy has a workaround to solve TP 600X S3 issue.
What we need to do is to come up with a clean patch. 
It is on to-do list. 

Thanks,
Luming
