Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C19938F638
	for <linux-ide@vger.kernel.org>; Thu, 17 Sep 2026 11:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789644939; cv=none; b=HJ29Z2jljUtgLp+H0mdeasqMRZW3UrRsab3c7uyxMC2wlCoGEhqIs9yH5/BTUwcGxMiJW5/22cxARkqG0/LFe/EEcs+3vYFUw8tSyR1dRcbzdhdJ6koAYthJBm5okXOOnpJfzQiE7INm6S9omqP+nuTOvvnfnGzhflZVO3JSdK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789644939; c=relaxed/simple;
	bh=If+gaTte8A/0kJZ8AkZaydvfCXtO2qnc76xFjZjtJNs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MzTojXXTD6QuYbcnBSmjrqjpDH+iMpcjV4nICXKniMbITIt++RPVtU8KL8/CMCHs3xpldJbCdtqL5aN4pYMJkLcLOp0+Gjc3adkhz8VZamQN5uoMVIivvI7kcA49DjHG9MdbJJU/UEF2nfUw7cM4bG2P0B/r51fZwUoUVREVQHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Nszp8uLe; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=HzKCARHb; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Nszp8uLe";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="HzKCARHb"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 0B3C21FFDF;
	Thu, 17 Sep 2026 11:35:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1789644932; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=eRkvHvV5phGAIvz4l7bC3fxZnJ3nlOXsofSkoxIe95g=;
	b=Nszp8uLetXG8msU/IypdCE1prmjwDLSA8EcmcYPbJj9yrd5V+Z59QzW+cWDsp1ZvqCklGy
	QTmqtQW2eJEwmgTMX1A5tyElvmjM3fZ4fdbmPEFOVnhpmGVT45n+fdtAjo0oyZ5+YBGzYd
	47dFSu5hDPj8NLqKODOxLKf0cUIJZ6Q=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1789644928; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=eRkvHvV5phGAIvz4l7bC3fxZnJ3nlOXsofSkoxIe95g=;
	b=HzKCARHbLv3SUkeszucQVY0mT6Yh3vKf2X2iVBg3pd8GhXjLc6jFK62jc818dFrHiPF7j3
	ftgI+1j6M+kSlhkFfteBqdPYyIsFGjdLjtNljyB7IztzMqOs5OiGyGzdmt3VDhtL+ACGrJ
	gC6+rxEBqxgVqQiUjxHuNJzkxyjtN3Y=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 963F01374A;
	Thu, 17 Sep 2026 11:35:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id fCiJF3/Qq2reOAAAD6G6ig
	(envelope-from <nik.borisov@suse.com>); Thu, 17 Sep 2026 11:35:27 +0000
From: Nikolay Borisov <nik.borisov@suse.com>
To: linux-ide@vger.kernel.org
Cc: dlemoal@kernel.org,
	cassel@kernel.org,
	rosenp@gmail.com,
	Nikolay Borisov <nik.borisov@suse.com>
Subject: [PATCH v3] ata: sata_dwc_460ex: Don't enable interrupt if libATA core registration fails
Date: Thu, 17 Sep 2026 14:35:26 +0300
Message-ID: <20260917113526.1589813-1-nik.borisov@suse.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -2.80
X-Spam-Level: 
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:mid,suse.com:email];
	RCVD_COUNT_TWO(0.00)[2];
	FREEMAIL_ENVRCPT(0.00)[gmail.com]
X-Spam-Flag: NO

Recent 4bbc16a353a9 commit changed the timing when interrupts are
enabled. However it didn't account for the libATA registration step. So
it's possible that interrupts are enabled when the device is not
registered with libATA core.

Resolve the issue by ensuring that interrupts are enabled only if the rest of the
initialization is successful.

Fixes: 4bbc16a353a9 ("ata: sata_dwc_460ex: enable SATA interrupts only after IRQ handler is registered")
Signed-off-by: Nikolay Borisov <nik.borisov@suse.com>
---


Changes since v1:
	* Added proper goto label
Changes since v2:
    * Rework logic so that interrupts are enabled if everything is successful
	and don't call phy_exit otherwise, as the driver is quite broken w.r.t to it.

 drivers/ata/sata_dwc_460ex.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/ata/sata_dwc_460ex.c b/drivers/ata/sata_dwc_460ex.c
index 8e3fc713891a..e74335dec42a 100644
--- a/drivers/ata/sata_dwc_460ex.c
+++ b/drivers/ata/sata_dwc_460ex.c
@@ -1185,11 +1185,13 @@ static int sata_dwc_probe(struct platform_device *ofdev)
 	 * error_handler() to execute a dummy Softreset EH session
 	 */
 	err = ata_host_activate(host, irq, sata_dwc_isr, 0, &sata_dwc_sht);
-	if (err)
+	if (err) {
 		dev_err(dev, "failed to activate host");
+	} else {
+		/* Enable SATA Interrupts */
+		sata_dwc_enable_interrupts(hsdev);
+	}
 
-	/* Enable SATA Interrupts */
-	sata_dwc_enable_interrupts(hsdev);
 	return 0;
 
 error_out:
--
2.55.0

