Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 937D5C4332F
	for <linux-ide@archiver.kernel.org>; Wed,  8 Dec 2021 16:33:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237054AbhLHQhF (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 8 Dec 2021 11:37:05 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:37746 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237056AbhLHQgv (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 8 Dec 2021 11:36:51 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 450E81FE2D;
        Wed,  8 Dec 2021 16:33:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1638981181; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Y3jmduD4DC/3XiJKiGVyNYXPQA3QqZdoEDrDwHgMgF0=;
        b=nLl0ePf9PyOZ9ctN1w+sHinZj342Upi/r4sy94bM15pW7shje6VsX19axqbxnMHtWPNhAT
        xkMa65qzS4tGa8Ep5KDeHgWeON6e2Wcluo/i0GV8DmZb6Yha94Cv7WVg3eeXM48dCMl4oj
        vIDGG0fKf4VxCYplGEWD1/p2yKHzC4U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1638981181;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Y3jmduD4DC/3XiJKiGVyNYXPQA3QqZdoEDrDwHgMgF0=;
        b=ehlS3i7h6HAR1IaXyY1nD9jzFRoamyvQ9CgjLpzK6illcregfvsNYwKoRwdu8aw0sBH9vm
        FT3/hWrhNYXLUcDw==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
        by relay2.suse.de (Postfix) with ESMTP id 42E1AA3BD1;
        Wed,  8 Dec 2021 16:33:01 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
        id 3F60E5191FD5; Wed,  8 Dec 2021 17:33:01 +0100 (CET)
From:   Hannes Reinecke <hare@suse.de>
To:     Damien LeMoal <damien.lemoal@wdc.com>
Cc:     linux-ide@vger.kernel.org, Hannes Reinecke <hare@suse.de>
Subject: [PATCH 60/73] pata_it821x: convert blank printk() calls
Date:   Wed,  8 Dec 2021 17:32:42 +0100
Message-Id: <20211208163255.114660-61-hare@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20211208163255.114660-1-hare@suse.de>
References: <20211208163255.114660-1-hare@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Convert blank printk() calls to structured logging.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/ata/pata_it821x.c | 43 ++++++++++++++++++++++-----------------
 1 file changed, 24 insertions(+), 19 deletions(-)

diff --git a/drivers/ata/pata_it821x.c b/drivers/ata/pata_it821x.c
index 0e2265978a34..b77ef0046dbe 100644
--- a/drivers/ata/pata_it821x.c
+++ b/drivers/ata/pata_it821x.c
@@ -431,7 +431,8 @@ static unsigned int it821x_smart_qc_issue(struct ata_queued_cmd *qc)
 		case ATA_CMD_SET_FEATURES:
 			return ata_bmdma_qc_issue(qc);
 	}
-	printk(KERN_DEBUG "it821x: can't process command 0x%02X\n", qc->tf.command);
+	ata_dev_dbg(qc->dev, "it821x: can't process command 0x%02X\n",
+		    qc->tf.command);
 	return AC_ERR_DEV;
 }
 
@@ -507,12 +508,14 @@ static void it821x_dev_config(struct ata_device *adev)
 
 	if (strstr(model_num, "Integrated Technology Express")) {
 		/* RAID mode */
-		ata_dev_info(adev, "%sRAID%d volume",
-			     adev->id[147] ? "Bootable " : "",
-			     adev->id[129]);
-		if (adev->id[129] != 1)
-			pr_cont("(%dK stripe)", adev->id[146]);
-		pr_cont("\n");
+		if (adev->id[129] == 1)
+			ata_dev_info(adev, "%sRAID%d volume\n",
+				     adev->id[147] ? "Bootable " : "",
+				     adev->id[129]);
+		else
+			ata_dev_info(adev, "%sRAID%d volume (%dK stripe)\n",
+				     adev->id[147] ? "Bootable " : "",
+				     adev->id[129], adev->id[146]);
 	}
 	/* This is a controller firmware triggered funny, don't
 	   report the drive faulty! */
@@ -593,6 +596,7 @@ static int it821x_check_atapi_dma(struct ata_queued_cmd *qc)
 
 /**
  *	it821x_display_disk	-	display disk setup
+ *	@ap: ATA port
  *	@n: Device number
  *	@buf: Buffer block from firmware
  *
@@ -600,7 +604,7 @@ static int it821x_check_atapi_dma(struct ata_queued_cmd *qc)
  *	by the firmware.
  */
 
