From: Michael Tokarev <mjt@tls.msk.ru>
Subject: Re: sata_nv on MCP51: NCQ possible?
Date: Thu, 15 Nov 2007 12:09:21 +0300
Message-ID: <473C0CC1.3090702@msgid.tls.msk.ru>
References: <473C0AB1.8050907@msgid.tls.msk.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hobbit.corpit.ru ([81.13.94.6]:20294 "EHLO hobbit.corpit.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752775AbXKOJJX (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 15 Nov 2007 04:09:23 -0500
In-Reply-To: <473C0AB1.8050907@msgid.tls.msk.ru>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

[replying to myself...]

Michael Tokarev wrote:
> While trying to test NCQ thing again, I come across
> a problem, it seems: the only hardware available for
> testing to me right now is an ASUS M2NPV-VM motherboard,
> which is based on Nvidia nForce 430/GeForce 6150.
> lspci shows this:
> 
>  00:0f.0 IDE interface: nVidia Corporation MCP51 Serial ATA Controller (rev a1)
> 
> I see no command queuing enabled by linux (queue depth: 0/32),
> and there's no way to enable it in sysfs, either.

Hmm.  When googling harder, I've found something about this,
e.g. here:

http://www.mail-archive.com/linux-ide@vger.kernel.org/msg09517.html

(it's a long thread).

But some question(s) remains still.

First, it looks like that patch(set) isn't in 2.6.23.  I'll grab
2.6.24pre to see if it's there.

And second, and most important -- what's "SW NCQ", or "Software NCQ"?
To me it sounds like "BIOS RAID" - that "RAID" thing found on many
modern desktop motherboards which isn't hardware raid, and hence
it does not offer any advantage over normal linux software raid
implementation (which has its own advantages anyway).  So I'm
a bit confused here: linux I/O scheduler and this "Software NCQ" -
isn't one of the two redundrand?  And sure thing - is it worth
to test NCQ at all if it's "Software"?

Thanks.

/mjt
