From: Kristen Carlson Accardi <kristen.c.accardi@intel.com>
Subject: [patch 1/3] libata: check for AN support
Date: Tue, 20 Mar 2007 17:52:30 -0700
Message-ID: <20070320175230.cd343471.kristen.c.accardi@intel.com>
References: <20070321004740.939006166@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="Multipart=_Tue__20_Mar_2007_17_52_30_-0700_.g28=X5XbXW+5dYg"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:33373 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933664AbXCUAzD (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 20 Mar 2007 20:55:03 -0400
In-Reply-To: <20070321004740.939006166@intel.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: jgarzik@pobox.com, Kristen Carlson Accardi <kristen.c.accardi@intel.com>

This is a multi-part message in MIME format.

--Multipart=_Tue__20_Mar_2007_17_52_30_-0700_.g28=X5XbXW+5dYg
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Check to see if an ATAPI device supports Asynchronous Notification.
If so, enable it.

Signed-off-by: Kristen Carlson Accardi <kristen.c.accardi@intel.com>

Index: 2.6-git/drivers/ata/libata-core.c
===================================================================
--- 2.6-git.orig/drivers/ata/libata-core.c	2007-03-21 00:37:11.000000000 -0700
+++ 2.6-git/drivers/ata/libata-core.c	2007-03-21 01:26:08.000000000 -0700
@@ -67,6 +67,7 @@
 static unsigned int ata_dev_init_params(struct ata_device *dev,
 					u16 heads, u16 sectors);
 static unsigned int ata_dev_set_xfermode(struct ata_device *dev);
+static unsigned int ata_dev_set_an(struct ata_device *dev);
 static void ata_dev_xfermask(struct ata_device *dev);
 
 static unsigned int ata_unique_id = 1;
@@ -1739,6 +1740,23 @@
 		}
 		dev->cdb_len = (unsigned int) rc;
 
+		/*
+		 * check to see if this ATAPI device supports
+		 * Asynchronous Notification
+		 */
+		if (ata_id_has_an(id))
+		{
+			/* issue SET feature command to turn this on */
+			rc = ata_dev_set_an(dev);
+			if (rc) {
+				ata_dev_printk(dev, KERN_ERR,
+						"unable to set AN\n");
+				rc = -EINVAL;
+				goto err_out_nosup;
+			}
+			dev->flags |= ATA_DFLAG_AN;
+		}
+
 		if (ata_id_cdb_intr(dev->id)) {
 			dev->flags |= ATA_DFLAG_CDB_INTR;
 			cdb_intr_string = ", CDB intr";
@@ -3479,6 +3497,42 @@
 }
 
 /**
+ *	ata_dev_set_an - Issue SET FEATURES - SATA FEATURES
+ *                       with sector count set to indicate
+ *                       Asynchronous Notification feature
+ *	@dev: Device to which command will be sent
+ *
+ *	Issue SET FEATURES - SATA FEATURES command to device @dev
+ *	on port @ap.
+ *
+ *	LOCKING:
+ *	PCI/etc. bus probe sem.
+ *
+ *	RETURNS:
+ *	0 on success, AC_ERR_* mask otherwise.
+ */
+static unsigned int ata_dev_set_an(struct ata_device *dev)
+{
+	struct ata_taskfile tf;
+	unsigned int err_mask;
+
+	/* set up set-features taskfile */
+	DPRINTK("set features - SATA features\n");
+
+	ata_tf_init(dev, &tf);
+	tf.command = ATA_CMD_SET_FEATURES;
+	tf.feature = SETFEATURES_SATA_ENABLE;
+	tf.flags |= ATA_TFLAG_ISADDR | ATA_TFLAG_DEVICE;
+	tf.protocol = ATA_PROT_NODATA;
+	tf.nsect = SATA_AN;
+
+	err_mask = ata_exec_internal(dev, &tf, NULL, DMA_NONE, NULL, 0);
+
+	DPRINTK("EXIT, err_mask=%x\n", err_mask);
+	return err_mask;
+}
+
+/**
  *	ata_dev_init_params - Issue INIT DEV PARAMS command
  *	@dev: Device to which command will be sent
  *	@heads: Number of heads (taskfile parameter)
Index: 2.6-git/include/linux/ata.h
===================================================================
--- 2.6-git.orig/include/linux/ata.h	2007-03-21 00:37:16.000000000 -0700
+++ 2.6-git/include/linux/ata.h	2007-03-21 00:40:59.000000000 -0700
@@ -190,6 +190,12 @@
 	SETFEATURES_WC_ON	= 0x02, /* Enable write cache */
 	SETFEATURES_WC_OFF	= 0x82, /* Disable write cache */
 
