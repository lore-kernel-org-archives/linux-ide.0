From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH] ahci: fix endianness in spurious interrupt message
Date: Fri, 26 Jan 2007 14:47:38 +0900
Message-ID: <20070126054738.GE8606@htj.dyndns.org>
References: <20070115090117.GL10987@htj.dyndns.org> <20070116065239.GO10987@htj.dyndns.org> <45B806DA.1050107@pobox.com> <45B8626B.9090002@gmail.com> <20070125101628.GA8606@htj.dyndns.org> <45B961C4.10404@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.232]:65105 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030776AbXAZFro (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 26 Jan 2007 00:47:44 -0500
Received: by nz-out-0506.google.com with SMTP id s1so613943nze
        for <linux-ide@vger.kernel.org>; Thu, 25 Jan 2007 21:47:43 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <45B961C4.10404@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org

Fix endianness in spurious interrupt message.

Signed-off-by: Tejun Heo <htejun@gmail.com>

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index 2fe5a58..d8f0ce9 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -1178,7 +1178,8 @@ static void ahci_host_intr(struct ata_port *ap)
 		ata_port_printk(ap, KERN_INFO, "Spurious SDB FIS during NCQ "
 				"issue=0x%x SAct=0x%x FIS=%08x:%08x%s\n",
 				readl(port_mmio + PORT_CMD_ISSUE),
-				readl(port_mmio + PORT_SCR_ACT), f[0], f[1],
+				readl(port_mmio + PORT_SCR_ACT),
+				le32_to_cpu(f[0]), le32_to_cpu(f[1]),
 				pp->ncq_saw_spurious_sdb_cnt < 10 ?
 				"" : ", shutting up");
 
