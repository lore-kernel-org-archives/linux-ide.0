From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 45/86] pata_legacy: do not probe extra ports automatically if PCI is not present
Date: Wed, 25 Nov 2009 18:07:40 +0100
Message-ID: <20091125170740.5446.67217.sendpatchset@localhost>
References: <20091125170218.5446.13513.sendpatchset@localhost>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.156]:24999 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932311AbZKYRIS (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 25 Nov 2009 12:08:18 -0500
In-Reply-To: <20091125170218.5446.13513.sendpatchset@localhost>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org

From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] pata_legacy: do not probe extra ports automatically if PCI is not present

It can be problematic if there are other ISA/VLB devices using
those ports.

This is a forward port of bugfix from IDE ide-generic host driver.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ata/pata_legacy.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: b/drivers/ata/pata_legacy.c
===================================================================
--- a/drivers/ata/pata_legacy.c
+++ b/drivers/ata/pata_legacy.c
@@ -1241,7 +1241,7 @@ static __init int legacy_init(void)
 	if (secondary == 0 || all)
 		legacy_probe_add(0x170, 15, UNKNOWN, 0);
 
-	if (probe_all || !pci_present) {
+	if (probe_all) {
 		/* ISA/VLB extra ports */
 		legacy_probe_add(0x1E8, 11, UNKNOWN, 0);
 		legacy_probe_add(0x168, 10, UNKNOWN, 0);
