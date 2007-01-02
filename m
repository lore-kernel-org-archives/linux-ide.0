From: Alan <alan@lxorguk.ukuu.org.uk>
Subject: Re: problem with pata_hpt37x ...
Date: Tue, 2 Jan 2007 14:58:55 +0000
Message-ID: <20070102145855.170c03e2@localhost.localdomain>
References: <20070102070144.GA11270@MAIL.13thfloor.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:52787 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754857AbXABOs4 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 2 Jan 2007 09:48:56 -0500
In-Reply-To: <20070102070144.GA11270@MAIL.13thfloor.at>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Herbert Poetzl <herbert@13thfloor.at>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org, Linux Kernel ML <linux-kernel@vger.kernel.org>

On Tue, 2 Jan 2007 08:01:45 +0100
Herbert Poetzl <herbert@13thfloor.at> wrote:

> if you are interested in investigating this, please
> let me know what kind of data you would like to see
> and/or what kind of tests would be appreciated.

I reviewed the 374 code a bit further to see what might be causing this
and found the slave channel end of DMA handling was using the wrong port
I think.

Signed-off-by: Alan Cox <alan@redhat.com>

--- linux.vanilla-2.6.20-rc3/drivers/ata/pata_hpt37x.c	2007-01-01 21:43:27.000000000 +0000
+++ linux-2.6.20-rc3/drivers/ata/pata_hpt37x.c	2007-01-02 14:30:18.122801920 +0000
@@ -25,7 +25,7 @@
 #include <linux/libata.h>
 
 #define DRV_NAME	"pata_hpt37x"
-#define DRV_VERSION	"0.5.1"
+#define DRV_VERSION	"0.5.2"
 
 struct hpt_clock {
 	u8	xfer_speed;
@@ -749,7 +749,7 @@
 {
 	struct ata_port *ap = qc->ap;
 	struct pci_dev *pdev = to_pci_dev(ap->host->dev);
-	int mscreg = 0x50 + 2 * ap->port_no;
+	int mscreg = 0x50 + 4 * ap->port_no;
 	u8 bwsr_stat, msc_stat;
 
 	pci_read_config_byte(pdev, 0x6A, &bwsr_stat);


