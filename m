Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5AE3446049;
	Fri, 21 Aug 2026 09:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787303554; cv=none; b=dhCr0ePUL2F7COtT78dSQECB0Y795r6j16i1RYoQBPq1Hi4dakYyzp7twkRAm1b0DknWOX7ZtzxoSM7CETalTmks1tDPcpQvElxCgJifTEO4qDY/I5GghtVVU8DLfYS/8aTX7J8VFnvvwhw0g9wyqBiR4pVkG++hzBtmL6QregQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787303554; c=relaxed/simple;
	bh=VG92G7KeQBvuWK2Ab9bUbiLlBfErPymcFEuYd7g8+qg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IIuWBvU1JZyqEj5DRD7IfJbzd2tqeMnfm25xU4jLVIz5c6uHIdNqCUxIyvm6RsuZ9mNn0nIjjsGg+aplI/MidvmQEFBdZTGyD6pGxxSvgYCW+EDm05bWKfYOO07+XcxwHajX+S3s9ECI83lUsm+2HIcgYCQYkMr15xOzO6Ai7qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Nzf++DQd; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=ErnpUuCW; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Nzf++DQd";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="ErnpUuCW"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 351223EFB;
	Fri, 21 Aug 2026 09:12:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1787303538; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Gv3p80RRgnZ/KbDBd8WeweGrjOmJnrxy8aJFMYe3xfA=;
	b=Nzf++DQdXTWJKuG3r78YVjeQjHm05f3sINOa6bMyH8hCzHAAukwzToUeFSCPaHLjcDLKWi
	seNCNjr0+PQbUydSzFFUrVD9i244Ydt1DnSyFvnu9B/wAnCRVeVSFLIujXoLnJ594qAP5T
	4fqpZ1KnUiIDg4tvHkOzuDoGzu9BQLQ=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1787303534; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Gv3p80RRgnZ/KbDBd8WeweGrjOmJnrxy8aJFMYe3xfA=;
	b=ErnpUuCWPcnsYXDJqKR7cMgz/oAkZx86XbVNZH6FbZnLVOflQ0YmZap7dUcolKIWGOW7Lc
	1e0opSPzNq2nBsBvLzeiZD7H361MDx9ny+nMHJ69sX+HuuGJqE1GqlgxtyXiNrAul882xV
	Y+xqMGYuP/X4dIaXoH+s7kuijhzbdJA=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0EB9D26F8;
	Fri, 21 Aug 2026 09:12:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id VQRoAm4WiGrDGAAAD6G6ig
	(envelope-from <jgross@suse.com>); Fri, 21 Aug 2026 09:12:14 +0000
From: Juergen Gross <jgross@suse.com>
To: linux-kernel@vger.kernel.org,
	linux-ide@vger.kernel.org
Cc: Juergen Gross <jgross@suse.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>
Subject: [PATCH v3 04/13] drivers/ata: Stop using 32-bit MSR interfaces
Date: Fri, 21 Aug 2026 11:12:10 +0200
Message-ID: <20260821091210.1661197-1-jgross@suse.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260819102314.1499258-5-jgross@suse.com>
References: <20260819102314.1499258-5-jgross@suse.com>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -2.80
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_EQ_ENVFROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email,suse.com:mid];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_TLS_ALL(0.00)[]

The 32-bit MSR interfaces rdmsr() and wrmsr() are planned to be
removed. Use the related 64-bit variants instead.

In drivers/ata/pata_cs5536.c don't redefine rdmsr() and wrmsr() as
empty macros for avoiding misuse, but guard the affected code via
a simple #ifdef.

Switch pio_cmd_timings[] to a u32 type array in order to avoid a cast
to u32 when constructing final MSR values.

Signed-off-by: Juergen Gross <jgross@suse.com>
---
V2:
- avoid sign extension when using wrmsrq() (Sashiko bot)
V3:
- use a u32 array for pio_cmd_timings (David Laight)
---
 drivers/ata/pata_cs5535.c | 24 ++++++++++++------------
 drivers/ata/pata_cs5536.c | 17 ++++++++---------
 2 files changed, 20 insertions(+), 21 deletions(-)

diff --git a/drivers/ata/pata_cs5535.c b/drivers/ata/pata_cs5535.c
index d793fc441b46..512f9728224f 100644
--- a/drivers/ata/pata_cs5535.c
+++ b/drivers/ata/pata_cs5535.c
@@ -87,10 +87,10 @@ static void cs5535_set_piomode(struct ata_port *ap, struct ata_device *adev)
 	static const u16 pio_timings[5] = {
 		0xF7F4, 0xF173, 0x8141, 0x5131, 0x1131
 	};
-	static const u16 pio_cmd_timings[5] = {
-		0xF7F4, 0x53F3, 0x13F1, 0x5131, 0x1131
+	static const u32 pio_cmd_timings[5] = {
+		0xF7F40000, 0x53F30000, 0x13F10000, 0x51310000, 0x11310000
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
+			       pio_cmd_timings[cmdmode] | pio_timings[pairmode]);
 	}
 	/* Write the drive timing register */
-	wrmsr(ATAC_CH0D0_PIO + 2 * adev->devno,
-		pio_cmd_timings[cmdmode] << 16 | pio_timings[mode], 0);
+	wrmsrq(ATAC_CH0D0_PIO + 2 * adev->devno,
+	       pio_cmd_timings[cmdmode] | pio_timings[mode]);
 
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

