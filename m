From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] alim15x3: add Mitac 8317 and derivatives to ali_cable_override()
Date: Thu, 22 Nov 2007 22:56:15 +0100
Message-ID: <200711222256.15490.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.174]:57239 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753210AbXKVWHQ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 22 Nov 2007 17:07:16 -0500
Received: by ug-out-1314.google.com with SMTP id z38so409665ugc
        for <linux-ide@vger.kernel.org>; Thu, 22 Nov 2007 14:07:15 -0800 (PST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Alan Cox <alan@redhat.com>


Port of Alan's patch for pata_ali.c.

Cc: Alan Cox <alan@redhat.com>
Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/pci/alim15x3.c |    5 +++++
 1 file changed, 5 insertions(+)

Index: b/drivers/ide/pci/alim15x3.c
===================================================================
--- a/drivers/ide/pci/alim15x3.c
+++ b/drivers/ide/pci/alim15x3.c
@@ -603,6 +603,11 @@ static int ali_cable_override(struct pci
 	    pdev->subsystem_device == 0x10AF)
 		return 1;
 
+	/* Mitac 8317 (Winbook-A) and relatives */
+	if (pdev->subsystem_vendor == 0x1071 &&
+	    pdev->subsystem_device == 0x8317)
+		return 1;
+
 	/* Systems by DMI */
 	if (dmi_check_system(cable_dmi_table))
 		return 1;
