From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 2/4] libata-core.c: add another IRQ calls
Date: Wed, 17 Jan 2007 11:49:34 -0500
Message-ID: <45AE539E.2040600@garzik.org>
References: <200701170924.l0H9OsdG002754@harpo.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:37050 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932583AbXAQQtw (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 17 Jan 2007 11:49:52 -0500
In-Reply-To: <200701170924.l0H9OsdG002754@harpo.it.uu.se>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mikael Pettersson <mikpe@it.uu.se>
Cc: alan@lxorguk.ukuu.org.uk, benh@kernel.crashing.org, akira2.iguchi@toshiba.co.jp, arnd@arndb.de, kou.ishizaki@toshiba.co.jp, linas@austin.ibm.com, linux-ide@vger.kernel.org, linuxppc-dev@ozlabs.org, paulus@samba.org

Mikael Pettersson wrote:
> If there is a highly common case, the code for that case
> is available, and the code is cheap to execute (doesn't
> require too many additional variables), then having an
> explicit test + inline code is preferred. If any of these
> conditions isn't met, then I wouldn't bother converting
> the call to the if/inline/call combo.


To be a bit more specific, the branch being taken, or not, depends on 
the system setup.  For example, in sata_promise's case, with no other 
SATA controllers in use,

	if (ap->ops->irq_on)
		ap->ops->irq_on(ap);
	else
		ata_irq_on(ap);

the direct function call will ALWAYS be called.  But if you had a weird 
system with both Cell and Promise PDC203xx, then the branch is dependent 
on whether the activity comes from the Cell SATA or Promise SATA.

So it's highly predictable in a great many cases.

And it should be noted that it is a direct function call not inline, 
thus its if/indirect/direct not if/indirect/inline.

Does that change the answer at all?

	Jeff


