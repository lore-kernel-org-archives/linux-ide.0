From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH Linux 2.6.12 09/09] NCQ: causes error or timeout
Date: Mon, 27 Jun 2005 00:21:53 +0900 (KST)
Message-ID: <20050626152106.8E066207@htj.dyndns.org>
References: <20050626152105.D86561FB@htj.dyndns.org>
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.207]:58973 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261325AbVFZPV5 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 26 Jun 2005 11:21:57 -0400
Received: by zproxy.gmail.com with SMTP id 14so89251nzn
        for <linux-ide@vger.kernel.org>; Sun, 26 Jun 2005 08:21:57 -0700 (PDT)
In-Reply-To: <20050626152105.D86561FB@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, axboe@suse.de, linux-ide@vger.kernel.org

09_NCQ_ahci-debug.patch

	This is what I've used for testing EH.  This patch contains
	codes for corrupting or skipping specific tags causing error
	conditions.  If you're curious....

Signed-off-by: Tejun Heo <htejun@gmail.com>

 ahci.c |   34 ++++++++++++++++++++++++++++++++++
 1 files changed, 34 insertions(+)

Index: work/drivers/scsi/ahci.c
===================================================================
--- work.orig/drivers/scsi/ahci.c	2005-06-27 00:20:31.000000000 +0900
+++ work/drivers/scsi/ahci.c	2005-06-27 00:20:32.000000000 +0900
@@ -696,11 +696,45 @@ static int ahci_qc_issue(struct ata_queu
 	void *port_mmio = (void *) ap->ioaddr.cmd_addr;
 	unsigned int tag = ata_qc_to_tag(qc);
 
+#if 0
+	if (tag == 3) {
+		struct ahci_port_priv *pp = qc->ap->private_data;
+		int offset = tag * AHCI_CMD_TOTAL;
+		u8 *fis = pp->cmd_tbl + offset;
+		printk("AHCI: FAILING %02u: %08x %08x %08x %08x %08x\n",
+		       tag, ((unsigned *)fis)[0],
+		       ((unsigned *)fis)[1], ((unsigned *)fis)[2],
+		       ((unsigned *)fis)[3], ((unsigned *)fis)[4]);
+		fis[4] = 0xff;
+		fis[5] = 0xff;
+		fis[6] = 0xff;
+		fis[8] = 0xff;
+		fis[9] = 0xff;
+		fis[10] = 0xff;
+	}
+#endif
+
+#if 1
+	{
+		struct ahci_port_priv *pp = qc->ap->private_data;
+		unsigned *fis = pp->cmd_tbl + (tag * AHCI_CMD_TOTAL);
+		printk("AHCI: FIS(tag%02u): %08x %08x %08x %08x %08x\n",
+		   tag, fis[0], fis[1], fis[2], fis[3], fis[4]);
+	}
+#endif
+
 	if (qc->flags & ATA_QCFLAG_NCQ) {
 		writel(1 << tag, port_mmio + PORT_SCR_ACT);
 		readl(port_mmio + PORT_SCR_ACT);
 	}
 
+#if 1
+	if (tag == 3) {
+		printk("AHCI: SKIPPING %02u\n", tag);
+		return 0;
+	}
+#endif
+
 	writel(1 << tag, port_mmio + PORT_CMD_ISSUE);
 	readl(port_mmio + PORT_CMD_ISSUE);	/* flush */
 

