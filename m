From: Mark Lord <liml@rtr.ca>
Subject: Re: laptop reboots right after hibernation
Date: Wed, 28 Nov 2007 09:11:05 -0500
Message-ID: <474D76F9.6080504@rtr.ca>
References: <473730F6.2010900@dbservice.com> <20071118105214.GB7299@ucw.cz> <4740692E.7010801@dbservice.com> <47409DA3.7070909@dbservice.com> <1195551141.2792.3.camel@localhost.localdomain> <474CBFB6.4020105@gmail.com> <1196253340.2884.1.camel@localhost.localdomain> <474D6EA7.2000506@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:2188 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752723AbXK1OLH (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 28 Nov 2007 09:11:07 -0500
In-Reply-To: <474D6EA7.2000506@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Kjartan Maraas <kmaraas@broadpark.no>, Tomas Carnecky <tom@dbservice.com>, Pavel Machek <pavel@ucw.cz>, linux-ide@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>, Jeff Garzik <jeff@garzik.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>

Tejun Heo wrote:
>
> Your BIOS is probably trying to issue DCO freeze lock to all drives.  I
> don't have the faintest idea why it does but it does.  I think there are
> several choices here.
> 
> 1. Ignore device errors for _GTF commands.  Report the failure with
> KERN_DEBUG priority and just keep processing.  ISTR there was a patch to
> do this.  Anyone knows what happened to it.
..

Since we now *know* that this is how it has to be done
(as otherwise the BIOS would never even attempt DCO here
because most drives don't support it yet),
then ignoring the return value seems to be a useful strategy.

> 2. Filter out certain commands from ACPI.  I definitely don't like BIOS
> locking up random features via _GTF commands.  It makes debugging difficult.
..

Mmmm.. I agree there, too!  I'm not big on filtering out commands
that *we* don't happen to like, but for this specific opcode, yes.

> 3. Look at opcode on failure and ignore error for certain operations.
..

Number 1. would take care of this.

Cheers
