From: Stan Hoeppner <stan@hardwarefreak.com>
Subject: Re: kernel 2.6.31.1 + Sil 3512 + WDC WD5000AAKS-00V1A0 = no NCQ and
 UDMA5 instead of UDMA6
Date: Thu, 17 Dec 2009 21:49:49 -0600
Message-ID: <4B2AFBDD.30601@hardwarefreak.com>
References: <4B2A3D25.9030209@hardwarefreak.com> <4B2A720B.2040809@pobox.com> <4B2AE779.9060109@hardwarefreak.com> <4B2AF2C2.9010708@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mo-65-41-216-221.sta.embarqhsd.net ([65.41.216.221]:33204 "EHLO
	greer.hardwarefreak.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753553AbZLRDtv (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 17 Dec 2009 22:49:51 -0500
In-Reply-To: <4B2AF2C2.9010708@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org

Jeff Garzik put forth on 12/17/2009 9:10 PM:

> Nope.  You are pretty much maxing out the drive, of whatever drive you
> plug in.  The sata bus -- at its hardware spec'd maximum -- is far
> faster than just about any drive, and the PCI bus is far faster than the
> sata bus.

I'm on the old 32bit/33MHz PCI bus of 133MB/s.  SATA1 at 150MB/s is
slightly faster, no?  No argument here that both are far faster than
almost all drives on the market.  I was just wondering if bumping up
from the default UDMA/100 to UDMA/133 would allow quicker PCI bus
bursting and thus a slight improvement in overall performance.

> You could probably max out the SATA bus with a RAM-based SATA device;
> that's it.

Yeah, I've seen some results published of quality SSDs and they just
absolutely scream in latency, IOPs, and throughput.  That's not in my
future, it's complete overkill for my applications, performance and
dollar wise.  I just want to optimize the performance of what I already
have.

I think I only gave $15 for this Koutech Sil3512 PCI (32/33) controller
at Newegg.  You being you with the knowledge you have, would buying one
of the cards whose chipset supports NCQ, such as the sata_sil24 cards,
be anything close to worth the additional investment in dollars and time
spent swapping hardware and drivers?  Is NCQ the performance panacea
that some purport it to be?  How much difference does it really make?

Thanks again for your time and advice Jeff.

--
Stan
