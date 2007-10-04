From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: pata_cs5536: ATA driver for Geode companion chip
Date: Thu, 4 Oct 2007 16:58:19 +0100
Message-ID: <20071004165819.003b86c6@the-village.bc.nu>
References: <20071003233012.GA8721@cosmic.amd.com>
	<yq1przva76x.fsf@sermon.lab.mkp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:51708 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757362AbXJDPxm (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 4 Oct 2007 11:53:42 -0400
In-Reply-To: <yq1przva76x.fsf@sermon.lab.mkp.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Martin K. Petersen" <mkp@mkp.net>
Cc: Jordan Crouse <jordan.crouse@amd.com>, Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org

> For kicks I switched my driver over to using PCI config registers
> instead of MSRs.  And it still worked!
> 
> When I changed my driver I did a quickie conversion from wrmsr() to
> pci_write_config_dword().  If I use pci_write_config_byte() instead
> (like pata_amd.c), things fail miserably.  A register dump reveals
> that any value I write becomes a 0.  Yay!

At that point its probaly a good idea to take CS5536 out of AMD and use
your driver for it, whether in PCI or MSR mode (or perhaps supporting
either)

Alan
