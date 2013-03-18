From: Shan Hai <shan.hai@windriver.com>
Subject: [PATCH 1/2] libata: Use integer return value for atapi_command_packet_set
Date: Mon, 18 Mar 2013 10:30:43 +0800
Message-ID: <1363573844-12729-2-git-send-email-shan.hai@windriver.com>
References: <1363573844-12729-1-git-send-email-shan.hai@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail1.windriver.com ([147.11.146.13]:54152 "EHLO
	mail1.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750930Ab3CRCa6 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 17 Mar 2013 22:30:58 -0400
In-Reply-To: <1363573844-12729-1-git-send-email-shan.hai@windriver.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org
Cc: linux-ide@vger.kernel.org

The function returns type of ATAPI drives so it should return integer value.
The commit 4dce8ba94c7 (libata: Use 'bool' return value for ata_id_XXX) since
v2.6.39 changed the type of return value from int to bool, the change would
cause all of the ATAPI class drives to be treated as TYPE_TAPE and the
max_sectors of the drives to be set to 65535 because of the commit
f8d8e5799b7(libata: increase 128 KB / cmd limit for ATAPI tape drives), for the
function would return true for all ATAPI class drives and the TYPE_TAPE is
defined as 0x01.

Cc: stable@vger.kernel.org
Signed-off-by: Shan Hai <shan.hai@windriver.com>
---
 include/linux/ata.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/include/linux/ata.h b/include/linux/ata.h
index 8f7a3d6..ee0bd95 100644
--- a/include/linux/ata.h
+++ b/include/linux/ata.h
@@ -954,7 +954,7 @@ static inline int atapi_cdb_len(const u16 *dev_id)
 	}
 }
 
-static inline bool atapi_command_packet_set(const u16 *dev_id)
+static inline int atapi_command_packet_set(const u16 *dev_id)
 {
 	return (dev_id[ATA_ID_CONFIG] >> 8) & 0x1f;
 }
-- 
1.7.0.5

