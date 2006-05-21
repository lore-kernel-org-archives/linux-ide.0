From: Carl-Daniel Hailfinger <c-d.hailfinger.devel.2006@gmx.net>
Subject: Re: 2.6.16-rc5: known regressions [TP 600X S3, vanilla DSDT]
Date: Sun, 21 May 2006 02:40:18 +0200
Message-ID: <446FB6F2.7040803@gmx.net>
References: <E1FhbYy-0005jL-00@skye.ra.phy.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <E1FhbYy-0005jL-00@skye.ra.phy.cam.ac.uk>
Sender: linux-acpi-owner@vger.kernel.org
To: Sanjoy Mahajan <sanjoy@mrao.cam.ac.uk>
Cc: trenn@suse.de, "Yu, Luming" <luming.yu@intel.com>, linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>, Tom Seeley <redhat@tomseeley.co.uk>, Dave Jones <davej@redhat.com>, Jiri Slaby <jirislaby@gmail.com>, michael@mihu.de, mchehab@infradead.org, v4l-dvb-maintainer@linuxtv.org, video4linux-list@redhat.com, Brian Marete <bgmarete@gmail.com>, Ryan Phillips <rphillips@gentoo.org>, gregkh@suse.de, linux-usb-devel@lists.sourceforge.net, "Brown, Len" <len.brown@intel.com>, linux-acpi@vger.kernel.org, Mark Lord <lkml@rtr.ca>, Randy Dunlap <rdunlap@xenotime.net>, jgarzik@pobox.com, linux-ide@vger.kernel.org, Duncan <1i5t5.duncan@cox.net>, Pavlik Vojtech <vojtech@suse.cz>, linux-input@atrey.karlin.mff.cuni.cz, Meelis Roos <mroos@linux.ee>
List-Id: linux-ide@vger.kernel.org

Sanjoy Mahajan wrote:
> That seems likely, thanks for the pointer: Besides the ACPI sleep
> hangs, this machine (TP 600X) has fan troubles upon S3 resume.  The
> problems don't do harm (the damn fan keeps turning on when it
> shouldn't), but that's probably chance.  Various patches that I tested
> for S3 resume hangs reversed this fan behavior, making the fan refuse
> to turn on when it should have.  The same problem happened after
> resume from swsusp (bugzilla #5000).

Please try kernel 2.6.16.17 (just released). It has the SMBus fix which
may fix resume and fan behaviour.


Regards,
Carl-Daniel
-- 
http://www.hailfinger.org/
