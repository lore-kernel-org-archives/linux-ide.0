From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [1/2] 2.6.22-rc6: known regressions v2
Date: Fri, 29 Jun 2007 17:59:20 +0100
Message-ID: <20070629175920.6af0c62b@the-village.bc.nu>
References: <46852187.3080504@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from [81.2.110.250] ([81.2.110.250]:55668 "EHLO the-village.bc.nu"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1758103AbXF2Qyk (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 29 Jun 2007 12:54:40 -0400
In-Reply-To: <46852187.3080504@googlemail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Rodrigo Luiz <troops.of.doom@gmail.com>, alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, Jaroslav Kysela <perex@suse.cz>, Ben Collins <bcollins@ubuntu.com>, reiserfs-devel@vger.kernel.org, "Vladimir V. Saveliev" <vs@namesys.com>, Randy Dunlap <randy.dunlap@oracle.com>, linux-ide@vger.kernel.org, David Chinner <dgc@sgi.com>, Jeff Garzik <jeff@garzik.org>, Tejun Heo <htejun@gmail.com>, Rodney Gordon II <meff@spherevision.org>

> SATA/PATA
> 
> Subject    : libata IT821X driver still fails! Hard-freezes system
> References : http://lkml.org/lkml/2007/6/14/82
> Submitter  : Rodney Gordon II <meff@spherevision.org>
> Status     : unknown

Not a regression as it seems this user's box has always been broken. I've
been running heavy testing with 2.6.22rc6 and IT8212 and its working
reliably for the "dumb" mode in question.

The hardware mode needs a fix Tejun has queued somewhere (probably in
Jeff's vast backlog) and then works too.

I'm not even sure this report is IT8212 related rather than just an IRQ
storm
