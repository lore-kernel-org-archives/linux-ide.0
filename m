From: Dan Streetman <ddstreet@ieee.org>
Subject: ata_piix id table and module loading
Date: Tue, 29 Mar 2005 18:25:54 -0500 (EST)
Message-ID: <Pine.LNX.4.51.0503291819050.1887@dylan.root.cx>
Reply-To: ddstreet@ieee.org
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from pop-a065d14.pas.sa.earthlink.net ([207.217.121.252]:49323 "EHLO
	pop-a065d14.pas.sa.earthlink.net") by vger.kernel.org with ESMTP
	id S261654AbVC2X0A (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 29 Mar 2005 18:26:00 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com
Cc: linux-ide@vger.kernel.org


Hi,

I have a system with a "PCI_DEVICE_ID_INTEL_ICH6_0" (from pci_ids.h)  
Serial ATA chip in it, that works with the ata_piix driver.  However, I
can't figure out how the driver is supposed to auto-load; the PCI ID,
(0x8086, 0x2640), isn't in the ata_piix id table.  Should that ID be in
the ata_piix driver (and in pci/quirks.c)?  Or is the driver supposed to
auto-load some other way?

Thanks!

-- 
Dan Streetman
ddstreet@ieee.org
---------------------
186,272 miles per second:
It isn't just a good idea, it's the law!