+	SETFEATURES_SATA_ENABLE = 0x10, /* Enable use of SATA feature */
+	SETFEATURES_SATA_DISABLE = 0x90, /* Disable use of SATA feature */
+
+	/* SETFEATURE Sector counts for SATA features */
+	SATA_AN			= 0x05,  /* Asynchronous Notification */
+
 	/* ATAPI stuff */
 	ATAPI_PKT_DMA		= (1 << 0),
 	ATAPI_DMADIR		= (1 << 2),	/* ATAPI data dir:
@@ -296,6 +302,8 @@
 #define ata_id_queue_depth(id)	(((id)[75] & 0x1f) + 1)
 #define ata_id_removeable(id)	((id)[0] & (1 << 7))
 #define ata_id_has_dword_io(id)	((id)[50] & (1 << 0))
+#define ata_id_has_an(id)	\
+	((id[76] && (~id[76])) & ((id)[78] & (1 << 5)))
 #define ata_id_u32(id,n)	\
 	(((u32) (id)[(n) + 1] << 16) | ((u32) (id)[(n)]))
 #define ata_id_u64(id,n)	\
Index: 2.6-git/include/linux/libata.h
===================================================================
--- 2.6-git.orig/include/linux/libata.h	2007-03-21 00:37:17.000000000 -0700
+++ 2.6-git/include/linux/libata.h	2007-03-21 01:26:08.000000000 -0700
@@ -141,6 +141,7 @@
 	ATA_DFLAG_CDB_INTR	= (1 << 2), /* device asserts INTRQ when ready for CDB */
 	ATA_DFLAG_NCQ		= (1 << 3), /* device supports NCQ */
 	ATA_DFLAG_FLUSH_EXT	= (1 << 4), /* do FLUSH_EXT instead of FLUSH */
+	ATA_DFLAG_AN		= (1 << 5), /* device supports Async notification */
 	ATA_DFLAG_CFG_MASK	= (1 << 8) - 1,
 
 	ATA_DFLAG_PIO		= (1 << 8), /* device limited to PIO mode */

-- 

--Multipart=_Tue__20_Mar_2007_17_52_30_-0700_.g28=X5XbXW+5dYg
Content-Type: text/plain;
 name="libata-check-for-an"
Content-Disposition: attachment;
 filename="libata-check-for-an"
Content-Transfer-Encoding: 7bit

Check to see if an ATAPI device supports Asynchronous Notification.
If so, enable it.

Signed-off-by: Kristen Carlson Accardi <kristen.c.accardi@intel.com>

Index: 2.6-git/drivers/ata/libata-core.c
===================================================================
--- 2.6-git.orig/drivers/ata/libata-core.c	2007-03-21 00:37:11.000000000 -0700
+++ 2.6-git/drivers/ata/libata-core.c	2007-03-21 01:26:08.000000000 -0700
@@ -67,6 +67,7 @@
 static unsigned int ata_dev_init_params(struct ata_device *dev,
 					u16 heads, u16 sectors);
 static unsigned int ata_dev_set_xfermode(struct ata_device *dev);
+static unsigned int ata_dev_set_an(struct ata_device *dev);
 static void ata_dev_xfermask(struct ata_device *dev);
 
 static unsigned int ata_unique_id = 1;
@@ -1739,6 +1740,23 @@
 		}
 		dev->cdb_len = (unsigned int) rc;
 
