From: Paul Bolle <pebolle@tiscali.nl>
Subject: [PATCH] libata-sff: remove dead code
Date: Sun, 04 May 2014 13:50:29 +0200
Message-ID: <1399204229.8729.15.camel@x220>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Alan Cox <alan@linux.intel.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

Ever since v2.6.19 the code contains a check for CONFIG_NO_ATA_LEGACY.
But that macro has never been defined. Apparently no one ran into
problems on platforms that do not support compatibility mode. So remove
this code that has been dead for over seven years.

Signed-off-by: Paul Bolle <pebolle@tiscali.nl>
---
Untested!

Perhaps the test should have been
    #if !defined(CONFIG_PATA_LEGACY)

I wouldn't know if that's correct. But after seven years it doesn't
matter anyhow, so I did not bother to research that.

 drivers/ata/libata-sff.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/drivers/ata/libata-sff.c b/drivers/ata/libata-sff.c
index b603720b877d..1121153f1ecd 100644
--- a/drivers/ata/libata-sff.c
+++ b/drivers/ata/libata-sff.c
@@ -2433,15 +2433,6 @@ int ata_pci_sff_activate_host(struct ata_host *host,
 		mask = (1 << 2) | (1 << 0);
 		if ((tmp8 & mask) != mask)
 			legacy_mode = 1;
-#if defined(CONFIG_NO_ATA_LEGACY)
-		/* Some platforms with PCI limits cannot address compat
-		   port space. In that case we punt if their firmware has
-		   left a device in compatibility mode */
-		if (legacy_mode) {
-			printk(KERN_ERR "ata: Compatibility mode ATA is not supported on this platform, skipping.\n");
-			return -EOPNOTSUPP;
-		}
-#endif
 	}
 
 	if (!devres_open_group(dev, NULL, GFP_KERNEL))
-- 
1.9.0
