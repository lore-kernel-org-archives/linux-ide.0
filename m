From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: 2.6.16-rc5: known regressions
Date: Mon, 27 Feb 2006 01:54:17 -0500
Message-ID: <4402A219.8010501@pobox.com>
References: <Pine.LNX.4.64.0602262122000.22647@g5.osdl.org> <20060227061354.GO3674@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20060227061354.GO3674@stusta.de>
Sender: linux-acpi-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>, Tom Seeley <redhat@tomseeley.co.uk>, Dave Jones <davej@redhat.com>, Jiri Slaby <jirislaby@gmail.com>, michael@mihu.de, mchehab@infradead.org, v4l-dvb-maintainer@linuxtv.org, video4linux-list@redhat.com, Brian Marete <bgmarete@gmail.com>, Ryan Phillips <rphillips@gentoo.org>, gregkh@suse.de, linux-usb-devel@lists.sourceforge.net, Sanjoy Mahajan <sanjoy@mrao.cam.ac.uk>, Luming Yu <luming.yu@intel.com>, len.brown@intel.com, linux-acpi@vger.kernel.org, Mark Lord <lkml@rtr.ca>, Randy Dunlap <rdunlap@xenotime.net>, linux-ide@vger.kernel.org, Duncan <1i5t5.duncan@cox.net>, Pavlik Vojtech <vojtech@suse.cz>, linux-input@atrey.karlin.mff.cuni.cz, Meelis Roos <mroos@linux.ee>
List-Id: linux-ide@vger.kernel.org

Adrian Bunk wrote:
> Subject    : 2.6.16-rc[34]: resume-from-RAM unreliable (SATA)
> References : http://lkml.org/lkml/2006/2/20/159
> Submitter  : Mark Lord <lkml@rtr.ca>
> Handled-By : Randy Dunlap <rdunlap@xenotime.net>
> Status     : one of Randy's patches seems to fix it


This is not a regression, libata suspend/resume has always been crappy. 
  It's under active development (by Randy, among others) to fix this.

	Jeff