+		/*
+		 * check to see if this ATAPI device supports
+		 * Asynchronous Notification
+		 */
+		if (ata_id_has_an(id))
+		{
+			/* issue SET feature command to turn this on */
+			rc = ata_dev_set_an(dev);
+			if (rc) {
+				ata_dev_printk(dev, KERN_ERR,
+						"unable to set AN\n");
+				rc = -EINVAL;
+				goto err_out_nosup;
+			}
+			dev->flags |= ATA_DFLAG_AN;
+		}
+
 		if (ata_id_cdb_intr(dev->id)) {
 			dev->flags |= ATA_DFLAG_CDB_INTR;
 			cdb_intr_string = ", CDB intr";
@@ -3479,6 +3497,42 @@
 }
 
 /**
+ *	ata_dev_set_an - Issue SET FEATURES - SATA FEATURES
+ *                       with sector count set to indicate
+ *                       Asynchronous Notification feature
+ *	@dev: Device to which command will be sent
+ *
+ *	Issue SET FEATURES - SATA FEATURES command to device @dev
+ *	on port @ap.
+ *
+ *	LOCKING:
+ *	PCI/etc. bus probe sem.
+ *
+ *	RETURNS:
+ *	0 on success, AC_ERR_* mask otherwise.
+ */
+static unsigned int ata_dev_set_an(struct ata_device *dev)
+{
+	struct ata_taskfile tf;
+	unsigned int err_mask;
+
+	/* set up set-features taskfile */
+	DPRINTK("set features - SATA features\n");
+
+	ata_tf_init(dev, &tf);
+	tf.command = ATA_CMD_SET_FEATURES;
+	tf.feature = SETFEATURES_SATA_ENABLE;
+	tf.flags |= ATA_TFLAG_ISADDR | ATA_TFLAG_DEVICE;
+	tf.protocol = ATA_PROT_NODATA;
+	tf.nsect = SATA_AN;
+
+	err_mask = ata_exec_internal(dev, &tf, NULL, DMA_NONE, NULL, 0);
+
+	DPRINTK("EXIT, err_mask=%x\n", err_mask);
+	return err_mask;
+}
+
+/**
  *	ata_dev_init_params - Issue INIT DEV PARAMS command
  *	@dev: Device to which command will be sent
  *	@heads: Number of heads (taskfile parameter)
Index: 2.6-git/include/linux/ata.h
===================================================================
--- 2.6-git.orig/include/linux/ata.h	2007-03-21 00:37:16.000000000 -0700
+++ 2.6-git/include/linux/ata.h	2007-03-21 00:40:59.000000000 -0700
@@ -190,6 +190,12 @@
 	SETFEATURES_WC_ON	= 0x02, /* Enable write cache */
 	SETFEATURES_WC_OFF	= 0x82, /* Disable write cache */
 
+	SETFEATURES_SATA_ENABLE = 0x10, /* Enable use of SATA feature */
+	SETFEATURES_SATA_DISABLE = 0x90, /* Disable use of SATA feature */
+
+	/* SETFEATURE Sector counts for SATA features */
+	SATA_AN			= 0x05,  /* Asynchronous Notification */
+
 	/* ATAPI stuff */
 	ATAPI_PKT_DMA		= (1 << 0),
 	ATAPI_DMADIR		= (1 << 2),	/* ATAPI data dir:
@@ -296,6 +302,8 @@
 #define ata_id_queue_depth(id)	(((id)[75] & 0x1f) + 1)
 #define ata_id_removeable(id)	((id)[0] & (1 << 7))
 #define ata_id_has_dword_io(id)	((id)[50] & (1 << 0))
+#define ata_id_has_an(id)	\
+	((id[76] && (~id[76])) & ((id)[78] & (1 << 5)))
 #define ata_id_u32(id,n)	\
 	(((u32) (id)[(n) + 1] << 16) | ((u32) (id)[(n)]))
 #define ata_id_u64(id,n)	\
Index: 2.6-git/include/linux/libata.h
===================================================================
--- 2.6-git.orig/include/linux/libata.h	2007-03-21 00:37:17.000000000 -0700
+++ 2.6-git/include/linux/libata.h	2007-03-21 01:26:08.000000000 -0700
@@ -141,6 +141,7 @@
 	ATA_DFLAG_CDB_INTR	= (1 << 2), /* device asserts INTRQ when ready for CDB */
 	ATA_DFLAG_NCQ		= (1 << 3), /* device supports NCQ */
 	ATA_DFLAG_FLUSH_EXT	= (1 << 4), /* do FLUSH_EXT instead of FLUSH */
+	ATA_DFLAG_AN		= (1 << 5), /* device supports Async notification */
 	ATA_DFLAG_CFG_MASK	= (1 << 8) - 1,
 
 	ATA_DFLAG_PIO		= (1 << 8), /* device limited to PIO mode */

-- 

--Multipart=_Tue__20_Mar_2007_17_52_30_-0700_.g28=X5XbXW+5dYg--
