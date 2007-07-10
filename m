From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH] ata_piix: kill incorrect invalid map value warning
Date: Tue, 10 Jul 2007 17:58:21 +0900
Message-ID: <20070710085821.GC23568@htj.dyndns.org>
References: <113a52882e6.buthysia@virgilio.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.235]:58927 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758078AbXGJI60 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 10 Jul 2007 04:58:26 -0400
Received: by nz-out-0506.google.com with SMTP id s18so943578nze
        for <linux-ide@vger.kernel.org>; Tue, 10 Jul 2007 01:58:26 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <113a52882e6.buthysia@virgilio.it>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org, "buthysia@virgilio.it" <buthysia@virgilio.it>
Cc: linux-ide@vger.kernel.org

The last two slots of MAP 00b of ich6m was incorrectly marked as
reserved.  This is left over from converting the entry to allow 00b.
This causes no real problem.  It only makes the driver print annoying
warning message.  Fix it.

Signed-off-by: Tejun Heo <htejun@gmail.com>
--
 drivers/ata/ata_piix.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ata/ata_piix.c b/drivers/ata/ata_piix.c
index 6a3bfef..21a7ca4 100644
--- a/drivers/ata/ata_piix.c
+++ b/drivers/ata/ata_piix.c
@@ -414,7 +414,7 @@ static const struct piix_map_db ich6m_map_db = {
 	 */
 	.map = {
 		/* PM   PS   SM   SS       MAP */
-		{  P0,  P2,  RV,  RV }, /* 00b */
+		{  P0,  P2,  NA,  NA }, /* 00b */
 		{ IDE, IDE,  P1,  P3 }, /* 01b */
 		{  P0,  P2, IDE, IDE }, /* 10b */
 		{  RV,  RV,  RV,  RV },
