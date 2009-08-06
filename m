From: akpm@linux-foundation.org
Subject: [patch 2/2] drivers/ata: introduce missing kfree
Date: Thu, 06 Aug 2009 16:05:09 -0700
Message-ID: <200908062305.n76N59jW004244@imap1.linux-foundation.org>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:33728 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756878AbZHFXHk (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 6 Aug 2009 19:07:40 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org
Cc: linux-ide@vger.kernel.org, akpm@linux-foundation.org, julia@diku.dk, tj@kernel.org

From: Julia Lawall <julia@diku.dk>

Error handling code following a kzalloc should free the allocated data.

The semantic match that finds the problem is as follows:
(http://www.emn.fr/x-info/coccinelle/)

// <smpl>
@r exists@
local idexpression x;
statement S;
expression E;
identifier f,f1,l;
position p1,p2;
expression *ptr != NULL;
@@

x@p1 = \(kmalloc\|kzalloc\|kcalloc\)(...);
...
if (x == NULL) S
<... when != x
     when != if (...) { <+...x...+> }
(
x->f1 = E
|
 (x->f1 == NULL || ...)
|
 f(...,x->f1,...)
)
...>
(
 return \(0\|<+...x...+>\|ptr\);
|
 return@p2 ...;
)

@script:python@
p1 << r.p1;
p2 << r.p2;
@@

print "* file: %s kmalloc %s return %s" % (p1[0].file,p1[0].line,p2[0].line)
// </smpl>

Signed-off-by: Julia Lawall <julia@diku.dk>
Cc: Jeff Garzik <jeff@garzik.org>
Cc: Tejun Heo <tj@kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/ata/pata_at91.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff -puN drivers/ata/pata_at91.c~drivers-ata-introduce-missing-kfree drivers/ata/pata_at91.c
--- a/drivers/ata/pata_at91.c~drivers-ata-introduce-missing-kfree
+++ a/drivers/ata/pata_at91.c
@@ -261,7 +261,8 @@ static int __devinit pata_at91_probe(str
 
 	if (IS_ERR(info->mck)) {
 		dev_err(dev, "failed to get access to mck clock\n");
-		return -ENODEV;
+		ret = -ENODEV;
+		goto err_clk_get;
 	}
 
 	info->cs    = board->chipselect;
@@ -308,6 +309,7 @@ err_alt_ioremap:
 
 err_ide_ioremap:
 	clk_put(info->mck);
+err_clk_get:
 	kfree(info);
 
 	return ret;
_
