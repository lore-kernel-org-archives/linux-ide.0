From: Valdis Kletnieks <Valdis.Kletnieks@vt.edu>
Subject: [PATCH] silence warning in drivers/ata/libata-scsi.c when building W=1
Date: Sun, 31 Jul 2016 23:28:34 -0400
Message-ID: <8997.1470022114@turing-police.cc.vt.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outbound.smtp.vt.edu ([198.82.183.121]:47506 "EHLO
	omr1.cc.vt.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750767AbcHADnW (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 31 Jul 2016 23:43:22 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

When building with W=1, we get these warnings:

drivers/ata/libata-scsi.c: In function 'ata_mselect_caching':
drivers/ata/libata-scsi.c:3637:28: warning: suggest parentheses around comparison in operand of '&' [-Wparentheses]
    if (mpage[i + 2] & 0xfb != buf[i] & 0xfb) {
                       ~~~~~^~~~~~~~~
drivers/ata/libata-scsi.c: In function 'ata_mselect_control':
drivers/ata/libata-scsi.c:3702:28: warning: suggest parentheses around comparison in operand of '&' [-Wparentheses]
    if (mpage[i + 2] & 0xfb != buf[i] & 0xfb) {
                       ~~~~~^~~~~~~~~

So give them the extra () and make things a bit clearer for both the
compiler and programmer...

Signed-off-by: Valdis Kletnieks <valdis.kletnieks@vt.edu>

diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index fa9d16fe295c..8ad4b237f342 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -3634,7 +3634,7 @@ static int ata_mselect_caching(struct ata_queued_cmd *qc,
 		/* Check the first byte */
 		if (i == 0) {
 			/* except the WCE bit */
-			if (mpage[i + 2] & 0xfb != buf[i] & 0xfb) {
+			if ((mpage[i + 2] & 0xfb) != (buf[i] & 0xfb)) {
 				*fp = i;
 				return -EINVAL;
 			} else {
@@ -3699,7 +3699,7 @@ static int ata_mselect_control(struct ata_queued_cmd *qc,
 		/* Check the first byte */
 		if (i == 0) {
 			/* except the D_SENSE bit */
-			if (mpage[i + 2] & 0xfb != buf[i] & 0xfb) {
+			if ((mpage[i + 2] & 0xfb) != (buf[i] & 0xfb)) {
 				*fp = i;
 				return -EINVAL;
 			} else {


