From: Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>
Subject: [PATCH 03/10] IDE: Coding Style fixes to drivers/ide/ide-pnp.c
Date: Sat, 23 Feb 2008 15:05:08 +0100
Message-ID: <20080223150508.2f9addff@paolo-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fk-out-0910.google.com ([209.85.128.188]:17790 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758709AbYBWOFP (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 23 Feb 2008 09:05:15 -0500
Received: by fk-out-0910.google.com with SMTP id z23so1143294fkz.5
        for <linux-ide@vger.kernel.org>; Sat, 23 Feb 2008 06:05:13 -0800 (PST)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, linux-ide <linux-ide@vger.kernel.org>

File is now error free.
Compile tested.

Signed-off-by: Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>
---
 drivers/ide/ide-pnp.c |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/ide/ide-pnp.c b/drivers/ide/ide-pnp.c
index c125b05..479663d 100644
--- a/drivers/ide/ide-pnp.c
+++ b/drivers/ide/ide-pnp.c
@@ -11,7 +11,7 @@
  *
  * You should have received a copy of the GNU General Public License
  * (for example /usr/src/linux/COPYING); if not, write to the Free
- * Software Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.  
+ * Software Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
  */
 
 #include <linux/init.h>
@@ -20,12 +20,12 @@
 
 /* Add your devices here :)) */
 static struct pnp_device_id idepnp_devices[] = {
-  	/* Generic ESDI/IDE/ATA compatible hard disk controller */
+	/* Generic ESDI/IDE/ATA compatible hard disk controller */
 	{.id = "PNP0600", .driver_data = 0},
 	{.id = ""}
 };
 
-static int idepnp_probe(struct pnp_dev * dev, const struct pnp_device_id *dev_id)
+static int idepnp_probe(struct pnp_dev *dev, const struct pnp_device_id *dev_id)
 {
 	hw_regs_t hw;
 	ide_hwif_t *hwif;
@@ -47,7 +47,7 @@ static int idepnp_probe(struct pnp_dev * dev, const struct pnp_device_id *dev_id
 		ide_init_port_hw(hwif, &hw);
 
 		printk(KERN_INFO "ide%d: generic PnP IDE interface\n", index);
-		pnp_set_drvdata(dev,hwif);
+		pnp_set_drvdata(dev, hwif);
 
 		ide_device_add(idx, NULL);
 
@@ -57,7 +57,7 @@ static int idepnp_probe(struct pnp_dev * dev, const struct pnp_device_id *dev_id
 	return -1;
 }
 
-static void idepnp_remove(struct pnp_dev * dev)
+static void idepnp_remove(struct pnp_dev *dev)
 {
 	ide_hwif_t *hwif = pnp_get_drvdata(dev);
 
-- 
1.5.4.2.316.gf7a7

