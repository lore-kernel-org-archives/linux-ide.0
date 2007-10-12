From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH] libata: Deal with ATA8-ACS proposed Trusted/Treacherous
 Computing features
Date: Fri, 12 Oct 2007 17:39:18 +0100
Message-ID: <20071012173918.3f6d2760@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:39866 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S933191AbXJLQeu (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 12 Oct 2007 12:34:50 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org, linux-ide@vger.kernel.org


Historically word 48 in the identify data was used to mean 32bit I/O was
supported for VLB IDE etc. ATA8 reassigns this word to the Trusted
Computing Group, where it is used for TCG features. This means that an
ATA8 TCG drive is going to trigger 32bit I/O on some systems which will
be funny. Perhaps thats why T13 gave them the word.

Anyway we need to sort this out ready for ATA8 so:
- Reorder the ata.h header a bit so the ata_version function occurs early
in it
- Make dword_io check the ATA version
- Add an ATA8 version checking TCG presence test

While we are at it the current drafts have a flaw where it may not be
possible to disable TCG features at boot (and opt out of the trusted
model) as TCG intends because it relies on presence of a different
optional feature (DCS). Handle this in software by refusing the TCG
commands if libata.allow_tpm is not set. (We must make it possible as
some environments such as proprietary VDR devices will doubtless want to
use it to lock up content)

Finally as with CPRM print a warning so that the user knows they may not
be able to full access and use the device.

Alan

Signed-off-by: Alan Cox <alan@redhat.com>

diff -u --exclude-from /usr/src/exclude --new-file --recursive linux.vanilla-2.6.23rc8-mm1/drivers/ata/libata-core.c linux-2.6.23rc8-mm1/drivers/ata/libata-core.c
--- linux.vanilla-2.6.23rc8-mm1/drivers/ata/libata-core.c	2007-09-26 16:46:48.000000000 +0100
+++ linux-2.6.23rc8-mm1/drivers/ata/libata-core.c	2007-10-12 15:17:37.986953728 +0100
@@ -111,6 +111,10 @@
 module_param_named(noacpi, libata_noacpi, int, 0444);
 MODULE_PARM_DESC(noacpi, "Disables the use of ACPI in suspend/resume when set");
 
+int libata_allow_tpm = 0;
+module_param_named(allow_tpm, libata_allow_tpm, int, 0444);
+MODULE_PARM_DESC(allow_tpm, "Permit the use uf TPM commands");
+
 MODULE_AUTHOR("Jeff Garzik");
 MODULE_DESCRIPTION("Library module for ATA devices");
 MODULE_LICENSE("GPL");
@@ -1945,10 +1950,15 @@
 					       "supports DRM functions and may "
 					       "not be fully accessable.\n");
 			snprintf(revbuf, 7, "CFA");
-		}
-		else
+		} else {
 			snprintf(revbuf, 7, "ATA-%d",  ata_id_major_version(id));
-
+			/* Warn the user if the device has TPM extensions */
+			if (ata_id_has_tpm(id)) {
+				ata_dev_printk(dev, KERN_WARNING,
+					       "supports DRM functions and may "
+					       "not be fully accessable.\n");
+			}
+		}
 		dev->n_sectors = ata_id_n_sectors(id);
 
 		if (dev->id[59] & 0x100)
diff -u --exclude-from /usr/src/exclude --new-file --recursive linux.vanilla-2.6.23rc8-mm1/drivers/ata/libata.h linux-2.6.23rc8-mm1/drivers/ata/libata.h
--- linux.vanilla-2.6.23rc8-mm1/drivers/ata/libata.h	2007-09-26 16:46:48.000000000 +0100
+++ linux-2.6.23rc8-mm1/drivers/ata/libata.h	2007-10-12 14:53:28.413322416 +0100
@@ -59,6 +59,7 @@
 extern int atapi_passthru16;
 extern int libata_fua;
 extern int libata_noacpi;
