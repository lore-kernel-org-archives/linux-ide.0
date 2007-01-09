From: Adrian Bunk <bunk@stusta.de>
Subject: 2.6.20-rc4: known unfixed regressions (v2)
Date: Tue, 9 Jan 2007 06:25:10 +0100
Message-ID: <20070109052510.GG25007@stusta.de>
References: <Pine.LNX.4.64.0701062216210.3661@woody.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0701062216210.3661@woody.osdl.org>
Sender: linux-acpi-owner@vger.kernel.org
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Malte =?iso-8859-1?Q?Schr=F6der?= <MalteSch@gmx.de>, reiserfs-dev@namesys.com, Cijoml Cijomlovic Cijomlov <cijoml@volny.cz>, ttb@tentacle.dhs.org, rml@novell.com, Jon Smirl <jonsmirl@gmail.com>, Damien Wyart <damien.wyart@free.fr>, Aaron Sethman <androsyn@ratbox.org>, alan@lxorguk.ukuu.org.uk, linux-ide@vger.kernel.org, Uwe Bugla <uwe.bugla@gmx.de>, Florin Iucha <florin@iucha.net>, Jiri Kosina <jkosina@suse.cz>, dmitry.torokhov@gmail.com, linux-input@atrey.karlin.mff.cuni.cz, greg@kroah.com, linux-usb-devel@lists.sourceforge.net, Berthold Cogel <cogel@rrz.uni-koeln.de>, Alexey Starikovskiy <alexey.y.starikovskiy@linux.intel.com>, len.brown@intel.com, linux-acpi@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

This email lists some known regressions in 2.6.20-rc4 compared to 2.6.1=
9
that are not yet fixed in Linus' tree.

If you find your name in the Cc header, you are either submitter of one
of the bugs, maintainer of an affectected subsystem or driver, a patch
of you caused a breakage or I'm considering you in any other way possib=
ly
involved with one or more of these issues.

Due to the huge amount of recipients, please trim the Cc when answering=
=2E


Subject    : BUG: at mm/truncate.c:60 cancel_dirty_page()  (reiserfs)
References : http://lkml.org/lkml/2007/1/7/117
Submitter  : Malte Schr=F6der <MalteSch@gmx.de>
Status     : unknown


Subject    : BUG: at fs/inotify.c:172 set_dentry_child_flags()
References : http://bugzilla.kernel.org/show_bug.cgi?id=3D7785
Submitter  : Cijoml Cijomlovic Cijomlov <cijoml@volny.cz>
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


Subject    : problems with CD burning
References : http://www.spinics.net/lists/linux-ide/msg06545.html
Submitter  : Uwe Bugla <uwe.bugla@gmx.de>
Status     : unknown


Subject    : USB keyboard unresponsive after some time
References : http://lkml.org/lkml/2006/12/25/35
             http://lkml.org/lkml/2006/12/26/106
Submitter  : Florin Iucha <florin@iucha.net>
Handled-By : Jiri Kosina <jkosina@suse.cz>
Status     : problem is being debugged


Subject    : Acer Extensa 3002 WLMi: 'shutdown -h now' reboots the syst=
em
References : http://lkml.org/lkml/2006/12/25/40
Submitter  : Berthold Cogel <cogel@rrz.uni-koeln.de>
Handled-By : Alexey Starikovskiy <alexey.y.starikovskiy@linux.intel.com=
>
Status     : problem is being debugged


-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
