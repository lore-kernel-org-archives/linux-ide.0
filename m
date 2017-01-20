From: Darren Stevens <darren@stevens-zone.net>
Subject: [PATCH] libata-sff: Don't scan disabled ports when checking for
 legacy mode.
Date: Fri, 20 Jan 2017 17:58:21 +0000 (GMT)
Message-ID: <497610a8448.441e0a10@auth.smtp.1and1.co.uk>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([217.72.192.74]:57860 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752574AbdATSES (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 20 Jan 2017 13:04:18 -0500
Received: from mintppc.lan ([86.156.215.177]) by mrelayeu.kundenserver.de
 (mreue104 [212.227.15.179]) with ESMTPA (Nemesis) id 0MfIB0-1csD6C3ezC-00Oq9B
 for <linux-ide@vger.kernel.org>; Fri, 20 Jan 2017 19:04:14 +0100
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

libata-sff.c checks for legacy mode by testing if both primary
and secondary ports on a controller are in legacy mode and selects
legacy if either one is. However on some southbridge chips (e.g
AMD SB600/SB700) the secondary port is not wired, and when it is 
disabled by setting the disable bit in the PCI header it appears
as a fixed legacy port.
Prevent incorrect detection by not testing ports that are marked
as 'dummy'

Signed-off-by: Darren Stevens <darren@stevens-zone.net>
---

diff --git a/drivers/ata/libata-sff.c b/drivers/ata/libata-sff.c
index 051b615..05f688a 100644
--- a/drivers/ata/libata-sff.c
+++ b/drivers/ata/libata-sff.c
@@ -2429,9 +2429,16 @@ int ata_pci_sff_activate_host(struct ata_host *host,
    if ((pdev->class >> 8) == PCI_CLASS_STORAGE_IDE) {
        u8 tmp8, mask;
 
-       /* TODO: What if one channel is in native mode ... */
+       /*
+        * ATA spec says we should use legacy mode when one
+        * port is in legacy mode, but disabled ports on some
+        * PCI hosts appear as fixed legacy ports, e.g SB600/700
+        * on which the secondary port is not wired, so
+        * ignore ports that we've marked as 'dummy' during
+        * this check
+        */
        pci_read_config_byte(pdev, PCI_CLASS_PROG, &tmp8);
-       mask = (1 << 2) | (1 << 0);
+       mask = (! ata_port_is_dummy(host->ports[1]) << 2) | (!
ata_port_is_dummy(host->ports[0]) << 0);
        if ((tmp8 & mask) != mask)
            legacy_mode = 1;
    }

