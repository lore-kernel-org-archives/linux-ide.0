From: Hannes Reinecke <hare@suse.de>
Subject: [PATCH] too late: updated version of the ACPI patches
Date: Thu, 28 Sep 2006 10:38:29 +0200
Message-ID: <451B8A05.5080002@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------040806070702020200010407"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:38301 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751776AbWI1Iic (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 28 Sep 2006 04:38:32 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Kristen Carlson Accardi <kristen.c.accardi@intel.com>

This is a multi-part message in MIME format.
--------------040806070702020200010407
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit

Hi Jeff,

argl. Appearently I'm in Yeltsin mode.

Anyway: I'm also have finished an updated version of the ACPI patches.
They are also based upon the patches by Randy Dunlap but with some 
improvements:

- Omit the namespace walk for SATA devices. We can really trust the ACPI 
layer to find out the correct device. If not the ACPI is buggered anyway 
and we shouldn't even try to continue.
- Make the control over the ACPI execution more finegrained as some 
methods (most notably _GTF) are downright disastrous on PATA devices, 
whereas you really want to call _GTM / _STM on these to have them 
properly resumed after suspend to RAM.
- Only export the symbols we really have to :-)
- Proper integration with the new EH code. This is actually an error in 
the patch by Kristen; for new-style EH the ACPI functions will never be 
called :-(

If you consider this a duplicate I'm happy to rebase my patch on top of 
Kristens.

Comments etc are welcome.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke			hare@suse.de
SuSE Linux Products GmbH		S390 & zSeries
Maxfeldstraße 5				+49 911 74053 688
90409 Nürnberg				http://www.suse.de

--------------040806070702020200010407
Content-Type: text/plain;
 name="libata-acpi-support"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="libata-acpi-support"

diff --git a/Documentation/kernel-parameters.txt b/Documentation/kernel-parameters.txt
index b50595a..73e73ef 100644
--- a/Documentation/kernel-parameters.txt
+++ b/Documentation/kernel-parameters.txt
@@ -48,6 +48,7 @@ parameter is applicable:
 	ISAPNP	ISA PnP code is enabled.
 	ISDN	Appropriate ISDN support is enabled.
 	JOY	Appropriate joystick support is enabled.
+	LIBATA  Libata driver is enabled.
 	LP	Printer support is enabled.
 	LOOP	Loopback device support is enabled.
 	M68k	M68k architecture is enabled.
@@ -257,6 +258,10 @@ running once the system is up.
 	arcrimi=	[HW,NET] ARCnet - "RIM I" (entirely mem-mapped) cards
 			Format: <io>,<irq>,<nodeID>
 
+	ata_acpi=	[LIBATA] Disables use of ACPI in libata suspend/resume
+			when set.
+			Format: <int>
+
 	ataflop=	[HW,M68k]
 
 	atarimouse=	[HW,MOUSE] Atari Mouse
diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
index 13027d5..4b90b2d 100644
--- a/drivers/ata/Kconfig
+++ b/drivers/ata/Kconfig
@@ -145,6 +145,19 @@ config SATA_INTEL_COMBINED
 	depends on IDE=y && !BLK_DEV_IDE_SATA && (SATA_AHCI || ATA_PIIX)
 	default y
 
+config ATA_ACPI
+	bool "Handle ATA-related ACPI objects"
+	depends on ACPI && PCI
+	default y
+	help
+	  This option adds support for ATA-related ACPI objects.
+	  These ACPI objects add the ability to retrieve taskfiles
+	  from the ACPI BIOS and write them to the disk controller.
+	  These objects may be related to performance, security,
+	  power management, or other areas.
+	  You can disable this at kernel boot time by using the
+	  option 'libata.ata_acpi=0'.
+
 endif
 endmenu
 
diff --git a/drivers/ata/Makefile b/drivers/ata/Makefile
index e260e3f..875b5d9 100644
--- a/drivers/ata/Makefile
+++ b/drivers/ata/Makefile
@@ -18,4 +18,5 @@ obj-$(CONFIG_SATA_MV)		+= sata_mv.o
 obj-$(CONFIG_PDC_ADMA)		+= pdc_adma.o
 
 libata-objs	:= libata-core.o libata-scsi.o libata-sff.o libata-eh.o
+libata-$(CONFIG_ATA_ACPI) += libata-acpi.o
 
diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 1c93154..c914e94 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -90,6 +90,12 @@ static int ata_probe_timeout = ATA_TMOUT
 module_param(ata_probe_timeout, int, 0444);
 MODULE_PARM_DESC(ata_probe_timeout, "Set ATA probing timeout (seconds)");
 
+#ifdef CONFIG_ATA_ACPI
+int libata_acpi = 0x73;
+module_param_named(ata_acpi, libata_acpi, int, 0444);
+MODULE_PARM_DESC(ata_acpi, "Controls use of ACPI objects");
+#endif
+
 MODULE_AUTHOR("Jeff Garzik");
 MODULE_DESCRIPTION("Library module for ATA devices");
 MODULE_LICENSE("GPL");
@@ -1396,10 +1402,10 @@ int ata_dev_configure(struct ata_device 
 	if (ata_msg_probe(ap))
 		ata_dev_printk(dev, KERN_DEBUG,
 			       "%s: cfg 49:%04x 82:%04x 83:%04x 84:%04x "
-			       "85:%04x 86:%04x 87:%04x 88:%04x\n",
+			       "85:%04x 86:%04x 87:%04x 88:%04x 93:%04x\n",
 			       __FUNCTION__,
-			       id[49], id[82], id[83], id[84],
-			       id[85], id[86], id[87], id[88]);
+			       id[49], id[82], id[83], id[84], id[85],
+			       id[86], id[87], id[88], id[93]);
 
 	/* initialize to-be-configured parameters */
 	dev->flags &= ~ATA_DFLAG_CFG_MASK;
@@ -1623,6 +1629,32 @@ int ata_bus_probe(struct ata_port *ap)
 		goto fail;
 	}
 
