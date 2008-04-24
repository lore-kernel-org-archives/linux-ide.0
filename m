From: Volker Armin Hemmann <volker.armin.hemmann@tu-clausthal.de>
Subject: Re: [PATCH] ahci: retry enabling AHCI a few times before spitting out WARN_ON()
Date: Thu, 24 Apr 2008 02:24:09 +0200
Message-ID: <200804240224.09518.volker.armin.hemmann@tu-clausthal.de>
References: <480F231A.7020401@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hades.rz.tu-clausthal.de ([139.174.2.20]:50233 "EHLO
	hades.rz.tu-clausthal.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751752AbYDXAYR (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 23 Apr 2008 20:24:17 -0400
In-Reply-To: <480F231A.7020401@gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Jeff Garzik <jeff@garzik.org>, IDE/ATA development list <linux-ide@vger.kernel.org>, Peer Chen <pchen@nvidia.com>

Hi,

patch -p1 <  ../ahci.patch
patching file drivers/ata/ahci.c
Hunk #1 FAILED at 556.
1 out of 1 hunk FAILED -- saving rejects to file drivers/ata/ahci.c.rej

cat drivers/ata/ahci.c.rej
***************
*** 556,571 ****

  static void ahci_enable_ahci(void __iomem *mmio)
  {
         u32 tmp;

         /* turn on AHCI_EN */
         tmp = readl(mmio + HOST_CTL);
-        if (!(tmp & HOST_AHCI_EN)) {
                 tmp |= HOST_AHCI_EN;
                 writel(tmp, mmio + HOST_CTL);
                 tmp = readl(mmio + HOST_CTL);   /* flush && sanity check */
-                WARN_ON(!(tmp & HOST_AHCI_EN));
         }
  }

  /**
--- 556,582 ----

  static void ahci_enable_ahci(void __iomem *mmio)
  {
+        int i;
         u32 tmp;

         /* turn on AHCI_EN */
         tmp = readl(mmio + HOST_CTL);
+        if (tmp & HOST_AHCI_EN)
+                return;
+
+        /* Some controllers need AHCI_EN to be written multiple times.
+         * Try a few times before giving up.
+         */
+        for (i = 0; i < 5; i++) {
                 tmp |= HOST_AHCI_EN;
                 writel(tmp, mmio + HOST_CTL);
                 tmp = readl(mmio + HOST_CTL);   /* flush && sanity check */
+                if (tmp & HOST_AHCI_EN)
+                        return;
+                msleep(10);
         }
+
+        WARN_ON(1);
  }

  /**


with 2.6.25+reiser4.
