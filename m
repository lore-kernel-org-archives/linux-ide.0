From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 22/23] ata: sata_dwc_460ex: make debug messages neat
Date: Thu, 21 Apr 2016 21:15:43 +0300
Message-ID: <1461262544-115408-23-git-send-email-andriy.shevchenko@linux.intel.com>
References: <1461262544-115408-1-git-send-email-andriy.shevchenko@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1461262544-115408-1-git-send-email-andriy.shevchenko@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, Christian Lamparter <chunkeey@googlemail.com>, =?UTF-8?q?M=C3=A5ns=20Rullg=C3=A5rd?= <mans@mansr.com>, Julian Margetson <runaway@candw.ms>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
List-Id: linux-ide@vger.kernel.org

There is a duplication in the debug messages when accessing SCR registers.
Remove duplication to make the messages neat.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/ata/sata_dwc_460ex.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/ata/sata_dwc_460ex.c b/drivers/ata/sata_dwc_460ex.c
index 44dca8c..2d73cdf 100644
--- a/drivers/ata/sata_dwc_460ex.c
+++ b/drivers/ata/sata_dwc_460ex.c
@@ -414,16 +414,16 @@ static int sata_dwc_scr_read(struct ata_link *link, unsigned int scr, u32 *val)
 	}
 
 	*val = sata_dwc_readl(link->ap->ioaddr.scr_addr + (scr * 4));
-	dev_dbg(link->ap->dev, "%s: id=%d reg=%d val=val=0x%08x\n",
-		__func__, link->ap->print_id, scr, *val);
+	dev_dbg(link->ap->dev, "%s: id=%d reg=%d val=0x%08x\n", __func__,
+		link->ap->print_id, scr, *val);
 
 	return 0;
 }
 
 static int sata_dwc_scr_write(struct ata_link *link, unsigned int scr, u32 val)
 {
-	dev_dbg(link->ap->dev, "%s: id=%d reg=%d val=val=0x%08x\n",
-		__func__, link->ap->print_id, scr, val);
+	dev_dbg(link->ap->dev, "%s: id=%d reg=%d val=0x%08x\n", __func__,
+		link->ap->print_id, scr, val);
 	if (scr > SCR_NOTIFICATION) {
 		dev_err(link->ap->dev, "%s: Incorrect SCR offset 0x%02x\n",
 			 __func__, scr);
-- 
2.8.0.rc3
