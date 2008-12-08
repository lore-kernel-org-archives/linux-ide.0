From: Tejun Heo <tj@kernel.org>
Subject: [PATCH #upstream-fixes 1/3] pata_hpt366: fix clock detection
Date: Mon, 08 Dec 2008 18:48:42 +0900
Message-ID: <493CED7A.2010505@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:53025 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751181AbYLHJtD (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 8 Dec 2008 04:49:03 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, IDE/ATA development list <linux-ide@vger.kernel.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Mark Lord <liml@rtr.ca>, rob.opensuse.linux@googlemail.com

pata_hpt366 had its clock detection wrong and detected 25Mhz as 40Mhz
and vice-versa.  Fix it.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 drivers/ata/pata_hpt366.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

Index: work/drivers/ata/pata_hpt366.c
===================================================================
--- work.orig/drivers/ata/pata_hpt366.c
+++ work/drivers/ata/pata_hpt366.c
@@ -382,10 +382,10 @@ static int hpt36x_init_one(struct pci_de
 	/* PCI clocking determines the ATA timing values to use */
 	/* info_hpt366 is safe against re-entry so we can scribble on it */
 	switch((reg1 & 0x700) >> 8) {
-		case 5:
+		case 9:
 			hpriv = &hpt366_40;
 			break;
-		case 9:
+		case 5:
 			hpriv = &hpt366_25;
 			break;
 		default:
