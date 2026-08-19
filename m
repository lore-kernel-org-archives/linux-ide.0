Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0754643C7DF;
	Wed, 19 Aug 2026 10:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787135033; cv=none; b=XES2hA9RnZBiT6N3eQiND67bYw4YaUvjX9P6C35Xyn+DOKGPBO1EJ+1egBnlmLElvfmU3U5N0+9S5NhPXowt74NOQuWW+T7mGuQRfIjnEfhFswdBZaYQdFrUa5eDKjJcZ2cw8sqnVk7+Zp1zoGnjSXBGxzJutD+nW8tfrU139LA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787135033; c=relaxed/simple;
	bh=8+66wLOI71kBFZbqPTRdHY2rrwJBSc2H+Np5THpttMo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aU+Q1VX0+gHHUxUAFxl9r3s4V8OjA+lIF5mgURG7K4ofAbFNzaVQwCYEyHoC4u4m03QaLtUZ206aboeFbUUg3d5LLv8juZNTI/qkhxAEXP4EIEF4YX8Mcp5Csr6q+FpmKz4Kw9y95tOkYFvb+S0rzDnvIkllndNMFUebqe150yU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=L+0OS4eC; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=m+QNYZ+b; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="L+0OS4eC";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="m+QNYZ+b"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E40FB84A7C;
	Wed, 19 Aug 2026 10:23:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1787135026; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JFFzEGA4ARY1hHgr3t1hQ7pY12twYhSvqFb5J/jkM4U=;
	b=L+0OS4eCoc5OLASBTGyzCbVr15SPsCFet8Eyue7tVM0OYbCC8fzHeGwhjLCbTDNO+HUwAa
	7x6NBy3cX9H+ngSqoIXQq+sHZmCsWL77NhsHbUnZc8BjENPotffbwqdMHHMsUUApft9T5g
	M5+S+yVd34ChnewMJPqsg52Wam58oQA=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1787135021; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JFFzEGA4ARY1hHgr3t1hQ7pY12twYhSvqFb5J/jkM4U=;
	b=m+QNYZ+by87xZ+2MXkFsFQ2U5j/G5L7rE/i8bjdG0lL7moI5qi3aF908roUhQWGelLTikU
	GaZE6FPh/cFfj5bAjOz2C9F/FcSoiWOu1n4bxrQGvzvxr2TdNTi0t4f8d5v6hwqpGZqkFt
	LSg9Urgt56+AuurBIBY99IA4OqKuzxo=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BE1BC2F81;
	Wed, 19 Aug 2026 10:23:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id XF81LS2EhWoyEgAAD6G6ig
	(envelope-from <jgross@suse.com>); Wed, 19 Aug 2026 10:23:41 +0000
From: Juergen Gross <jgross@suse.com>
To: linux-kernel@vger.kernel.org,
	linux-ide@vger.kernel.org
Cc: Juergen Gross <jgross@suse.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>
Subject: [PATCH v2 04/13] drivers/ata: Stop using 32-bit MSR interfaces
Date: Wed, 19 Aug 2026 12:23:05 +0200
Message-ID: <20260819102314.1499258-5-jgross@suse.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260819102314.1499258-1-jgross@suse.com>
References: <20260819102314.1499258-1-jgross@suse.com>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:mid,suse.com:email];
	FROM_EQ_ENVFROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Score: -6.80
X-Spam-Level: 

The 32-bit MSR interfaces rdmsr() and wrmsr() are planned to be
removed. Use the related 64-bit variants instead.

In drivers/ata/pata_cs5536.c don't redefine rdmsr() and wrmsr() as
empty macros for avoiding misuse, but guard the affected code via
a simple #ifdef.

Signed-off-by: Juergen Gross <jgross@suse.com>
---
V2:
- avoid sign extension when using wrmsrq() (Sashiko bot)
---
 drivers/ata/pata_cs5535.c | 20 ++++++++++----------
 drivers/ata/pata_cs5536.c | 17 ++++++++---------
 2 files changed, 18 insertions(+), 19 deletions(-)

diff --git a/drivers/ata/pata_cs5535.c b/drivers/ata/pata_cs5535.c
index d793fc441b46..e16c7f4c7c27 100644
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
+				(u32)pio_cmd_timings[cmdmode] << 16 | pio_timings[pairmode]);
 	}
 	/* Write the drive timing register */
-	wrmsr(ATAC_CH0D0_PIO + 2 * adev->devno,
-		pio_cmd_timings[cmdmode] << 16 | pio_timings[mode], 0);
+	wrmsrq(ATAC_CH0D0_PIO + 2 * adev->devno,
+		(u32)pio_cmd_timings[cmdmode] << 16 | pio_timings[mode]);
 
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
2.55.0