+#ifdef CONFIG_ATA_ACPI
+	if (!(ap->flags & ATA_FLAG_SATA)) {
+		/*  Call _GTM for PATA ports*/
+		ata_acpi_get_timing(ap);
+		/* Call _STM for PATA ports
+		 * required as _STM may modify _GTF information */
+		ata_acpi_push_timing(ap);
+	}
+
+	for (i = 0; i < ATA_MAX_DEVICES; i++) {
+		dev = &ap->device[i];
+
+		if (!ata_dev_enabled(dev))
+			continue;
+
+		if (ata_id_is_sata(dev->id)) {
+			/* Send down drive data via _SDD */
+			ata_acpi_push_id(dev);
+		}
+
+		/* retrieve and execute the ATA task file of _GTF */
+		ata_acpi_exec_tfs(dev);
+
+	}
+#endif
+
 	for (i = 0; i < ATA_MAX_DEVICES; i++)
 		if (ata_dev_enabled(&ap->device[i]))
 			return 0;
@@ -2186,6 +2218,11 @@ int ata_set_mode(struct ata_port *ap, st
 				break;
 			}
 		}
+#ifdef CONFIG_ATA_ACPI
+		/* Call _GTM for PATA ports */
+		if (!(ap->flags & ATA_FLAG_SATA))
+			ata_acpi_get_timing(ap);
+#endif
 		return 0;
 	}
 
