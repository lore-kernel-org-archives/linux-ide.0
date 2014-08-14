From: Himangi Saraogi <himangi774@gmail.com>
Subject: [PATCH] Drivers: ide: Remove typedef atiixp_ide_timing
Date: Thu, 14 Aug 2014 22:14:30 +0530
Message-ID: <20140814164430.GA4237@himangi-Dell>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pa0-f52.google.com ([209.85.220.52]:47965 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752936AbaHNQoh (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 14 Aug 2014 12:44:37 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "David S. Miller" <davem@davemloft.net>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Julia Lawall <julia.lawall@lip6.fr>

The Linux kernel coding style guidelines suggest not using typedefs
for structure types. This patch gets rid of the typedef for
atiixp_ide_timing.

The following Coccinelle semantic patch detects the case:

@tn1@
type td;
@@

typedef struct { ... } td;

@script:python tf@
td << tn1.td;
tdres;
@@

coccinelle.tdres = td;

@@
type tn1.td;
identifier tf.tdres;
@@

-typedef
 struct
+  tdres
   { ... }
-td
 ;

@@
type tn1.td;
identifier tf.tdres;
@@

-td
+ struct tdres

Signed-off-by: Himangi Saraogi <himangi774@gmail.com>
Acked-by: Julia Lawall <julia.lawall@lip6.fr>
---
 drivers/ide/atiixp.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/ide/atiixp.c b/drivers/ide/atiixp.c
index dbd0f24..76650e9 100644
--- a/drivers/ide/atiixp.c
+++ b/drivers/ide/atiixp.c
@@ -19,12 +19,12 @@
 #define ATIIXP_IDE_UDMA_CONTROL		0x54
 #define ATIIXP_IDE_UDMA_MODE		0x56
 
-typedef struct {
+struct atiixp_ide_timing {
 	u8 command_width;
 	u8 recover_width;
-} atiixp_ide_timing;
+};
 
-static atiixp_ide_timing pio_timing[] = {
+static struct atiixp_ide_timing pio_timing[] = {
 	{ 0x05, 0x0d },
 	{ 0x04, 0x07 },
 	{ 0x03, 0x04 },
@@ -32,7 +32,7 @@ static atiixp_ide_timing pio_timing[] = {
 	{ 0x02, 0x00 },
 };
 
-static atiixp_ide_timing mdma_timing[] = {
+static struct atiixp_ide_timing mdma_timing[] = {
 	{ 0x07, 0x07 },
 	{ 0x02, 0x01 },
 	{ 0x02, 0x00 },
-- 
1.9.1

