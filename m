From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: hpt374 sata (Highpoint Rocket 1540)
Date: Thu, 2 Aug 2007 14:12:28 +0100
Message-ID: <20070802141228.1d1b3aa3@the-village.bc.nu>
References: <1185880124.3483.25.camel@localhost>
	<46AF76D7.8050800@ru.mvista.com>
	<1185916925.8484.23.camel@orchid.arb.net>
	<200707312332.10820.bzolnier@gmail.com>
	<46B08D63.4040205@ru.mvista.com>
	<1185983536.16340.3.camel@orchid.arb.net>
	<46B0ADB6.60207@ru.mvista.com>
	<1185988529.16340.5.camel@orchid.arb.net>
	<46B0CEC0.60504@ru.mvista.com>
	<20070801234332.3d28f7b2@the-village.bc.nu>
	<46B1D0E0.20503@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:56592 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751718AbXHBNFd (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 2 Aug 2007 09:05:33 -0400
In-Reply-To: <46B1D0E0.20503@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: Bob Ham <rah@bash.sh>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-ide@vger.kernel.org

> > Since you don't do a reset is it not sufficient to check word93 on the
> 
>     Ah, you mean to identify a SATA drive?  Need to try this...

That is the basic approach libata uses, and I've been runnin for a while
with patches to actually pick this case up and flip the cable type as
well. PATA controller/SATA drive rather gives away the presence of a
bridge, although which end is one thing I've yet to work out a way to
probe

> > initial identify scan in PIO. Or if you do a reset the signature.
> 
>     Hm, the taskfile signature, you mean?..

Yes because that is if I remember rightly also different for a SATA device
