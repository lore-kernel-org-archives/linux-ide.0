From: akpm@osdl.org
Subject: [patch 03/12] libata: unexport ata_dev_revalidate()
Date: Fri, 20 Oct 2006 14:39:37 -0700
Message-ID: <200610202139.k9KLdb5n003568@shell0.pdx.osdl.net>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.4]:44419 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S2992747AbWJTVko (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 20 Oct 2006 17:40:44 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org
Cc: linux-ide@vger.kernel.org, akpm@osdl.org, htejun@gmail.com

From: Tejun Heo <htejun@gmail.com>

ata_dev_revalidate() isn't used outside of libata core.  Unexport it.

Signed-off-by: Tejun Heo <htejun@gmail.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 drivers/ata/libata-core.c |    1 -
 drivers/ata/libata.h      |    1 +
 include/linux/libata.h    |    1 -
 3 files changed, 1 insertion(+), 2 deletions(-)

diff -puN drivers/ata/libata-core.c~libata-unexport-ata_dev_revalidate drivers/ata/libata-core.c
--- a/drivers/ata/libata-core.c~libata-unexport-ata_dev_revalidate
+++ a/drivers/ata/libata-core.c
@@ -6144,7 +6144,6 @@ EXPORT_SYMBOL_GPL(ata_std_prereset);
 EXPORT_SYMBOL_GPL(ata_std_softreset);
 EXPORT_SYMBOL_GPL(sata_std_hardreset);
 EXPORT_SYMBOL_GPL(ata_std_postreset);
-EXPORT_SYMBOL_GPL(ata_dev_revalidate);
 EXPORT_SYMBOL_GPL(ata_dev_classify);
 EXPORT_SYMBOL_GPL(ata_dev_pair);
 EXPORT_SYMBOL_GPL(ata_port_disable);
diff -puN drivers/ata/libata.h~libata-unexport-ata_dev_revalidate drivers/ata/libata.h
--- a/drivers/ata/libata.h~libata-unexport-ata_dev_revalidate
+++ a/drivers/ata/libata.h
@@ -54,6 +54,7 @@ extern unsigned ata_exec_internal(struct
 extern unsigned int ata_do_simple_cmd(struct ata_device *dev, u8 cmd);
 extern int ata_dev_read_id(struct ata_device *dev, unsigned int *p_class,
 			   int post_reset, u16 *id);
+extern int ata_dev_revalidate(struct ata_device *dev, int post_reset);
 extern int ata_dev_configure(struct ata_device *dev, int print_info);
 extern int sata_down_spd_limit(struct ata_port *ap);
 extern int sata_set_spd_needed(struct ata_port *ap);
diff -puN include/linux/libata.h~libata-unexport-ata_dev_revalidate include/linux/libata.h
--- a/include/linux/libata.h~libata-unexport-ata_dev_revalidate
+++ a/include/linux/libata.h
@@ -708,7 +708,6 @@ extern int ata_std_prereset(struct ata_p
 extern int ata_std_softreset(struct ata_port *ap, unsigned int *classes);
 extern int sata_std_hardreset(struct ata_port *ap, unsigned int *class);
 extern void ata_std_postreset(struct ata_port *ap, unsigned int *classes);
-extern int ata_dev_revalidate(struct ata_device *dev, int post_reset);
 extern void ata_port_disable(struct ata_port *);
 extern void ata_std_ports(struct ata_ioports *ioaddr);
 #ifdef CONFIG_PCI
_
