From: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
Subject: Re: [4/5] 2.6.22-rc4: known regressions
Date: Tue, 05 Jun 2007 16:44:01 +0200
Message-ID: <466576B1.5020105__4141.89540683783$1181054703$gmane$org@googlemail.com>
References: <46657407.1000108@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.169]:32503 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932288AbXFEOoS (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 5 Jun 2007 10:44:18 -0400
Received: by ug-out-1314.google.com with SMTP id j3so192423ugf
        for <linux-ide@vger.kernel.org>; Tue, 05 Jun 2007 07:44:18 -0700 (PDT)
In-Reply-To: <46657407.1000108@googlemail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org, Tejun Heo <htejun@gmail.com>, Jeff Garzik <jeff@garzik.org>, Alan Cox <alan@redhat.com>, Gregor Jasny <gjasny@googlemail.com>, Stephen Smalley <sds@tycho.nsa.gov>, James Morris <jmorris@namei.org>, Eric Paris <eparis@parisplace.org>, Ingo Molnar <mingo@elte.hu>, sparclinux@vger.kernel.org, David Miller <davem@davemloft.net>, Mikael Pettersson <mikpe@it.uu.se>, linux-pm@lists.linux-foundation.org, "Rafael J. Wysocki" <rjw@sisk.pl>, Pavel Machek <pavel@ucw.cz>, Simon <sg02r@ecs.soton.ac.uk>, linux-usb-devel@lists.sourceforge.net, Greg Kroah-Hartman <gregkh@suse.de>

Hi all,

Here is a list of some known regressions in 2.6.22-rc4.

=46eel free to add new regressions/remove fixed etc.
http://kernelnewbies.org/known_regressions



SATA/PATA

Subject    : 22-rc3 broke the CDROM in Dell notebook
References : http://lkml.org/lkml/2007/5/27/63
Submitter  : Gregor Jasny <gjasny@googlemail.com>
Handled-By : Tejun Heo <htejun@gmail.com>
             Jeff Garzik <jeff@garzik.org>
Caused-By  : Tejun Heo <htejun@gmail.com>
             commit d4b2bab4f26345ea1803feb23ea92fbe3f6b77bc
Status     : problem is being debugged



SELinux

Subject    : very high non-preempt latency in context_struct_compute_av=
()
References : http://lkml.org/lkml/2007/6/4/78
Submitter  : Ingo Molnar <mingo@elte.hu>
Handled-By : Stephen Smalley <sds@tycho.nsa.gov>
             James Morris <jmorris@namei.org>
Status     : unknown



Sparc64

Subject    : 2.6.22-rc broke X on Ultra5
References : http://lkml.org/lkml/2007/5/22/78
Submitter  : Mikael Pettersson <mikpe@it.uu.se>
Handled-By : David Miller <davem@davemloft.net>
Status     : problem is being debugged



Suspend

Subject    : hibernate(?) fails totally - regression
References : http://lkml.org/lkml/2007/6/1/401
Submitter  : David Greaves <david@dgreaves.com>
Handled-By : Rafael J. Wysocki <rjw@sisk.pl>
Caused-By  : Tejun Heo <htejun@gmail.com>
             commit 9666f4009c22f6520ac3fb8a19c9e32ab973e828
Status     : problem is being debugged

Subject    : panic on s3 resume with uhci_hcd module
References : http://bugzilla.kernel.org/show_bug.cgi?id=3D8565
Submitter  : Simon <sg02r@ecs.soton.ac.uk>
Handled-By : Rafael J. Wysocki <rjw@sisk.pl>
Status     : Unknown



Regards,
Michal

--
"Najbardziej brakowa=B3o mi twojego milczenia."
-- Andrzej Sapkowski "Co=B6 wi=EAcej"
