From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] sata_mv:  Fix broken Marvell 7042 support.
Date: Sat, 01 Dec 2007 17:45:43 -0500
Message-ID: <4751E417.7060308@pobox.com>
References: <4751A2DA.6030403@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:59221 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752537AbXLAWpt (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 1 Dec 2007 17:45:49 -0500
In-Reply-To: <4751A2DA.6030403@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>, Tejun Heo <htejun@gmail.com>, Alan Cox <alan@redhat.com>, Tom Morrison <tmorrison@empirix.com>, Hein-Pieter van Braam <hp@syntomax.com>

Mark Lord wrote:
> sata_mv:  Fix broken Marvell 7042 support.
> 
> The Marvell 7042 chip is more or less the same as the 6042 internally,
> but sports a PCIe bus.  Despite having identical SATA cores, the 7042
> does differ from its PCI bus counterparts in placment and layout of
> certain bus related registers.
> 
> This patch fixes sata_mv to distinguish between the PCI bus registers
> of earlier chips, and the PCIe bus registers of the 7042.
> 
> Specifically, move the offsets and bit patterns for the
> PCI/PCIe interrupt cause/mask registers into the struct mv_host_priv,
> as these values differ between the 6xxx and 7xxx series chips.
> 
> This fixes the driver to not access reserved PCI addresses,
> and prevents the lockups reported in linux-2.6.24 with 7042 boards.
> 
> Also add a new PCI ID for the Highpoint 2300 7042-based board
> that I'm using for testing this stuff here.
> 
> Tested with Marvell 6081 + 7042 chips, on x86 & x86_64.
> 
> Signed-off-by: Mark Lord <mlord@pobox.com>

applied #upstream-fixes


