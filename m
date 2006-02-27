From: Ryan Phillips <ryan@trolocsis.com>
Subject: Re: 2.6.16-rc5: known regressions
Date: Sun, 26 Feb 2006 22:26:41 -0800
Message-ID: <44029BA1.8030601@trolocsis.com>
References: <Pine.LNX.4.64.0602262122000.22647@g5.osdl.org> <20060227061354.GO3674@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1751581AbWB0G1Q@vger.kernel.org>
In-Reply-To: <20060227061354.GO3674@stusta.de>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>, Tom Seeley <redhat@tomseeley.co.uk>, Dave Jones <davej@redhat.com>, Jiri Slaby <jirislaby@gmail.com>, michael@mihu.de, mchehab@infradead.org, v4l-dvb-maintainer@linuxtv.org, video4linux-list@redhat.com, Brian Marete <bgmarete@gmail.com>, Ryan Phillips <rphillips@gentoo.org>, gregkh@suse.de, linux-usb-devel@lists.sourceforge.net, Sanjoy Mahajan <sanjoy@mrao.cam.ac.uk>, Luming Yu <luming.yu@intel.com>, len.brown@intel.com, linux-acpi@vger.kernel.org, Mark Lord <lkml@rtr.ca>, Randy Dunlap <rdunlap@xenotime.net>, jgarzik@pobox.com, linux-ide@vger.kernel.org, Duncan <1i5t5.duncan@cox.net>, Pavlik Vojtech <vojtech@suse.cz>, linux-input@atrey.karlin.mff.cuni.cz, Meelis Roos <mroos@linux.ee>
List-Id: linux-ide@vger.kernel.org

Adrian Bunk wrote:
> This email lists some known regressions in 2.6.16-rc5 compared to 2.6.15.
>
> If you find your name in the Cc header, you are either submitter of one
> of the bugs, maintainer of an affectected subsystem or driver, a patch
> of you was declared guilty for a breakage or I'm considering you in any
> other way possibly involved with one or more of these issues.
>
> Due to the huge amount of recipients, this email has a Reply-To set.
> Please add the appropriate people to the Cc when replying regarding one 
> of these issues.
>
>
> Subject    : usb_submit_urb(ctrl) failed on 2.6.16-rc4-git10 kernel
> References : http://bugzilla.kernel.org/show_bug.cgi?id=6134
> Submitter  : Ryan Phillips <rphillips@gentoo.org>
> Status     : unknown
>
>   
*snipped
> Subject    : total ps2 keyboard lockup from boot
> References : http://bugzilla.kernel.org/show_bug.cgi?id=6130
> Submitter  : Duncan <1i5t5.duncan@cox.net>
> Handled-By : Dmitry Torokhov <dmitry.torokhov@gmail.com>
>              Pavlik Vojtech <vojtech@suse.cz>
> Status     : discussion and debugging in the bug logs
>
>   
*snipped


It appears that Duncan's "total ps2 keyboard lockup from boot" is the
same, or similar problem as mine.
2.6.15.1 kernel is working for me though.

-Ryan
