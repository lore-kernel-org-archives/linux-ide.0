Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65ED73612F8
	for <linux-ide@vger.kernel.org>; Fri, 29 May 2026 18:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780077809; cv=none; b=iz/i4lDJVTiaj/DN0q4wz69KgodvgNzqEm/iW259HdL9eeuF3ZSVDU4G17v8nqWlb3Zkrqzf0ImvMSf4C3tEPbk0cbrXn44r8Bzhn4wFCTf+1n5h2Z6dHvHmY+7ESexCDyhoxNtwh3ra7ah1yxlH/qHq9Y6lw9EDiZrv19nTJv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780077809; c=relaxed/simple;
	bh=zkWN7XO+2xNFUxdPKmMKTUacMt1mZ5vdiBlqZWteu8E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=B9bos7A76zWEnenEsbLZeJK1zvzWAzYKMBCHBonYoKUaKIftqBJ2UIx9xPafeqARpoe9o/C9mFdH5cKCxthmSlsaaOhfFwcz97pz03+PR9jgd0Nj18MdaHRkgETXpbAEaEDtzbpWYcn38eZaaqCNZPOb6ujRYuY/mOspj7v26y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=us4TjhUk; arc=none smtp.client-ip=199.89.1.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="us4TjhUk"
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4gRrnW6zt9zlgy1t;
	Fri, 29 May 2026 18:03:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:x-mailer:message-id:date
	:date:subject:subject:from:from:received:received; s=mr01; t=
	1780077803; x=1782669804; bh=xDp89UkCRihoOkghaR/m8Ve7WWalw5MoHX5
	FggSkVFg=; b=us4TjhUk8D+r4KtycRjrNFR3T5bNFnCLIn5ZlR0KuFUru2wiAPP
	SQz4CaxHTRbIYteCpS6kMLIXKWWbbOMgi2TnELUp4GA/spzqe38TGeLofPD2+Ex4
	qitZgaUOIPEFn9TINSEE2qAvbhmSm4mCdT2OkPQKmZlf8mmtN6qHugJqdOr1G2pT
	GTtVL8Q6a0S7QcdynBxtO2BNzJvmmGvEdfORRRqiaCEKxjpJr4aQHpb3TDXFDjjg
	+QiRyHq8ZLwZ7SH2nVn64TR9FpLgImSoPXqfJPPytW48SiPpar5ww5U0HO7gA4Vr
	PHXVOd84OlFNcPJBHdZ6HNsIH7L6tffkb6A==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id r-2EYq2eohlI; Fri, 29 May 2026 18:03:23 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4gRrnQ0KhYzlfl6N;
	Fri, 29 May 2026 18:03:21 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Niklas Cassel <cassel@kernel.org>
Cc: Damien Le Moal <dlemoal@kernel.org>,
	Hannes Reinecke <hare@suse.com>,
	Marco Elver <elver@google.com>,
	linux-ide@vger.kernel.org,
	Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH v5 0/2] ata: libata: Enable context analysis
Date: Fri, 29 May 2026 11:03:08 -0700
Message-ID: <cover.1780077008.git.bvanassche@acm.org>
X-Mailer: git-send-email 2.54.0.823.g6e5bcc1fc9-goog
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Niklas,

This patch series enables context analysis for the ATA subsystem. Please
consider this patch series for the next merge window.

Thanks,

Bart.

Changes compared to v4:
 - Added a patch that adds the ATA port argument to ata_eh_reset().
 - Removed the lockdep_assert_held() statements.

Changes compared to v3:
 - Removed two source code comments.
 - Annotated ata_dummy_error_handler().
 - Addressed Sashiko's that the address of a synchronization object shoul=
d be
   passed to __acquires() and __releases().

Changes compared to v2:
 - Instead of annotating only function declarations, annotate both functi=
on
   declarations and function definitions.
 - Changed __assume_ctx_lock() into lockdep_assert_held().
 - Left out the host lock changes because there is no agreement about how=
 to
   annotate functions that expect that the host lock is held.

Changes compared to v1:
 - Expanded a single patch into a series of nine patches.
 - Included a bug fix for ata_exec_internal() and several refactoring pat=
ches.
 - Added a patch for annotating the code that uses the host lock.

Bart Van Assche (2):
  ata: libata: Add an argument to ata_eh_reset()
  ata: libata: Document when host->eh_mutex should be held

 drivers/ata/Makefile         |  2 ++
 drivers/ata/ahci.h           |  3 ++-
 drivers/ata/ahci_imx.c       |  1 +
 drivers/ata/libahci.c        |  1 +
 drivers/ata/libata-core.c    |  2 ++
 drivers/ata/libata-eh.c      | 11 ++++++++---
 drivers/ata/libata-pmp.c     |  5 ++++-
 drivers/ata/libata-sff.c     |  2 ++
 drivers/ata/libata.h         | 14 +++++++++-----
 drivers/ata/pata_arasan_cf.c |  1 +
 drivers/ata/sata_dwc_460ex.c |  1 +
 drivers/ata/sata_fsl.c       |  1 +
 drivers/ata/sata_inic162x.c  |  1 +
 drivers/ata/sata_mv.c        |  1 +
 drivers/ata/sata_nv.c        |  2 ++
 drivers/ata/sata_promise.c   |  1 +
 drivers/ata/sata_qstor.c     |  1 +
 drivers/ata/sata_sil24.c     |  1 +
 drivers/ata/sata_sx4.c       |  1 +
 drivers/ata/sata_via.c       |  1 +
 include/linux/libata.h       | 15 ++++++++++-----
 21 files changed, 53 insertions(+), 15 deletions(-)

