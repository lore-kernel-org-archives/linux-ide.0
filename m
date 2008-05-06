From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Compact Flash Question
Date: Tue, 6 May 2008 23:09:54 +0100
Message-ID: <20080506230954.6e034cba@core>
References: <005b01c8afc4$77f4ec90$6401a8c0@techwriter>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:56117 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751379AbYEFWT3 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 6 May 2008 18:19:29 -0400
In-Reply-To: <005b01c8afc4$77f4ec90$6401a8c0@techwriter>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Yigal Sadgat <YSadgat1@gcte.com>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, jwboyer@linux.vnet.ibm.com, joern@logfs.org

> (1) Can you really ignore bit(2) (CORR) in the Status register offset 7 that 
> tells
> you that the CF has detected and corrected a soft error?, etc.

I guess it might be interesting to log the error rate but we don't
currently do that. A corrected error is just that however - corrected by
the card itself.

> (2) An engineer at SanDisk Engineering told me NOT to do wear leveling.
> The file allocation table is written very frequently back into the flash. So
> is it really safe to assume that I don't need wear leveling???

Depends on your hardware vendor. Wear management is done within the CF
card and only the hardware vendor can tell you what they do. 

> (3) Re. the BUSY bit in the status register (offset 7, bit D7), anybody 
> experienced
> time outs?

Yes - both from failing CF cards and also other random events (bad
connections, people removing live cards etc)

> (4) Re Error register (offset 1) bit D7 (BBK), again, I was told that it 
> cannot (???)
> happen since the CF performs read-after-write and it automatically switches 
> good blocks
> for bad ones... Is this correct?

Depends on your hardware vendor. It certainly *can* occur with some CF
cards perhaps when they run out of spare blocks.

Alan
