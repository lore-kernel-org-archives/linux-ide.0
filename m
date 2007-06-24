From: Eyal Lebedinsky <eyal@eyal.emu.id.au>
Subject: Re: SATA RAID5 speed drop of 100 MB/s
Date: Sun, 24 Jun 2007 10:54:56 +1000
Message-ID: <467DC0E0.509@eyal.emu.id.au>
References: <20070620224847.GA5488@alinoe.com> <4679B2DE.9090903@garzik.org> <20070622214859.GC6970@alinoe.com> <467CC5C5.6040201@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from customer-domains.icp-qv1-irony11.iinet.net.au ([203.59.1.151]:35478
	"EHLO customer-domains.icp-qv1-irony11.iinet.net.au"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753333AbXFXBFO (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 23 Jun 2007 21:05:14 -0400
In-Reply-To: <467CC5C5.6040201@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>

Jeff Garzik wrote:
[trim]
> Given that some drives might be better tuned for benchmarks in
> non-queued mode, and that a major behavior difference is that your
> drives are now NCQ-enabled, the first thing I would suggest you try is
> disabling NCQ:
>     http://linux-ata.org/faq.html#ncq

I see in my bootup messages:
ata6: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata6.00: ATA-7: WDC WD3200YS-01PGB0, 21.00M21, max UDMA/133
ata6.00: 625142448 sectors, multi 0: LBA48 NCQ (depth 0/1)
ata6.00: configured for UDMA/133

and I wonder how to interpret "NCQ (depth 0/1)". Does this drive
support NCQ or not?

Controller:	Promise SATA-II-150-TX4.
Kernel:		2.6.21.5, x86

-- 
Eyal Lebedinsky (eyal@eyal.emu.id.au) <http://samba.org/eyal/>
