From: Sanjoy Mahajan <sanjoy@mrao.cam.ac.uk>
Subject: Re: 2.6.16-rc5: known regressions [TP 600X S3, vanilla DSDT]
Date: Fri, 10 Mar 2006 06:27:11 +0000
Message-ID: <E1FHb5j-00085s-00@skye.ra.phy.cam.ac.uk>
References: <3ACA40606221794F80A5670F0AF15F840B2802AD@pdsmsx403>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mraos.ra.phy.cam.ac.uk ([131.111.48.8]:18104 "EHLO
	mraos.ra.phy.cam.ac.uk") by vger.kernel.org with ESMTP
	id S1751800AbWCJG1Q (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 10 Mar 2006 01:27:16 -0500
In-Reply-To: Your message of "Fri, 10 Mar 2006 14:12:06 +0800."
             <3ACA40606221794F80A5670F0AF15F840B2802AD@pdsmsx403>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Yu, Luming" <luming.yu@intel.com>
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>, Tom Seeley <redhat@tomseeley.co.uk>, Dave Jones <davej@redhat.com>, Jiri Slaby <jirislaby@gmail.com>, michael@mihu.de, mchehab@infradead.org, v4l-dvb-maintainer@linuxtv.org, video4linux-list@redhat.com, Brian Marete <bgmarete@gmail.com>, Ryan Phillips <rphillips@gentoo.org>, gregkh@suse.de, linux-usb-devel@lists.sourceforge.net, "Brown, Len" <len.brown@intel.com>, linux-acpi@vger.kernel.org, Mark Lord <lkml@rtr.ca>, Randy Dunlap <rdunlap@xenotime.net>, jgarzik@pobox.com, linux-ide@vger.kernel.org, Duncan <1i5t5.duncan@cox.net>, Pavlik Vojtech <vojtech@suse.cz>, linux-input@atrey.karlin.mff.cuni.cz, Meelis Roos <mroos@linux.ee>

> I assume you have tested ec_intr=0 and ec_intr=1.

Right: I forgot to mention it, but I did test it both ways, and
ec_intr=0 is fine.

>> These noises happen when printing via the wireless card or via USB
>> (to a different HP inkjet),

> Interesting, open bug for this.

I cannot reproduce it with the vanilla DSDT, only with the modified
one.  But:

> The ground rule is Don't use modified DSDT.
> If you do that,  the results won't be trusted.

>> exregion-0290 [36] ex_system_io_space_han: system_iO 1 (8 
>> width) Address=00000000000000B2
>>
>> repeated endlessly.

> I need calltrace for this 

Looking at /proc/acpi/debug_level, I see several debugging choices
that might give the calltrace you want.  Let me know which ones are
essential (I'd turn all of them on; however, I found when trying to
track this down earlier that the bug would slither away if I had too
much debugging turned on):

ACPI_LV_DISPATCH	       0x00000100 [ ]
ACPI_LV_EXEC		       0x00000200 [ ]
ACPI_LV_NAMES		       0x00000400 [ ]
ACPI_LV_FUNCTIONS	       0x00200000 [ ]

By the way, a long standing buglet for me is that 'cat
/proc/acpi/debug_level' truncates the output to 1024 bytes.  So I have
to do 'cat /proc/acpi/debug_level | cat' so that the first cat doesn't
find that its stdout is a tty and try to reduce its buffer size from
4096 (big enough) to 1024.  A patch is available at
<http://bugzilla.kernel.org/show_bug.cgi?id=5076>

> BTW, do you still think this is a regression?

I'm 95% sure, because booting with ec_intr=0 avoids the problem, so
the commit that made ec_intr=1 the default almost certainly also makes
this bug appear.

-Sanjoy

`Never underestimate the evil of which men of power are capable.'
         --Bertrand Russell, _War Crimes in Vietnam_, chapter 1.
