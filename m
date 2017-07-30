From: Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH] libata: fix a couple of doc build warnings
Date: Sun, 30 Jul 2017 16:16:04 -0600
Message-ID: <20170730161604.16e00c29@lwn.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ms.lwn.net ([45.79.88.28]:59322 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751045AbdG3WQF (ORCPT <rfc822;linux-ide@vger.kernel.org>);
        Sun, 30 Jul 2017 18:16:05 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: linux-ide@vger.kernel.org

The kerneldoc comments for a couple of functions in drivers/ata/libata-eh.c
had fallen behind the current implementation, resulting in these doc build
warnings:

  ./drivers/ata/libata-eh.c:1449: warning: No description found for parameter 'link'
  ./drivers/ata/libata-eh.c:1449: warning: Excess function parameter 'ap' description in 'ata_eh_done'
  ./drivers/ata/libata-eh.c:1590: warning: No description found for parameter 'qc'
  ./drivers/ata/libata-eh.c:1590: warning: Excess function parameter 'dev' description in 'ata_eh_request_sense'

Update the comments and make the warnings go away.

Signed-off-by: Jonathan Corbet <corbet@lwn.net>
---
 drivers/ata/libata-eh.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index b70bcf6d2914..2693428ed111 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -1434,7 +1434,7 @@ void ata_eh_about_to_do(struct ata_link *link, struct ata_device *dev,
 
 /**
  *	ata_eh_done - EH action complete
-*	@ap: target ATA port
+ *	@link: ATA link for which EH actions are complete
  *	@dev: target ATA dev for per-dev action (can be NULL)
  *	@action: action just completed
  *
@@ -1576,7 +1576,7 @@ unsigned int atapi_eh_tur(struct ata_device *dev, u8 *r_sense_key)
 
 /**
  *	ata_eh_request_sense - perform REQUEST_SENSE_DATA_EXT
- *	@dev: device to perform REQUEST_SENSE_SENSE_DATA_EXT to
+ *	@qc: qc to perform REQUEST_SENSE_SENSE_DATA_EXT to
  *	@cmd: scsi command for which the sense code should be set
  *
  *	Perform REQUEST_SENSE_DATA_EXT after the device reported CHECK
-- 
2.13.3

