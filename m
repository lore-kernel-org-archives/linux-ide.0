From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: Via SATA not working here
Date: Tue, 14 Sep 2004 14:06:18 -0400
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <4147331A.8040907@pobox.com>
References: <20040912191542.GO21202@uvt316-2.ruk.cuni.cz> <414520BB.3080306@wasp.net.au> <20040914094336.GG18257@uvt316-2.ruk.cuni.cz> <311601c90409140803aaa4d31@mail.gmail.com> <20040914175448.GK18257@uvt316-2.ruk.cuni.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------020007040009010105010501"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:18068 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S269645AbUINSGi
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 14 Sep 2004 14:06:38 -0400
In-Reply-To: <20040914175448.GK18257@uvt316-2.ruk.cuni.cz>
List-Id: linux-ide@vger.kernel.org
To: Michal 'hramrach' Suchanek <hramrach@centrum.cz>
Cc: Eric Mudama <edmudama@gmail.com>, Brad Campbell <brad@wasp.net.au>, f@uvt316-2.ruk.cuni.cz, linux-ide@vger.kernel.org

This is a multi-part message in MIME format.
--------------020007040009010105010501
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Michal 'hramrach' Suchanek wrote:
> imho it did not query it, it is simply bogus. afaict the drive does not
> produce write errors so the code cannot query it whatever it does.
> But i do not know anything about ata or the kernel ata drivers, I did
> not even try to look.
> 
> Currently I have another drive attached to the sata dongle and neither
> bios nor Linux can see it. Perhaps it is because  the drive is switched
> to slave or it does not like the drive rack.


ahhhhhh, that may be a clue.  If you are attaching a PATA drive via a 
bridge, that is very different from attaching a SATA drive, in terms of 
field behavior across the controller spectrum.

There are limitations on bridges.  Does Brad Campbell's patch (attached) 
work for you?

	Jeff


--------------020007040009010105010501
Content-Type: text/plain;
 name="patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch"

diff -ur orig/linux-2.6.0/drivers/scsi/libata-core.c linux-2.6.9-rc1/drivers/scsi/libata-core.c
--- orig/linux-2.6.0/drivers/scsi/libata-core.c	2004-08-30 20:48:35.000000000 +0400
+++ linux-2.6.9-rc1/drivers/scsi/libata-core.c	2004-08-30 21:02:42.000000000 +0400
@@ -1128,6 +1128,37 @@
 	DPRINTK("EXIT, err\n");
 }
 
+
+static inline u8 ata_dev_knobble(struct ata_port *ap)
+{
+	return ((ap->cbl == ATA_CBL_SATA) && (!ata_id_is_sata(ap->device)));
+}
+
+/**
+ * 	ata_dev_config - Run device specific handlers and check for
+ * 			 SATA->PATA bridges
+ * 	@ap: Bus 
+ * 	@i:  Device
+ *
+ * 	LOCKING:
+ */
+ 
+void ata_dev_config(struct ata_port *ap, unsigned int i)
+{
+	/* limit bridge transfers to udma5, 200 sectors */
+	if (ata_dev_knobble(ap)) {
+		printk(KERN_INFO "ata%u(%u): applying bridge limits\n",
+			ap->id, ap->device->devno);
+		ap->udma_mask &= ATA_UDMA5;
+		ap->host->max_sectors = ATA_MAX_SECTORS;
+		ap->host->hostt->max_sectors = ATA_MAX_SECTORS;
+		ap->device->flags |= ATA_DFLAG_LOCK_SECTORS;
+	}
+
+	if (ap->ops->dev_config)
+		ap->ops->dev_config(ap, &ap->device[i]);
+}
+
 /**
  *	ata_bus_probe - Reset and probe ATA bus
  *	@ap: Bus to probe
@@ -1150,8 +1181,7 @@
 		ata_dev_identify(ap, i);
 		if (ata_dev_present(&ap->device[i])) {
 			found = 1;
-			if (ap->ops->dev_config)
-				ap->ops->dev_config(ap, &ap->device[i]);
+			ata_dev_config(ap,i);
 		}
 	}
 
@@ -1226,7 +1256,7 @@
 		ata_port_disable(ap);
 		return;
 	}
-
+	ap->cbl = ATA_CBL_SATA;
 	ata_bus_reset(ap);
 }
 
@@ -3567,3 +3597,4 @@
 EXPORT_SYMBOL_GPL(ata_scsi_release);
 EXPORT_SYMBOL_GPL(ata_host_intr);
 EXPORT_SYMBOL_GPL(ata_dev_id_string);
+EXPORT_SYMBOL_GPL(ata_dev_config);
nly in linux-2.6.9-rc1/include: config
diff -ur orig/linux-2.6.0/include/linux/ata.h linux-2.6.9-rc1/include/linux/ata.h
--- orig/linux-2.6.0/include/linux/ata.h	2004-08-30 20:48:35.000000000 +0400
+++ linux-2.6.9-rc1/include/linux/ata.h	2004-08-30 18:42:41.000000000 +0400
@@ -218,6 +218,7 @@
 };
 
 #define ata_id_is_ata(dev)	(((dev)->id[0] & (1 << 15)) == 0)
+#define ata_id_is_sata(dev)	((dev)->id[93] == 0)
 #define ata_id_rahead_enabled(dev) ((dev)->id[85] & (1 << 6))
 #define ata_id_wcache_enabled(dev) ((dev)->id[85] & (1 << 5))
 #define ata_id_has_flush(dev) ((dev)->id[83] & (1 << 12))
diff -ur orig/linux-2.6.0/include/linux/libata.h linux-2.6.9-rc1/include/linux/libata.h
--- orig/linux-2.6.0/include/linux/libata.h	2004-08-30 20:48:35.000000000 +0400
+++ linux-2.6.9-rc1/include/linux/libata.h	2004-08-30 20:42:05.000000000 +0400
@@ -400,6 +400,7 @@
 		 unsigned int n_elem);
 extern void ata_dev_id_string(struct ata_device *dev, unsigned char *s,
 			      unsigned int ofs, unsigned int len);
+extern void ata_dev_config(struct ata_port *ap, unsigned int i);
 extern void ata_bmdma_setup_mmio (struct ata_queued_cmd *qc);
 extern void ata_bmdma_start_mmio (struct ata_queued_cmd *qc);
 extern void ata_bmdma_setup_pio (struct ata_queued_cmd *qc);


--------------020007040009010105010501--
