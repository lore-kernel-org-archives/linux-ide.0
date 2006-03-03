From: Sanjoy Mahajan <sanjoy@mrao.cam.ac.uk>
Subject: Re: 2.6.16-rc5: known regressions
Date: Fri, 03 Mar 2006 02:59:22 +0000
Message-ID: <E1FF0Vm-0002Fl-00@skye.ra.phy.cam.ac.uk>
References: <3ACA40606221794F80A5670F0AF15F840B0CE273@pdsmsx403>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mraos.ra.phy.cam.ac.uk ([131.111.48.8]:25592 "EHLO
	mraos.ra.phy.cam.ac.uk") by vger.kernel.org with ESMTP
	id S1751173AbWCCC72 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 2 Mar 2006 21:59:28 -0500
In-Reply-To: Your message of "Mon, 27 Feb 2006 17:04:15 +0800."
             <3ACA40606221794F80A5670F0AF15F840B0CE273@pdsmsx403>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Yu, Luming" <luming.yu@intel.com>
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>, Tom Seeley <redhat@tomseeley.co.uk>, Dave Jones <davej@redhat.com>, Jiri Slaby <jirislaby@gmail.com>, michael@mihu.de, mchehab@infradead.org, v4l-dvb-maintainer@linuxtv.org, video4linux-list@redhat.com, Brian Marete <bgmarete@gmail.com>, Ryan Phillips <rphillips@gentoo.org>, gregkh@suse.de, linux-usb-devel@lists.sourceforge.net, "Brown, Len" <len.brown@intel.com>, linux-acpi@vger.kernel.org, Mark Lord <lkml@rtr.ca>, Randy Dunlap <rdunlap@xenotime.net>, jgarzik@pobox.com, linux-ide@vger.kernel.org, Duncan <1i5t5.duncan@cox.net>, Pavlik Vojtech <vojtech@suse.cz>, linux-input@atrey.karlin.mff.cuni.cz, Meelis Roos <mroos@linux.ee>

>> Subject    : S3 sleep hangs the second time - 600X
>> References : http://bugzilla.kernel.org/show_bug.cgi?id=5989

From: "Yu, Luming" <luming.yu@intel.com>
> According to bug report, the BIOS DSDT is modified.  I don't know
> how these changes affect the results of suspend/resume. But, it is
> clear this is NOT right approach to fix problem. Hence, I need the
> testing report with un-modified DSDT on TP 600X, bios 1.11.

I'll try it, although I don't think I'll get any data on the problem.
The unmodified DSDT (bios 1.11) lacks an S3 sleep object, so I had to
modify the DSDT even to get S3 to sleep at all.  See
<http://bugzilla.kernel.org/show_bug.cgi?id=3534> for that discussion.
In additional comment #4 there (2004-10-14), you said:

  The root cause of [the missing S3 object] failure is that linux is
  using element in

  const char      *acpi_gbl_sleep_state_names[ACPI_S_STATE_COUNT] =
  {
	  "\_S0_",
	  "\_S1_",
	  "\_S2_",
	  "\_S3_",
	  "\_S4_",
	  "\_S5_"
  };

  to call acpi_get_sleep_type_data, but your box define _S3 under the
  device PNP0A03. So, the evaluating \_S3 will fail.

  The workaround in DSDT is to change _S3 to \_S3_ .
  We can fix it in acpi driver soon.

It looks unchanged in a recent acpi driver
(drivers/acpi/utilities/utglobal.c, line 170, 2.6.16-rc2), so I
suspect S3 won't happen with the vanilla DSDT.

(Sorry, I was away for 10 days and also just saw your info requests in
the bugme #5989.)

-Sanjoy

`Never underestimate the evil of which men of power are capable.'
         --Bertrand Russell, _War Crimes in Vietnam_, chapter 1.
