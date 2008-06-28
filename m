From: "Darren Jenkins\\" <darrenrjenkins@gmail.com>
Subject: [PATCH] drivers/ide/ide-tape.c: remove double kfree
Date: Sun, 29 Jun 2008 08:34:34 +1000
Message-ID: <1214692474.8254.22.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.172]:34099 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754441AbYF2KWT (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 29 Jun 2008 06:22:19 -0400
Received: by wf-out-1314.google.com with SMTP id 27so1093289wfd.4
        for <linux-ide@vger.kernel.org>; Sun, 29 Jun 2008 03:22:18 -0700 (PDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: kernel Janitors <kernel-janitors@lists.osdl.org>, LKML <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org, gadio@netvision.net.il

G'day people,


Coverity CID: 2336 USE_AFTER_FREE

drivers/ide/ide-tape.c ide_tape_kfree_buffer() double free's a pointer
(hint freed by an alias in first outer loop).
This patch simply removes the superfluous kfree().



Signed-off-by: Darren Jenkins <darrenrjenkins@gmailcom>


diff --git a/drivers/ide/ide-tape.c b/drivers/ide/ide-tape.c
index 1e1f263..86164be 100644
--- a/drivers/ide/ide-tape.c
+++ b/drivers/ide/ide-tape.c
@@ -600,7 +600,6 @@ static void ide_tape_kfree_buffer(idetape_tape_t *tape)
 		bh = bh->b_reqnext;
 		kfree(prev_bh);
 	}
-	kfree(tape->merge_bh);
 }
 
 static int idetape_end_request(ide_drive_t *drive, int uptodate, int nr_sects)


