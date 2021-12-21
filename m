Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DFDFC43217
	for <linux-ide@archiver.kernel.org>; Tue, 21 Dec 2021 07:23:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231267AbhLUHXG (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 21 Dec 2021 02:23:06 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:55966 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232569AbhLUHWx (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 21 Dec 2021 02:22:53 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 81D9C1F3CE;
        Tue, 21 Dec 2021 07:22:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1640071362; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AVHNT6qoP6M6/YN79beWZ2nf5or+Stx4lepfEhNrLJo=;
        b=0peCeg01S6xQl28NmgnLFaawANuWt3vI2wGdbjpKXcMhbF8nP6rAlv0D3K+gEJEXuTPUoN
        1BVeggE5Cy1qCZMIHEas5vcN+5mr+n83yz/Pl8IqL37nFjQ8JRJuoydQnvYWucH9nNKMeI
        jJV9Bn3ImXFoP3HwrxaGZLT2igRTVyQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1640071362;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AVHNT6qoP6M6/YN79beWZ2nf5or+Stx4lepfEhNrLJo=;
        b=nqToplkioKrkjY3byM+dz0Sux+Od+HKlw2SRbF0N8OwvzUAUkdSQlUTsYPztUbk3di8c3b
        UhsTT9LXoHt7IDAw==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
        by relay2.suse.de (Postfix) with ESMTP id 7D5BFA3BB3;
        Tue, 21 Dec 2021 07:22:42 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
        id 7C29E51923D4; Tue, 21 Dec 2021 08:22:42 +0100 (CET)
From:   Hannes Reinecke <hare@suse.de>
To:     Damien LeMoal <damien.lemoal@wdc.com>
Cc:     linux-ide@vger.kernel.org, Hannes Reinecke <hare@suse.de>
Subject: [PATCH 49/68] pata_cmd64x: convert printk() calls
Date:   Tue, 21 Dec 2021 08:21:12 +0100
Message-Id: <20211221072131.46673-50-hare@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20211221072131.46673-1-hare@suse.de>
References: <20211221072131.46673-1-hare@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Convert printk() calls to structured logging.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/ata/pata_cmd64x.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/pata_cmd64x.c b/drivers/ata/pata_cmd64x.c
index 1d74d89b5bed..5baa4a7819c1 100644
--- a/drivers/ata/pata_cmd64x.c
+++ b/drivers/ata/pata_cmd64x.c
@@ -116,7 +116,7 @@ static void cmd64x_set_timing(struct ata_port *ap, struct ata_device *adev, u8 m
 	/* ata_timing_compute is smart and will produce timings for MWDMA
 	   that don't violate the drives PIO capabilities. */
 	if (ata_timing_compute(adev, mode, &t, T, 0) < 0) {
-		printk(KERN_ERR DRV_NAME ": mode computation failed.\n");
+		ata_dev_err(adev, DRV_NAME ": mode computation failed.\n");
 		return;
 	}
 	if (ap->port_no) {
@@ -130,7 +130,7 @@ static void cmd64x_set_timing(struct ata_port *ap, struct ata_device *adev, u8 m
 		}
 	}
 
-	printk(KERN_DEBUG DRV_NAME ": active %d recovery %d setup %d.\n",
+	ata_dev_dbg(adev, DRV_NAME ": active %d recovery %d setup %d.\n",
 		t.active, t.recover, t.setup);
 	if (t.recover > 16) {
 		t.active += t.recover - 16;
-- 
2.29.2

