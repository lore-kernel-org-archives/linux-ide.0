From: Tejun Heo <tj@kernel.org>
Subject: [PATCH 7/8] libata: add no penalty retry request for EH device handling routines
Date: Thu, 29 Jan 2009 20:31:35 +0900
Message-ID: <1233228696-10562-8-git-send-email-tj@kernel.org>
References: <1233228696-10562-1-git-send-email-tj@kernel.org>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:34107 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752937AbZA2LcF (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 29 Jan 2009 06:32:05 -0500
In-Reply-To: <1233228696-10562-1-git-send-email-tj@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org, linux-ide@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>

Let -EAGAIN from EH device handling routines trigger EH retry without
consuming its tries count.  This will be used to implement link SPD
horkage which requires hardreset to adjust SPD without affecting other
EH decisions.  As it bypasses the forward progress guarantee provided
by the tries count, the requester is responsible for ensuring forward
progress.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 drivers/ata/libata-eh.c |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index caa1e9f..ce2ef04 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -3035,7 +3035,11 @@ static int ata_eh_handle_dev_fail(struct ata_device *dev, int err)
 {
 	struct ata_eh_context *ehc = &dev->link->eh_context;
 
-	ehc->tries[dev->devno]--;
+	/* -EAGAIN from EH routine indicates retry without prejudice.
+	 * The requester is responsible for ensuring forward progress.
+	 */
+	if (err != -EAGAIN)
+		ehc->tries[dev->devno]--;
 
 	switch (err) {
 	case -ENODEV:
-- 
1.6.0.2