@@ -2265,6 +2302,11 @@ int ata_set_mode(struct ata_port *ap, st
 	/* step5: chip specific finalisation */
 	if (ap->ops->post_set_mode)
 		ap->ops->post_set_mode(ap);
+#ifdef CONFIG_ATA_ACPI
+	/* step6: Call _GTM for PATA ports */
+	if (!(ap->flags & ATA_FLAG_SATA))
+		ata_acpi_get_timing(ap);
+#endif
 
  out:
 	if (rc)
@@ -5476,6 +5518,7 @@ int ata_device_add(const struct ata_prob
 		/* print per-port info to dmesg */
 		ata_port_printk(ap, KERN_INFO, "%cATA max %s cmd 0x%lX "
 				"ctl 0x%lX bmdma 0x%lX irq %d\n",
+				ap->flags & ATA_FLAG_PATA_MODE ? 'P' :
 				ap->flags & ATA_FLAG_SATA ? 'S' : 'P',
 				ata_mode_string(xfer_mode_mask),
 				ap->ioaddr.cmd_addr,
diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index b1b5104..93723c1 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -1991,6 +1991,21 @@ static int ata_eh_recover(struct ata_por
 			down_xfermask = 1;
 			goto dev_fail;
 		}
+
+#ifdef CONFIG_ATA_ACPI
+		for (i = 0; i < ATA_MAX_DEVICES; i++) {
+			dev = &ap->device[i];
+
+			if (!ata_dev_enabled(dev))
+				continue;
+
+			/* Send down drive data via _SDD */
+			ata_acpi_push_id(dev);
+
+			/* retrieve and execute the ATA task file of _GTF */
+			ata_acpi_exec_tfs(dev);			
+		}
+#endif
 	}
 
 	/* suspend devices */
@@ -2215,6 +2230,12 @@ static void ata_eh_handle_port_resume(st
 	if (!(ap->pflags & ATA_PFLAG_SUSPENDED))
 		goto done;
 
+#ifdef CONFIG_ATA_ACPI
+	if (!(ap->flags & ATA_FLAG_SATA)) {
+		/* Call _STM for PATA ports */
+		ata_acpi_push_timing(ap);
+	}
+#endif
 	if (ap->ops->port_resume)
 		rc = ap->ops->port_resume(ap);
 
diff --git a/drivers/ata/libata-sff.c b/drivers/ata/libata-sff.c
index 7605028..c8aee20 100644
--- a/drivers/ata/libata-sff.c
+++ b/drivers/ata/libata-sff.c
@@ -959,6 +959,10 @@ int ata_pci_init_one (struct pci_dev *pd
 
 	if ((port[0]->flags & ATA_FLAG_NO_LEGACY) == 0
 	    && (pdev->class >> 8) == PCI_CLASS_STORAGE_IDE) {
+		printk(KERN_DEBUG "%s: NO_LEGACY == 0\n", __FUNCTION__);
+		port[0]->flags |= ATA_FLAG_PATA_MODE;
+		port[0]->flags &= ~ATA_FLAG_SATA;
+	    
 		/* TODO: What if one channel is in native mode ... */
 		pci_read_config_byte(pdev, PCI_CLASS_PROG, &tmp8);
 		mask = (1 << 2) | (1 << 0);
diff --git a/drivers/ata/libata.h b/drivers/ata/libata.h
index a5ecb71..0b826eb 100644
--- a/drivers/ata/libata.h
+++ b/drivers/ata/libata.h
@@ -43,6 +43,9 @@ extern struct workqueue_struct *ata_aux_
 extern int atapi_enabled;
 extern int atapi_dmadir;
 extern int libata_fua;
+#ifdef CONFIG_ATA_ACPI
+extern int libata_acpi;
+#endif
 extern struct ata_queued_cmd *ata_qc_new_init(struct ata_device *dev);
 extern int ata_rwcmd_protocol(struct ata_queued_cmd *qc);
 extern void ata_dev_disable(struct ata_device *dev);
@@ -119,4 +122,12 @@ extern void ata_scsi_error(struct Scsi_H
 extern void ata_port_wait_eh(struct ata_port *ap);
 extern void ata_qc_schedule_eh(struct ata_queued_cmd *qc);
 
+/* libata-acpi.c */
+#ifdef CONFIG_ATA_ACPI
+extern int ata_acpi_push_id(struct ata_device *atadev);
+extern int ata_acpi_exec_tfs(struct ata_device *atadev);
+extern void ata_acpi_get_timing(struct ata_port *ap);
+extern void ata_acpi_push_timing(struct ata_port *ap);
+#endif
+
 #endif /* __LIBATA_H__ */
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 0ddf16c..d9104c1 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -35,6 +35,9 @@ #include <asm/io.h>
 #include <linux/ata.h>
 #include <linux/workqueue.h>
 #include <scsi/scsi_host.h>
+#ifdef CONFIG_ATA_ACPI
+#include <acpi/acpi.h>
+#endif
 
 #include <asm/libata-portmap.h>
 
@@ -46,7 +49,7 @@ #undef ATA_DEBUG		/* debugging output */
 #undef ATA_VERBOSE_DEBUG	/* yet more debugging output */
 #undef ATA_IRQ_TRAP		/* define to ack screaming irqs */
 #undef ATA_NDEBUG		/* define to disable quick runtime checks */
-#undef ATA_ENABLE_PATA		/* define to enable PATA support in some
+#define ATA_ENABLE_PATA		/* define to enable PATA support in some
 				 * low-level drivers */
 
 
@@ -97,6 +100,25 @@ static inline u32 ata_msg_init(int dval,
 	return (1 << dval) - 1;
 }
 
+#ifdef CONFIG_ATA_ACPI
+enum {
+    ATA_ACPI_SATA_MASK = 0xf0,
+    ATA_ACPI_SATA_SDD  = 0x10, /* Execute _SDD method */
+    ATA_ACPI_SATA_GTF  = 0x20, /* Execute _GTF method */
+    ATA_ACPI_SATA_TFX  = 0x40, /* Execute tf registers received via _GTF */
+    ATA_ACPI_PATA_MASK = 0x0f,
+    ATA_ACPI_PATA_GTM  = 0x01, /* Execute _GTM & _STM method */
+    ATA_ACPI_PATA_GTF  = 0x02, /* Execute _GTF method */
+    ATA_ACPI_PATA_TFX  = 0x04, /* Execute tf registers received via _GTF */
+
+    ATA_ACPI_GTF  = 0x02, /* Execute _GTF method */
+    ATA_ACPI_TFX  = 0x04, /* Execute tf registers received via _GTF */
+};
+
+#define ata_acpi_flags(a,f)  ata_id_is_sata((a)->id)?((f)>>4):(f)
+
+#endif
+
 /* defines only for the constants which don't work well as enums */
 #define ATA_TAG_POISON		0xfafbfcfdU
 
@@ -162,6 +184,7 @@ enum {
 	ATA_FLAG_SKIP_D2H_BSY	= (1 << 12), /* can't wait for the first D2H
 					      * Register FIS clearing BSY */
 	ATA_FLAG_DEBUGMSG	= (1 << 13),
+	ATA_FLAG_PATA_MODE	= (1 << 14), /* port in PATA mode */
 
 	/* The following flag belongs to ap->pflags but is kept in
 	 * ap->flags because it's referenced in many LLDs and will be
@@ -318,6 +341,7 @@ struct scsi_device;
 struct ata_port_operations;
 struct ata_port;
 struct ata_queued_cmd;
+struct GTM_buffer;
 
 /* typedefs */
 typedef void (*ata_qc_cb_t) (struct ata_queued_cmd *qc);
@@ -468,6 +492,11 @@ struct ata_device {
 
 	/* error history */
 	struct ata_ering	ering;
+
+#ifdef CONFIG_ATA_ACPI
+	/* ACPI objects info */
+	acpi_handle		obj_handle;
+#endif
 };
 
 /* Offset into struct ata_device.  Fields above it are maintained
@@ -554,6 +583,11 @@ struct ata_port {
 	pm_message_t		pm_mesg;
 	int			*pm_result;
 
+#ifdef CONFIG_ATA_ACPI
+	struct GTM_buffer	*gtm;
+	void			*gtm_object_area;
+#endif
+
 	void			*private_data;
 
 	u8			sector_buf[ATA_SECT_SIZE]; /* owned by EH */

--------------040806070702020200010407--
