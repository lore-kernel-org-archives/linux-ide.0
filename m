From: Nicolas Kaiser <nikai@nikai.net>
Subject: [PATCH][TRIVIAL] drivers/ide: stray bracket
Date: Sat, 11 Nov 2006 01:47:56 +0100
Message-ID: <20061111014756.3467d7ee@lucky.kitzblitz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ensim03.ffm.m2soft.com ([195.38.20.12]:24271 "EHLO
	ensim03.ffm.m2soft.com") by vger.kernel.org with ESMTP
	id S1424469AbWKKAtx (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 10 Nov 2006 19:49:53 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: trivial@kernel.org, linux-kernel@vger.kernel.org

Stray bracket in debug code.

Signed-off-by: Nicolas Kaiser <nikai@nikai.net>
---

 drivers/ide/legacy/hd.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff -uprN a/drivers/ide/legacy/hd.c b/drivers/ide/legacy/hd.c
--- a/drivers/ide/legacy/hd.c	2006-09-20 05:42:06.000000000 +0200
+++ b/drivers/ide/legacy/hd.c	2006-11-10 21:52:20.000000000 +0100
@@ -459,7 +459,7 @@ ok_to_read:
 #ifdef DEBUG
 	printk("%s: read: sector %ld, remaining = %ld, buffer=%p\n",
 		req->rq_disk->disk_name, req->sector, req->nr_sectors,
-		req->buffer+512));
+		req->buffer+512);
 #endif
 	if (req->current_nr_sectors <= 0)
 		end_request(req, 1);
