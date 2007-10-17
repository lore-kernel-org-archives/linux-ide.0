From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: pata_via refuses to detect one drive
Date: Wed, 17 Oct 2007 21:31:55 +0100
Message-ID: <20071017213155.2589bf8f@the-village.bc.nu>
References: <47161F09.3040003@msgid.tls.msk.ru>
	<20071017165007.77471e8d@the-village.bc.nu>
	<471653C4.9090709@msgid.tls.msk.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:56917 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1760084AbXJQU31 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 17 Oct 2007 16:29:27 -0400
In-Reply-To: <471653C4.9090709@msgid.tls.msk.ru>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: linux-ide@vger.kernel.org

> > This looks like both drives end up trying to be the slave ? Its certainly
> > very vey confused at this point. Interesting it works with the BIOS doing
> > the reset, wonder what the difference is.
> 
> Not only it works with BIOS, it also works with via82cxxx just fine.

The via82cxxx driver doesn't go off and reset everything unless it gets
bad error cases.
 
> > How are the drives jumpered and does it work with just one of the two
> > present ?
> 
> That's an interesting question.  The machine is remote, and there's
> no one on site who's able to check it.  I'll try to get reach of it,
> hopefully it will be soon enough.  In any case, it looks like the
> jumpers are OK, or else it shouldnt work with IDE module as well.

Maybe. But its useful to know and it helps narrow down the fault. I've no
idea whether the problem is hardware or software. What I am sure of
though is if the BIOS and old driver work we should be able to make the
new one work. My first guess is still a driver bug, and second some kind
of probing interaction. BIOSen usually use Hal's code so we've got a fair
idea of what the BIOS will do.

Alan
