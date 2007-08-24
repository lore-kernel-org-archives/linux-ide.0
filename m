From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH #upstream-fixes] ata_piix: add Satellite U200 to broken suspend list
Date: Sat, 25 Aug 2007 08:31:02 +0900
Message-ID: <20070824233102.GA32505@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.184]:3429 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751331AbXHXXbJ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 24 Aug 2007 19:31:09 -0400
Received: by rv-out-0910.google.com with SMTP id k20so763310rvb
        for <linux-ide@vger.kernel.org>; Fri, 24 Aug 2007 16:31:09 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org, john@nachtimwald.com

Satellite U200 also shares the problem.  Add it to the broken suspend
list.  Original patch from John Schember.

Signed-off-by: Tejun Heo <htejun@gmail.com>
Cc: John Schember <john@nachtimwald.com>
---
 drivers/ata/ata_piix.c |    7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/ata/ata_piix.c b/drivers/ata/ata_piix.c
index 071d274..b827def 100644
--- a/drivers/ata/ata_piix.c
+++ b/drivers/ata/ata_piix.c
@@ -908,6 +908,13 @@ static int piix_broken_suspend(void)
 			},
 		},
 		{
+			.ident = "Satellite U200",
+			.matches = {
+				DMI_MATCH(DMI_SYS_VENDOR, "TOSHIBA"),
+				DMI_MATCH(DMI_PRODUCT_NAME, "Satellite U200"),
+			},
+		},
+		{
 			.ident = "Satellite U205",
 			.matches = {
 				DMI_MATCH(DMI_SYS_VENDOR, "TOSHIBA"),
