Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC75B3264F5
	for <linux-ide@vger.kernel.org>; Tue,  3 Mar 2026 18:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772562823; cv=none; b=YOHsHOjt+cXaeiTGX8M54keTGX0Eg2GbUedUsGcBE4OkOh/nlI65WRdg4W+zibeKXtyMpVZuOfYnjDWCNKAAGA/h3aMcRIdg2lbltJtu4RCLRz0SXr2Yp8ERmvmmQoVCDJ+lMRnVzHizj+LMIuEs24weZzlQjWHEudB3/UUU4JQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772562823; c=relaxed/simple;
	bh=LUEHqTgZXDTnLAimyIR3EV+rHiA0/SBzFpSAfSz/GPU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SzF6qVAGAfwlnX8bTuQfr7fUDwXcsllvL/UfVod+ZXrAwdpbdSPNlz6uhLxpJhEnuymeve9haFCuxzmtBtlgaOCqcvIkAY3e9WlpJ9NzesJ9O01CtIvH2fZ43R2qqUOClj0RZT8ujpfpzyE/mi3Y+g8XZnuMurLrNOXRg7NaN0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=KdeLGIPz; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ttnwOp/A; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=KdeLGIPz; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ttnwOp/A; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="KdeLGIPz";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ttnwOp/A";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="KdeLGIPz";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ttnwOp/A"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 07D7E1FAA7;
	Tue,  3 Mar 2026 18:33:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1772562820; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=Zk14FV74Apw7zCcO++wN6xYld0QQLybxn0zPcwfu248=;
	b=KdeLGIPz274ZaIagL25gTZHhSjKih3pJNfTJdrjWlSFJwdMMICsynfNRD5WrA1qLRb2NQq
	dnSQyYl0JXYQckXi/dK9CbivdOyLU+jfRIXMyBuSm63uHfsSGOAiKEIN8iTsAST8Q3SsLj
	bOa+upmcB+bg1vj5zffPACIXZpwGWr8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1772562820;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=Zk14FV74Apw7zCcO++wN6xYld0QQLybxn0zPcwfu248=;
	b=ttnwOp/A4zBZ5L9iadWEz2c8g8Etdn1vp2BCazCPDrJ+1kqxKHl9g74mmYRl/2V5Unu06Q
	IJAq6ivcMCjf1KCA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=KdeLGIPz;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="ttnwOp/A"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1772562820; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=Zk14FV74Apw7zCcO++wN6xYld0QQLybxn0zPcwfu248=;
	b=KdeLGIPz274ZaIagL25gTZHhSjKih3pJNfTJdrjWlSFJwdMMICsynfNRD5WrA1qLRb2NQq
	dnSQyYl0JXYQckXi/dK9CbivdOyLU+jfRIXMyBuSm63uHfsSGOAiKEIN8iTsAST8Q3SsLj
	bOa+upmcB+bg1vj5zffPACIXZpwGWr8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1772562820;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=Zk14FV74Apw7zCcO++wN6xYld0QQLybxn0zPcwfu248=;
	b=ttnwOp/A4zBZ5L9iadWEz2c8g8Etdn1vp2BCazCPDrJ+1kqxKHl9g74mmYRl/2V5Unu06Q
	IJAq6ivcMCjf1KCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 986383EA69;
	Tue,  3 Mar 2026 18:33:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id DVznIYMpp2nXFAAAD6G6ig
	(envelope-from <pfalcato@suse.de>); Tue, 03 Mar 2026 18:33:39 +0000
From: Pedro Falcato <pfalcato@suse.de>
To: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>
Cc: linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Pedro Falcato <pfalcato@suse.de>
Subject: [PATCH] ata: libata-core: Add BRIDGE_OK quirk for QEMU drives
Date: Tue,  3 Mar 2026 18:33:37 +0000
Message-ID: <20260303183337.1013474-1-pfalcato@suse.de>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim,suse.de:mid,suse.de:email];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Queue-Id: 07D7E1FAA7
X-Spam-Flag: NO
X-Spam-Score: -3.01
X-Spam-Level: 

Currently, whenever you boot with a QEMU drive over an AHCI interface,
you get:
[    1.632121] ata1.00: applying bridge limits

This happens due to the kernel not believing the given drive is SATA,
since word 93 of IDENTIFY (ATA_ID_HW_CONFIG) is non-zero. The result is
a pretty severe limit in max_hw_sectors_kb, which limits our IO sizes.

QEMU shares IDENTIFY data between PATA/SATA drives (and the corresponding
emulation of IDE/AHCI) but does not, in any way, emulate any of these
real hardware details. There is no PATA drive and no SATA cable.

As such, add a BRIDGE_OK quirk for QEMU HARDDISK. This results in the
max_hw_sectors being limited solely by the controller interface's limits.
Which, for AHCI controllers, takes it from 128KB to 32767KB.

Signed-off-by: Pedro Falcato <pfalcato@suse.de>
---
Note: This may be ok for stable, but I'll leave it up to you. There is
obviously no Fixes: here that doesn't go back 20 years.
 drivers/ata/libata-core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index d61846f03edc..70703432063a 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -4231,6 +4231,7 @@ static const struct ata_dev_quirks_entry __ata_dev_quirks[] = {
 	/* Devices that do not need bridging limits applied */
 	{ "MTRON MSP-SATA*",		NULL,	ATA_QUIRK_BRIDGE_OK },
 	{ "BUFFALO HD-QSU2/R5",		NULL,	ATA_QUIRK_BRIDGE_OK },
+	{ "QEMU HARDDISK",		NULL,	ATA_QUIRK_BRIDGE_OK },
 
 	/* Devices which aren't very happy with higher link speeds */
 	{ "WD My Book",			NULL,	ATA_QUIRK_1_5_GBPS },
-- 
2.53.0

