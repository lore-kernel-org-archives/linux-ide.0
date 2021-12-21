Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC9C7C43217
	for <linux-ide@archiver.kernel.org>; Tue, 21 Dec 2021 07:22:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232237AbhLUHWs (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 21 Dec 2021 02:22:48 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:55890 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232548AbhLUHWo (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 21 Dec 2021 02:22:44 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id D999E1F3BC;
        Tue, 21 Dec 2021 07:22:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1640071361; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=at+Z4Rs4IYOyHDCQN3RQZIejSCJS0h3pJdBhq7Nia34=;
        b=sfuVPuc12T4mZ/t2mxkNT4BII1MSOPTVXIPTtIhiRVpHSrNvTDBk3yv4lPZav/LFF6bRSt
        XrGglfFYlT/gyju/wyYsw4fUU9df3Btvdfhnpzl06sjR9PLkMncWZbUqqorlfSULr7G6+4
        xpZvTjXw5H/oL7Rx6fmZBCjKlDsuUmc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1640071361;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=at+Z4Rs4IYOyHDCQN3RQZIejSCJS0h3pJdBhq7Nia34=;
        b=+c8C4gSMGZTnrPYVIZEBLl9HLJh3kaxGgLN2AQ9yN6ndtaI5Rgwmp5oi6OpQF68FcoFEeX
        jPNxLIxVmDZpRtAA==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
        by relay2.suse.de (Postfix) with ESMTP id D4E0BA3B92;
        Tue, 21 Dec 2021 07:22:41 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
        id D3243519238E; Tue, 21 Dec 2021 08:22:41 +0100 (CET)
From:   Hannes Reinecke <hare@suse.de>
To:     Damien LeMoal <damien.lemoal@wdc.com>
Cc:     linux-ide@vger.kernel.org, Hannes Reinecke <hare@suse.de>
Subject: [PATCH 14/68] libata: move DPRINTK to ata debugging
Date:   Tue, 21 Dec 2021 08:20:37 +0100
Message-Id: <20211221072131.46673-15-hare@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20211221072131.46673-1-hare@suse.de>
References: <20211221072131.46673-1-hare@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Replace all DPRINTK calls with ata_dev_dbg().

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/ata/libata-core.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index bd5803a86896..05a52e683593 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -1965,7 +1965,7 @@ unsigned int ata_read_log_page(struct ata_device *dev, u8 log,
 	unsigned int err_mask;
 	bool dma = false;
 
-	DPRINTK("read log page - log 0x%x, page 0x%x\n", log, page);
+	ata_dev_dbg(dev, "read log page - log 0x%x, page 0x%x\n", log, page);
 
 	/*
 	 * Return error without actually issuing the command on controllers
@@ -3341,8 +3341,8 @@ static int ata_dev_set_mode(struct ata_device *dev)
 			dev_err_whine = " (device error ignored)";
 	}
 
-	DPRINTK("xfer_shift=%u, xfer_mode=0x%x\n",
-		dev->xfer_shift, (int)dev->xfer_mode);
+	ata_dev_dbg(dev, "xfer_shift=%u, xfer_mode=0x%x\n",
+		    dev->xfer_shift, (int)dev->xfer_mode);
 
 	if (!(ehc->i.flags & ATA_EHI_QUIET) ||
 	    ehc->i.flags & ATA_EHI_DID_HARDRESET)
@@ -4288,7 +4288,7 @@ static unsigned int ata_dev_set_xfermode(struct ata_device *dev)
 	unsigned int err_mask;
 
 	/* set up set-features taskfile */
-	DPRINTK("set features - xfer mode\n");
+	ata_dev_dbg(dev, "set features - xfer mode\n");
 
 	/* Some controllers and ATAPI devices show flaky interrupt
 	 * behavior after setting xfer mode.  Use polling instead.
@@ -4310,7 +4310,6 @@ static unsigned int ata_dev_set_xfermode(struct ata_device *dev)
 	/* On some disks, this command causes spin-up, so we need longer timeout */
 	err_mask = ata_exec_internal(dev, &tf, NULL, DMA_NONE, NULL, 0, 15000);
 
-	DPRINTK("EXIT, err_mask=%x\n", err_mask);
 	return err_mask;
 }
 
@@ -4336,7 +4335,7 @@ unsigned int ata_dev_set_feature(struct ata_device *dev, u8 enable, u8 feature)
 	unsigned long timeout = 0;
 
 	/* set up set-features taskfile */
-	DPRINTK("set features - SATA features\n");
+	ata_dev_dbg(dev, "set features - SATA features\n");
 
 	ata_tf_init(dev, &tf);
 	tf.command = ATA_CMD_SET_FEATURES;
@@ -4350,7 +4349,6 @@ unsigned int ata_dev_set_feature(struct ata_device *dev, u8 enable, u8 feature)
 			  ata_probe_timeout * 1000 : SETFEATURES_SPINUP_TIMEOUT;
 	err_mask = ata_exec_internal(dev, &tf, NULL, DMA_NONE, NULL, 0, timeout);
 
-	DPRINTK("EXIT, err_mask=%x\n", err_mask);
 	return err_mask;
 }
 EXPORT_SYMBOL_GPL(ata_dev_set_feature);
@@ -4378,7 +4376,7 @@ static unsigned int ata_dev_init_params(struct ata_device *dev,
 		return AC_ERR_INVALID;
 
 	/* set up init dev params taskfile */
-	DPRINTK("init dev params \n");
+	ata_dev_dbg(dev, "init dev params \n");
 
 	ata_tf_init(dev, &tf);
 	tf.command = ATA_CMD_INIT_DEV_PARAMS;
@@ -4394,7 +4392,6 @@ static unsigned int ata_dev_init_params(struct ata_device *dev,
 	if (err_mask == AC_ERR_DEV && (tf.feature & ATA_ABORTED))
 		err_mask = 0;
 
-	DPRINTK("EXIT, err_mask=%x\n", err_mask);
 	return err_mask;
 }
 
-- 
2.29.2

