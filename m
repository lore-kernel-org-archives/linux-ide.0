From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: Re: libata / IDE cs5536: 80c cable detect issue (and worse?)
Date: Fri, 19 Jul 2013 12:40:38 +0200
Message-ID: <21479812.cJNm40xAqz@amdc1032>
References: <20130718181355.GA31889@rhlx01.hs-esslingen.de>
 <20130718182541.GA30707@rhlx01.hs-esslingen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:16615 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934447Ab3GSKku (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 19 Jul 2013 06:40:50 -0400
In-reply-to: <20130718182541.GA30707@rhlx01.hs-esslingen.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andreas Mohr <andi@lisas.de>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, "Martin K. Petersen" <martin.petersen@oracle.com>, Christian Gmeiner <christian.gmeiner@gmail.com>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org


Hi,

On Thursday, July 18, 2013 08:25:41 PM Andreas Mohr wrote:
> Hi,
> 
> forgot to mention that I had already added a libata.force=40c boot
> after my 80c config issue discovery
> which did successfully cause the "limiting to UDMA/33 due to 40c foo" dmesg
> yet where there's now initial but strong confirmation via reports
> that the resulting UDMA/33 limit did NOT manage to fix corruption issues,
> thus it's more strongly likely that the "bound to ill-suited pata_amd driver"
> (due to incorrectly configuring speeds, or due to not configuring speeds
> at all due to possibly BIOS not providing emulation of PCI register accesses
> to Geode bus, which would be properly supported by pata_cs5536 OTOH)
> thing is the actual reason and might fix it (fingers crossed).

UDMA/66 (and higher) requires 80-wire cable to work (if the vendor states
that UDMA/66 is supported then UDMA/100 should also work on CS5536). UDMA/33
should work just fine with 40-wire cable. Therefore this indeed sounds more
like wrong driver being selected issue than a cable problem.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

