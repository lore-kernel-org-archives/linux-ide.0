From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH] libata: Strict checking for identify reporting
Date: Wed, 22 Aug 2007 23:31:43 +0100
Message-ID: <20070822233143.46a36026@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:47568 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S964863AbXHVWXk (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 22 Aug 2007 18:23:40 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: akpm@osdl.org, linux-ide@vger.kernel.org, jeff@garzik.org

The ATA specifications require checks on certain flags before assuming
the validity of other data. Go through the methods and correct those
needing extra checks. Also note limits on ata_id_major_version with
respect to ATA-1 and ATA-2. Correct the 32bit PIO check.

Wants to sit in -mm for a bit in case of a screwup on my part that I
didn't hit on the test drives and also in case someone, somewhere has
a drive that gets it wrong.

Signed-off-by: Alan Cox <alan@redhat.com>

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.23rc3-mm1/include/linux/ata.h linux-2.6.23rc3-mm1/include/linux/ata.h
--- linux.vanilla-2.6.23rc3-mm1/include/linux/ata.h	2007-08-22 17:23:14.000000000 +0100
+++ linux-2.6.23rc3-mm1/include/linux/ata.h	2007-08-22 17:49:49.000000000 +0100
@@ -343,22 +344,12 @@
 };
 
 #define ata_id_is_ata(id)	(((id)[0] & (1 << 15)) == 0)
-#define ata_id_rahead_enabled(id) ((id)[85] & (1 << 6))
-#define ata_id_wcache_enabled(id) ((id)[85] & (1 << 5))
-#define ata_id_hpa_enabled(id)	((id)[85] & (1 << 10))
-#define ata_id_has_fua(id)	((id)[84] & (1 << 6))
-#define ata_id_has_flush(id)	((id)[83] & (1 << 12))
-#define ata_id_has_flush_ext(id) ((id)[83] & (1 << 13))
-#define ata_id_has_lba48(id)	((id)[83] & (1 << 10))
-#define ata_id_has_hpa(id)	((id)[82] & (1 << 10))
-#define ata_id_has_wcache(id)	((id)[82] & (1 << 5))
-#define ata_id_has_pm(id)	((id)[82] & (1 << 3))
 #define ata_id_has_lba(id)	((id)[49] & (1 << 9))
 #define ata_id_has_dma(id)	((id)[49] & (1 << 8))
 #define ata_id_has_ncq(id)	((id)[76] & (1 << 8))
 #define ata_id_queue_depth(id)	(((id)[75] & 0x1f) + 1)
 #define ata_id_removeable(id)	((id)[0] & (1 << 7))
-#define ata_id_has_dword_io(id)	((id)[50] & (1 << 0))
+#define ata_id_has_dword_io(id)	((id)[48] & (1 << 0))
 #define ata_id_has_AN(id)	\
 	( (((id)[76] != 0x0000) && ((id)[76] != 0xffff)) && \
 	  ((id)[78] & (1 << 5)) )
@@ -374,6 +365,90 @@
 
 #define ata_id_cdb_intr(id)	(((id)[0] & 0x60) == 0x20)
 
+static inline int ata_id_has_fua(const u16 *id)
+{
+	if ((id[84] & 0xC000) != 0x4000)
+		return 0;
+	return id[84] & (1 << 6);
+}
+
+static inline int ata_id_has_flush(const u16 *id)
+{
+	if ((id[83] & 0xC000) != 0x4000)
+		return 0;
+	return id[83] & (1 << 12);
+}
+
+static inline int ata_id_has_flush_ext(const u16 *id)
+{
+	if ((id[83] & 0xC000) != 0x4000)
+		return 0;
+	return id[83] & (1 << 13);
+}
+
+static inline int ata_id_has_lba48(const u16 *id)
+{
+	if ((id[83] & 0xC000) != 0x4000)
+		return 0;
+	return id[83] & (1 << 10);
+}
+
+static inline int ata_id_hpa_enabled(const u16 *id)
+{
+	/* Yes children, word 83 valid bits cover word 82 data */
+	if ((id[83] & 0xC000) != 0x4000)
+		return 0;
+	/* And 87 covers 85-87 */
+	if ((id[87] & 0xC000) != 0x4000)
+		return 0;
+	/* Check command sets enabled as well as supported */
+	if ((id[85] & ( 1 << 10)) == 0)
+		return 0;
+	return id[82] & (1 << 10);
+}
+
+static inline int ata_id_has_wcache(const u16 *id)
+{
+	/* Yes children, word 83 valid bits cover word 82 data */
+	if ((id[83] & 0xC000) != 0x4000)
+		return 0;
+	return id[82] & (1 << 5);
+}
+
+static inline int ata_id_has_pm(const u16 *id)
+{
+	if ((id[83] & 0xC000) != 0x4000)
+		return 0;
+	return id[82] & (1 << 3);
+}
+
+static inline int ata_id_rahead_enabled(const u16 *id)
+{
+	if ((id[87] & 0xC000) != 0x4000)
+		return 0;
+	return id[85] & (1 << 6);
+}
+
+static inline int ata_id_wcache_enabled(const u16 *id)
+{
+	if ((id[87] & 0xC000) != 0x4000)
+		return 0;
+	return id[85] & (1 << 5);
+}
+
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
 static inline unsigned int ata_id_major_version(const u16 *id)
 {
 	unsigned int mver;
