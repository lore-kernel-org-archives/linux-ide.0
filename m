From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] buddha: use struct ide_port_info
Date: Sat, 24 Jan 2009 15:17:50 +0100
Message-ID: <200901241517.50780.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mu-out-0910.google.com ([209.85.134.187]:62674 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754597AbZAXOVX (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 24 Jan 2009 09:21:23 -0500
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>

From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] buddha: use struct ide_port_info

This fixes hwif->channel and drive->dn assignments.

Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/buddha.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

Index: b/drivers/ide/buddha.c
===================================================================
--- a/drivers/ide/buddha.c
+++ b/drivers/ide/buddha.c
@@ -143,6 +143,10 @@ static void __init buddha_setup_ports(hw
 	hw->chipset = ide_generic;
 }
 
+static const struct ide_port_info buddha_port_info = {
+	.host_flags		= IDE_HFLAG_NO_DMA,
+};
+
     /*
      *  Probe for a Buddha or Catweasel IDE interface
      */
@@ -224,7 +228,7 @@ fail_base2:
 			hws[i] = &hw[i];
 		}
 
-		ide_host_add(NULL, hws, NULL);
+		ide_host_add(&buddha_port_info, hws, NULL);
 	}
 
 	return 0;
