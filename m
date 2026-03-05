Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AEF73B3C1F
	for <linux-ide@vger.kernel.org>; Thu,  5 Mar 2026 14:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772722401; cv=none; b=fUtmR/R+HCfpmROzpyWdXe9t5CmUNOIOB0e0y2TnjhRFSerc5T9B5Z93Ulj75V40xrOoYkwVcYfFUgrpzSNZZahoV+OJtQNXhvaxeXKm34NYTdvGfiJ7KS68YMo4AgCKD5XggS1wILxn4o7AEsq4jzq8OdrQ65pPpYZUzFYMMzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772722401; c=relaxed/simple;
	bh=7uDZsBmLWxU4wubBz2YbfMLyFqIgfbwOOL5u6mJIyk4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HSQA6CEriteOSlJyPepW+daPhrBL/du0pIlbiZCr8yF89xQnf/sAwZAsd5WGP2t99g89qsR2I1vQN9UYt2kujNbE2qbZf4HIhSam5ZhS1IBoyRYW7wECBkYTjByT5F7ynjeCjLF63+5ixO3ACmcRFmabhq0T4ZejRwqRip6prLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=MbGCgF9v; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=OGclW1QH; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=aZuodIs+; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=whfSqAFv; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="MbGCgF9v";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="OGclW1QH";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="aZuodIs+";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="whfSqAFv"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id AB2955BD1F;
	Thu,  5 Mar 2026 14:53:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1772722397; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=25Lay2I2vLoxz8F7Wzp5i3ZVvlLpDLHgk2kFQp4EJ0E=;
	b=MbGCgF9v9zuojeu7yZIBcbjYs9PV8+6oeeg/+AV6ViAx7Q9trgAYIlhi1mUkWI0Z1lEy8a
	wv7P40wWa/P5HJhA4J8ZGoIB3f9kdhCPuEjScLVv3FRJdylMw4suoBLtnmbWHqE5PCUQL2
	tG7bMQ8U6NMtmtVxzrsK4EvDJsjlatA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1772722397;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=25Lay2I2vLoxz8F7Wzp5i3ZVvlLpDLHgk2kFQp4EJ0E=;
	b=OGclW1QHotjG1RdQ33yqEqlshmA6G1OlA3lkB1bQcUTkUNZw4nqc4Vpg75+TyIF1f+YitP
	68YT7SkMQrioD6BQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1772722396; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=25Lay2I2vLoxz8F7Wzp5i3ZVvlLpDLHgk2kFQp4EJ0E=;
	b=aZuodIs+n+nPFEqpysPxFlqCvjXCel6GR6RIYLRnTstKclEu/dFv9bcr/JcSy4JWA41x7d
	uIPqAwYvfnDAdUnugog+kk06uyf8wxfnITAvgVhYdsq3qseREndQmuUWTrNRBg8CS6qtGu
	r5uBb3pvI3Sw66mx1yH4ZLEZ6iIe93Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1772722396;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=25Lay2I2vLoxz8F7Wzp5i3ZVvlLpDLHgk2kFQp4EJ0E=;
	b=whfSqAFvgOk+cDgWWexu57gJsZWYklLBnCk6Mqw+hDFTVYwBelW0ZPItNbxxSthYL6+HE+
	+lGz3DADXj4KbkDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 317303EA68;
	Thu,  5 Mar 2026 14:53:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id SPanCNyYqWlrEAAAD6G6ig
	(envelope-from <pfalcato@suse.de>); Thu, 05 Mar 2026 14:53:16 +0000
From: Pedro Falcato <pfalcato@suse.de>
To: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>
Cc: linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Pedro Falcato <pfalcato@suse.de>,
	stable@vger.kernel.org
Subject: [PATCH v2] ata: libata-core: Add BRIDGE_OK quirk for QEMU drives
Date: Thu,  5 Mar 2026 14:53:12 +0000
Message-ID: <20260305145312.1081112-1-pfalcato@suse.de>
X-Mailer: git-send-email 2.53.0
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
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email,imap1.dmz-prg2.suse.org:helo];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO

Currently, whenever you boot with a QEMU drive over an AHCI interface,
you get:
[    1.632121] ata1.00: applying bridge limits

This happens due to the kernel not believing the given drive is SATA,
since word 93 of IDENTIFY (ATA_ID_HW_CONFIG) is non-zero. The result is
a pretty severe limit in max_hw_sectors_kb, which limits our IO sizes.

QEMU has set word 93 erroneously for SATA drives but does not, in any
way, emulate any of these real hardware details. There is no PATA
drive and no SATA cable.

As such, add a BRIDGE_OK quirk for QEMU HARDDISK. Special care is taken
to limit this quirk to "2.5+", to allow for fixed future versions.

This results in the max_hw_sectors being limited solely by the
controller interface's limits. Which, for AHCI controllers, takes it
from 128KB to 32767KB.

Cc: stable@vger.kernel.org
Signed-off-by: Pedro Falcato <pfalcato@suse.de>
---
 drivers/ata/libata-core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index d61846f03edc..c57e35ccc092 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -4231,6 +4231,7 @@ static const struct ata_dev_quirks_entry __ata_dev_quirks[] = {
 	/* Devices that do not need bridging limits applied */
 	{ "MTRON MSP-SATA*",		NULL,	ATA_QUIRK_BRIDGE_OK },
 	{ "BUFFALO HD-QSU2/R5",		NULL,	ATA_QUIRK_BRIDGE_OK },
+	{ "QEMU HARDDISK",		"2.5+",	ATA_QUIRK_BRIDGE_OK },
 
 	/* Devices which aren't very happy with higher link speeds */
 	{ "WD My Book",			NULL,	ATA_QUIRK_1_5_GBPS },
-- 
2.53.0

