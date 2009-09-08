From: Shane Huang <shane.huang@amd.com>
Subject: [PATCH #upstream] libata: add SATA PMP revision information for
 spec 1.2
Date: Tue, 8 Sep 2009 17:37:01 +0800
Message-ID: <1252402621.3514.12.camel@zm-desktop>
Reply-To: shane.huang@amd.com
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from va3ehsobe003.messaging.microsoft.com ([216.32.180.13]:49802
	"EHLO VA3EHSOBE003.bigfish.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754072AbZIHJhl (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 8 Sep 2009 05:37:41 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, tj@kernel.org
Cc: linux-ide@vger.kernel.org, "Huang, Shane" <Shane.Huang@amd.com>

This small patch is just adding the information for PMP spec 1.2

Signed-off-by: Shane Huang <shane.huang@amd.com>
---
 drivers/ata/libata-pmp.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/ata/libata-pmp.c b/drivers/ata/libata-pmp.c
index 619f2c3..51f0ffb 100644
--- a/drivers/ata/libata-pmp.c
+++ b/drivers/ata/libata-pmp.c
@@ -221,6 +221,8 @@ static const char *sata_pmp_spec_rev_str(const u32 *gscr)
 {
 	u32 rev = gscr[SATA_PMP_GSCR_REV];
 
+	if (rev & (1 << 3))
+		return "1.2";
 	if (rev & (1 << 2))
 		return "1.1";
 	if (rev & (1 << 1))


