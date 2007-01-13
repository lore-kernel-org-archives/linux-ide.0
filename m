From: Adrian Bunk <bunk@stusta.de>
Subject: 2.6.20-rc5: known unfixed regressions
Date: Sat, 13 Jan 2007 08:11:25 +0100
Message-ID: <20070113071125.GG7469@stusta.de>
References: <Pine.LNX.4.64.0701121424520.11200@woody.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mailout.stusta.mhn.de ([141.84.69.5]:2920 "HELO
	mailout.stusta.mhn.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1161296AbXAMHLW (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 13 Jan 2007 02:11:22 -0500
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0701121424520.11200@woody.osdl.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, gd@spherenet.de, alan@lxorguk.ukuu.org.uk, linux-ide@vger.kernel.org, petero2@telia.com, Uwe Bugla <uwe.bugla@gmx.de>, B.Zolnierkiewicz@elka.pw.edu.pl, Jon Smirl <jonsmirl@gmail.com>, Damien Wyart <damien.wyart@free.fr>, Aaron Sethman <androsyn@ratbox.org>, Berthold Cogel <cogel@rrz.uni-koeln.de>, Alexey Starikovskiy <alexey.y.starikovskiy@linux.intel.com>, greg@kroah.com, linux-usb-devel@lists.sourceforge.net, Florin Iucha <florin@iucha.net>, Jiri Kosina <jkosina@suse.cz>, Alan Stern <stern@rowland.harvard.edu>, Cijoml Cijomlovic Cijomlov <cijoml@volny.cz>, Nick Piggin <nickpiggin@yahoo.com.au>, ttb@tentacle.dhs.org, rml@novell.com, Sami Farin <7atbggg02@sneakemail.com>, David Chinner <dgc@sgi.com>, xfs-masters@oss.sgi.com, Malte =?iso-8859-1?Q?Schr=F6der?= <MalteSch@gmx.de>, "Vladimir V. Saveliev" <vs@namesy>

On Fri, Jan 12, 2007 at 02:27:48PM -0500, Linus Torvalds wrote:
>...
> A lot of developers (including me) will be gone next week for=20
> Linux.Conf.Au, so you have a week of rest and quiet to test this, and=
=20
> report any problems.=20
>=20
> Not that there will be any, right? You all behave now!
>...

This still leaves the old regressions we have not yet fixed...


This email lists some known regressions in 2.6.20-rc5 compared to 2.6.1=
9.

If you find your name in the Cc header, you are either submitter of one
of the bugs, maintainer of an affectected subsystem or driver, a patch
of you caused a breakage or I'm considering you in any other way possib=
ly
involved with one or more of these issues.

Due to the huge amount of recipients, please trim the Cc when answering=
=2E


Subject    : pktcdvd fails with pata_amd
References : http://bugzilla.kernel.org/show_bug.cgi?id=3D7810
Submitter  : gd@spherenet.de
Status     : unknown


Subject    : problems with CD burning
References : http://www.spinics.net/lists/linux-ide/msg06545.html
Submitter  : Uwe Bugla <uwe.bugla@gmx.de>
Status     : unknown


Subject    : BUG: scheduling while atomic: hald-addon-stor/...
             cdrom_{open,release,ioctl} in trace
References : http://lkml.org/lkml/2006/12/26/105
             http://lkml.org/lkml/2006/12/29/22
             http://lkml.org/lkml/2006/12/31/133
Submitter  : Jon Smirl <jonsmirl@gmail.com>
             Damien Wyart <damien.wyart@free.fr>
             Aaron Sethman <androsyn@ratbox.org>
Status     : unknown


Subject    : 'shutdown -h now' reboots the system  (CONFIG_USB_SUSPEND)
References : http://lkml.org/lkml/2006/12/25/40
Submitter  : Berthold Cogel <cogel@rrz.uni-koeln.de>
Handled-By : Alexey Starikovskiy <alexey.y.starikovskiy@linux.intel.com=
>
Status     : problem is being debugged


Subject    : USB keyboard unresponsive after some time
References : http://lkml.org/lkml/2006/12/25/35
             http://lkml.org/lkml/2006/12/26/106
Submitter  : Florin Iucha <florin@iucha.net>
Handled-By : Jiri Kosina <jkosina@suse.cz>
             Alan Stern <stern@rowland.harvard.edu>
Status     : problem is being debugged


Subject    : BUG: at fs/inotify.c:172 set_dentry_child_flags()
References : http://bugzilla.kernel.org/show_bug.cgi?id=3D7785
Submitter  : Cijoml Cijomlovic Cijomlov <cijoml@volny.cz>
Handled-By : Nick Piggin <nickpiggin@yahoo.com.au>
Status     : problem is being debugged


Subject    : BUG: at mm/truncate.c:60 cancel_dirty_page()  (XFS)
References : http://lkml.org/lkml/2007/1/5/308
Submitter  : Sami Farin <7atbggg02@sneakemail.com>
Handled-By : David Chinner <dgc@sgi.com>
Status     : problem is being discussed


Subject    : BUG: at mm/truncate.c:60 cancel_dirty_page()  (reiserfs)
References : http://lkml.org/lkml/2007/1/7/117
             http://lkml.org/lkml/2007/1/10/202
Submitter  : Malte Schr=F6der <MalteSch@gmx.de>
Handled-By : Vladimir V. Saveliev <vs@namesys.com>
             Nick Piggin <nickpiggin@yahoo.com.au>
Patch      : http://lkml.org/lkml/2007/1/10/202
Status     : problem is being discussed


