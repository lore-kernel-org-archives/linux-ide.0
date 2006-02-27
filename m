From: "Yu, Luming" <luming.yu@intel.com>
Subject: RE: 2.6.16-rc5: known regressions
Date: Mon, 27 Feb 2006 17:04:15 +0800
Message-ID: <3ACA40606221794F80A5670F0AF15F840B0CE273@pdsmsx403>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S932315AbWB0JGJ@vger.kernel.org>
Content-class: urn:content-classes:message
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Tom Seeley <redhat@tomseeley.co.uk>, Dave Jones <davej@redhat.com>, Jiri Slaby <jirislaby@gmail.com>, michael@mihu.de, mchehab@infradead.org, v4l-dvb-maintainer@linuxtv.org, video4linux-list@redhat.com, Brian Marete <bgmarete@gmail.com>, Ryan Phillips <rphillips@gentoo.org>, gregkh@suse.de, linux-usb-devel@lists.sourceforge.net, Sanjoy Mahajan <sanjoy@mrao.cam.ac.uk>, "Brown, Len" <len.brown@intel.com>, linux-acpi@vger.kernel.org, Mark Lord <lkml@rtr.ca>, Randy Dunlap <rdunlap@xenotime.net>, jgarzik@pobox.com, linux-ide@vger.kernel.org, Duncan <1i5t5.duncan@cox.net>, Pavlik Vojtech <vojtech@suse.cz>, linux-input@atrey.karlin.mff.cuni.cz, Meelis Roos <mroos@linux.ee>
List-Id: linux-ide@vger.kernel.org

>Subject    : S3 sleep hangs the second time - 600X
>References : http://bugzilla.kernel.org/show_bug.cgi?id=5989
>Submitter  : Sanjoy Mahajan <sanjoy@mrao.cam.ac.uk>
>Handled-By : Luming Yu <luming.yu@intel.com>
>Status     : is being debugged,
>             we might want to change the default back for 2.6.16:
>             http://lkml.org/lkml/2006/2/25/101
>

Accordint to bug report, the BIOS DSDT is modified.
I don't know how these changes affect the results
of suspend/resume. But, it is clear this is NOT right approach 
to fix problem. Hence, I need the testing report with 
un-modified DSDT on TP 600X, bios 1.11.

--Luming
