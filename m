From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] libata: Add MMIO support to pata_sil680
Date: Thu, 24 May 2007 10:54:07 +0100
Message-ID: <20070524105407.64514929@the-village.bc.nu>
References: <20070515061239.611A2DDEE9@ozlabs.org>
	<1179209697.32247.153.camel@localhost.localdomain>
	<20070523144217.5abd9fdf@the-village.bc.nu>
	<1179960518.32247.948.camel@localhost.localdomain>
	<20070524003123.77b9c81c@the-village.bc.nu>
	<1179963820.32247.996.camel@localhost.localdomain>
	<20070524001302.GA18571@devserv.devel.redhat.com>
	<1179978137.32247.1035.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:45302 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754965AbXEXJuq (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 24 May 2007 05:50:46 -0400
In-Reply-To: <1179978137.32247.1035.camel@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Alan Cox <alan@redhat.com>, jgarzik@pobox.com, Linux IDE <linux-ide@vger.kernel.org>

> Currently libata does the 400ns thingy in the inline ata_pause() which
> unconditionally does ata_altstatus(); ndelay(400); (and thus does it on
> PIO, MMIO, anything ...).

It might actually improve performance for PATA if we did as we'll get rid
of an excess (expensive) PCI read access for non MMIO cases.

