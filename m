From: Erik Mouw <erik@harddisk-recovery.com>
Subject: libata-pata: how to select PIO mode instead of DMA?
Date: Wed, 20 Dec 2006 13:23:56 +0100
Message-ID: <20061220122356.GE28435@harddisk-recovery.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from dtp.xs4all.nl ([80.126.206.180]:53868 "HELO abra2.bitwizard.nl"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with SMTP
	id S1754806AbWLTMbX (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 20 Dec 2006 07:31:23 -0500
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: alan@lxorguk.ukuu.org.uk

Hi,

I'm experimenting with the libata-pata drivers in linux 2.6.19. So far
it looks good, great job Alan! 

We obviously have some drives that due to their damaged nature have
some funny behaviour. One of them is that some drives really don't like
DMA mode anymore and can only be reliably recovered in PIO mode. With
the old IDE drivers that was easy: hdparm -d 0 /dev/hda . Unfortunately
I can't find a way to do the same with libata-pata.

The libata-pata drivers have a set_piomode method that gets called in
libata-core.c:ata_set_mode(), which is only called from the bus probe
function and the exception handler. What is needed to force a drive
into PIO mode from userspace?


Erik

-- 
+-- Erik Mouw -- www.harddisk-recovery.com -- +31 70 370 12 90 --
| Lab address: Delftechpark 26, 2628 XH, Delft, The Netherlands
