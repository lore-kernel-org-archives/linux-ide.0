From: Andreas Mohr <andi@lisas.de>
Subject: Re: libata / IDE cs5536: 80c cable detect issue (and worse?)
Date: Thu, 18 Jul 2013 20:25:41 +0200
Message-ID: <20130718182541.GA30707@rhlx01.hs-esslingen.de>
References: <20130718181355.GA31889@rhlx01.hs-esslingen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20130718181355.GA31889@rhlx01.hs-esslingen.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Andreas Mohr <andi@lisas.de>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, "Martin K. Petersen" <martin.petersen@oracle.com>, Christian Gmeiner <christian.gmeiner@gmail.com>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

Hi,

forgot to mention that I had already added a libata.force=40c boot
after my 80c config issue discovery
which did successfully cause the "limiting to UDMA/33 due to 40c foo" dmesg
yet where there's now initial but strong confirmation via reports
that the resulting UDMA/33 limit did NOT manage to fix corruption issues,
thus it's more strongly likely that the "bound to ill-suited pata_amd driver"
(due to incorrectly configuring speeds, or due to not configuring speeds
at all due to possibly BIOS not providing emulation of PCI register accesses
to Geode bus, which would be properly supported by pata_cs5536 OTOH)
thing is the actual reason and might fix it (fingers crossed).

Thanks,

Andreas Mohr
