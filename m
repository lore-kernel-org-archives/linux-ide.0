From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 2/6] libata: unexport ata_dev_revalidate()
Date: Sat, 30 Sep 2006 15:46:49 +0900
Message-ID: <11595988092784-git-send-email-htejun@gmail.com>
References: <11595988092938-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wx-out-0506.google.com ([66.249.82.238]:990 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751084AbWI3Gq4 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 30 Sep 2006 02:46:56 -0400
Received: by wx-out-0506.google.com with SMTP id s14so1162646wxc
        for <linux-ide@vger.kernel.org>; Fri, 29 Sep 2006 23:46:55 -0700 (PDT)
In-Reply-To: <11595988092938-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: nabiki@teleline.es, kaos@ocs.com.au, stevenm@umd.edu, jfs@keytradebank.com, 0602@eq.cz, jgarzik@pobox.com, akpm@osdl.org, alan@lxorguk.ukuu.org.uk, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

ata_dev_revalidate() isn't used outside of libata core.  Unexport it.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 drivers/ata/libata-core.c |    1 -
 drivers/ata/libata.h      |    1 +
 include/linux/libata.h    |    1 -
 3 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 7ab45f4..6cbb5e7 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -6119,7 +6119,6 @@ EXPORT_SYMBOL_GPL(ata_std_prereset);
 EXPORT_SYMBOL_GPL(ata_std_softreset);
 EXPORT_SYMBOL_GPL(sata_std_hardreset);
 EXPORT_SYMBOL_GPL(ata_std_postreset);
-EXPORT_SYMBOL_GPL(ata_dev_revalidate);
 EXPORT_SYMBOL_GPL(ata_dev_classify);
 EXPORT_SYMBOL_GPL(ata_dev_pair);
 EXPORT_SYMBOL_GPL(ata_port_disable);
diff --git a/drivers/ata/libata.h b/drivers/ata/libata.h
index a5ecb71..0ed263b 100644
--- a/drivers/ata/libata.h
+++ b/drivers/ata/libata.h
@@ -53,6 +53,7 @@ extern unsigned ata_exec_internal(struct
 extern unsigned int ata_do_simple_cmd(struct ata_device *dev, u8 cmd);
 extern int ata_dev_read_id(struct ata_device *dev, unsigned int *p_class,
 			   int post_reset, u16 *id);
+extern int ata_dev_revalidate(struct ata_device *dev, int post_reset);
 extern int ata_dev_configure(struct ata_device *dev, int print_info);
 extern int sata_down_spd_limit(struct ata_port *ap);
 extern int sata_set_spd_needed(struct ata_port *ap);
diff --git a/include/linux/libata.h b/include/linux/libata.h
index df44b09..0cd6699 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -701,7 +701,6 @@ extern int ata_std_prereset(struct ata_p
 extern int ata_std_softreset(struct ata_port *ap, unsigned int *classes);
 extern int sata_std_hardreset(struct ata_port *ap, unsigned int *class);
 extern void ata_std_postreset(struct ata_port *ap, unsigned int *classes);
-extern int ata_dev_revalidate(struct ata_device *dev, int post_reset);
 extern void ata_port_disable(struct ata_port *);
 extern void ata_std_ports(struct ata_ioports *ioaddr);
 #ifdef CONFIG_PCI
-- 
1.4.2.1


