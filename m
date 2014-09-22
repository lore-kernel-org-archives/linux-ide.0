From: Joe Perches <joe@perches.com>
Subject: [PATCH] libata: change ata_<foo>_printk routines to return void
Date: Mon, 22 Sep 2014 09:52:18 -0700
Message-ID: <1411404738.2952.39.camel@joe-AO725>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: linux-ide <linux-ide@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-ide@vger.kernel.org

The return value is not used by callers of these functions nor
by uses of all macros so change the functions to return void.

Signed-off-by: Joe Perches <joe@perches.com>
---
This change is associated to a desire to eventually
change printk to return void.

 drivers/ata/libata-core.c | 35 +++++++++++++----------------------
 include/linux/libata.h    | 12 ++++++------
 2 files changed, 19 insertions(+), 28 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index f27dc07..b80b160 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -6772,32 +6772,28 @@ const struct ata_port_info ata_dummy_port_info = {
 /*
  * Utility print functions
  */
-int ata_port_printk(const struct ata_port *ap, const char *level,
-		    const char *fmt, ...)
+void ata_port_printk(const struct ata_port *ap, const char *level,
+		     const char *fmt, ...)
 {
 	struct va_format vaf;
 	va_list args;
-	int r;
 
 	va_start(args, fmt);
 
 	vaf.fmt = fmt;
 	vaf.va = &args;
 
-	r = printk("%sata%u: %pV", level, ap->print_id, &vaf);
+	printk("%sata%u: %pV", level, ap->print_id, &vaf);
 
 	va_end(args);
-
-	return r;
 }
 EXPORT_SYMBOL(ata_port_printk);
 
-int ata_link_printk(const struct ata_link *link, const char *level,
-		    const char *fmt, ...)
+void ata_link_printk(const struct ata_link *link, const char *level,
+		     const char *fmt, ...)
 {
 	struct va_format vaf;
 	va_list args;
-	int r;
 
 	va_start(args, fmt);
 
@@ -6805,37 +6801,32 @@ int ata_link_printk(const struct ata_link *link, const char *level,
 	vaf.va = &args;
 
 	if (sata_pmp_attached(link->ap) || link->ap->slave_link)
-		r = printk("%sata%u.%02u: %pV",
-			   level, link->ap->print_id, link->pmp, &vaf);
+		printk("%sata%u.%02u: %pV",
+		       level, link->ap->print_id, link->pmp, &vaf);
 	else
-		r = printk("%sata%u: %pV",
-			   level, link->ap->print_id, &vaf);
+		printk("%sata%u: %pV",
+		       level, link->ap->print_id, &vaf);
 
 	va_end(args);
-
-	return r;
 }
 EXPORT_SYMBOL(ata_link_printk);
 
-int ata_dev_printk(const struct ata_device *dev, const char *level,
+void ata_dev_printk(const struct ata_device *dev, const char *level,
 		    const char *fmt, ...)
 {
 	struct va_format vaf;
 	va_list args;
-	int r;
 
 	va_start(args, fmt);
 
 	vaf.fmt = fmt;
 	vaf.va = &args;
 
-	r = printk("%sata%u.%02u: %pV",
-		   level, dev->link->ap->print_id, dev->link->pmp + dev->devno,
-		   &vaf);
+	printk("%sata%u.%02u: %pV",
+	       level, dev->link->ap->print_id, dev->link->pmp + dev->devno,
+	       &vaf);
 
 	va_end(args);
-
-	return r;
 }
 EXPORT_SYMBOL(ata_dev_printk);
 
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 92abb49..bd5fefe 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -1404,14 +1404,14 @@ static inline int sata_srst_pmp(struct ata_link *link)
  * printk helpers
  */
 __printf(3, 4)
-int ata_port_printk(const struct ata_port *ap, const char *level,
-		    const char *fmt, ...);
+void ata_port_printk(const struct ata_port *ap, const char *level,
+		     const char *fmt, ...);
 __printf(3, 4)
-int ata_link_printk(const struct ata_link *link, const char *level,
-		    const char *fmt, ...);
+void ata_link_printk(const struct ata_link *link, const char *level,
+		     const char *fmt, ...);
 __printf(3, 4)
-int ata_dev_printk(const struct ata_device *dev, const char *level,
-		   const char *fmt, ...);
+void ata_dev_printk(const struct ata_device *dev, const char *level,
+		    const char *fmt, ...);
 
 #define ata_port_err(ap, fmt, ...)				\
 	ata_port_printk(ap, KERN_ERR, fmt, ##__VA_ARGS__)
