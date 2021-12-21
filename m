Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C05BBC433FE
	for <linux-ide@archiver.kernel.org>; Tue, 21 Dec 2021 07:22:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229930AbhLUHWo (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 21 Dec 2021 02:22:44 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:52518 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229999AbhLUHWm (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 21 Dec 2021 02:22:42 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id A8D82212C9;
        Tue, 21 Dec 2021 07:22:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1640071361; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XcjHejZAE7fXi8NzOVh0N6ru0hk2D5eszke4DtP+dZM=;
        b=YyfyWzf1eBBJNuWTYGPp3wZTbgIbOpU3Aw+IBd+Lj2Ihju7jijL2GdV725rE4qckOmhxGC
        7YYQUnz6prDTh4GTLnh2gaftpSW+b0fqRVAfgReCkGChvzumw3CCGVBSfGg+VuwcR5tXqd
        UBBD28f9uUS63h8S6cIxVclwEq92mwE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1640071361;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XcjHejZAE7fXi8NzOVh0N6ru0hk2D5eszke4DtP+dZM=;
        b=WSsPu7cjfGMzpAUCtPQ9R3DqoMVljK/vyW16wrpYfEellNWh2GvR7F/3gMIVn+N6ajwe5h
        +1W2cMQm6pM3XVCA==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
        by relay2.suse.de (Postfix) with ESMTP id A2C39A3B87;
        Tue, 21 Dec 2021 07:22:41 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
        id 9E7D45192378; Tue, 21 Dec 2021 08:22:41 +0100 (CET)
From:   Hannes Reinecke <hare@suse.de>
To:     Damien LeMoal <damien.lemoal@wdc.com>
Cc:     linux-ide@vger.kernel.org, Hannes Reinecke <hare@suse.de>
Subject: [PATCH 03/68] libata: Add ata_port_classify() helper
Date:   Tue, 21 Dec 2021 08:20:26 +0100
Message-Id: <20211221072131.46673-4-hare@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20211221072131.46673-1-hare@suse.de>
References: <20211221072131.46673-1-hare@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Add an ata_port_classify() helper to print out the results from
the device classification and remove the debugging statements
from ata_dev_classify().

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/ata/libahci.c          |  2 +-
 drivers/ata/libata-core.c      | 21 +++++----------------
 drivers/ata/libata-sff.c       |  2 +-
 drivers/ata/libata-transport.c | 27 +++++++++++++++++++++++++++
 drivers/ata/sata_fsl.c         |  2 +-
 drivers/ata/sata_inic162x.c    |  2 +-
 drivers/ata/sata_sil24.c       |  2 +-
 include/linux/libata.h         |  2 ++
 8 files changed, 39 insertions(+), 21 deletions(-)

diff --git a/drivers/ata/libahci.c b/drivers/ata/libahci.c
index 94edbc89a48c..b7b460560a92 100644
--- a/drivers/ata/libahci.c
+++ b/drivers/ata/libahci.c
@@ -1300,7 +1300,7 @@ unsigned int ahci_dev_classify(struct ata_port *ap)
 	tf.lbal		= (tmp >> 8)	& 0xff;
 	tf.nsect	= (tmp)		& 0xff;
 
-	return ata_dev_classify(&tf);
+	return ata_port_classify(ap, &tf);
 }
 EXPORT_SYMBOL_GPL(ahci_dev_classify);
 
diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 72f56c32fe83..296cca54017a 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -1007,32 +1007,21 @@ unsigned int ata_dev_classify(const struct ata_taskfile *tf)
 	 * SEMB signature.  This is worked around in
 	 * ata_dev_read_id().
 	 */
-	if ((tf->lbam == 0) && (tf->lbah == 0)) {
-		DPRINTK("found ATA device by sig\n");
+	if ((tf->lbam == 0) && (tf->lbah == 0))
 		return ATA_DEV_ATA;
-	}
 
-	if ((tf->lbam == 0x14) && (tf->lbah == 0xeb)) {
-		DPRINTK("found ATAPI device by sig\n");
+	if ((tf->lbam == 0x14) && (tf->lbah == 0xeb))
 		return ATA_DEV_ATAPI;
-	}
 
-	if ((tf->lbam == 0x69) && (tf->lbah == 0x96)) {
-		DPRINTK("found PMP device by sig\n");
+	if ((tf->lbam == 0x69) && (tf->lbah == 0x96))
 		return ATA_DEV_PMP;
-	}
 
-	if ((tf->lbam == 0x3c) && (tf->lbah == 0xc3)) {
-		DPRINTK("found SEMB device by sig (could be ATA device)\n");
+	if ((tf->lbam == 0x3c) && (tf->lbah == 0xc3))
 		return ATA_DEV_SEMB;
-	}
 
-	if ((tf->lbam == 0xcd) && (tf->lbah == 0xab)) {
-		DPRINTK("found ZAC device by sig\n");
+	if ((tf->lbam == 0xcd) && (tf->lbah == 0xab))
 		return ATA_DEV_ZAC;
-	}
 
-	DPRINTK("unknown device\n");
 	return ATA_DEV_UNKNOWN;
 }
 EXPORT_SYMBOL_GPL(ata_dev_classify);
