From: Mauro Carvalho Chehab <mchehab@infradead.org>
Subject: Re: [v4l-dvb-maintainer] 2.6.16-rc5: known regressions
Date: Thu, 02 Mar 2006 11:00:11 -0300
Message-ID: <1141308011.5884.5.camel@localhost>
References: <Pine.LNX.4.64.0602262122000.22647@g5.osdl.org>
	 <20060227061354.GO3674@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20060227061354.GO3674@stusta.de>
Sender: linux-acpi-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>, video4linux-list@redhat.com, Jiri Slaby <jirislaby@gmail.com>, Ryan Phillips <rphillips@gentoo.org>, linux-ide@vger.kernel.org, Randy Dunlap <rdunlap@xenotime.net>, linux-input@atrey.karlin.mff.cuni.cz, linux-usb-devel@lists.sourceforge.net, Meelis Roos <mroos@linux.ee>, Luming Yu <luming.yu@intel.com>, linux-acpi@vger.kernel.org, Pavlik Vojtech <vojtech@suse.cz>, Sanjoy Mahajan <sanjoy@mrao.cam.ac.uk>, jgarzik@pobox.com, len.brown@intel.com, Brian Marete <bgmarete@gmail.com>, Dave Jones <davej@redhat.com>, v4l-dvb-maintainer@linuxtv.org, Duncan <1i5t5.duncan@cox.net>, Tom Seeley <redhat@tomseeley.co.uk>, michael@mihu.de, gregkh@suse.de, Mark Lord <lkml@rtr.ca>
List-Id: linux-ide@vger.kernel.org


> Subject    : Oops in Kernel 2.6.16-rc4 on Modprobe of saa7134.ko
> References : http://lkml.org/lkml/2006/2/20/122
> Submitter  : Brian Marete <bgmarete@gmail.com>
> Status     : unknown

This is not a regression, since the user is not configuring saa7134 with
the right card. 

Cheers, 
Mauro.

