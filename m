Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 917CA3932D1
	for <linux-ide@vger.kernel.org>; Mon, 29 Jun 2026 06:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782713250; cv=none; b=mbbPdVrEE4An+g5eaIsNpIfTftrWdoFg/nsov+jwW9F5ERwYxfjDd0ZSK6JeP4tdIr2xV510ahMhu5Q+N3E3L9zoPGdBkjX8WyIpQQwIiwyQ9lSEBkpMZ9Qe6eKBeOrlxsWToewPbK+ZiF4ay6NiBqETx7YkdrI3kwBa97ybPcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782713250; c=relaxed/simple;
	bh=+Igh/SLaeEIjqhSAggmBu2BVUEJWPunVeTlrW7Nx9z4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f8suwXv11ZBIMq61CqmW9yPWnGz47jdGuh/HuZeYTDMAh7O6kF4DtdzZ1hlW1fUqfDJ0wlGNXsWe2mg9uJ/ORAQxEKiyVTdlyvmrXgvIz27C1Iz2Nn1kpf5EAhbsOS1Hcuhv9miZA8G+ObKJnrFhrlZ6c7+pSox0+EKHyqBPNF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=azVGE2xB; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=JmGcK++F; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="azVGE2xB";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="JmGcK++F"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E4CF975D16;
	Mon, 29 Jun 2026 06:07:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1782713247; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UvrsgseWc++glwG1FMlvUuKroqd6hagpxKUlH2ks3iI=;
	b=azVGE2xBzcLU38l6BnISf09tEVm7JULv2ZGFCA6k4z9aTEe51YzRxcspx4l2Kwh5B6R0yu
	WD4Ng/5rIWRyc6Pme6Ud2ujV6dWNffNT8Kkxy42TpwV+VJ7DzhtTWxOVq/B+u3Ba7iLj1x
	HLyld/DZiJxlZQOV6EYgkN8edHAUl7w=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1782713245; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UvrsgseWc++glwG1FMlvUuKroqd6hagpxKUlH2ks3iI=;
	b=JmGcK++F+NV744zSgyE9VJbC+H2at0eEvmwWVnU9iTJ66d8/2wB6w+sWE3aITpPkXzIv9+
	n5RkDAQPcZiBXBqYoMmeJtgTQ6JGa0jrR2+qqyVxRqgYqh/dPsHuuW6Fq4soZdpcsftPxi
	uyA7bsMsPZIs1DJozhk46Gk7b/ikeus=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B41BC779A8;
	Mon, 29 Jun 2026 06:07:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ufmNKp0LQmpHEwAAD6G6ig
	(envelope-from <jgross@suse.com>); Mon, 29 Jun 2026 06:07:25 +0000
From: Juergen Gross <jgross@suse.com>
To: linux-kernel@vger.kernel.org,
	linux-ide@vger.kernel.org
Cc: Juergen Gross <jgross@suse.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>
Subject: [PATCH 20/32] drivers/ata: Stop using 32-bit MSR interfaces
Date: Mon, 29 Jun 2026 08:05:11 +0200
Message-ID: <20260629060526.3638272-21-jgross@suse.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260629060526.3638272-1-jgross@suse.com>
References: <20260629060526.3638272-1-jgross@suse.com>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spamd-Result: default: False [-6.80 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_HAS_DN(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:mid,imap1.dmz-prg2.suse.org:helo];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Level: 
X-Spam-Score: -6.80

The 32-bit MSR interfaces rdmsr() and wrmsr() are planned to be
removed. Use the related 64-bit variants instead.

In drivers/ata/pata_cs5536.c don't redefine rdmsr() and wrmsr() as
empty macros for avoiding misuse, but guard the affected code via

Signed-off-by: Juergen Gross <jgross@suse.com>
---
 drivers/ata/pata_cs5535.c | 20 ++++++++++----------
 drivers/ata/pata_cs5536.c | 17 ++++++++---------
 2 files changed, 18 insertions(+), 19 deletions(-)

diff --git a/drivers/ata/pata_cs5535.c b/drivers/ata/pata_cs5535.c
index d793fc441b46..da98390cc49e 100644
--- a/drivers/ata/pata_cs5535.c
+++ b/drivers/ata/pata_cs5535.c
@@ -90,7 +90,7 @@ static void cs5535_set_piomode(struct ata_port *ap, struct ata_device *adev)
 	static const u16 pio_cmd_timings[5] = {
 		0xF7F4, 0x53F3, 0x13F1, 0x5131, 0x1131
 	};
-	u32 reg, __maybe_unused dummy;
+	u32 reg;
 	struct ata_device *pair = ata_dev_pair(adev);
 
 	int mode = adev->pio_mode - XFER_PIO_0;
@@ -102,16 +102,16 @@ static void cs5535_set_piomode(struct ata_port *ap, struct ata_device *adev)
 		cmdmode = min(mode, pairmode);
 		/* Write the other drive timing register if it changed */
 		if (cmdmode < pairmode)
-			wrmsr(ATAC_CH0D0_PIO + 2 * pair->devno,
-				pio_cmd_timings[cmdmode] << 16 | pio_timings[pairmode], 0);
+			wrmsrq(ATAC_CH0D0_PIO + 2 * pair->devno,
+				pio_cmd_timings[cmdmode] << 16 | pio_timings[pairmode]);
 	}
 	/* Write the drive timing register */
