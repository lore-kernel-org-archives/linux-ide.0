From: Tejun Heo <tj@kernel.org>
Subject: [PATCH libata/for-4.12-fixes] libata: fix error checking in in
 ata_parse_force_one()
Date: Wed, 31 May 2017 14:31:40 -0400
Message-ID: <20170531183140.GB4795@htj.duckdns.org>
References: <CAKHFTdOvzO7W_NsDhqHVTN=FQCpuT61zXFjNRQ8y0YfTx1CY6Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yb0-f195.google.com ([209.85.213.195]:34273 "EHLO
        mail-yb0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751034AbdEaSbm (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 31 May 2017 14:31:42 -0400
Received: by mail-yb0-f195.google.com with SMTP id o185so747747yba.1
        for <linux-ide@vger.kernel.org>; Wed, 31 May 2017 11:31:42 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAKHFTdOvzO7W_NsDhqHVTN=FQCpuT61zXFjNRQ8y0YfTx1CY6Q@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Petru Mihancea <petrum@gmail.com>
Cc: linux-ide@vger.kernel.org

>From f7cf69ae171592d133c69b9adaa5de7cfb6038ea Mon Sep 17 00:00:00 2001
From: Tejun Heo <tj@kernel.org>
Date: Wed, 31 May 2017 14:26:26 -0400

ata_parse_force_one() was incorrectly comparing @p to @endp when it
should have been comparing @id.  The only consequence is that it may
end up using an invalid port number in "libata.force" module param
instead of rejecting it.

Signed-off-by: Tejun Heo <tj@kernel.org>
Reported-by: Petru-Florin Mihancea <petrum@gmail.com>
Link: https://bugzilla.kernel.org/show_bug.cgi?id=195785
---
Applied to libata/for-4.12-fixes.  Thanks.

 drivers/ata/libata-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 2d83b8c75965..e157a0e44419 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -6800,7 +6800,7 @@ static int __init ata_parse_force_one(char **cur,
 	}
 
 	force_ent->port = simple_strtoul(id, &endp, 10);
-	if (p == endp || *endp != '\0') {
+	if (id == endp || *endp != '\0') {
 		*reason = "invalid port/link";
 		return -EINVAL;
 	}
-- 
2.13.0

