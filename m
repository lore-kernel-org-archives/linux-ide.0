Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AF61C43217
	for <linux-ide@archiver.kernel.org>; Fri, 21 Oct 2022 05:38:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230026AbiJUFiR (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 21 Oct 2022 01:38:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230006AbiJUFiP (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 21 Oct 2022 01:38:15 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1677922C816
        for <linux-ide@vger.kernel.org>; Thu, 20 Oct 2022 22:38:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1666330694; x=1697866694;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=nYVgcYAmj5mPbQxRh/2yCmSRY6DlENEn+Zz4kfK8Kpk=;
  b=eEZ5fPszl9N0Mx6k7OMbK48FhehQhCMLJhgLH01E+oqJWtzf+1Hv8FuU
   N5UOzeNEVEpQ88FlpwN6TBwWRwfALvCXOthX1HMqP4iriywrvaMBpViji
   FwD99I6yygEFbBGFVgorwTsH6VbJ3/peqWN9vNvK2Y49bzBXj9g1GXWvC
   Kh5RAVLsYm/i2YpPCLpUI7/5CL3pGA/OEGEqg9LzCKlb72Pup0Ok1NYux
   conlX1hk4k/0AbYY/xKWienY6DYKAWs2IexVST5j5u5WNLUaAgBzM+F1k
   YvGAeZlq0KKhZNOMDB3Q7ARI1uy8qFOJwUtKuRA8DKRgXGhfCTybws5fV
   w==;
X-IronPort-AV: E=Sophos;i="5.95,200,1661788800"; 
   d="scan'208";a="326518273"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 21 Oct 2022 13:38:13 +0800
IronPort-SDR: crjgcvxLvRyfnyIDfaKBaM4ecY9CAesS/AXqUYlGN86x8w/Z2Gg4xyj+I80zh7sq083NHk8aBG
 1ZumooWcgZUxVoAuX/12tP8oz6hx2LYUNNko9f5ienVjAVYN/ACfskIAddEnjWW5krj3znzEfk
 2dNwHDtSPnGDi4DbIH7kg4T7Fj9mVsR+3E4Nka4spQmV5BxetV9MRHWeNnNTbYaAdV4frI6GIj
 E3BulVfl219/FV6siF6eQ4aJPMkFD89f1Zi8XTgHwT83smLGogqZlp2/YkzZMD0f/w3/UcvVRv
 KoZMmqLo0Gsv0akLa9tDd8Ry
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 20 Oct 2022 21:57:41 -0700
IronPort-SDR: nq/zyIG+h+PMRFkoyxIIb4TE6ap2ZRb+BbulV/zFsuPEGC9QBa6VOqHOdMWOB3DM9tEuaElap2
 Lil/tKLg8x/biZZ6he7MEyiLEvUiZw3NmW2oc8lE7MWotEaHJ0Gl+yIon9Y83nFmkYH38stzbm
 JV6GJag/paIsy8oUJHsjW6RCBtIwKvJ+sU6nHfD3LNgYF8By6KmGOFspeuTTZcqVsT9vfjKEFf
 BZRwc3Zarz7KoJrBF5NosvWdG2zjAejYvrwLCzydJh9iifKFItgZ+dOhCqcUQYMS6MJ8a0ys7s
 Snw=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 20 Oct 2022 22:38:13 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4MttY04zBcz1RvTr
        for <linux-ide@vger.kernel.org>; Thu, 20 Oct 2022 22:38:12 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:subject:to
        :from; s=dkim; t=1666330692; x=1668922693; bh=nYVgcYAmj5mPbQxRh/
        2yCmSRY6DlENEn+Zz4kfK8Kpk=; b=hOKcDqnvgf71GbD6Dpkr2ZrpkLGFAAtNBE
        rUUG2LNe9UmBFphQyijN4yOHxs0FiacmkvzXTvXpwU8tdUA4MlwfJxnHg1n3cHJn
        T1eO2TKN2pZxs4pl+o5S7LzbEJxcErbZs0EDxnPcC+jdpBrMlxkEw93Ir+CpeWoQ
        XTTwlrRHVyxo0qmyTEpkIf0tly4ma4RXg05BEzfRfT08nz/5+XQjf8Ld1RuAFCtQ
        hU9G8KLY99hdvJn/tP0cYYHt8sYOEmjc4PN6AVNUoW/Fzem1VoVoxgmtHQkNR2tS
        OfEefMeM7s3gXfb9mRuzqa6xYMT9uaRn3uJiuUxvmsB1UDMCmasA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id pSV-rPbNk2ix for <linux-ide@vger.kernel.org>;
        Thu, 20 Oct 2022 22:38:12 -0700 (PDT)
Received: from washi.fujisawa.hgst.com (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4MttXz42JGz1RvTp;
        Thu, 20 Oct 2022 22:38:11 -0700 (PDT)
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
To:     linux-ide@vger.kernel.org,
        "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>
Cc:     Hannes Reinecke <hare@suse.de>
Subject: [PATCH 1/3] ata: libata: cleanup fua handling
Date:   Fri, 21 Oct 2022 14:38:07 +0900
Message-Id: <20221021053809.237651-2-damien.lemoal@opensource.wdc.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221021053809.237651-1-damien.lemoal@opensource.wdc.com>
References: <20221021053809.237651-1-damien.lemoal@opensource.wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Move the detection of a device FUA support from
ata_scsiop_mode_sense()/ata_dev_supports_fua() to device scan time in
ata_dev_configure().

The function ata_dev_config_fua() is introduced to detect a device FUA
support and this support is indicated using the new device flag
ATA_DFLAG_FUA. In order to blacklist known buggy devices, the horkage
flag ATA_HORKAGE_NO_FUA is introduced. Similarly to other horkage flags,
the arguments fua and nofua are also introduced to allow a user to
control this horkage flag through the "force" libata module parameter.

The ATA_DFLAG_FUA device flag is set only and only if all the following
conditions are met:
* libata.fua module parameter is set to 1
* The device is not marked with the ATA_HORKAGE_NO_FUA flag, either from
  the blacklist or set by the user with libata.force=3Dnofua
* The device advertizes support for the WRITE DMA FUA EXT command,
* The device supports LBA48 and is not restricted to single block PIO

Note: Enabling or diabling libata fua support for all devices by default
can now by done using either the "fua" module parameter or the
"force=3D[port[.device]][no]fua" module parameter when libata.fua=3D=3D1.

Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
---
 .../admin-guide/kernel-parameters.txt         |  3 ++
 drivers/ata/libata-core.c                     | 29 +++++++++++++++++-
 drivers/ata/libata-scsi.c                     | 30 ++-----------------
 include/linux/libata.h                        |  8 +++--
 4 files changed, 38 insertions(+), 32 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentat=
ion/admin-guide/kernel-parameters.txt
index a465d5242774..f9724642c703 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -2786,6 +2786,9 @@
 			* [no]setxfer: Indicate if transfer speed mode setting
 			  should be skipped.
=20
+			* [no]fua: Disable or enable FUA (Force Unit Access)
+			  support for devices supporting this feature.
+
 			* dump_id: Dump IDENTIFY data.
=20
 			* disable: Disable this device.
diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 884ae73b11ea..6008f7ed1c42 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -2420,6 +2420,27 @@ static void ata_dev_config_chs(struct ata_device *=
dev)
 			     dev->heads, dev->sectors);
 }
=20
+static void ata_dev_config_fua(struct ata_device *dev)
+{
+	/* Ignore FUA support if its use is globally disabled */
+	if (!libata_fua)
+		goto nofua;
+
+	/* Ignore devices without support and known bad devices */
+	if (!ata_id_has_fua(dev->id) || (dev->horkage & ATA_HORKAGE_NO_FUA))
+		goto nofua;
+
+	/* Limit FUA support to LBA48 without PIO restriction */
+	if ((dev->flags & ATA_DFLAG_LBA48) &&
+	    (!(dev->flags & ATA_DFLAG_PIO) || dev->multi_count)) {
+		dev->flags |=3D ATA_DFLAG_FUA;
+		return;
+	}
+
+nofua:
+	dev->flags &=3D ~ATA_DFLAG_FUA;
+}
+
 static void ata_dev_config_devslp(struct ata_device *dev)
 {
 	u8 *sata_setting =3D dev->link->ap->sector_buf;
@@ -2508,7 +2529,8 @@ static void ata_dev_print_features(struct ata_devic=
e *dev)
 		return;
=20
 	ata_dev_info(dev,
-		     "Features:%s%s%s%s%s%s\n",
+		     "Features:%s%s%s%s%s%s%s\n",
+		     dev->flags & ATA_DFLAG_FUA ? " FUA" : "",
 		     dev->flags & ATA_DFLAG_TRUSTED ? " Trust" : "",
 		     dev->flags & ATA_DFLAG_DA ? " Dev-Attention" : "",
 		     dev->flags & ATA_DFLAG_DEVSLP ? " Dev-Sleep" : "",
@@ -2669,6 +2691,7 @@ int ata_dev_configure(struct ata_device *dev)
 			ata_dev_config_chs(dev);
 		}
=20
+		ata_dev_config_fua(dev);
 		ata_dev_config_devslp(dev);
 		ata_dev_config_sense_reporting(dev);
 		ata_dev_config_zac(dev);
@@ -4103,6 +4126,9 @@ static const struct ata_blacklist_entry ata_device_=
blacklist [] =3D {
 	 */
 	{ "SATADOM-ML 3ME",		NULL,	ATA_HORKAGE_NO_LOG_DIR },
=20
+	/* Buggy FUA */
+	{ "Maxtor",		"BANC1G10",	ATA_HORKAGE_NO_FUA },
+
 	/* End Marker */
 	{ }
 };
@@ -6214,6 +6240,7 @@ static const struct ata_force_param force_tbl[] __i=
nitconst =3D {
 	force_horkage_onoff(lpm,	ATA_HORKAGE_NOLPM),
 	force_horkage_onoff(setxfer,	ATA_HORKAGE_NOSETXFER),
 	force_horkage_on(dump_id,	ATA_HORKAGE_DUMP_ID),
+	force_horkage_onoff(fua,	ATA_HORKAGE_NO_FUA),
=20
 	force_horkage_on(disable,	ATA_HORKAGE_DISABLE),
 };
diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index 4cb914103382..69948e2a8f6d 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -2240,30 +2240,6 @@ static unsigned int ata_msense_rw_recovery(u8 *buf=
, bool changeable)
 	return sizeof(def_rw_recovery_mpage);
 }
=20
-/*
- * We can turn this into a real blacklist if it's needed, for now just
- * blacklist any Maxtor BANC1G10 revision firmware
- */
-static int ata_dev_supports_fua(u16 *id)
-{
-	unsigned char model[ATA_ID_PROD_LEN + 1], fw[ATA_ID_FW_REV_LEN + 1];
-
-	if (!libata_fua)
-		return 0;
-	if (!ata_id_has_fua(id))
-		return 0;
-
-	ata_id_c_string(id, model, ATA_ID_PROD, sizeof(model));
-	ata_id_c_string(id, fw, ATA_ID_FW_REV, sizeof(fw));
-
-	if (strcmp(model, "Maxtor"))
-		return 1;
-	if (strcmp(fw, "BANC1G10"))
-		return 1;
-
-	return 0; /* blacklisted */
-}
-
 /**
  *	ata_scsiop_mode_sense - Simulate MODE SENSE 6, 10 commands
  *	@args: device IDENTIFY data / SCSI command of interest.
@@ -2287,7 +2263,7 @@ static unsigned int ata_scsiop_mode_sense(struct at=
a_scsi_args *args, u8 *rbuf)
 	};
 	u8 pg, spg;
 	unsigned int ebd, page_control, six_byte;
-	u8 dpofua, bp =3D 0xff;
+	u8 dpofua =3D 0, bp =3D 0xff;
 	u16 fp;
=20
 	six_byte =3D (scsicmd[0] =3D=3D MODE_SENSE);
@@ -2350,9 +2326,7 @@ static unsigned int ata_scsiop_mode_sense(struct at=
a_scsi_args *args, u8 *rbuf)
 		goto invalid_fld;
 	}
=20
-	dpofua =3D 0;
-	if (ata_dev_supports_fua(args->id) && (dev->flags & ATA_DFLAG_LBA48) &&
-	    (!(dev->flags & ATA_DFLAG_PIO) || dev->multi_count))
+	if (dev->flags & ATA_DFLAG_FUA)
 		dpofua =3D 1 << 4;
=20
 	if (six_byte) {
diff --git a/include/linux/libata.h b/include/linux/libata.h
index af4953b95f76..81d863d751e1 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -91,6 +91,7 @@ enum {
 	ATA_DFLAG_AN		=3D (1 << 7), /* AN configured */
 	ATA_DFLAG_TRUSTED	=3D (1 << 8), /* device supports trusted send/recv */
 	ATA_DFLAG_DMADIR	=3D (1 << 10), /* device requires DMADIR */
+	ATA_DFLAG_FUA		=3D (1 << 11), /* device supports FUA */
 	ATA_DFLAG_CFG_MASK	=3D (1 << 12) - 1,
=20
 	ATA_DFLAG_PIO		=3D (1 << 12), /* device limited to PIO mode */
@@ -113,9 +114,9 @@ enum {
 	ATA_DFLAG_D_SENSE	=3D (1 << 29), /* Descriptor sense requested */
 	ATA_DFLAG_ZAC		=3D (1 << 30), /* ZAC device */
=20
-	ATA_DFLAG_FEATURES_MASK	=3D ATA_DFLAG_TRUSTED | ATA_DFLAG_DA | \
-				  ATA_DFLAG_DEVSLP | ATA_DFLAG_NCQ_SEND_RECV | \
-				  ATA_DFLAG_NCQ_PRIO,
+	ATA_DFLAG_FEATURES_MASK	=3D (ATA_DFLAG_TRUSTED | ATA_DFLAG_DA |	\
+				   ATA_DFLAG_DEVSLP | ATA_DFLAG_NCQ_SEND_RECV | \
+				   ATA_DFLAG_NCQ_PRIO | ATA_DFLAG_FUA),
=20
 	ATA_DEV_UNKNOWN		=3D 0,	/* unknown device */
 	ATA_DEV_ATA		=3D 1,	/* ATA device */
@@ -381,6 +382,7 @@ enum {
 	ATA_HORKAGE_NO_NCQ_ON_ATI =3D (1 << 27),	/* Disable NCQ on ATI chipset =
*/
 	ATA_HORKAGE_NO_ID_DEV_LOG =3D (1 << 28),	/* Identify device log missing=
 */
 	ATA_HORKAGE_NO_LOG_DIR	=3D (1 << 29),	/* Do not read log directory */
+	ATA_HORKAGE_NO_FUA	=3D (1 << 30),	/* Do not use FUA */
=20
 	 /* DMA mask for user DMA control: User visible values; DO NOT
 	    renumber */
--=20
2.37.3

