From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 2/4] libata-core.c: add another IRQ calls
Date: Tue, 16 Jan 2007 17:04:27 -0500
Message-ID: <45AD4BEB.4070507@garzik.org>
References: <200701161046.l0GAk5Go019691@toshiba.co.jp> <20070116120335.59b4491d@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:59045 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751695AbXAPWEj (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 16 Jan 2007 17:04:39 -0500
In-Reply-To: <20070116120335.59b4491d@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan <alan@lxorguk.ukuu.org.uk>, benh@kernel.crashing.org
Cc: Akira Iguchi <akira2.iguchi@toshiba.co.jp>, linux-ide@vger.kernel.org, linuxppc-dev@ozlabs.org, kou.ishizaki@toshiba.co.jp, arnd@arndb.de, paulus@samba.org, linas@austin.ibm.com

Alan wrote:
> Jeff - at some point we could eliminate a lot of the NULL checks like
> these by having the registration code fill in the defaults where
> appropriate ?

libata policy up until this point has been to require all drivers fill 
in the hook, either with the commonly-used default, or with their own 
variant.  Thus, no NULL checks for required hooks, and you get an oops 
if you fail this requirement.  I like that better than defaults buried 
inside libata-core, where it is easier for programmers to forget them.

But actually, it's an open question for the compiler guys whether this 
case is preferred:

	if (ap->ops->hook)
		ap->ops->hook(foo, bar);
	else
		commonly_used_default(foo, bar);

or this:

	ap->ops->hook(foo, bar);

With advanced branch prediction in modern CPUs, ISTR the first case may 
be worth considering, even with the branch.

If the second case is preferred, then Akira should make a bombing run 
through each driver, applying the patch
+	.irq_on		= ata_irq_on

No NULL checks or registration code bother, in that case.

Comments welcome...

	Jeff


