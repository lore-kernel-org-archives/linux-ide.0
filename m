Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A5F5C433EF
	for <linux-ide@archiver.kernel.org>; Tue, 21 Dec 2021 07:22:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229820AbhLUHWn (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 21 Dec 2021 02:22:43 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:55798 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230053AbhLUHWm (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 21 Dec 2021 02:22:42 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id A8F3D1F3B4;
        Tue, 21 Dec 2021 07:22:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1640071361; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NqiM7Ui8DpkDYcwwcVxSUlp4/b5zYbLgqNVqetoUke4=;
        b=lw8bh8ieF4gBN85GPg5LgE5ZIXSsFYrNjxoYAA02BzaHTn0uDGagClna3K7eKl05cQQSJB
        E7eBEuCmJ5q6fEWtkx/K83ye9VNc2EZIn0sQdxTLcf5R12OxWQwoXZKKdvSDjerQv5bmNx
        eNU3SaGJnxIOAACMZHaMwxBJr9nx2d0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1640071361;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NqiM7Ui8DpkDYcwwcVxSUlp4/b5zYbLgqNVqetoUke4=;
        b=5sokmq3Iy9QxtVeS83gHEPuQcye3j7Muu3+C7zMhaOiHTe5yBgL+vcuh2i4puVFezD6zn1
        i4+TKLy735tVInBQ==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
        by relay2.suse.de (Postfix) with ESMTP id A3D98A3B88;
        Tue, 21 Dec 2021 07:22:41 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
        id A2FEA519237A; Tue, 21 Dec 2021 08:22:41 +0100 (CET)
From:   Hannes Reinecke <hare@suse.de>
To:     Damien LeMoal <damien.lemoal@wdc.com>
Cc:     linux-ide@vger.kernel.org, Hannes Reinecke <hare@suse.de>
Subject: [PATCH 04/68] libata: move ata_dump_id() to dynamic debugging
Date:   Tue, 21 Dec 2021 08:20:27 +0100
Message-Id: <20211221072131.46673-5-hare@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20211221072131.46673-1-hare@suse.de>
References: <20211221072131.46673-1-hare@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Use ata_dev_dbg() to print out the information in ata_dump_id()
and remove the ata_msg_probe() conditional.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/ata/libata-core.c | 38 ++++++++++----------------------------
 1 file changed, 10 insertions(+), 28 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 296cca54017a..c9e8fab05a9a 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -1341,6 +1341,7 @@ static int ata_hpa_resize(struct ata_device *dev)
 
 /**
  *	ata_dump_id - IDENTIFY DEVICE info debugging output
+ *	@dev: device from which the information is fetched
  *	@id: IDENTIFY DEVICE page to dump
  *
  *	Dump selected 16-bit words from the given IDENTIFY DEVICE
@@ -1350,32 +1351,14 @@ static int ata_hpa_resize(struct ata_device *dev)
  *	caller.
  */
 
-static inline void ata_dump_id(const u16 *id)
-{
-	DPRINTK("49==0x%04x  "
-		"53==0x%04x  "
-		"63==0x%04x  "
-		"64==0x%04x  "
-		"75==0x%04x  \n",
-		id[49],
-		id[53],
-		id[63],
-		id[64],
-		id[75]);
-	DPRINTK("80==0x%04x  "
-		"81==0x%04x  "
-		"82==0x%04x  "
-		"83==0x%04x  "
-		"84==0x%04x  \n",
-		id[80],
-		id[81],
-		id[82],
-		id[83],
-		id[84]);
-	DPRINTK("88==0x%04x  "
-		"93==0x%04x\n",
-		id[88],
-		id[93]);
+static inline void ata_dump_id(struct ata_device *dev, const u16 *id)
+{
+	ata_dev_dbg(dev,
+		"49==0x%04x  53==0x%04x  63==0x%04x  64==0x%04x  75==0x%04x\n"
+		"80==0x%04x  81==0x%04x  82==0x%04x  83==0x%04x  84==0x%04x\n"
+		"88==0x%04x  93==0x%04x\n",
+		id[49], id[53], id[63], id[64], id[75], id[80],
+		id[81], id[82], id[83], id[84], id[88], id[93]);
 }
 
 /**
@@ -2632,8 +2615,7 @@ int ata_dev_configure(struct ata_device *dev)
 	/* find max transfer mode; for printk only */
 	xfer_mask = ata_id_xfermask(id);
 
-	if (ata_msg_probe(ap))
-		ata_dump_id(id);
+	ata_dump_id(dev, id);
 
 	/* SCSI only uses 4-char revisions, dump full 8 chars from ATA */
 	ata_id_c_string(dev->id, fwrevbuf, ATA_ID_FW_REV,
-- 
2.29.2

