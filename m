From: Mark Lord <lkml@rtr.ca>
Subject: Re: 2.6.16-rc5: known regressions
Date: Mon, 27 Feb 2006 08:36:47 -0500
Message-ID: <4403006F.2070603@rtr.ca>
References: <Pine.LNX.4.64.0602262122000.22647@g5.osdl.org> <20060227061354.GO3674@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([64.26.128.89]:21637 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S1751151AbWB0NhJ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 27 Feb 2006 08:37:09 -0500
In-Reply-To: <20060227061354.GO3674@stusta.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>, Tom Seeley <redhat@tomseeley.co.uk>, Dave Jones <davej@redhat.com>, Jiri Slaby <jirislaby@gmail.com>, michael@mihu.de, mchehab@infradead.org, v4l-dvb-maintainer@linuxtv.org, video4linux-list@redhat.com, Brian Marete <bgmarete@gmail.com>, Ryan Phillips <rphillips@gentoo.org>, gregkh@suse.de, linux-usb-devel@lists.sourceforge.net, Sanjoy Mahajan <sanjoy@mrao.cam.ac.uk>, Luming Yu <luming.yu@intel.com>, len.brown@intel.com, linux-acpi@vger.kernel.org, Randy Dunlap <rdunlap@xenotime.net>, jgarzik@pobox.com, linux-ide@vger.kernel.org, Duncan <1i5t5.duncan@cox.net>, Pavlik Vojtech <vojtech@suse.cz>, linux-input@atrey.karlin.mff.cuni.cz, Meelis Roos <mroos@linux.ee>

Adrian Bunk wrote:
>
> Subject    : 2.6.16-rc[34]: resume-from-RAM unreliable (SATA)
> References : http://lkml.org/lkml/2006/2/20/159
> Submitter  : Mark Lord <lkml@rtr.ca>
> Handled-By : Randy Dunlap <rdunlap@xenotime.net>
> Status     : one of Randy's patches seems to fix it

I'm not certain about this.  It may also have been broken in 2.6.15,
but it (resume) did work fine with 2.6.14.  I've been using Randy's
patches with both 2.6.15 (since -rc?), and 2.6.16-rc.

Cheers
