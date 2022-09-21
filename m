Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E6D7C6FA82
	for <linux-ide@archiver.kernel.org>; Wed, 21 Sep 2022 17:20:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229866AbiIURT7 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 21 Sep 2022 13:19:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230087AbiIURT6 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 21 Sep 2022 13:19:58 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E6A75C35C
        for <linux-ide@vger.kernel.org>; Wed, 21 Sep 2022 10:19:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1663780794; x=1695316794;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=snPvfZCdDqDFcpBnh+0xdjo3PDdJaJXqCgEHIMewdI8=;
  b=Q2JUjnhcNoNSbiA2mUwNa7KCSl7W1o5x/4e/92J2g7m1tHfsX48L26tA
   BJmevSsz+sXI6J07+y44L1gpoxQ4dwQtkLnPnRjO79MMR1pe2zJqf/09P
   dRdDl9vQ8+ygFIWGCZVaizOGND+ZuNrNsFOeZ9xDgfIerqC4VZUhd9Ld7
   pdmUIzGnobvbggPvSRtbBAbUe+opYV8Co1dbiw4WoMklQisHyE2JAhL88
   CQkxplEQy8RmrNDJfyQsYhiEzhnqsluV1m3OxxTSBLJk4Qo4w69URY2kt
   EGE3fmPO5nzHEDeId62kUjavawIRTHv+b4sfnfUv1PRRxuRrGkFiChg2D
   A==;
X-IronPort-AV: E=Sophos;i="5.93,333,1654531200"; 
   d="scan'208";a="210311071"
Received: from unknown (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 21 Sep 2022 23:58:19 +0800
IronPort-SDR: O6ctfnpDI+hCSzYd6bEENdLezoNQKsqz0dCoO5rBW4eQ0Xtu4UrkcJQKapeq3ShSXErdFHImwh
 OK5JST8dOXQvJY/Ufmi78fiiM2yAnlVyZFfpUyb+LzXbUKb5m6cPZIuJd500k8dlbWji6T0f/i
 4eSdsJ8QFBp3XzIiRd84Bszrh64zkSZx/Do2Jm7KwLOYrVYffnOp3QfMvdS4r58LbxkRckyPbC
 r7Wlp7tdJYbz2zk4vQVK6GvSFiW5nU8XsXKfMKAeyU4GTBFhbI4768n8B4x6H6LvIoFWuFuuWw
 txvKm/SmDp09fkb7X8tmNsY7
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 21 Sep 2022 08:18:04 -0700
IronPort-SDR: lUQKyi3Cfmw8b5ACycosvtHYMf2zjTtmqPdrPmm/7HAzyxt+tOU6PXcLFb6gVUlTPaWa6VcoYL
 gYbPPYKKcBZd421bUCz1+IVIf+3NeBDvdHVOD0g16qS3bVKh7bvlHqyc/MJPwaTsUBdiTuazXu
 qeCwit+wsNUAKjanXrMF1zBjmwP288uHVGoiHE4iUyMsoR8uxNz52FCJ27IFxrQNEi7rY87yHn
 Ybi3nnORg6yidV2QYQTeyo0pY0m1WPLGuL6SUZW25WpnERmsuukK/4YD2y2NUz2rKIez70qHbo
 4jg=
WDCIronportException: Internal
Received: from unknown (HELO x1-carbon.wdc.com) ([10.225.164.30])
  by uls-op-cesaip02.wdc.com with ESMTP; 21 Sep 2022 08:57:59 -0700
From:   Niklas Cassel <niklas.cassel@wdc.com>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     Niklas Cassel <niklas.cassel@wdc.com>, linux-ide@vger.kernel.org
Subject: [PATCH] ata: libata-eh: avoid needless hard reset when revalidating link
Date:   Wed, 21 Sep 2022 17:57:52 +0200
Message-Id: <20220921155753.231770-1-niklas.cassel@wdc.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Performing a revalidation on a AHCI controller supporting LPM,
while using a lpm mode of e.g. med_power_with_dip (hipm + dipm) or
medium_power (hipm), will currently always lead to a hard reset.

The expected behavior is that a hard reset is only performed when
revalidate fails, because the properties of the drive has changed.

A revalidate performed after e.g. a NCQ error, or such a simple thing
as disabling write-caching (hdparm -W 0 /dev/sda), should succeed on
the first try (and should therefore not cause the link to be reset).

This unwarranted hard reset happens because ata_phys_link_offline()
returns true for a link that is in deep sleep. Thus the call to
ata_phys_link_offline() in ata_eh_revalidate_and_attach() will cause
the revalidation to fail, which causes ata_eh_handle_dev_fail() to be
called, which will set ehc->i.action |= ATA_EH_RESET, such that the
link is reset before retrying revalidation.

When the link is reset, the link is reestablished, so when
ata_eh_revalidate_and_attach() is called the second time, directly
after the link has been reset, ata_phys_link_offline() will return
false, and the revalidation will succeed.

Looking at "8.3.1.3 HBA Initiated" in the AHCI 1.3.1 specification,
it is clear the when host software writes a new command to memory,
by setting a bit in the PxCI/PxSACT HBA port registers, the HBA will
automatically bring back the link before sending out the Command FIS.

However, simply reading a SCR (like ata_phys_link_offline() does),
will not cause the HBA to automatically bring back the link.

As long as hipm is enabled, the HBA will put an idle link into deep
sleep. Avoid this needless hard reset on revalidation by temporarily
disabling hipm, by setting the LPM mode to ATA_LPM_MAX_POWER.

After revalidation is complete, ata_eh_recover() will restore the link
policy by setting the LPM mode to ap->target_lpm_policy.

Signed-off-by: Niklas Cassel <niklas.cassel@wdc.com>
---
 drivers/ata/libata-eh.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index 7c128c89b454..1f83ae8690ee 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -151,6 +151,8 @@ ata_eh_cmd_timeout_table[ATA_EH_CMD_TIMEOUT_TABLE_SIZE] = {
 #undef CMDS
 
 static void __ata_port_freeze(struct ata_port *ap);
+static int ata_eh_set_lpm(struct ata_link *link, enum ata_lpm_policy policy,
+			  struct ata_device **r_failed_dev);
 #ifdef CONFIG_PM
 static void ata_eh_handle_port_suspend(struct ata_port *ap);
 static void ata_eh_handle_port_resume(struct ata_port *ap);
@@ -2940,6 +2942,23 @@ static int ata_eh_revalidate_and_attach(struct ata_link *link,
 		if ((action & ATA_EH_REVALIDATE) && ata_dev_enabled(dev)) {
 			WARN_ON(dev->class == ATA_DEV_PMP);
 
+			/*
+			 * The link may be in a deep sleep, wake it up.
+			 *
+			 * If the link is in deep sleep, ata_phys_link_offline()
+			 * will return true, causing the revalidation to fail,
+			 * which leads to a (potentially) needless hard reset.
+			 *
+			 * ata_eh_recover() will later restore the link policy
+			 * to ap->target_lpm_policy after revalidation is done.
+			 */
+			if (link->lpm_policy > ATA_LPM_MAX_POWER) {
+				rc = ata_eh_set_lpm(link, ATA_LPM_MAX_POWER,
+						    r_failed_dev);
+				if (rc)
+					goto err;
+			}
+
 			if (ata_phys_link_offline(ata_dev_phys_link(dev))) {
 				rc = -EIO;
 				goto err;
-- 
2.37.3

