Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F6ED54281E
	for <linux-ide@vger.kernel.org>; Wed,  9 Sep 2026 11:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788953086; cv=none; b=JkZk+xRpAikZmih2pOWNlxh7un6jMTC2ULvzOyutT5LxK68XFILl/3HaLGRkQbTf5BnwberkHoJxiKABQvkcKeTpd0NWjfFaKaMdYUN0uNkv2e1zKzoIjy1p8FJtvCta7UAKKONRxBbnumYDXbcGdpq5l619LfTvGL57wXdwjW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788953086; c=relaxed/simple;
	bh=+vYyZvxNMXm+ZRKUBT915b8ELxfryNitX56nos8CV+E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nuNNaMhrZ3zFyjZ7yZ5urpJJMNpbs0lLW3JE6zJ8FyGHN8nULR7l59e0KBNO4rReXx/LTimmgu87Kkp0gsSFL8G9EfVmcM2V8+Rw85LfzYuLmfrbwuZr+K3xqm5sLBnjxFfTr3gl21WJxwQ/rgUhWKyKHojNS9joG7/JzdC+UdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=YZjUYwhq; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=kKKEsPKt; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="YZjUYwhq";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="kKKEsPKt"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 31F5E22D22;
	Wed,  9 Sep 2026 11:24:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1788953078; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=ukY/eBZNitlz+9xvy6BCK56ic+JqZbo3ZdDSa7vQi4E=;
	b=YZjUYwhqMHsi24hTAgQA8gv9St19e/jegQeDleXEoUbLoymJBI2Gnhxm8Xr1/nAjizSYEp
	pdZ9TevjD44XIJpZ1AP1lzc+7OMV7JW0oYzJMC2pJSixI4sBNjYwjSxPp8bF/VAYuf2pfe
	iYKm2Rm80QxXU6ToqT4KgPfWc2vj1Jw=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=kKKEsPKt
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1788953074; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=ukY/eBZNitlz+9xvy6BCK56ic+JqZbo3ZdDSa7vQi4E=;
	b=kKKEsPKtubtfHfMC32FvwucXaIOqQqLQ8l3Re6Tnsf4PCGBb0MdEoOvg1Y/c4JJOP0/4h/
	/n31gFlJUVJb0/RdVREIT0ipM4iKfDkouMpMpUpNeq16fFh/kG4OCIU4Nr0igTCkiGq0Jb
	hO9wxOEMMd9ey0MYTxYvIsUm3KgjHug=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9EE561352C;
	Wed,  9 Sep 2026 11:24:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id e/VPJPFBoWpeagAAD6G6ig
	(envelope-from <nik.borisov@suse.com>); Wed, 09 Sep 2026 11:24:33 +0000
From: Nikolay Borisov <nik.borisov@suse.com>
To: linux-ide@vger.kernel.org
Cc: dlemoal@kernel.org,
	cassel@kernel.org,
	rosenp@gmail.com,
	Nikolay Borisov <nik.borisov@suse.com>
Subject: [PATCH v2] ata: sata_dwc_460ex: Don't enable interrupt if libATA core registration fails
Date: Wed,  9 Sep 2026 14:24:26 +0300
Message-ID: <20260909112426.811456-1-nik.borisov@suse.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -3.01
X-Rspamd-Queue-Id: 31F5E22D22
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Level: 
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FROM_EQ_ENVFROM(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,suse.com];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,suse.com:email,suse.com:mid];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCPT_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[suse.com:+]
X-Spam-Flag: NO

Recent 4bbc16a353a9 commit changed the timing when interrupts are
enabled. However it didn't account for the libATA registration step. So
it's possible that interrupts are enabled when the device is not
registered with libATA core.

Resolve the issue by failing the entire registration process in case of
failure to register with libATA.

Fixes: 4bbc16a353a9 ("ata: sata_dwc_460ex: enable SATA interrupts only after IRQ handler is registered")
Signed-off-by: Nikolay Borisov <nik.borisov@suse.com>
---

Changes since v1:
	* Added proper goto label

 drivers/ata/sata_dwc_460ex.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/ata/sata_dwc_460ex.c b/drivers/ata/sata_dwc_460ex.c
index 8e3fc713891a..db39843c5f0f 100644
--- a/drivers/ata/sata_dwc_460ex.c
+++ b/drivers/ata/sata_dwc_460ex.c
@@ -1185,8 +1185,10 @@ static int sata_dwc_probe(struct platform_device *ofdev)
 	 * error_handler() to execute a dummy Softreset EH session
 	 */
 	err = ata_host_activate(host, irq, sata_dwc_isr, 0, &sata_dwc_sht);
-	if (err)
+	if (err) {
 		dev_err(dev, "failed to activate host");
+		goto error_out;
+	}
 
 	/* Enable SATA Interrupts */
 	sata_dwc_enable_interrupts(hsdev);
--
2.55.0

