From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH libata-dev-2.6:ncq+ncq helpers] sata_sil24 debug stuff
Date: Wed, 13 Jul 2005 12:32:20 +0900
Message-ID: <20050713033220.GB9349@htj.dyndns.org>
References: <20050713033101.GA9349@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.201]:60110 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262534AbVGMDcZ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 12 Jul 2005 23:32:25 -0400
Received: by zproxy.gmail.com with SMTP id o37so52812nzf
        for <linux-ide@vger.kernel.org>; Tue, 12 Jul 2005 20:32:24 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20050713033101.GA9349@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org

 As usual, error trigger and debug message patch.

diff --git a/drivers/scsi/sata_sil24.c b/drivers/scsi/sata_sil24.c
--- a/drivers/scsi/sata_sil24.c
+++ b/drivers/scsi/sata_sil24.c
@@ -421,6 +421,46 @@ static int sil24_qc_issue(struct ata_que
 	struct sil24_port_priv *pp = ap->private_data;
 	dma_addr_t paddr = pp->cmd_block_dma + qc->tag * sizeof(*pp->cmd_block);
 
+#if 0
+	static unsigned err_cnt;
+	err_cnt++;
+	if (err_cnt > 500 && err_cnt % 30 == 0) {
+		struct sil24_cmd_block *cb = pp->cmd_block + qc->tag;
+		struct sil24_prb *prb = &cb->prb;
+		u8 *fis = prb->fis;
+		printk("SIL24%u: FAILING %p: %08x %08x %08x %08x %08x\n",
+		       ap->id, qc->scsicmd,
+		       ((unsigned *)fis)[0], ((unsigned *)fis)[1],
+		       ((unsigned *)fis)[2], ((unsigned *)fis)[3],
+		       ((unsigned *)fis)[4]);
+		fis[4] = 0xff;
+		fis[5] = 0xff;
+		fis[6] = 0xff;
+		fis[8] = 0xff;
+		fis[9] = 0xff;
+		fis[10] = 0xff;
+	}
+#endif
+
+#if 0
+	{
+		struct sil24_cmd_block *cb = pp->cmd_block + qc->tag;
+		struct sil24_prb *prb = &cb->prb;
+		u32 *fis = (u32 *)prb->fis;
+		printk("SIL24%u: FIS %p: %08x %08x %08x %08x %08x\n",
+		       ap->id, qc->scsicmd,
+		       fis[0], fis[1], fis[2], fis[3], fis[4]);
+	}
+#endif
+
+#if 1
+	static unsigned skip_cnt;
+	skip_cnt++;
+	if (skip_cnt > 500 && skip_cnt % 100 == 0) {
+		printk("AHCI: SKIPPING %02u\n", qc->tag);
+		return 0;
+	}
+#endif
 	writel((u32)paddr, pp->port + PORT_CMD_ACTIVATE);
 	return 0;
 }
