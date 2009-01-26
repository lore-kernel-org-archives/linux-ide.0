From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] ide/libata: fix ata_id_is_cfa()
Date: Mon, 26 Jan 2009 19:08:01 +0000
Message-ID: <20090126190801.7d198246@lxorguk.ukuu.org.uk>
References: <200901231615.38011.sshtylyov@ru.mvista.com>
	<497B9EE4.8010807@ru.mvista.com>
	<497E0548.80904@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:43310 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751464AbZAZTNN (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 26 Jan 2009 14:13:13 -0500
In-Reply-To: <497E0548.80904@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: bzolnier@gmail.com, jgarzik@pobox.com, linux-ide@vger.kernel.org, gdu@mns.spb.ru

This is what I would favour:

libata: Fix CFA detection & improve version inlines

From: Alan Cox <alan@redhat.com>

Sergei Shtylyov noticed thae ata_id_is_cfa checked the wrong word for the
secondary CFA test and posted a patch set to improve this, but which
removed the version checks.

This patch keeps the version checks but incorporates the other suggestions
Sergei made including a better ata version check for the usual case where
we want to know "is version >= x" rather than "what version do you
support".

Signed-off-by: Alan Cox <alan@lxorguk.ukuu.org.uk>
---

 drivers/ata/libata-core.c |    2 +-
 include/linux/ata.h       |   22 +++++++++++++++-------
 2 files changed, 16 insertions(+), 8 deletions(-)


diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 88c2428..c17b62a 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -2212,7 +2212,7 @@ retry:
 		 * Note that ATA4 says lba is mandatory so the second check
 		 * shoud never trigger.
 		 */
-		if (ata_id_major_version(id) < 4 || !ata_id_has_lba(id)) {
+		if (!ata_id_has_version(id, 4) || !ata_id_has_lba(id)) {
 			err_mask = ata_dev_init_params(dev, id[3], id[6]);
 			if (err_mask) {
 				rc = -EIO;
diff --git a/include/linux/ata.h b/include/linux/ata.h
index a53318b..e35d8de 100644
--- a/include/linux/ata.h
+++ b/include/linux/ata.h
@@ -675,6 +675,13 @@ static inline unsigned int ata_id_major_version(const u16 *id)
 	return mver;
 }
 
+static inline int ata_id_has_version(const u16 *id, int v)
+{
+	if (id[ATA_ID_MAJOR_VER] == 0xFFFF)
+		return 0;
+	return (id[ATA_ID_MAJOR_VER] & (1 << v)) ? 1 : 0;
+}
+ 
 static inline int ata_id_is_sata(const u16 *id)
 {
 	/*
@@ -691,7 +698,7 @@ static inline int ata_id_is_sata(const u16 *id)
 static inline int ata_id_has_tpm(const u16 *id)
 {
 	/* The TPM bits are only valid on ATA8 */
-	if (ata_id_major_version(id) < 8)
+	if (!ata_id_has_version(id, 8))
 		return 0;
 	if ((id[48] & 0xC000) != 0x4000)
 		return 0;
@@ -701,7 +708,7 @@ static inline int ata_id_has_tpm(const u16 *id)
 static inline int ata_id_has_dword_io(const u16 *id)
 {
 	/* ATA 8 reuses this flag for "trusted" computing */
-	if (ata_id_major_version(id) > 7)
+	if (ata_id_has_version(id, 8))
 		return 0;
 	if (id[ATA_ID_DWORD_IO] & (1 << 0))
 		return 1;
@@ -710,7 +717,7 @@ static inline int ata_id_has_dword_io(const u16 *id)
 
 static inline int ata_id_has_unload(const u16 *id)
 {
-	if (ata_id_major_version(id) >= 7 &&
+	if (ata_id_has_version(id, 7) &&
 	    (id[ATA_ID_CFSSE] & 0xC000) == 0x4000 &&
 	    id[ATA_ID_CFSSE] & (1 << 13))
 		return 1;
@@ -734,15 +741,16 @@ static inline int ata_id_is_cfa(const u16 *id)
 	if (id[ATA_ID_CONFIG] == 0x848A)	/* Standard CF */
 		return 1;
 	/* Could be CF hiding as standard ATA */
-	if (ata_id_major_version(id) >= 3 &&
-	    id[ATA_ID_COMMAND_SET_1] != 0xFFFF &&
-	   (id[ATA_ID_COMMAND_SET_1] & (1 << 2)))
+	if (ata_id_has_version(id, 3) &&
+	   (id[ATA_ID_COMMAND_SET_2] & 0xC000) == 0x4000 &&
+	   (id[ATA_ID_COMMAND_SET_2] & (1 << 2)))
 		return 1;
 	return 0;
 }
 
 static inline int ata_id_is_ssd(const u16 *id)
 {
+	/* FIXME: Check validity of version */
 	return id[ATA_ID_ROT_SPEED] == 0x01;
 }
 
@@ -779,7 +787,7 @@ static inline int atapi_command_packet_set(const u16 *dev_id)
 
 static inline int atapi_id_dmadir(const u16 *dev_id)
 {
-	return ata_id_major_version(dev_id) >= 7 && (dev_id[62] & 0x8000);
+	return ata_id_has_version(dev_id, 7) && (dev_id[62] & 0x8000);
 }
 
 /*
