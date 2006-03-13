From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH] libata: clean up IDENTIFY printing
Date: Mon, 13 Mar 2006 14:33:50 +0900
Message-ID: <20060313053350.GD29870@htj.dyndns.org>
References: <44144172.9040304@garzik.org> <20060312165701.GA9051@htj.dyndns.org> <44146758.6090006@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from pproxy.gmail.com ([64.233.166.183]:32203 "EHLO pproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751243AbWCMFd4 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 13 Mar 2006 00:33:56 -0500
Received: by pproxy.gmail.com with SMTP id d42so809295pyd
        for <linux-ide@vger.kernel.org>; Sun, 12 Mar 2006 21:33:55 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <44146758.6090006@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

Printing info about IDENTIFY page used to be the responsibility of
ata_dev_read_id().  As all devices are revalidated after xfer mode
configuration, this resulted in two info messages about one device.
This patch improves ata_dump_id() such that it can be generally
useable and makes printing the responsibility of ata_dev_configure()
which has better understanding of what's going on.

The IDENTIFY info printing now looks like the following.

ata2: dev 1 cfg 49:2f00 53:0007 63:0007 64:0003 75:001f 80:00fe 81:0000 82:346b
                83:7d01 84:4023 85:3469 86:3c01 87:4023 88:207f 93:0000

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 libata-core.c |   61 +++++++++++++++++++++++-----------------------------------
 1 file changed, 25 insertions(+), 36 deletions(-)

diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index 439b6db..7e9cb70 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -743,40 +743,33 @@ void ata_dev_select(struct ata_port *ap,
 /**
  *	ata_dump_id - IDENTIFY DEVICE info debugging output
  *	@id: IDENTIFY DEVICE page to dump
+ *	@level: KERN_* message level
+ *	@fmt: header format string
+ *	@...: header string arguments
  *
- *	Dump selected 16-bit words from the given IDENTIFY DEVICE
- *	page.
+ *	Dump selected 16-bit words from the given IDENTIFY DEVICE page
+ *	with the specified header.
  *
  *	LOCKING:
  *	caller.
  */
-
-static inline void ata_dump_id(const u16 *id)
+static void ata_dump_id(const u16 *id, const char *level, const char *fmt, ...)
 {
-	DPRINTK("49==0x%04x  "
-		"53==0x%04x  "
-		"63==0x%04x  "
-		"64==0x%04x  "
-		"75==0x%04x  \n",
-		id[49],
-		id[53],
-		id[63],
-		id[64],
-		id[75]);
-	DPRINTK("80==0x%04x  "
-		"81==0x%04x  "
-		"82==0x%04x  "
-		"83==0x%04x  "
-		"84==0x%04x  \n",
-		id[80],
-		id[81],
-		id[82],
-		id[83],
-		id[84]);
-	DPRINTK("88==0x%04x  "
-		"93==0x%04x\n",
-		id[88],
-		id[93]);
+	va_list ap;
+	char buf[24];
+
+	va_start(ap, fmt);
+	vscnprintf(buf, sizeof(buf), fmt, ap);
+	va_end(ap);
+
+	printk("%s%s49:%04x 53:%04x 63:%04x 64:%04x 75:%04x 80:%04x 81:%04x 82:%04x\n",
+	       level, buf,
+	       id[49], id[53], id[63], id[64], id[75], id[80], id[81], id[82]);
+
+	memset(buf, ' ', strlen(buf));
+	printk("%s%s83:%04x 84:%04x 85:%04x 86:%04x 87:%04x 88:%04x 93:%04x\n",
+	       level, buf,
+	       id[83], id[84], id[85], id[86], id[87], id[88], id[93]);
 }
 
 /**
@@ -1120,12 +1113,6 @@ static int ata_dev_read_id(struct ata_po
 
 	swap_buf_le16(id, ATA_ID_WORDS);
 
-	/* print device capabilities */
-	printk(KERN_DEBUG "ata%u: dev %u cfg "
-	       "49:%04x 82:%04x 83:%04x 84:%04x 85:%04x 86:%04x 87:%04x 88:%04x\n",
-	       ap->id, dev->devno,
-	       id[49], id[82], id[83], id[84], id[85], id[86], id[87], id[88]);
-
 	/* sanity check */
 	if ((class == ATA_DEV_ATA) != ata_id_is_ata(id)) {
 		rc = -EINVAL;
@@ -1204,6 +1191,10 @@ static int ata_dev_configure(struct ata_
 
 	DPRINTK("ENTER, host %u, dev %u\n", ap->id, dev->devno);
 
+	if (print_info)
+		ata_dump_id(dev->id, KERN_DEBUG, "ata%u: dev %u cfg ",
+			    ap->id, dev->devno);
+
 	/* initialize to-be-configured parameters */
 	dev->flags = 0;
 	dev->max_sectors = 0;
@@ -1227,8 +1218,6 @@ static int ata_dev_configure(struct ata_
 	/* find max transfer mode; for printk only */
 	xfer_mask = ata_id_xfermask(dev->id);
 
-	ata_dump_id(dev->id);
-
 	/* ATA-specific feature tests */
 	if (dev->class == ATA_DEV_ATA) {
 		dev->n_sectors = ata_id_n_sectors(dev->id);
