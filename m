From: David Daney <ddaney@caviumnetworks.com>
Subject: [PATCH 2/3] libata: Add special ata_pio_need_iordy() handling for Compact Flash.
Date: Mon,  8 Dec 2008 17:39:57 -0800
Message-ID: <1228786798-20369-2-git-send-email-ddaney@caviumnetworks.com>
References: <493DCBEA.9090007@caviumnetworks.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail3.caviumnetworks.com ([12.108.191.235]:20519 "EHLO
	mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751444AbYLIBnY (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 8 Dec 2008 20:43:24 -0500
In-Reply-To: <493DCBEA.9090007@caviumnetworks.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: linux-mips@linux-mips.org, David Daney <ddaney@caviumnetworks.com>

According to the Compact Flash specification r4.1, PIO modes 5 and 6
do not use iordy.

Signed-off-by: David Daney <ddaney@caviumnetworks.com>
---
 drivers/ata/libata-core.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index b156d83..febdcb7 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -1923,6 +1923,10 @@ unsigned int ata_pio_need_iordy(const struct ata_device *adev)
 	   as the caller should know this */
 	if (adev->link->ap->flags & ATA_FLAG_NO_IORDY)
 		return 0;
+	/* CF spec. r4.1 Table 22 says no iordy on PIO5 and PIO6.  */
+	if (ata_id_is_cfa(adev->id)
+	    && (adev->pio_mode == XFER_PIO_5 || adev->pio_mode == XFER_PIO_6))
+		return 0;
 	/* PIO3 and higher it is mandatory */
 	if (adev->pio_mode > XFER_PIO_2)
 		return 1;
-- 
1.5.6.5

