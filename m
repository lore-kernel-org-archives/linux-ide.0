Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEA8A4B44CD
	for <linux-ide@vger.kernel.org>; Thu, 17 Sep 2026 15:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789657654; cv=none; b=d8y2z0lDKFcACdNti5tA6gpxw5o9H1qBaC6yoA0p2AkeT8wek6uhtmdWF7Y7OcUlv19WgcP6Umj/W0u7+dRZAvjBw2AEGWAOcjt6ohGz8N68PsIp+fOrNtKXJToZUxPhy1+GlNIwvLbSSwWN6eco+J8gnOWuuOZ/R9gzV6NfWgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789657654; c=relaxed/simple;
	bh=dihYbHWbbZ5vDkzEvzfwYTF1uz8CtfSCsphby4WvAHY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Cc4aflYin+Kow+5/SO+ZQItSvvsZVZQOba/Uw7BNR3lJntgLElLpdGmeeS/0gKTwyLDR3oV9DkXypbBeo6ZLkz5MvDsdCYvVgmwmkmCmTiiqT205xCpFLk7yBwWWPnzpP2kwtnu5klCi2t0y8Z5qJtXy6jA9+dIvNIrIxOGaVgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=j9xi3kBb; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=CvLIhORj; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="j9xi3kBb";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="CvLIhORj"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 9CAB51FF84;
	Thu, 17 Sep 2026 15:07:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1789657633; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=1Vksv4UG9YhGavets6PeiL1vDVF0Et1NooS1JreUOmo=;
	b=j9xi3kBbqHxSmBClOOLljPgwJQPEiWJCDDAO+I7RnqQcWrnoVS3gI6gioLvgnvuWhecya0
	TZm73S5jpP4G0NpoLkNT9z1MQ8WIDBj5VHYGfTnnRW4vZsP1zvBwf6L5uyl44eIJ8UWJQ7
	IbAmlVs2FzDz7hqP2UoBv/dnT7JE0EM=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=CvLIhORj
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1789657629; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=1Vksv4UG9YhGavets6PeiL1vDVF0Et1NooS1JreUOmo=;
	b=CvLIhORj9/TnSql/NfSCX4E3E4iMgdb0scOxz5SaDRc78MfCdSK9l9qD1EeWqqnkGdS7pP
	653v+HaUkRvri5cfN5Uk0MBC65BPCj0tdlxh+CcwUtowqe5L/T3phpK2k8hNuiJF3xmm5x
	VjbhdgnT0zl/9RleSFqm6tjpqkyR1Io=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3603013786;
	Thu, 17 Sep 2026 15:07:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id XyWLAh0CrGrSMQAAD6G6ig
	(envelope-from <nik.borisov@suse.com>); Thu, 17 Sep 2026 15:07:09 +0000
From: Nikolay Borisov <nik.borisov@suse.com>
To: linux-ide@vger.kernel.org
Cc: dlemoal@kernel.org,
	cassel@kernel.org,
	rosenp@gmail.com,
	Nikolay Borisov <nik.borisov@suse.com>
Subject: [PATCH v4] ata: sata_dwc_460ex: Don't enable interrupt if libATA core registration fails
Date: Thu, 17 Sep 2026 18:07:07 +0300
Message-ID: <20260917150707.1643330-1-nik.borisov@suse.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 9CAB51FF84
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,suse.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,suse.com:email,suse.com:mid,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_TRACE(0.00)[suse.com:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com]
X-Spam-Flag: NO
X-Spam-Score: -3.01

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
Changes since v2:
    * Rework logic so that interrupts are enabled if everything is successful
	and don't call phy_exit otherwise, as the driver is quite broken w.r.t to it.
Changes since v3:
	* Revert to the code as in v2 of the patch following a series that has been
	merged in the mean time

 drivers/ata/sata_dwc_460ex.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/ata/sata_dwc_460ex.c b/drivers/ata/sata_dwc_460ex.c
index 8e3fc713891a..aa816a1a4c54 100644
--- a/drivers/ata/sata_dwc_460ex.c
+++ b/drivers/ata/sata_dwc_460ex.c
@@ -1185,11 +1185,14 @@ static int sata_dwc_probe(struct platform_device *ofdev)
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
+
 	return 0;
 
 error_out:

base-commit: 52d19459ca79fef362126e472b9e9a3bfc5020b8
--
2.55.0

