From: David Miller <davem@davemloft.net>
Subject: Re: pata_ali can't detect partitions
Date: Fri, 20 Nov 2009 14:54:29 -0800 (PST)
Message-ID: <20091120.145429.16637573.davem@davemloft.net>
References: <20091110111125.15a71ed7@lxorguk.ukuu.org.uk>
	<20091119.125445.186207836.davem@davemloft.net>
	<20091119211031.51cf95ff@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:45180
	"EHLO sunset.davemloft.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754151AbZKTWyO (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 20 Nov 2009 17:54:14 -0500
In-Reply-To: <20091119211031.51cf95ff@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: alan@lxorguk.ukuu.org.uk
Cc: gianluca@sottospazio.it, linux-ide@vger.kernel.org

From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Date: Thu, 19 Nov 2009 21:10:31 +0000

> I have exactly zero Sparc64 documentation on the subject. The only Sparc
> related material I have is the C2/C3 post reset stuff. That *might* be a
> relevant difference in behaviour for C2 and C3 devices but only with an
> ALi bridge (ali_c2_c3_postreset)

So I can't even reproduce these ALI problems on my sb100, it works
perfectly fine with Linus's tree.  I'll play around on my sb1000 and
some other drives.

And yes that poking in the ISA bridge during reset is necessary to
make sure all the gates are in the proper initial state.
