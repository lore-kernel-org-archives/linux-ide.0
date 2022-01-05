Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AA1AC43217
	for <linux-ide@archiver.kernel.org>; Wed,  5 Jan 2022 05:18:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237444AbiAEFR7 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 5 Jan 2022 00:17:59 -0500
Received: from rap-us.hgst.com ([199.255.44.250]:12339 "EHLO
        usg-ed-osssrv.wdc.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S237445AbiAEFR5 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 5 Jan 2022 00:17:57 -0500
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4JTHn03mJpz1VSkV
        for <linux-ide@vger.kernel.org>; Tue,  4 Jan 2022 21:17:56 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:subject:to
        :from; s=dkim; t=1641359876; x=1643951877; bh=b9u/WF13LDaffl7XOx
        YZYQKkgek7FFxIUjf0shI8+d4=; b=cgcH0d76bnGKttyqdRDqIkBpyavfQEV0ju
        dAht0p2T9D8cK/zWq70nl4H0FUg33Wy7Y89kan9T0WRWIOk6xrVMALE7xT0cBED2
        qJEkP4DfKsUihcp5PdKAJu4SDp4NlFtxkAvDzGmPX2bsbboKjd2Sogu4Kw79gWA/
        PsK97DBU1YTB72Eg6wlgXK+aVd/LckCL0OriCZ4SDpbL0lZA8x9ZVQkINyaiPld5
        Qks92Wui8ho2gJpftTQp0ygJyGYD/5+HE29LJyMutak1Ppycpx2OZaaejW8/kzXA
        siRJ7BmzmWC9nUdhPFFZIGGaUyEds+wNrVelAEEhuwvyPNkeZ/fA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id q-tj2TVhI-jN for <linux-ide@vger.kernel.org>;
        Tue,  4 Jan 2022 21:17:56 -0800 (PST)
Received: from washi.fujisawa.hgst.com (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4JTHmz4kSjz1VSkc;
        Tue,  4 Jan 2022 21:17:55 -0800 (PST)
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
To:     linux-ide@vger.kernel.org
Cc:     Hannes Reinecke <hare@suse.de>
Subject: [PATCH v3 22/22] ata: fix read_id() ata port operation interface
Date:   Wed,  5 Jan 2022 14:17:35 +0900
Message-Id: <20220105051735.1871177-23-damien.lemoal@opensource.wdc.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220105051735.1871177-1-damien.lemoal@opensource.wdc.com>
References: <20220105051735.1871177-1-damien.lemoal@opensource.wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Drivers that need to tweak a device IDENTIFY data implement the
read_id() port operation. The IDENTIFY data buffer is passed as an
argument to the read_id() operation for drivers to use. However, when
this operation is called, the IDENTIFY data is not yet converted to CPU
endian and contains le16 words.

Change the interface of the read_id operation to pass a __le16 * pointer
to the IDENTIFY data buffer to clarify the buffer endianness. Fix the
pata_netcell, pata_it821x, ahci_xgene, ahci_ceva and ahci_brcm drivers
implementation of this operation and modify the code to corretly deal
with identify data words manipulation to avoid sparse warnings such as:

drivers/ata/ahci_xgene.c:262:33: warning: invalid assignment: &=3D
drivers/ata/ahci_xgene.c:262:33:    left side has type unsigned short
drivers/ata/ahci_xgene.c:262:33:    right side has type restricted __le16

Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
---
 drivers/ata/ahci_brcm.c    |  2 +-
 drivers/ata/ahci_ceva.c    |  5 ++---
 drivers/ata/ahci_xgene.c   |  2 +-
 drivers/ata/libata-core.c  |  6 +++---
 drivers/ata/pata_it821x.c  | 23 +++++++++++------------
 drivers/ata/pata_netcell.c |  5 +++--
 include/linux/libata.h     |  5 +++--
 7 files changed, 24 insertions(+), 24 deletions(-)

diff --git a/drivers/ata/ahci_brcm.c b/drivers/ata/ahci_brcm.c
index 6e9c5ade4c2e..ba695338927a 100644
--- a/drivers/ata/ahci_brcm.c
+++ b/drivers/ata/ahci_brcm.c
@@ -246,7 +246,7 @@ static void brcm_sata_init(struct brcm_ahci_priv *pri=
v)
 }
=20
 static unsigned int brcm_ahci_read_id(struct ata_device *dev,
-				      struct ata_taskfile *tf, u16 *id)
+				      struct ata_taskfile *tf, __le16 *id)
 {
 	struct ata_port *ap =3D dev->link->ap;
 	struct ata_host *host =3D ap->host;
diff --git a/drivers/ata/ahci_ceva.c b/drivers/ata/ahci_ceva.c
index e9c7c07fd84c..acf59f51b356 100644
--- a/drivers/ata/ahci_ceva.c
+++ b/drivers/ata/ahci_ceva.c
@@ -92,9 +92,8 @@ struct ceva_ahci_priv {
 };
=20
 static unsigned int ceva_ahci_read_id(struct ata_device *dev,
-					struct ata_taskfile *tf, u16 *id)
+				      struct ata_taskfile *tf, __le16 *id)
 {
-	__le16 *__id =3D (__le16 *)id;
 	u32 err_mask;
=20
 	err_mask =3D ata_do_dev_read_id(dev, tf, id);
@@ -104,7 +103,7 @@ static unsigned int ceva_ahci_read_id(struct ata_devi=
ce *dev,
 	 * Since CEVA controller does not support device sleep feature, we
 	 * need to clear DEVSLP (bit 8) in word78 of the IDENTIFY DEVICE data.
 	 */
-	__id[ATA_ID_FEATURE_SUPP] &=3D cpu_to_le16(~(1 << 8));
+	id[ATA_ID_FEATURE_SUPP] &=3D cpu_to_le16(~(1 << 8));
=20
 	return 0;
 }
diff --git a/drivers/ata/ahci_xgene.c b/drivers/ata/ahci_xgene.c
index 68ec7e9430b2..8e206379d699 100644
--- a/drivers/ata/ahci_xgene.c
+++ b/drivers/ata/ahci_xgene.c
@@ -237,7 +237,7 @@ static bool xgene_ahci_is_memram_inited(struct xgene_=
ahci_context *ctx)
  * does not support DEVSLP.
  */
 static unsigned int xgene_ahci_read_id(struct ata_device *dev,
-				       struct ata_taskfile *tf, u16 *id)
+				       struct ata_taskfile *tf, __le16 *id)
 {
 	u32 err_mask;
=20
diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 9c2947905d1e..67f88027680a 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -1722,7 +1722,7 @@ static u32 ata_pio_mask_no_iordy(const struct ata_d=
evice *adev)
  *	this function is wrapped or replaced by the driver
  */
 unsigned int ata_do_dev_read_id(struct ata_device *dev,
-					struct ata_taskfile *tf, u16 *id)
+				struct ata_taskfile *tf, __le16 *id)
 {
 	return ata_exec_internal(dev, tf, NULL, DMA_FROM_DEVICE,
 				     id, sizeof(id[0]) * ATA_ID_WORDS, 0);
@@ -1795,9 +1795,9 @@ int ata_dev_read_id(struct ata_device *dev, unsigne=
d int *p_class,
 	tf.flags |=3D ATA_TFLAG_POLLING;
=20
 	if (ap->ops->read_id)
-		err_mask =3D ap->ops->read_id(dev, &tf, id);
+		err_mask =3D ap->ops->read_id(dev, &tf, (__le16 *)id);
 	else
-		err_mask =3D ata_do_dev_read_id(dev, &tf, id);
+		err_mask =3D ata_do_dev_read_id(dev, &tf, (__le16 *)id);
=20
 	if (err_mask) {
 		if (err_mask & AC_ERR_NODEV_HINT) {
diff --git a/drivers/ata/pata_it821x.c b/drivers/ata/pata_it821x.c
index b77ef0046dbe..8a5b4e0079ab 100644
--- a/drivers/ata/pata_it821x.c
+++ b/drivers/ata/pata_it821x.c
@@ -537,7 +537,7 @@ static void it821x_dev_config(struct ata_device *adev=
)
  */
=20
 static unsigned int it821x_read_id(struct ata_device *adev,
-					struct ata_taskfile *tf, u16 *id)
+				   struct ata_taskfile *tf, __le16 *id)
 {
 	unsigned int err_mask;
 	unsigned char model_num[ATA_ID_PROD_LEN + 1];
@@ -545,21 +545,20 @@ static unsigned int it821x_read_id(struct ata_devic=
e *adev,
 	err_mask =3D ata_do_dev_read_id(adev, tf, id);
 	if (err_mask)
 		return err_mask;
-	ata_id_c_string(id, model_num, ATA_ID_PROD, sizeof(model_num));
+	ata_id_c_string((u16 *)id, model_num, ATA_ID_PROD, sizeof(model_num));
=20
-	id[83] &=3D ~(1 << 12);	/* Cache flush is firmware handled */
-	id[83] &=3D ~(1 << 13);	/* Ditto for LBA48 flushes */
-	id[84] &=3D ~(1 << 6);	/* No FUA */
-	id[85] &=3D ~(1 << 10);	/* No HPA */
-	id[76] =3D 0;		/* No NCQ/AN etc */
+	id[83] &=3D cpu_to_le16(~(1 << 12)); /* Cache flush is firmware handled=
 */
+	id[84] &=3D cpu_to_le16(~(1 << 6));  /* No FUA */
+	id[85] &=3D cpu_to_le16(~(1 << 10)); /* No HPA */
+	id[76] =3D 0;			   /* No NCQ/AN etc */
=20
 	if (strstr(model_num, "Integrated Technology Express")) {
 		/* Set feature bits the firmware neglects */
-		id[49] |=3D 0x0300;	/* LBA, DMA */
-		id[83] &=3D 0x7FFF;
-		id[83] |=3D 0x4400;	/* Word 83 is valid and LBA48 */
-		id[86] |=3D 0x0400;	/* LBA48 on */
-		id[ATA_ID_MAJOR_VER] |=3D 0x1F;
+		id[49] |=3D cpu_to_le16(0x0300);	/* LBA, DMA */
+		id[83] &=3D cpu_to_le16(0x7FFF);
+		id[83] |=3D cpu_to_le16(0x4400);	/* Word 83 is valid and LBA48 */
+		id[86] |=3D cpu_to_le16(0x0400);	/* LBA48 on */
+		id[ATA_ID_MAJOR_VER] |=3D cpu_to_le16(0x1F);
 		/* Clear the serial number because it's different each boot
 		   which breaks validation on resume */
 		memset(&id[ATA_ID_SERNO], 0x20, ATA_ID_SERNO_LEN);
diff --git a/drivers/ata/pata_netcell.c b/drivers/ata/pata_netcell.c
index a7ecc1a204b5..06929e77c491 100644
--- a/drivers/ata/pata_netcell.c
+++ b/drivers/ata/pata_netcell.c
@@ -21,12 +21,13 @@
 /* No PIO or DMA methods needed for this device */
=20
 static unsigned int netcell_read_id(struct ata_device *adev,
-					struct ata_taskfile *tf, u16 *id)
+				    struct ata_taskfile *tf, __le16 *id)
 {
 	unsigned int err_mask =3D ata_do_dev_read_id(adev, tf, id);
+
 	/* Firmware forgets to mark words 85-87 valid */
 	if (err_mask =3D=3D 0)
-		id[ATA_ID_CSF_DEFAULT] |=3D 0x4000;
+		id[ATA_ID_CSF_DEFAULT] |=3D cpu_to_le16(0x4000);
 	return err_mask;
 }
=20
diff --git a/include/linux/libata.h b/include/linux/libata.h
index cafe360ab3cd..27b693d87e4b 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -884,7 +884,8 @@ struct ata_port_operations {
 	void (*set_piomode)(struct ata_port *ap, struct ata_device *dev);
 	void (*set_dmamode)(struct ata_port *ap, struct ata_device *dev);
 	int  (*set_mode)(struct ata_link *link, struct ata_device **r_failed_de=
v);
-	unsigned int (*read_id)(struct ata_device *dev, struct ata_taskfile *tf=
, u16 *id);
+	unsigned int (*read_id)(struct ata_device *dev, struct ata_taskfile *tf=
,
+				__le16 *id);
=20
 	void (*dev_config)(struct ata_device *dev);
=20
@@ -1119,7 +1120,7 @@ extern void ata_id_string(const u16 *id, unsigned c=
har *s,
 extern void ata_id_c_string(const u16 *id, unsigned char *s,
 			    unsigned int ofs, unsigned int len);
 extern unsigned int ata_do_dev_read_id(struct ata_device *dev,
-					struct ata_taskfile *tf, u16 *id);
+				       struct ata_taskfile *tf, __le16 *id);
 extern void ata_qc_complete(struct ata_queued_cmd *qc);
 extern u64 ata_qc_get_active(struct ata_port *ap);
 extern void ata_scsi_simulate(struct ata_device *dev, struct scsi_cmnd *=
cmd);
--=20
2.31.1