-	wrmsr(ATAC_CH0D0_PIO + 2 * adev->devno,
-		pio_cmd_timings[cmdmode] << 16 | pio_timings[mode], 0);
+	wrmsrq(ATAC_CH0D0_PIO + 2 * adev->devno,
+		pio_cmd_timings[cmdmode] << 16 | pio_timings[mode]);
 
 	/* Set the PIO "format 1" bit in the DMA timing register */
-	rdmsr(ATAC_CH0D0_DMA + 2 * adev->devno, reg, dummy);
-	wrmsr(ATAC_CH0D0_DMA + 2 * adev->devno, reg | 0x80000000UL, 0);
+	rdmsrq(ATAC_CH0D0_DMA + 2 * adev->devno, reg);
+	wrmsrq(ATAC_CH0D0_DMA + 2 * adev->devno, reg | 0x80000000UL);
 }
 
 /**
@@ -129,16 +129,16 @@ static void cs5535_set_dmamode(struct ata_port *ap, struct ata_device *adev)
 	static const u32 mwdma_timings[3] = {
 		0x7F0FFFF3, 0x7F035352, 0x7F024241
 	};
-	u32 reg, __maybe_unused dummy;
+	u32 reg;
 	int mode = adev->dma_mode;
 
-	rdmsr(ATAC_CH0D0_DMA + 2 * adev->devno, reg, dummy);
+	rdmsrq(ATAC_CH0D0_DMA + 2 * adev->devno, reg);
 	reg &= 0x80000000UL;
 	if (mode >= XFER_UDMA_0)
 		reg |= udma_timings[mode - XFER_UDMA_0];
 	else
 		reg |= mwdma_timings[mode - XFER_MW_DMA_0];
-	wrmsr(ATAC_CH0D0_DMA + 2 * adev->devno, reg, 0);
+	wrmsrq(ATAC_CH0D0_DMA + 2 * adev->devno, reg);
 }
 
 static const struct scsi_host_template cs5535_sht = {
diff --git a/drivers/ata/pata_cs5536.c b/drivers/ata/pata_cs5536.c
index 73e81e160c91..61d232a82b5e 100644
--- a/drivers/ata/pata_cs5536.c
+++ b/drivers/ata/pata_cs5536.c
@@ -32,11 +32,8 @@
 static int use_msr;
 module_param_named(msr, use_msr, int, 0644);
 MODULE_PARM_DESC(msr, "Force using MSR to configure IDE function (Default: 0)");
+#define MAYBE_USE_MSR
 #else
-#undef rdmsr	/* avoid accidental MSR usage on, e.g. x86-64 */
-#undef wrmsr
-#define rdmsr(x, y, z) do { } while (0)
-#define wrmsr(x, y, z) do { } while (0)
 #define use_msr 0
 #endif
 
@@ -85,22 +82,24 @@ static const struct dmi_system_id udma_quirk_dmi_table[] = {
 
 static int cs5536_read(struct pci_dev *pdev, int reg, u32 *val)
 {
+#ifdef MAYBE_USE_MSR
 	if (unlikely(use_msr)) {
-		u32 dummy __maybe_unused;
-
-		rdmsr(MSR_IDE_CFG + reg, *val, dummy);
+		rdmsrq(MSR_IDE_CFG + reg, *val);
 		return 0;
 	}
+#endif
 
 	return pci_read_config_dword(pdev, PCI_IDE_CFG + reg * 4, val);
 }
 
-static int cs5536_write(struct pci_dev *pdev, int reg, int val)
+static int cs5536_write(struct pci_dev *pdev, int reg, u32 val)
 {
+#ifdef MAYBE_USE_MSR
 	if (unlikely(use_msr)) {
-		wrmsr(MSR_IDE_CFG + reg, val, 0);
+		wrmsrq(MSR_IDE_CFG + reg, val);
 		return 0;
 	}
+#endif
 
 	return pci_write_config_dword(pdev, PCI_IDE_CFG + reg * 4, val);
 }
-- 
2.54.0

