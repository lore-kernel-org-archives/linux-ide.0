Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E5E2C7EE24
	for <linux-ide@archiver.kernel.org>; Wed, 10 May 2023 22:52:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230023AbjEJWwh (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 10 May 2023 18:52:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229836AbjEJWwd (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 10 May 2023 18:52:33 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34D0B61AD
        for <linux-ide@vger.kernel.org>; Wed, 10 May 2023 15:52:23 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id DA4E421991;
        Wed, 10 May 2023 22:52:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1683759141; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JbSCl6pQsiob51YjIjOw2bhOWJEvyjsaL89umja5Ekk=;
        b=onMxlyPy9l45qflcV3MRELpsLS8MhtPfATlETVB4tOWo+781OcRblNdQwOgEDt+LFMhW1E
        bL/wb/28Er07u3Jd9u/s6z+V9OZbafLh8JS9so2shON1WWMAb+OUbFf/rdRU7xAazYjIjs
        IsA9fttcKostnC7Q5f9ilrSbfTIF5+o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1683759141;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JbSCl6pQsiob51YjIjOw2bhOWJEvyjsaL89umja5Ekk=;
        b=Aoe3+6a+KiUVoHvhR2gmqieiuYnvSRgK58Ooe6ucnTN7xQwNwyIRnxuKRFAdvXu/mUPaEJ
        J1Ak3jFoiSINMVBA==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
        by relay2.suse.de (Postfix) with ESMTP id CFF632C145;
        Wed, 10 May 2023 22:52:21 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
        id C6EAF51C34E3; Thu, 11 May 2023 00:52:21 +0200 (CEST)
From:   Hannes Reinecke <hare@suse.de>
To:     Damien LeMoal <dlemoal@kernel.org>
Cc:     linux-ide@vger.kernel.org, Hannes Reinecke <hare@suse.de>
Subject: [PATCH 2/6] ata,scsi: remove ata_sas_port_{start,stop} callbacks
Date:   Thu, 11 May 2023 00:52:07 +0200
Message-Id: <20230510225211.111113-3-hare@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230510225211.111113-1-hare@suse.de>
References: <20230510225211.111113-1-hare@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Callbacks are empty now, so remove them.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/ata/libata-sata.c     | 36 -----------------------------------
 drivers/scsi/libsas/sas_ata.c |  2 --
 include/linux/libata.h        |  2 --
 3 files changed, 40 deletions(-)

diff --git a/drivers/ata/libata-sata.c b/drivers/ata/libata-sata.c
index bd2a754b645c..3c56b15c43f1 100644
--- a/drivers/ata/libata-sata.c
+++ b/drivers/ata/libata-sata.c
@@ -1123,42 +1123,6 @@ struct ata_port *ata_sas_port_alloc(struct ata_host *host,
 }
 EXPORT_SYMBOL_GPL(ata_sas_port_alloc);
 
-/**
- *	ata_sas_port_start - Set port up for dma.
- *	@ap: Port to initialize
- *
- *	Called just after data structures for each port are
- *	initialized.
- *
- *	May be used as the port_start() entry in ata_port_operations.
- *
- *	LOCKING:
- *	Inherited from caller.
- */
-int ata_sas_port_start(struct ata_port *ap)
-{
-	/*
-	 * the port is marked as frozen at allocation time
-	 */
-	return 0;
-}
-EXPORT_SYMBOL_GPL(ata_sas_port_start);
-
-/**
- *	ata_sas_port_stop - Undo ata_sas_port_start()
- *	@ap: Port to shut down
- *
- *	May be used as the port_stop() entry in ata_port_operations.
- *
- *	LOCKING:
- *	Inherited from caller.
- */
-
-void ata_sas_port_stop(struct ata_port *ap)
-{
-}
-EXPORT_SYMBOL_GPL(ata_sas_port_stop);
-
 /**
  * ata_sas_async_probe - simply schedule probing and return
  * @ap: Port to probe
diff --git a/drivers/scsi/libsas/sas_ata.c b/drivers/scsi/libsas/sas_ata.c
index 77714a495cbb..7ead1f1be97f 100644
--- a/drivers/scsi/libsas/sas_ata.c
+++ b/drivers/scsi/libsas/sas_ata.c
@@ -565,8 +565,6 @@ static struct ata_port_operations sas_sata_ops = {
 	.qc_prep		= ata_noop_qc_prep,
 	.qc_issue		= sas_ata_qc_issue,
 	.qc_fill_rtf		= sas_ata_qc_fill_rtf,
-	.port_start		= ata_sas_port_start,
-	.port_stop		= ata_sas_port_stop,
 	.set_dmamode		= sas_ata_set_dmamode,
 	.sched_eh		= sas_ata_sched_eh,
 	.end_eh			= sas_ata_end_eh,
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 311cd93377c7..395b25fea187 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -1228,10 +1228,8 @@ extern struct ata_port *ata_sas_port_alloc(struct ata_host *,
 extern void ata_sas_async_probe(struct ata_port *ap);
 extern int ata_sas_sync_probe(struct ata_port *ap);
 extern int ata_sas_port_init(struct ata_port *);
-extern int ata_sas_port_start(struct ata_port *ap);
 extern int ata_sas_tport_add(struct device *parent, struct ata_port *ap);
 extern void ata_sas_tport_delete(struct ata_port *ap);
-extern void ata_sas_port_stop(struct ata_port *ap);
 extern int ata_sas_slave_configure(struct scsi_device *, struct ata_port *);
 extern int ata_sas_queuecmd(struct scsi_cmnd *cmd, struct ata_port *ap);
 extern void ata_tf_to_fis(const struct ata_taskfile *tf,
-- 
2.35.3

