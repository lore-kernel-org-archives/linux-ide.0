From: Sanjoy Mahajan <sanjoy@mrao.cam.ac.uk>
Subject: Re: 2.6.16-rc5: known regressions [TP 600X S3, vanilla DSDT]
Date: Fri, 10 Mar 2006 00:26:14 -0500
Message-ID: <E1FHa8k-00015b-M5@approximate.corpus.cam.ac.uk>
References: <3ACA40606221794F80A5670F0AF15F840B0CE273@pdsmsx403>
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: Your message of "Mon, 27 Feb 2006 17:04:15 +0800."
             <3ACA40606221794F80A5670F0AF15F840B0CE273@pdsmsx403>
Sender: linux-acpi-owner@vger.kernel.org
To: "Yu, Luming" <luming.yu@intel.com>
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>, Tom Seeley <redhat@tomseeley.co.uk>, Dave Jones <davej@redhat.com>, Jiri Slaby <jirislaby@gmail.com>, michael@mihu.de, mchehab@infradead.org, v4l-dvb-maintainer@linuxtv.org, video4linux-list@redhat.com, Brian Marete <bgmarete@gmail.com>, Ryan Phillips <rphillips@gentoo.org>, gregkh@suse.de, linux-usb-devel@lists.sourceforge.net, "Brown, Len" <len.brown@intel.com>, linux-acpi@vger.kernel.org, Mark Lord <lkml@rtr.ca>, Randy Dunlap <rdunlap@xenotime.net>, jgarzik@pobox.com, linux-ide@vger.kernel.org, Duncan <1i5t5.duncan@cox.net>, Pavlik Vojtech <vojtech@suse.cz>, linux-input@atrey.karlin.mff.cuni.cz, Meelis Roos <mroos@linux.ee>
List-Id: linux-ide@vger.kernel.org

[Re: bugme #5989, head no longer hanging in shame]

From: "Yu, Luming" <luming.yu@intel.com>
> I suggest you to retest, and post dmesg with UN-modified BIOS.

I'm now running/testing an unmodified DSDT with 2.6.16-rc5.  For a while
I had no S3 hangs, but I just noticed them again.  The error is the same
as with the modified DSDT (with slightly different offsets):

exregion-0185 [36] ex_system_memory_space: system_memory 0 (32 width) Address=0000000023FDFFC0
exregion-0185 [36] ex_system_memory_space: system_memory 1 (32 width) Address=0000000023FDFFC0
exregion-0290 [36] ex_system_io_space_han: system_iO 1 (8 width) Address=00000000000000B2

repeated endlessly.

I think the problem resurfaced once I decided to let my sleep.sh script
leave the thermal driver loaded before going into S3 (suspecting that
the bug might come back if I did that).

So I susect that my modified DSDT didn't cause the S3 problems, it
merely exposed one even in the minimal configuration discussed in the
#5989 report.

Which makes me wonder about another bug that disappeared when I switched
to the vanilla DSDT: While printing (via gs+hpijs to an HP photosmart
2710 via the wireless card), the system makes double-beeps as if it were
having the AC adapter plugged and unplugged.  These noises happen when
printing via the wireless card or via USB (to a different HP inkjet),
but not when printing via the parallel port to a Lexmark laserprinter
(using just gs).  Since I didn't do anything to the battery code in the
DSDT, I now wonder whether changing the DSDT merely exposed the issue
but didn't create it.

[From an earlier msg:]
> I think the truth is, for 5989, we need to fix thermal and processor
> driver issue.

I agree, although I think the processor driver is not the culprit.  My
earlier testing with the (with the modified DSDT) worked fine with the
processor module loaded, but hung with processor + thermal loaded.

-Sanjoy

`A society of sheep must in time beget a government of wolves.'
   - Bertrand de Jouvenal
