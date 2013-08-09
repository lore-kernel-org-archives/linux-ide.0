From: Jingoo Han <jg1.han@samsung.com>
Subject: [PATCH 2/2] ata: pata_samsung_cf: add missing __iomem annotation
Date: Fri, 09 Aug 2013 14:35:57 +0900
Message-ID: <000101ce94c2$52ad79f0$f8086dd0$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:9808 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933343Ab3HIFf7 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 9 Aug 2013 01:35:59 -0400
Received: from epcpsbgr5.samsung.com
 (u145.gpu120.samsung.co.kr [203.254.230.145])
 by mailout4.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MR900KNL0VXYL40@mailout4.samsung.com> for
 linux-ide@vger.kernel.org; Fri, 09 Aug 2013 14:35:57 +0900 (KST)
Content-language: ko
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: 'Tejun Heo' <tj@kernel.org>
Cc: linux-ide@vger.kernel.org, Jingoo Han <jg1.han@samsung.com>

>From e15fc1811b2ce01358de00c34e4a69a52bb1e9c5 Mon Sep 17 00:00:00 2001
From: Jingoo Han <jg1.han@samsung.com>
Date: Fri, 9 Aug 2013 14:24:35 +0900
Subject: [PATCH 2/2] ata: pata_samsung_cf: add missing __iomem annotation

Added missing __iomem annotation and staticized local symbol
in order to fix the following sparse warnings:

drivers/ata/pata_samsung_cf.c:244:14: warning: symbol 'pata_s3c_data_xfer' was not declared. Should it be static?
drivers/ata/pata_samsung_cf.c:423:20: warning: incorrect type in argument 1 (different address spaces)
drivers/ata/pata_samsung_cf.c:423:20:    expected void const volatile [noderef] <asn:2>*addr
drivers/ata/pata_samsung_cf.c:423:20:    got void *
drivers/ata/pata_samsung_cf.c:425:9: warning: incorrect type in argument 2 (different address spaces)
drivers/ata/pata_samsung_cf.c:425:9:    expected void volatile [noderef] <asn:2>*addr
drivers/ata/pata_samsung_cf.c:425:9:    got void *
drivers/ata/pata_samsung_cf.c:448:37: warning: incorrect type in argument 1 (different address spaces)
drivers/ata/pata_samsung_cf.c:448:37:    expected void *s3c_ide_regbase
drivers/ata/pata_samsung_cf.c:448:37:    got void [noderef] <asn:2>*ide_addr
drivers/ata/pata_samsung_cf.c:463:37: warning: incorrect type in argument 1 (different address spaces)
drivers/ata/pata_samsung_cf.c:463:37:    expected void *s3c_ide_regbase
drivers/ata/pata_samsung_cf.c:463:37:    got void [noderef] <asn:2>*ide_addr

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
 drivers/ata/pata_samsung_cf.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/ata/pata_samsung_cf.c b/drivers/ata/pata_samsung_cf.c
index 951aa95..898e544 100644
--- a/drivers/ata/pata_samsung_cf.c
+++ b/drivers/ata/pata_samsung_cf.c
@@ -241,8 +241,8 @@ static u8 pata_s3c_check_altstatus(struct ata_port *ap)
 /*
  * pata_s3c_data_xfer - Transfer data by PIO
  */
-unsigned int pata_s3c_data_xfer(struct ata_device *dev, unsigned char *buf,
-				unsigned int buflen, int rw)
+static unsigned int pata_s3c_data_xfer(struct ata_device *dev,
+				unsigned char *buf, unsigned int buflen, int rw)
 {
 	struct ata_port *ap = dev->link->ap;
 	struct s3c_ide_info *info = ap->host->private_data;
@@ -418,7 +418,7 @@ static struct ata_port_operations pata_s5p_port_ops = {
 	.set_piomode		= pata_s3c_set_piomode,
 };
 
-static void pata_s3c_enable(void *s3c_ide_regbase, bool state)
+static void pata_s3c_enable(void __iomem *s3c_ide_regbase, bool state)
 {
 	u32 temp = readl(s3c_ide_regbase + S3C_ATA_CTRL);
 	temp = state ? (temp | 1) : (temp & ~1);
-- 
1.7.10.4


