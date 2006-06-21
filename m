From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: 2.6.17-rc6-mm2 VIA PATA fails on some ATAPI drives
Date: Wed, 21 Jun 2006 12:42:05 +0100
Message-ID: <1150890125.15275.50.camel@localhost.localdomain>
References: <4495A3E6.6010405@free.fr>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:60346 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S932067AbWFUL0x
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 21 Jun 2006 07:26:53 -0400
In-Reply-To: <4495A3E6.6010405@free.fr>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: matthieu castet <castet.matthieu@free.fr>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>, linux-ide@vger.kernel.org

Ar Sul, 2006-06-18 am 21:05 +0200, ysgrifennodd matthieu castet:
> I make a patch that seem to make work the drive. It is attached as 
> pata-via-atapi.I don't know if is the correct thing to do.

To be honest I am still very confused about this one as well. It isn't
just occurring with the CDR-6S48 either, a few other reports look as if
they are the same kind of problem.

I didn't spot anything in the ATAPI spec but I need to go back over it
in case I missed something here. Similarly I can find nothing in the VIA
docs to explain the occurence.

I don't see anything fundamentally wrong with the patch, I'd just like
to understand better the real reasons behind it.