+extern int libata_allow_tpm;
 extern struct ata_queued_cmd *ata_qc_new_init(struct ata_device *dev);
 extern int ata_build_rw_tf(struct ata_taskfile *tf, struct ata_device *dev,
 			   u64 block, u32 n_block, unsigned int tf_flags,
@@ -158,5 +159,4 @@
 /* libata-sff.c */
 extern u8 ata_irq_on(struct ata_port *ap);
 
-
 #endif /* __LIBATA_H__ */
diff -u --exclude-from /usr/src/exclude --new-file --recursive linux.vanilla-2.6.23rc8-mm1/drivers/ata/libata-scsi.c linux-2.6.23rc8-mm1/drivers/ata/libata-scsi.c
--- linux.vanilla-2.6.23rc8-mm1/drivers/ata/libata-scsi.c	2007-09-26 16:46:48.000000000 +0100
+++ linux-2.6.23rc8-mm1/drivers/ata/libata-scsi.c	2007-10-12 15:20:05.330554096 +0100
@@ -2729,6 +2739,24 @@
 	if ((tf->command == ATA_CMD_SET_FEATURES)
 	 && (tf->feature == SETFEATURES_XFER))
 		goto invalid_fld;
+		
+	/*
+	 * Filter TPM commands by default. These provide an
+	 * essentially uncontrolled encrypted "back door" between
+	 * applications and the disk. Set libata.allow_tpm=1 if you
+	 * have a real reason for wanting to use them. This ensures
+	 * that installed software cannot easily mess stuff up without
+	 * user intent. DVR type users will probably ship with this enabled
+	 * for movie content management.
+	 *
+	 * Note that for ATA8 we can issue a DCS change and DCS freeze lock
+	 * for this and should do in future but that it is not sufficient as
+	 * DCS is an optional feature set. Thus we also do the software filter
+	 * so that we comply with the TC consortium stated goal that the user
+	 * can turn off TC features of their system.
+	 */
+	 if (tf->command >= 0x5C && tf->command <= 0x5F && !libata_allow_tpm)
+	 	goto invalid_fld;
 
 	/*
 	 * Set flags so that all registers will be written,
diff -u --exclude-from /usr/src/exclude --new-file --recursive linux.vanilla-2.6.23rc8-mm1/include/linux/ata.h linux-2.6.23rc8-mm1/include/linux/ata.h
--- linux.vanilla-2.6.23rc8-mm1/include/linux/ata.h	2007-09-26 16:46:57.000000000 +0100
+++ linux-2.6.23rc8-mm1/include/linux/ata.h	2007-10-12 15:16:15.000000000 +0100
@@ -306,6 +306,7 @@
 	ATA_TFLAG_LBA		= (1 << 4), /* enable LBA */
 	ATA_TFLAG_FUA		= (1 << 5), /* enable FUA */
 	ATA_TFLAG_POLLING	= (1 << 6), /* set nIEN to 1 and use polling */
+	ATA_TFLAG_QUIET		= (1 << 7), /* don't log rejection */
 };
 
 enum ata_tf_protocols {
@@ -361,7 +362,6 @@
 #define ata_id_has_ncq(id)	((id)[76] & (1 << 8))
 #define ata_id_queue_depth(id)	(((id)[75] & 0x1f) + 1)
 #define ata_id_removeable(id)	((id)[0] & (1 << 7))
-#define ata_id_has_dword_io(id)	((id)[48] & (1 << 0))
 #define ata_id_has_AN(id)	\
 	( (((id)[76] != 0x0000) && ((id)[76] != 0xffff)) && \
 	  ((id)[78] & (1 << 5)) )
@@ -377,6 +377,37 @@
 
 #define ata_id_cdb_intr(id)	(((id)[0] & 0x60) == 0x20)
 
+/**
+ *	ata_id_major_version	-	get ATA level of drive
+ *	@id: Identify data
+ *
+ *	Caveats:
+ *		ATA-1 considers identify optional
+ *		ATA-2 introduces mandatory identify
+ *		ATA-3 introduces word 80 and accurate reporting
+ *
+ *	The practical impact of this is that ata_id_major_version cannot
+ *	reliably report on drives below ATA3. 
+ */
+
+static inline unsigned int ata_id_major_version(const u16 *id)
+{
+	unsigned int mver;
+
+	if (id[ATA_ID_MAJOR_VER] == 0xFFFF)
+		return 0;
+
+	for (mver = 14; mver >= 1; mver--)
+		if (id[ATA_ID_MAJOR_VER] & (1 << mver))
+			break;
+	return mver;
+}
+
+static inline int ata_id_is_sata(const u16 *id)
+{
+	return ata_id_major_version(id) >= 5 && id[93] == 0;
+}
+
 static inline int ata_id_has_fua(const u16 *id)
 {
 	if ((id[84] & 0xC000) != 0x4000)
@@ -448,37 +479,27 @@
 	return id[85] & (1 << 5);
 }
 
-/**
- *	ata_id_major_version	-	get ATA level of drive
- *	@id: Identify data
- *
- *	Caveats:
- *		ATA-1 considers identify optional
- *		ATA-2 introduces mandatory identify
- *		ATA-3 introduces word 80 and accurate reporting
- *
- *	The practical impact of this is that ata_id_major_version cannot
- *	reliably report on drives below ATA3. 
- */
-
-static inline unsigned int ata_id_major_version(const u16 *id)
+static inline int ata_id_has_tpm(const u16 *id)
 {
-	unsigned int mver;
-
-	if (id[ATA_ID_MAJOR_VER] == 0xFFFF)
+	/* The TPM bits are only valid on ATA8 */
+	if (ata_id_major_version(id) < 8)
 		return 0;
-
-	for (mver = 14; mver >= 1; mver--)
-		if (id[ATA_ID_MAJOR_VER] & (1 << mver))
-			break;
-	return mver;
+	if ((id[48] & 0xC000) != 0x4000)
+		return 0;
+	return id[48] & (1 << 0);
 }
 
-static inline int ata_id_is_sata(const u16 *id)
+static inline int ata_id_has_dword_io(const u16 *id)
 {
-	return ata_id_major_version(id) >= 5 && id[93] == 0;
+	/* ATA 8 reuses this flag for "trusted" computing */
+	if (ata_id_major_version(id) > 7)
+		return 0;
+	if (id[48] & (1 << 0))
+		return 1;
+	return 0;
 }
 
+
 static inline int ata_id_current_chs_valid(const u16 *id)
 {
 	/* For ATA-1 devices, if the INITIALIZE DEVICE PARAMETERS command
