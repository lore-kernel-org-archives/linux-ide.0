From: Michal 'hramrach' Suchanek <hramrach@centrum.cz>
Subject: Re: Via SATA not working here
Date: Sat, 5 Feb 2005 16:03:49 +0100
Message-ID: <20050205150349.GB17295@uvt316-2.ruk.cuni.cz>
References: <20040912191542.GO21202@uvt316-2.ruk.cuni.cz> <414520BB.3080306@wasp.net.au> <20040914094336.GG18257@uvt316-2.ruk.cuni.cz> <311601c90409140803aaa4d31@mail.gmail.com> <20040914175448.GK18257@uvt316-2.ruk.cuni.cz> <4147331A.8040907@pobox.com> <41474D2F.6060201@wasp.net.au>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="bp/iNruPH9dso1Pn"
Received: from dec59.ruk.cuni.cz ([195.113.2.17]:32518 "HELO dec59.ruk.cuni.cz")
	by vger.kernel.org with SMTP id S264624AbVBEPIX (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 5 Feb 2005 10:08:23 -0500
Content-Disposition: inline
In-Reply-To: <41474D2F.6060201@wasp.net.au>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Brad Campbell <brad@wasp.net.au>
Cc: Jeff Garzik <jgarzik@pobox.com>, Eric Mudama <edmudama@gmail.com>, f@uvt316-2.ruk.cuni.cz, linux-ide@vger.kernel.org


--bp/iNruPH9dso1Pn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Sep 14, 2004 at 11:57:35PM +0400, Brad Campbell wrote:
> Jeff Garzik wrote:
> >
> >ahhhhhh, that may be a clue.  If you are attaching a PATA drive via a 
> >bridge, that is very different from attaching a SATA drive, in terms of 
> >field behavior across the controller spectrum.
> >
> >There are limitations on bridges.  Does Brad Campbell's patch (attached) 
> >work for you?
> >
> 
> I doubt it, thats why I had him compile up and test on a 2.6.5 kernel :p(
> Sounds like a similar but different incompatibility.
> 
Hello again

I thought I replied to this but I do not see the reply nor is 2.6.10
working for me. 

Thanks for the patch, it works for me but I had to apply it manually to
the newer kernel. I am not sure I got it right - when I unload ide-scsi
I get a kernel panic but I did not try with an unpatched kernel.

Also I wonder why sata is using the scsi emulation? Is it so different
from pata?

When I used the driver with ide kernel interface hdparm and smartctl
worked on the drive. If dma worked too it would be fine. With the scsi
interface hdparm and smartctl are confused by the drive.

I'm sorry if the previous mail got lost somehow.

Thanks

Michal Suchanek

--bp/iNruPH9dso1Pn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="linux-2.6.10-sata-pata-adaptor.patch"

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


--bp/iNruPH9dso1Pn--
