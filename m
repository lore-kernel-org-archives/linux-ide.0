From: Andreas Arens <ari@goron.de>
Subject: Re: hdb: irq timeout: status=0xd0 { Busy }
Date: Sat, 24 Feb 2007 16:36:27 +0100
Message-ID: <erpm1a$muc$1@sea.gmane.org>
References: <2fa647f60702230519u4dc178b8s6c28948cd824272d@mail.gmail.com> <20070223142840.7c771453@lxorguk.ukuu.org.uk> <2fa647f60702230530x48e5d558o422825892e428d1d@mail.gmail.com> <20070223151709.3b819367@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from main.gmane.org ([80.91.229.2]:32917 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932954AbXBXPzN (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 24 Feb 2007 10:55:13 -0500
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1HKzEk-0003oy-Dw
	for linux-ide@vger.kernel.org; Sat, 24 Feb 2007 16:55:02 +0100
Received: from p50917152.dip.t-dialin.net ([80.145.113.82])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-ide@vger.kernel.org>; Sat, 24 Feb 2007 16:55:02 +0100
Received: from ari by p50917152.dip.t-dialin.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-ide@vger.kernel.org>; Sat, 24 Feb 2007 16:55:02 +0100
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Alan wrote:

>> Would it be possible for the kernel to realize that the drive stopped
>> responding? And make sure that it doesn't make the whole computer
>> unresponsive...
> 
> libata should eventually get rid of the drive. The old ide isn't quite so
> smart.
> 

I see the same happening with a non-udma capable cdrw drive since
2.6.19-rc1. 2.6.18.x was ok.

Unfortunately libata was not a solution (at least in 2.6.19). It took
the hard drive sharing the bus with the mwdma cdrw down from UDMA100
to PIO0 the entire chain and finally offline in steps each time
it detected trouble on the bus.
I suspect the genirq changes (I'm on x86_64) which went in at that
point to be the cause. The ide irq's are edge triggered, and changes to
the fragile timing there might have made it miss.
I solved this by replacing the drive against an UDMA capable on
(but still have the old one around for testing, if need be).
In 2.6.19 (after trying libata on it) I saw errors of command time
outs etc. 2.6.20 was even worse as it failed silently.

Andy


