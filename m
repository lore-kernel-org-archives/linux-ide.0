Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795161849;
	b=imAw7tB2tpMS4xNQn6rK6uuhPmPVJFdqRu7ICBggMyCmIgO0U+Ut59eeamDcSU8/vQ6F
	 WjdvrnYwyL718KggcJbcRESLMpbhZyhHBUUJ6aR4egU+63+bVd+maax/rBaZVWU9VKXUp
	 31KCxxQYSwXtaSsZ1NYgoqqdE5zudzfokk6b4/wU+kaGePnaDT+Rz89Y7JWvQrvPK91ko
	 JcRirMXYmRTLeWjJOVYZpyIzr5kOB6Mo3592BpcHjuecmaouvVt1hQwRF5KcvoOycW5gd
	 915UYFML9kU5GX84/NOSg/cKKsYJ8dtBROA8wM8wIcUjVb1Z5On83TLNI4Jtaaq7OXQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795161849;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:X-Rspamd-Queue-Id:
	 X-Spam-Level:X-Rspamd-Server:X-Rspamd-Action:X-Spam-Flag:
	 X-Spamd-Result:X-Spam-Score;
	bh=p9BtnMg5jXZKGfllMG3hhDm0ffyd55CrQxecP13oJXU=;
	b=dD3aOjRNW9Br211+9Q8mbxKDrTzRYfpvL8TfmKDa94bsy+N9e6fy3rkkzisTQbMikS1B
	 u06//eypl2rzliMn5m5MBhDys/s2adhJtqwIcSU0VuYvi+trZGMYZlbvcowakog62D6o3
	 d3vxzmq1XgVtybf4EVlij9AJTV16D+vVXMZ5v2nAdzqiAWVBI8M81H+2fuse+8NmDgOGr
	 GXsI9zVr789fGn+Q3ef2gt9J2nUolIfgAtUdm/hlZXIaHIxp3BT718uHmDsclSTjDSCFF
	 Dqe2EL9H4KMn/WYNkh2yOcf+aYosy2OmFuPY+esdEpCNQJWrqU18S/nUkgftfCgXBDQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.com;
	spf=pass smtp.mailfrom=suse.com;
	dkim=pass header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=susede1 header.b=IGZ4iBU5;
	dkim=pass header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=susede1 header.b=auCO3QhT;
	arc=none smtp.remote-ip=195.135.223.131
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE436606A32A;
	Fri, 20 Nov 2026 08:04:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DE436606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=susede1 header.b=IGZ4iBU5;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=susede1 header.b=auCO3QhT
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C0DDB1F849;
	Fri, 20 Nov 2026 08:04:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1795161847; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=p9BtnMg5jXZKGfllMG3hhDm0ffyd55CrQxecP13oJXU=;
	b=IGZ4iBU5RFQa6PDznAM8KTETXmZrgkCIXDTVIpI6kEGpzm+//QIKg9D1jnrSM26dXMEdq4
	wRFz48+9cNXoslWqAsUvhzvu7BhJykI66mCr9LNnOz1VcOY5iAcBUslG3Lmel0HjmX6xos
	L2srMgZlUPfI11LGPA4xTtnTVeI9Rr0=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=auCO3QhT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1795161846; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=p9BtnMg5jXZKGfllMG3hhDm0ffyd55CrQxecP13oJXU=;
	b=auCO3QhThyx4MNZMxMQVptRlk2avMiJQYZrHufMa79Vawq0wQoU2l9Kq+dstOz1fKKhIei
	RUdwwAUM2xUHPXPm7jLyc5DOFnxZP2cSnOaXmL1I2MbT7z1BduwHJzvkDhPk+oRoGjpxE/
	iKi9y9fkIpw9MZfcf84Lqqyka1dg6eM=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 750091348F;
	Fri, 20 Nov 2026 08:04:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 4GjyEvb+/2qCIQAAD6G6ig
	(envelope-from <jgross@suse.com>); Fri, 20 Nov 2026 08:04:06 +0000
From: Juergen Gross <jgross@suse.com>
To: linux-kernel@vger.kernel.org,
	linux-ide@vger.kernel.org
Cc: Juergen Gross <jgross@suse.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>
Subject: [PATCH v6.1 04/12] ata: pata_cs553X: Stop using 32-bit MSR interfaces
Date: Fri, 20 Nov 2026 09:04:04 +0100
Message-ID: <20261120080404.2920298-1-jgross@suse.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <932b724d-b062-4b99-aa25-6da2ac1c45e4@kernel.org>
References: <932b724d-b062-4b99-aa25-6da2ac1c45e4@kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Post: <mailto:linux-ide@vger.kernel.org>
List-Help: <mailto:linux-ide+help@vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-ide+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: C0DDB1F849
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spamd-Result: default: False [-12.01 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.com:dkim,suse.com:email];
	MIME_TRACE(0.00)[0:+];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_TLS_ALL(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[suse.com:+]
X-Spam-Score: -12.01

The 32-bit MSR interfaces rdmsr() and wrmsr() are planned to be
removed. Use the related 64-bit variants instead.

In drivers/ata/pata_cs5536.c don't redefine rdmsr() and wrmsr() as
empty macros for avoiding misuse, but guard the affected code via
a simple #ifdef.

Switch pio_cmd_timings[] to a u32 type array in order to avoid a cast
to u32 when constructing final MSR values.

Signed-off-by: Juergen Gross <jgross@suse.com>
Acked-by: Niklas Cassel <cassel@kernel.org>
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
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
2.56.0

