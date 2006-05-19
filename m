From: Thomas Renninger <trenn@suse.de>
Subject: Re: 2.6.16-rc5: known regressions [TP 600X S3, vanilla DSDT]
Date: Fri, 19 May 2006 15:44:17 +0200
Message-ID: <1148046258.9319.441.camel@queen.suse.de>
References: <E1FHa8k-00015b-M5@approximate.corpus.cam.ac.uk>
Reply-To: trenn@suse.de
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <E1FHa8k-00015b-M5@approximate.corpus.cam.ac.uk>
Sender: linux-acpi-owner@vger.kernel.org
To: Sanjoy Mahajan <sanjoy@mrao.cam.ac.uk>
Cc: "Yu, Luming" <luming.yu@intel.com>, linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>, Tom Seeley <redhat@tomseeley.co.uk>, Dave Jones <davej@redhat.com>, Jiri Slaby <jirislaby@gmail.com>, michael@mihu.de, mchehab@infradead.org, v4l-dvb-maintainer@linuxtv.org, video4linux-list@redhat.com, Brian Marete <bgmarete@gmail.com>, Ryan Phillips <rphillips@gentoo.org>, gregkh@suse.de, linux-usb-devel@lists.sourceforge.net, "Brown, Len" <len.brown@intel.com>, linux-acpi@vger.kernel.org, Mark Lord <lkml@rtr.ca>, Randy Dunlap <rdunlap@xenotime.net>, jgarzik@pobox.com, linux-ide@vger.kernel.org, Duncan <1i5t5.duncan@cox.net>, Pavlik Vojtech <vojtech@suse.cz>, linux-input@atrey.karlin.mff.cuni.cz, Meelis Roos <mroos@linux.ee>, Carl-Daniel Hailfinger <c-d.hailfinger.devel.2006@gmx.net>
List-Id: linux-ide@vger.kernel.org

On Fri, 2006-03-10 at 00:26 -0500, Sanjoy Mahajan wrote:
> [Re: bugme #5989, head no longer hanging in shame]
> 
> From: "Yu, Luming" <luming.yu@intel.com>
> > I suggest you to retest, and post dmesg with UN-modified BIOS.
> 
> I'm now running/testing an unmodified DSDT with 2.6.16-rc5.  For a while
> I had no S3 hangs, but I just noticed them again.  The error is the same
> as with the modified DSDT (with slightly different offsets):
> 
> exregion-0185 [36] ex_system_memory_space: system_memory 0 (32 width) Address=0000000023FDFFC0
> exregion-0185 [36] ex_system_memory_space: system_memory 1 (32 width) Address=0000000023FDFFC0
> exregion-0290 [36] ex_system_io_space_han: system_iO 1 (8 width) Address=00000000000000B2
> 
> repeated endlessly.

This sounds like the problem Daniel had on his Samsung P35 recently.
He could fix it by getting rid of some asus_unhide_smbus stuff or the
otherway around, adding asus_unhide_smbus quirks in the S3 resume code.

This thread was recently posted on lkml:
Re: [patch] smbus unhiding kills thermal management

Here are some more details, for me that sounds related...:
https://bugzilla.novell.com/show_bug.cgi?id=173420

     Thomas

