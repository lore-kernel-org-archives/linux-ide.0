From: Adrian Bunk <bunk@kernel.org>
Subject: [2.6 patch] libata-core.c: remove no longer used exports
Date: Mon, 21 Apr 2008 11:51:23 +0300
Message-ID: <20080421085123.GD26897@cs181133002.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp6.pp.htv.fi ([213.243.153.40]:41214 "EHLO smtp6.pp.htv.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759178AbYDUIvv (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 21 Apr 2008 04:51:51 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Since the usages went to libata-sff, the following exports are no longer 
used:
- ata_std_prereset
- ata_do_eh

Signed-off-by: Adrian Bunk <bunk@kernel.org>

---

 drivers/ata/libata-core.c |    2 --
 1 file changed, 2 deletions(-)

8f30ab861a3649ea3bab9c830b922346364dbd55 diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 8c2bb65..d684a22 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -6217,7 +6217,6 @@ EXPORT_SYMBOL_GPL(sata_set_spd);
 EXPORT_SYMBOL_GPL(ata_wait_after_reset);
 EXPORT_SYMBOL_GPL(sata_link_debounce);
 EXPORT_SYMBOL_GPL(sata_link_resume);
-EXPORT_SYMBOL_GPL(ata_std_prereset);
 EXPORT_SYMBOL_GPL(sata_link_hardreset);
 EXPORT_SYMBOL_GPL(sata_std_hardreset);
 EXPORT_SYMBOL_GPL(ata_std_postreset);
@@ -6278,7 +6277,6 @@ EXPORT_SYMBOL_GPL(ata_eh_freeze_port);
 EXPORT_SYMBOL_GPL(ata_eh_thaw_port);
 EXPORT_SYMBOL_GPL(ata_eh_qc_complete);
 EXPORT_SYMBOL_GPL(ata_eh_qc_retry);
-EXPORT_SYMBOL_GPL(ata_do_eh);
 EXPORT_SYMBOL_GPL(ata_std_error_handler);
 
 EXPORT_SYMBOL_GPL(ata_cable_40wire);

