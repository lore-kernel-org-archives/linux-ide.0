From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 10/12] libata-pmp-prep: implement EH fast-fail path
Date: Sun, 23 Sep 2007 13:14:13 +0900
Message-ID: <11905208533707-git-send-email-htejun@gmail.com>
References: <11905208513747-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.181]:64232 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752668AbXIWEOb (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 23 Sep 2007 00:14:31 -0400
Received: by wa-out-1112.google.com with SMTP id v27so1545902wah
        for <linux-ide@vger.kernel.org>; Sat, 22 Sep 2007 21:14:31 -0700 (PDT)
In-Reply-To: <11905208513747-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org, alan@lxorguk.ukuu.org.uk, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

If PMP itself becomes inaccessible while trying to link a downstream
link, spending time to recover the downstream link doesn't make any
sense.  Make EH skip retry and fail fast if -ERESTART is received.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 drivers/ata/libata-eh.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index fbbf791..3c31e10 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -2050,7 +2050,7 @@ int ata_eh_reset(struct ata_link *link, int classify,
 	if (rc == -EAGAIN)
 		rc = 0;
 
-	if (rc && try < ARRAY_SIZE(ata_eh_reset_timeouts)) {
+	if (rc && rc != -ERESTART && try < ARRAY_SIZE(ata_eh_reset_timeouts)) {
 		unsigned long now = jiffies;
 
 		if (time_before(now, deadline)) {
-- 
1.5.0.3


