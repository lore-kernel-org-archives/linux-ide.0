From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [1/2] 2.6.22-rc6: known regressions v2
Date: Fri, 29 Jun 2007 19:06:02 +0100
Message-ID: <20070629190602.4ef6a0cb@the-village.bc.nu>
References: <46852187.3080504@googlemail.com>
	<20070629175920.6af0c62b@the-village.bc.nu>
	<468543CE.6080401@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:47137 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754755AbXF2SAu (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 29 Jun 2007 14:00:50 -0400
In-Reply-To: <468543CE.6080401@redhat.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Chuck Ebbert <cebbert@redhat.com>
Cc: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Rodrigo Luiz <troops.of.doom@gmail.com>, alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, Jaroslav Kysela <perex@suse.cz>, Ben Collins <bcollins@ubuntu.com>, reiserfs-devel@vger.kernel.org, "Vladimir V. Saveliev" <vs@namesys.com>, Randy Dunlap <randy.dunlap@oracle.com>, linux-ide@vger.kernel.org, David Chinner <dgc@sgi.com>, Jeff Garzik <jeff@garzik.org>, Tejun Heo <htejun@gmail.com>, Rodney Gordon II <meff@spherevision.org>

> > I'm not even sure this report is IT8212 related rather than just an IRQ
> > storm
> 
> Why does the driver report "irq 0"?
> 
> ata7: PATA max UDMA/133 cmd <blah> ctl <blah> bmdma <blah> irq 0  <====
> 
> Above that, the ACPI layer says it assigned IRQ 20

Because the libata core code in 2.6.22rc6 reports all the ports and IRQ
values wrongly ?

Alan