diff --git a/drivers/ata/libata-sff.c b/drivers/ata/libata-sff.c
index 39c026f3948c..a119fabe0919 100644
--- a/drivers/ata/libata-sff.c
+++ b/drivers/ata/libata-sff.c
@@ -1853,7 +1853,7 @@ unsigned int ata_sff_dev_classify(struct ata_device *dev, int present,
 		return ATA_DEV_NONE;
 
 	/* determine if device is ATA or ATAPI */
-	class = ata_dev_classify(&tf);
+	class = ata_port_classify(ap, &tf);
 
 	if (class == ATA_DEV_UNKNOWN) {
 		/* If the device failed diagnostic, it's likely to
diff --git a/drivers/ata/libata-transport.c b/drivers/ata/libata-transport.c
index 4162d625fc92..8f44ad772a0e 100644
--- a/drivers/ata/libata-transport.c
+++ b/drivers/ata/libata-transport.c
@@ -321,6 +321,33 @@ int ata_tport_add(struct device *parent,
 	return error;
 }
 
+/**
+ *     ata_port_classify - determine device type based on ATA-spec signature
+ *     @ap: ATA port device on which the classification should be run
+ *     @tf: ATA taskfile register set for device to be identified
+ *
+ *     A wrapper around ata_dev_classify() to provide additional logging
+ *
+ *     RETURNS:
+ *     Device type, %ATA_DEV_ATA, %ATA_DEV_ATAPI, %ATA_DEV_PMP,
+ *     %ATA_DEV_ZAC, or %ATA_DEV_UNKNOWN the event of failure.
+ */
+unsigned int ata_port_classify(struct ata_port *ap,
+			       const struct ata_taskfile *tf)
+{
+	int i;
+	unsigned int class = ata_dev_classify(tf);
+
+	/* Start with index '1' to skip the 'unknown' entry */
+	for (i = 1; i < ARRAY_SIZE(ata_class_names); i++) {
+		if (ata_class_names[i].value == class)
+			ata_port_dbg(ap, "found %s device by sig\n",
+				     ata_class_names[i].name);
+	}
+	ata_port_info(ap, "found unknown device (class %u)\n", class);
+	return class;
+}
+EXPORT_SYMBOL_GPL(ata_port_classify);
 
 /*
  * ATA link attributes
diff --git a/drivers/ata/sata_fsl.c b/drivers/ata/sata_fsl.c
index ec52511ae60f..7504d9fbff2a 100644
--- a/drivers/ata/sata_fsl.c
+++ b/drivers/ata/sata_fsl.c
@@ -814,7 +814,7 @@ static unsigned int sata_fsl_dev_classify(struct ata_port *ap)
 	tf.lbal = (temp >> 8) & 0xff;
 	tf.nsect = temp & 0xff;
 
-	return ata_dev_classify(&tf);
+	return ata_port_classify(ap, &tf);
 }
 
 static int sata_fsl_hardreset(struct ata_link *link, unsigned int *class,
diff --git a/drivers/ata/sata_inic162x.c b/drivers/ata/sata_inic162x.c
index e517bd8822a5..b6239dae524a 100644
--- a/drivers/ata/sata_inic162x.c
+++ b/drivers/ata/sata_inic162x.c
@@ -657,7 +657,7 @@ static int inic_hardreset(struct ata_link *link, unsigned int *class,
 		}
 
 		inic_tf_read(ap, &tf);
-		*class = ata_dev_classify(&tf);
+		*class = ata_port_classify(ap, &tf);
 	}
 
 	return 0;
diff --git a/drivers/ata/sata_sil24.c b/drivers/ata/sata_sil24.c
index f99ec6f7d7c0..7e9c1945dc81 100644
--- a/drivers/ata/sata_sil24.c
+++ b/drivers/ata/sata_sil24.c
@@ -680,7 +680,7 @@ static int sil24_softreset(struct ata_link *link, unsigned int *class,
 	}
 
 	sil24_read_tf(ap, 0, &tf);
-	*class = ata_dev_classify(&tf);
+	*class = ata_port_classify(ap, &tf);
 
 	DPRINTK("EXIT, class=%u\n", *class);
 	return 0;
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 2a8404b26083..235fdbeb19ea 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -1160,6 +1160,8 @@ extern enum ata_completion_errors ata_noop_qc_prep(struct ata_queued_cmd *qc);
 extern void ata_sg_init(struct ata_queued_cmd *qc, struct scatterlist *sg,
 		 unsigned int n_elem);
 extern unsigned int ata_dev_classify(const struct ata_taskfile *tf);
+extern unsigned int ata_port_classify(struct ata_port *ap,
+				      const struct ata_taskfile *tf);
 extern void ata_dev_disable(struct ata_device *adev);
 extern void ata_id_string(const u16 *id, unsigned char *s,
 			  unsigned int ofs, unsigned int len);
-- 
2.29.2

