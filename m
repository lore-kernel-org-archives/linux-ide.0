From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 03/12] libata: add more SATA specific constants and macros to ata.h
Date: Mon, 17 Jul 2006 15:52:31 +0900
Message-ID: <11531191512408-git-send-email-htejun@gmail.com>
References: <11531191512028-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0102.google.com ([64.233.162.202]:36985 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751302AbWGQGvN (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 17 Jul 2006 02:51:13 -0400
Received: by nz-out-0102.google.com with SMTP id x7so398401nzc
        for <linux-ide@vger.kernel.org>; Sun, 16 Jul 2006 23:51:12 -0700 (PDT)
In-Reply-To: <11531191512028-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, lkml@rtr.ca, axboe@suse.de, forrest.zhao@intel.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Add more SATA specific constants and macros to ata.h.

* SATA SETFEATURES constants
* SControl field selectors and extracting macros
* link powersave feature test macros

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 include/linux/ata.h |   21 +++++++++++++++++++++
 1 files changed, 21 insertions(+), 0 deletions(-)

cc62d2cee0b3edb867a7cfde35b8383c37900e65
diff --git a/include/linux/ata.h b/include/linux/ata.h
index a7798c3..089a2df 100644
--- a/include/linux/ata.h
+++ b/include/linux/ata.h
@@ -184,6 +184,12 @@ enum {
 	SETFEATURES_WC_ON	= 0x02, /* Enable write cache */
 	SETFEATURES_WC_OFF	= 0x82, /* Disable write cache */
 
+	SETFEATURES_SATA_ON	= 0x10, /* Enable SATA feature */
+	SETFEATURES_SATA_OFF	= 0x90, /* Disable SATA feature */
+
+	/* SATA feature nsect values */
+	SETFEATURES_SATA_DIPS	= 0x03,
+
 	/* ATAPI stuff */
 	ATAPI_PKT_DMA		= (1 << 0),
 	ATAPI_DMADIR		= (1 << 2),	/* ATAPI data dir:
@@ -204,6 +210,13 @@ enum {
 	SCR_ACTIVE		= 3,
 	SCR_NOTIFICATION	= 4,
 
+	/* SControl subfields, each field is 4 bit wide */
+	ATA_SCTL_DET		= 0, /* lsb */
+	ATA_SCTL_SPD		= 1,
+	ATA_SCTL_IPM		= 2,
+	ATA_SCTL_SPM		= 3,
+	ATA_SCTL_PMP		= 4,
+
 	/* SError bits */
 	SERR_DATA_RECOVERED	= (1 << 0), /* recovered data error */
 	SERR_COMM_RECOVERED	= (1 << 1), /* recovered comm failure */
@@ -289,6 +302,9 @@ #define ata_id_has_dma(id)	((id)[49] & (
 #define ata_id_has_sata(id)	((id)[76] && (id)[76] != 0xffff)
 #define ata_id_has_ncq(id)	(ata_id_has_sata(id) && ((id)[76] & (1 << 8)))
 #define ata_id_queue_depth(id)	(((id)[75] & 0x1f) + 1)
+#define ata_id_has_hips(id)	(ata_id_has_sata(id) && ((id)[76] & (1 << 9)))
+#define ata_id_has_dips(id)	(ata_id_has_sata(id) && ((id)[78] & (1 << 3)))
+#define ata_id_dips_enabled(id)	(ata_id_has_sata(id) && ((id)[79] & (1 << 3)))
 #define ata_id_removeable(id)	((id)[0] & (1 << 7))
 #define ata_id_has_dword_io(id)	((id)[50] & (1 << 0))
 #define ata_id_u32(id,n)	\
@@ -367,4 +383,9 @@ static inline int lba_48_ok(u64 block, u
 	return ((block + n_block - 1) < ((u64)1 << 48)) && (n_block <= 65536);
 }
 
+static inline u8 ata_scontrol_field(u32 scontrol, int sel)
+{
+	return (scontrol >> (sel * 4)) & 0xf;
+}
+
 #endif /* __LINUX_ATA_H__ */
-- 
1.3.2


