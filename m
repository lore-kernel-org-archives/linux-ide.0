From: "Martin K. Petersen" <mkp@mkp.net>
Subject: Re: pata_cs5536: ATA driver for Geode companion chip
Date: Wed, 03 Oct 2007 23:29:26 -0400
Message-ID: <yq1przva76x.fsf@sermon.lab.mkp.net>
References: <20071003233012.GA8721@cosmic.amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from jaguar.mkp.net ([192.139.46.146]:39000 "EHLO jaguar.mkp.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753248AbXJDD31 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 3 Oct 2007 23:29:27 -0400
In-Reply-To: <20071003233012.GA8721@cosmic.amd.com> (Jordan Crouse's message of "Wed\, 3 Oct 2007 17\:30\:12 -0600")
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jordan Crouse <jordan.crouse@amd.com>
Cc: Jeff Garzik <jeff@garzik.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org

>>>>> "Jordan" == Jordan Crouse <jordan.crouse@amd.com> writes:

Jordan> In the standard AMD VSA, writeos to PCI space 0x48 (DTC), 0x49
Jordan> (CAST) and 0x50 (ETC) should work - and the change should be
Jordan> immediately reflected in the MSR.  

I know what the problem is.  I just got a BIOS update tonight which
was supposed to fix the issue.  However, pata_amd.c still failed
spectacularly at configuring the device whereas pata_cs5536 worked
fine.  

For kicks I switched my driver over to using PCI config registers
instead of MSRs.  And it still worked!

When I changed my driver I did a quickie conversion from wrmsr() to
pci_write_config_dword().  If I use pci_write_config_byte() instead
(like pata_amd.c), things fail miserably.  A register dump reveals
that any value I write becomes a 0.  Yay!

-- 
Martin K. Petersen      http://mkp.net/
