Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D1E5C433EF
	for <linux-ide@archiver.kernel.org>; Fri, 10 Dec 2021 07:29:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237514AbhLJHc4 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 10 Dec 2021 02:32:56 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:46982 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237512AbhLJHcx (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 10 Dec 2021 02:32:53 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 960241F387;
        Fri, 10 Dec 2021 07:29:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1639121358; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=L8Jq8ooCprSc4sLAv3D+zc1vRLI14PVVrHU7jIQqRIU=;
        b=iM8pnjOjqlNSI2dndEBp94eTOvBueYpqItRBkJvG57IXoRzArdLIqzExDHvZliaEkwgjPg
        bvfJfWW+NLJ0WB9obnluB7lf+j9XxWYbOUVWnGCzXb8XigcWxvMnwoWkiV/vATPARda84x
        h96dDg3VsYAciA1Z1rK6BH+vtSnyjvQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1639121358;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=L8Jq8ooCprSc4sLAv3D+zc1vRLI14PVVrHU7jIQqRIU=;
        b=MKirVfAot7QPe4aW4SnNvDXqoeKeG6OVj2I1A4yI4TTJ7Ct1F24HSY6O3n4nDwouU9QhNP
        qrnF7jADO2d5ezCQ==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
        by relay2.suse.de (Postfix) with ESMTP id 7C7AEA3B9A;
        Fri, 10 Dec 2021 07:29:18 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
        id 692895192029; Fri, 10 Dec 2021 08:29:18 +0100 (CET)
From:   Hannes Reinecke <hare@suse.de>
To:     Damien LeMoal <damien.lemoal@wdc.com>
Cc:     linux-ide@vger.kernel.org, Hannes Reinecke <hare@suse.de>
Subject: [PATCH 04/68] libata: move ata_dump_id() to dynamic debugging
Date:   Fri, 10 Dec 2021 08:28:01 +0100
Message-Id: <20211210072905.15666-5-hare@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20211210072905.15666-1-hare@suse.de>
References: <20211210072905.15666-1-hare@suse.de>
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
index 604d9b826c29..5c5b01fb9351 100644
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
@@ -2627,8 +2610,7 @@ int ata_dev_configure(struct ata_device *dev)
 	/* find max transfer mode; for printk only */
 	xfer_mask = ata_id_xfermask(id);
 
-	if (ata_msg_probe(ap))
-		ata_dump_id(id);
+	ata_dump_id(dev, id);
 
 	/* SCSI only uses 4-char revisions, dump full 8 chars from ATA */
 	ata_id_c_string(dev->id, fwrevbuf, ATA_ID_FW_REV,
-- 
2.29.2

