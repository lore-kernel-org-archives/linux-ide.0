Received: from 011.lax.mailroute.net (011.lax.mailroute.net [199.89.1.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE2C141440D;
	Fri, 25 Sep 2026 18:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790359570; cv=none; b=TJijU+sjwyTg3QiB31VLIv4CSuKY3p40HP1wDHS49GuEL+9IMIrXzWalwCkBALGsqu41GnXqU1OlPsb3iwQDrWufhvjngJsTdXKxD1bmcLr5Y2z0L35zjWpp+KyahAtfJCbFOrMqF9wLFvznCZK9tg7kwlz8Gb5bUuopyAaugZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790359570; c=relaxed/simple;
	bh=mhzJR8Y9vUY5+zagJG7EjENZW57LjxxqFlW62sFDtQY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jWPpqDQD29+ECfcxf7Fd4lgS6AcQR0nr/QtEuT09Y802jZVToxHmykydfhusy2VLikferCYVEPQ35hdbZWRFya3U/ryzwLLjPm/BS7cyMttEuF/Wa+SmMSACPIoGNO3hmbX2+fBMhu3vCaQApi+vD4nKUn+BUXSqHc1WqcgMu30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=gQPZrn1Y; arc=none smtp.client-ip=199.89.1.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="gQPZrn1Y"
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4hrzCZ5wJkz1XM4Tl;
	Fri, 25 Sep 2026 18:06:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:x-mailer:message-id:date
	:date:subject:subject:from:from:received:received; s=mr01; t=
	1790359555; x=1792951556; bh=mhzJR8Y9vUY5+zagJG7EjENZW57LjxxqFlW
	62sFDtQY=; b=gQPZrn1Yw26fInwZH3XNeQwpt0UY+0ct5jIiXSOtL1HY8OjP35G
	CQa5lizz4nav86tVgXISiIu4r7/bFTyGVH77+5YI/Dzz9inmQSJZ6kpnW5O853WH
	9KMpoMdFGLmfCorf8GTdoCWeJ2Ycs7fxLW7U+gGgMd0KdnlDU5OHq3lnb/eMBsoC
	+dbuMutvjpPHUQn62q5o71nk4WDWngKyUCJpIphU+uQ6dylxAKH0VpI1Pe3orDzZ
	MbPGbCzS56vN92ZF+VPmQZ7YsGxXps0S6AGFnc6TRnu2Db+CPQbMES3bqUMVPc1Y
	pfxBqOpK9fiVxHi4OuYWDBRGCyno3ord19w==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id 0_h46b6VuaNS; Fri, 25 Sep 2026 18:05:55 +0000 (UTC)
Received: from bvanassche.c.googlers.com.com (148.60.168.34.bc.googleusercontent.com [34.168.60.148])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4hrzCN2FFcz1XM4Sx;
	Fri, 25 Sep 2026 18:05:51 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org,
	Randy Dunlap <rdunlap@infradead.org>,
	linux-kernel@vger.kernel.org,
	Bart Van Assche <bvanassche@acm.org>,
	Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	linux-ide@vger.kernel.org
Subject: [PATCH] ata: libata: Fix scsi_done() documentation
Date: Fri, 25 Sep 2026 11:05:43 -0700
Message-ID: <291519238580d795929d44437f3c863403d14e1f.1790359497.git.bvanassche@acm.org>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

In 2008 the SCSI core was converted to use the block layer timeout
infrastructure instead of its own infrastructure (see also patch
"block: unify request timeout handling"). Since then, calling
scsi_done() while SCSI host recovery is in progress has no effect.
Originally the REQ_ATOM_COMPLETE flag was used to prevent double
completions. Today the SCMD_STATE_COMPLETE flag is used to prevent
double completions.

Instead of mentioning that calling scsi_done() is not allowed while
host recovery is in progress, mention that it has no effect.

Cc: Damien Le Moal <dlemoal@kernel.org>
Cc: Niklas Cassel <cassel@kernel.org>
Cc: linux-ide@vger.kernel.org
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 Documentation/driver-api/libata.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/driver-api/libata.rst b/Documentation/driver-a=
pi/libata.rst
index 28b8437f6e4f..c130b480180f 100644
--- a/Documentation/driver-api/libata.rst
+++ b/Documentation/driver-api/libata.rst
@@ -524,8 +524,8 @@ EH will know to handle it later. Then it calls low le=
vel libata driver's
 :c:func:`error_handler` callback.
=20
 When the :c:func:`error_handler` callback is invoked it stops BMDMA and
-completes the qc. Note that as we're currently in EH, we cannot call
-scsi_done. As described in SCSI EH doc, a recovered scmd should be
+completes the qc. Note that as we're currently in EH, scsi_done() has
+no effect. As described in SCSI EH doc, a recovered scmd should be
 either retried with :c:func:`scsi_queue_insert` or finished with
 :c:func:`scsi_finish_command`. Here, we override ``qc->scsidone`` with
 :c:func:`scsi_finish_command` and calls :c:func:`ata_qc_complete`.
