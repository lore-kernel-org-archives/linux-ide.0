From: Olaf Hering <olaf@aepfle.de>
Subject: [PATCH] add delay around sl82c105_reset_engine calls
Date: Sat, 10 Feb 2007 21:36:14 +0100
Message-ID: <20070210203614.GA25602@aepfle.de>
References: <20070210203512.GA25586@aepfle.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.9]:55587 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751855AbXBJUex (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 10 Feb 2007 15:34:53 -0500
Content-Disposition: inline
In-Reply-To: <20070210203512.GA25586@aepfle.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linuxppc-dev@ozlabs.org, Andrew Morton <akpm@osdl.org>
Cc: linux-ide@vger.kernel.org


The hald media changed polling does really confuse things.
Noone knows why the delays are needed, but they give us access to the CD.

An udelay(50) will give reliable access to the drive, but there is still
one (or more) EH reset. The drive works without EH resets with udelay(100).

Signed-off-by: Olaf Hering <olaf@aepfle.de>

---
 drivers/ata/pata_sl82c105.c |    3 +++
 1 file changed, 3 insertions(+)

Index: linux-2.6/drivers/ata/pata_sl82c105.c
===================================================================
--- linux-2.6.orig/drivers/ata/pata_sl82c105.c
+++ linux-2.6/drivers/ata/pata_sl82c105.c
@@ -187,7 +187,9 @@ static void sl82c105_bmdma_start(struct 
 {
 	struct ata_port *ap = qc->ap;
 
+	udelay(100);
 	sl82c105_reset_engine(ap);
+	udelay(100);
 
 	/* Set the clocks for DMA */
 	sl82c105_configure_dmamode(ap, qc->dev);
@@ -216,6 +218,7 @@ static void sl82c105_bmdma_stop(struct a
 
 	ata_bmdma_stop(qc);
 	sl82c105_reset_engine(ap);
+	udelay(100);
 
 	/* This will redo the initial setup of the DMA device to matching
 	   PIO timings */
