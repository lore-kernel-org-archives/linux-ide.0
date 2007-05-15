From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] libata: Add MMIO support to pata_sil680
Date: Tue, 15 May 2007 16:14:00 +1000
Message-ID: <1179209640.32247.151.camel@localhost.localdomain>
References: <20070515061153.425BDDDEE8@ozlabs.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:55736 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755414AbXEOGOL (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 15 May 2007 02:14:11 -0400
In-Reply-To: <20070515061153.425BDDDEE8@ozlabs.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com
Cc: Alan Cox <alan@redhat.com>, Linux IDE <linux-ide@vger.kernel.org>

On Tue, 2007-05-15 at 16:11 +1000, Benjamin Herrenschmidt wrote:
> This patch adds MMIO support to the pata_sil680 for taskfile IOs,
> based on what the old siimage does.
> 
> I haven't bothered changing the chip setup stuff from PCI config
> cycles to MMIO though (siimage does it), I don't think it matters,
> I've only adapted it to use MMIO for taskfile accesses.
> 
> I've tested it on a Cell blade and it seems to work fine.

Oops, forgot a quilt ref ... fixed patch on the way. Sorry.

Ben.


