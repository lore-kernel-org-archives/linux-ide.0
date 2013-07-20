From: Marc C <marc.ceeeee@gmail.com>
Subject: [PATCH] libata: Add additional queued command opcodes from SATA spec
Date: Fri, 19 Jul 2013 18:17:14 -0700
Message-ID: <CAO1A-8DmPXdM-XbzD18aQUYy4+Aph0jVwrSe1_spJJcRM57NNQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-vb0-f47.google.com ([209.85.212.47]:49424 "EHLO
	mail-vb0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752057Ab3GTBRP (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 19 Jul 2013 21:17:15 -0400
Received: by mail-vb0-f47.google.com with SMTP id x14so3503526vbb.6
        for <linux-ide@vger.kernel.org>; Fri, 19 Jul 2013 18:17:14 -0700 (PDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org

This patch adds the new queued opcodes to the ATA device command
list.

Rev 3.0 and 3.1 of the SATA spec introduced the following
opcodes:

- NCQ QUEUE MANAGEMENT
- SEND FPDMA QUEUED
- RECEIVE FPDMA QUEUED

Signed-off-by: Marc C <marc.ceeeee@gmail.com>
---
 include/linux/ata.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/linux/ata.h b/include/linux/ata.h
index ee0bd95..ae0e447 100644
--- a/include/linux/ata.h
+++ b/include/linux/ata.h
@@ -239,6 +239,9 @@ enum {
     ATA_CMD_WRITE_QUEUED_FUA_EXT = 0x3E,
     ATA_CMD_FPDMA_READ    = 0x60,
     ATA_CMD_FPDMA_WRITE    = 0x61,
+    ATA_CMD_NCQ_QUEUE_MGMT    = 0x63,
+    ATA_CMD_FPDMA_SEND    = 0x64,
+    ATA_CMA_FPDMA_RECEIVE    = 0x65,
     ATA_CMD_PIO_READ    = 0x20,
     ATA_CMD_PIO_READ_EXT    = 0x24,
     ATA_CMD_PIO_WRITE    = 0x30,
--
1.8.1.3
