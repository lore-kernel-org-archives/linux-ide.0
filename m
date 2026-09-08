Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77A1C53D0D6
	for <linux-ide@vger.kernel.org>; Tue,  8 Sep 2026 14:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788876964; cv=none; b=tgwxqSeynPFaj7NlpX8tZKhMEAzr6wLnLu9OPC4va2JyLg7igQF/scbb/n+qiylbUTegYY2RNKrWk0ZHIMWLwicDHiRYINfoShWQW/Cg2cPs6gjv4hsmooX/tDF6+vuLL/+/rEUqgv0ZBabliLkC8GdLbuauGgpA2xBARKqMnJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788876964; c=relaxed/simple;
	bh=kGWK8btAXe24nAH3yzzf1M00CoWIuRCNNi+XB4d/Y3E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=flbMj/bmmCAf2/iNxMtN44ozp6AXJRz5MseuKnvCOAplUxCxUq64Ign8wI1nUuG+Qo9B+i6OlStfzAiZBcOzP69JIr4yxB0DXj/47pA+Rk9HIcIRWMgZGdZAU0fT/OZ7MCs8pE0tVBR+RH4lhzdarRySwi1n4TRpLREiilr4FNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=nGvMwupf; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=M/7/id/W; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="nGvMwupf";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="M/7/id/W"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 3F94321A4A;
	Tue,  8 Sep 2026 14:15:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1788876947; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=cL3svVKXt5LF62yNqt0cM0bdBmywE+L2j5cDDO+a+a8=;
	b=nGvMwupfBA9gHUBDyUwl5iukq5NVmP1atgLIxEkhhbRQn0BdWwDvXfTvH0pJlpO1JW/+VX
	glQUDlvhrt+86hRoi2E4LdUUoT0D1seayK07liXHv91hb9/d1voanYVml43P/t20D4vD+G
	PaMiF8dmbVmV8u8govmPePaX8dFVlnw=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1788876943; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=cL3svVKXt5LF62yNqt0cM0bdBmywE+L2j5cDDO+a+a8=;
	b=M/7/id/WYnNZXGiSEDjHvZYJC/PxpZRapc6kwelwiv/fIthR3k00sEDqok4onqbtztRb7K
	Q8Qb/rKX4upOeux5twHKk9K9hSir9x/9nFjE6uAP3jf7bhJbEMOheUkfRuKVEgDjTiOW7v
	LBzx2K6nc+5kWlkJht+rH7C7qiFIItY=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D0BD513332;
	Tue,  8 Sep 2026 14:15:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id zuCSMI4YoGqEfQAAD6G6ig
	(envelope-from <nik.borisov@suse.com>); Tue, 08 Sep 2026 14:15:42 +0000
From: Nikolay Borisov <nik.borisov@suse.com>
To: linux-ide@vger.kernel.org
Cc: dlemoal@kernel.org,
	cassel@kernel.org,
	rosenp@gmail.com,
	Nikolay Borisov <nik.borisov@suse.com>
Subject: [PATCH] ata: sata_dwc_460ex: Don't enable interrupt if libATA core registration fails
Date: Tue,  8 Sep 2026 17:15:38 +0300
Message-ID: <20260908141538.731237-1-nik.borisov@suse.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spam-Score: -2.80
X-Spam-Flag: NO
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_TLS_ALL(0.00)[];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,suse.com];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_EQ_ENVFROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email,suse.com:mid];
	RCVD_COUNT_TWO(0.00)[2];
	FREEMAIL_ENVRCPT(0.00)[gmail.com]

Recent 4bbc16a353a9 commit changed the timing when interrupts are
enabled. However it didn't account for the libATA registration step. So
it's possible that interrupts are enabled when the device is not
registered with libATA core.

Resolve the issue by failing the entire registration process in case of
failure to register with libATA.

Fixes: 4bbc16a353a9 ("ata: sata_dwc_460ex: enable SATA interrupts only after IRQ handler is registered")
Signed-off-by: Nikolay Borisov <nik.borisov@suse.com>
---

This was discovered during review of an internal backport by some internal
LLM-based tool but the fix is entirely cooked up by me.

 drivers/ata/sata_dwc_460ex.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/ata/sata_dwc_460ex.c b/drivers/ata/sata_dwc_460ex.c
index 8e3fc713891a..c3df2fce4af7 100644
--- a/drivers/ata/sata_dwc_460ex.c
+++ b/drivers/ata/sata_dwc_460ex.c
@@ -1185,8 +1185,10 @@ static int sata_dwc_probe(struct platform_device *ofdev)
 	 * error_handler() to execute a dummy Softreset EH session
 	 */
 	err = ata_host_activate(host, irq, sata_dwc_isr, 0, &sata_dwc_sht);
-	if (err)
+	if (err) {
 		dev_err(dev, "failed to activate host");
+		goto err;
+	}
 
 	/* Enable SATA Interrupts */
 	sata_dwc_enable_interrupts(hsdev);
--
2.55.0

