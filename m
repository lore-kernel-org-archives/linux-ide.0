From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH] ata_piix: update map 10b for ich8m
Date: Tue, 7 Aug 2007 02:43:27 +0900
Message-ID: <20070806174327.GP13674@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.189]:54986 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1764864AbXHFRnc (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 6 Aug 2007 13:43:32 -0400
Received: by rv-out-0910.google.com with SMTP id k20so1180104rvb
        for <linux-ide@vger.kernel.org>; Mon, 06 Aug 2007 10:43:32 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org, kristen.c.accardi@intel.com, stable@kernel.org

Fix map entry 10b for ich8.  It's [P0 P2 IDE IDE] like ich6 / ich6m.

Signed-off-by: Tejun Heo <htejun@gmail.com>
Cc: <Kristen Carlson Accardi> kristen.c.accardi@intel.com
---
Many users can be hit by this.  Please consider for -stable.  Thanks.

 drivers/ata/ata_piix.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ata/ata_piix.c b/drivers/ata/ata_piix.c
index a78832e..c5b4509 100644
--- a/drivers/ata/ata_piix.c
+++ b/drivers/ata/ata_piix.c
@@ -436,7 +436,7 @@ static const struct piix_map_db ich8_map_db = {
 		/* PM   PS   SM   SS       MAP */
 		{  P0,  P2,  P1,  P3 }, /* 00b (hardwired when in AHCI) */
 		{  RV,  RV,  RV,  RV },
-		{  IDE,  IDE,  NA,  NA }, /* 10b (IDE mode) */
+		{  P0,  P2, IDE, IDE }, /* 10b (IDE mode) */
 		{  RV,  RV,  RV,  RV },
 	},
 };