-static void it821x_display_disk(int n, u8 *buf)
+static void it821x_display_disk(struct ata_port *ap, int n, u8 *buf)
 {
 	unsigned char id[41];
 	int mode = 0;
@@ -633,13 +637,13 @@ static void it821x_display_disk(int n, u8 *buf)
 	else
 		strcpy(mbuf, "PIO");
 	if (buf[52] == 4)
-		printk(KERN_INFO "%d: %-6s %-8s          %s %s\n",
+		ata_port_info(ap, "%d: %-6s %-8s          %s %s\n",
 				n, mbuf, types[buf[52]], id, cbl);
 	else
-		printk(KERN_INFO "%d: %-6s %-8s Volume: %1d %s %s\n",
+		ata_port_info(ap, "%d: %-6s %-8s Volume: %1d %s %s\n",
 				n, mbuf, types[buf[52]], buf[53], id, cbl);
 	if (buf[125] < 100)
-		printk(KERN_INFO "%d: Rebuilding: %d%%\n", n, buf[125]);
+		ata_port_info(ap, "%d: Rebuilding: %d%%\n", n, buf[125]);
 }
 
 /**
@@ -676,7 +680,7 @@ static u8 *it821x_firmware_command(struct ata_port *ap, u8 cmd, int len)
 		status = ioread8(ap->ioaddr.status_addr);
 		if (status & ATA_ERR) {
 			kfree(buf);
-			printk(KERN_ERR "it821x_firmware_command: rejected\n");
+			ata_port_err(ap, "%s: rejected\n", __func__);
 			return NULL;
 		}
 		if (status & ATA_DRQ) {
@@ -686,7 +690,7 @@ static u8 *it821x_firmware_command(struct ata_port *ap, u8 cmd, int len)
 		usleep_range(500, 1000);
 	}
 	kfree(buf);
-	printk(KERN_ERR "it821x_firmware_command: timeout\n");
+	ata_port_err(ap, "%s: timeout\n", __func__);
 	return NULL;
 }
 
@@ -709,13 +713,13 @@ static void it821x_probe_firmware(struct ata_port *ap)
 	buf = it821x_firmware_command(ap, 0xFA, 512);
 
 	if (buf != NULL) {
-		printk(KERN_INFO "pata_it821x: Firmware %02X/%02X/%02X%02X\n",
+		ata_port_info(ap, "pata_it821x: Firmware %02X/%02X/%02X%02X\n",
 				buf[505],
 				buf[506],
 				buf[507],
 				buf[508]);
 		for (i = 0; i < 4; i++)
- 			it821x_display_disk(i, buf + 128 * i);
+			it821x_display_disk(ap, i, buf + 128 * i);
 		kfree(buf);
 	}
 }
@@ -771,7 +775,8 @@ static int it821x_port_start(struct ata_port *ap)
 		itdev->timing10 = 1;
 		/* Need to disable ATAPI DMA for this case */
 		if (!itdev->smart)
-			printk(KERN_WARNING DRV_NAME": Revision 0x10, workarounds activated.\n");
+			dev_warn(&pdev->dev,
+				 "Revision 0x10, workarounds activated.\n");
 	}
 
 	return 0;
@@ -919,14 +924,14 @@ static int it821x_init_one(struct pci_dev *pdev, const struct pci_device_id *id)
 	} else {
 		/* Force the card into bypass mode if so requested */
 		if (it8212_noraid) {
-			printk(KERN_INFO DRV_NAME ": forcing bypass mode.\n");
+			dev_info(&pdev->dev, "forcing bypass mode.\n");
 			it821x_disable_raid(pdev);
 		}
 		pci_read_config_byte(pdev, 0x50, &conf);
 		conf &= 1;
 
-		printk(KERN_INFO DRV_NAME": controller in %s mode.\n",
-								mode[conf]);
+		dev_info(&pdev->dev, "controller in %s mode.\n", mode[conf]);
+
 		if (conf == 0)
 			ppi[0] = &info_passthru;
 		else
-- 
2.29.2

