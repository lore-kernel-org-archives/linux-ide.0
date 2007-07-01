From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 10/12] libata-pmp-prep: implement EH fast-fail path
Date: Sun, 1 Jul 2007 19:26:09 +0900
Message-ID: <11832855693162-git-send-email-htejun@gmail.com>
References: <11832855672398-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.179]:24640 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755837AbXGAK0Q (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 1 Jul 2007 06:26:16 -0400
Received: by wa-out-1112.google.com with SMTP id v27so1884682wah
        for <linux-ide@vger.kernel.org>; Sun, 01 Jul 2007 03:26:16 -0700 (PDT)
In-Reply-To: <11832855672398-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org, Forrest Zhao <forrest.zhao@gmail.com>
Cc: Tejun Heo <htejun@gmail.com>

If PMP itself becomes inaccessible while trying to link a downstream
link, spending time to recover the downstream link doesn't make any
sense.  Make EH skip retry and fail fast if -ERESTART is received.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 drivers/ata/libata-eh.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index 0a60105..f4dae06 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -1912,7 +1912,7 @@ int ata_eh_reset(struct ata_link *link, int classify,
 	if (rc == -EAGAIN)
 		rc = 0;
 
-	if (rc && try < ARRAY_SIZE(ata_eh_reset_timeouts)) {
+	if (rc && rc != -ERESTART && try < ARRAY_SIZE(ata_eh_reset_timeouts)) {
 		unsigned long now = jiffies;
 
 		if (time_before(now, deadline)) {
-- 
1.5.0.3


