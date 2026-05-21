Received: from 011.lax.mailroute.net (011.lax.mailroute.net [199.89.1.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D43833D7D86
	for <linux-ide@vger.kernel.org>; Thu, 21 May 2026 17:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779384847; cv=none; b=Dm3QFeJc2kg0emEsGNB+nYxRpMw0nHQQQkjnueMkHkkHOWUR8RYL4Gie3t47Q0BrBlaP8IkuXJIsH6xex4cOEAimCSaX1uWOmpCV3NC1W+eC2D+hJnoIo+xeT1IAaSIqhh4tOg3/jsMTOUCKj4LNaa4w1ki2YV5yVPSw0ulXXjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779384847; c=relaxed/simple;
	bh=yUPSB47foYrk6iBzHfcAxwnQY0qb7PRXCycBC5mAmP0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SWOyviGPOKlAUPSQkfrEwn3EJVtLPtUF6fwe1CWrpYQk0nWyszh4OFvJBAnYpt2/xtD9d0CSstX1QDyD+UyQrNRk7P1z2uf89Cqf+ag5rz1krHOjT6rqWeDMqjAbVjOikKBWb9vBb4D4/rr1Y51fpwe2TaH+kwD+l1fqckoGT3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=Zs2bViCD; arc=none smtp.client-ip=199.89.1.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="Zs2bViCD"
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4gLwWC6WmXz1XM0pD;
	Thu, 21 May 2026 17:33:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:x-mailer:message-id:date
	:date:subject:subject:from:from:received:received; s=mr01; t=
	1779384836; x=1781976837; bh=6Oblpt6wlZUaoeVcMo5+Thr/aCpLjRcRZVu
	ap5J4buY=; b=Zs2bViCDobPbQvCOQOQuv48qjfNx7HswIT50dxL8LXCkok94ii6
	wRA2JgZrzQP9GO124e0mm5lyekTUDpLsiFfrJ0AwAd6T/oMrKNcfSnK4ILmhVZ8U
	JZ7Herw/mRoJGcFhBjfAcMzUQhHfPfP2SS5oRqNDHcj6w4xFYarC4oFVN/N26X31
	ULyI4EM/2mYMENNZVAdAMjcdnrz8l/Y6TaCjO6QbH3p8DBvH14U523C0cZhxT0ZD
	VqsnIa273luJe+nOMNcZ4h5pc2f0Kzftxe1ga9e2ln2m2Wq98Ab7yGJj8OJ5jXLz
	S2SzjvHcdKVU7WGm01aPWd0Qf3TaMmqIktg==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id rTxmyTREbQEc; Thu, 21 May 2026 17:33:56 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4gLwW73NhCz1XM0ns;
	Thu, 21 May 2026 17:33:55 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Niklas Cassel <cassel@kernel.org>
Cc: linux-ide@vger.kernel.org,
	Damien Le Moal <dlemoal@kernel.org>,
	Marco Elver <elver@google.com>,
	Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH v2 0/9] ata: libata-core: Enable context analysis
Date: Thu, 21 May 2026 10:33:28 -0700
Message-ID: <20260521173347.2079560-1-bvanassche@acm.org>
X-Mailer: git-send-email 2.54.0.746.g67dd491aae-goog
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

Changes compared to v1:
 - Expanded a single patch into a series of nine patches.
 - Included a bug fix for ata_exec_internal() and several refactoring pat=
ches.
 - Added a patch for annotating the code that uses the host lock.

Bart Van Assche (9):
  ata: libata: Fix ata_exec_internal()
  ata: libata: Pass the ATA port argument directly to
    __ata_scsi_queuecmd()
  ata: libata: Pass the ATA port argument directly to
    ata_qc_schedule_eh()
  ata: libata: Pass the ATA port argument directly to ata_qc_complete()
  ata: libata: Pass the ATA port argument directly to ata_qc_issue()
  ata: libata: Pass the ATA port argument directly to
    __ata_qc_complete()
  ata: libata: Pass the ATA port argument directly to ata_link_abort()
  ata: libata: Enable context analysis
  ata: Annotate the code that uses the host lock

 drivers/ata/Makefile          |  2 ++
 drivers/ata/ahci.h            |  6 +++--
 drivers/ata/ahci_imx.c        |  1 +
 drivers/ata/ahci_xgene.c      |  1 +
 drivers/ata/libahci.c         | 11 +++++++-
 drivers/ata/libata-core.c     | 51 ++++++++++++++++++++++++-----------
 drivers/ata/libata-eh.c       | 23 +++++++++++-----
 drivers/ata/libata-pmp.c      |  5 ++++
 drivers/ata/libata-sata.c     |  4 +--
 drivers/ata/libata-scsi.c     | 18 +++++++++----
 drivers/ata/libata-sff.c      | 12 +++++++--
 drivers/ata/libata.h          | 28 ++++++++++++-------
 drivers/ata/pata_arasan_cf.c  |  1 +
 drivers/ata/pdc_adma.c        | 16 ++++++++---
 drivers/ata/sata_dwc_460ex.c  |  9 ++++++-
 drivers/ata/sata_fsl.c        | 12 +++++++--
 drivers/ata/sata_inic162x.c   | 10 +++++--
 drivers/ata/sata_mv.c         | 18 +++++++++++--
 drivers/ata/sata_nv.c         | 18 +++++++++++++
 drivers/ata/sata_promise.c    | 16 +++++++++--
 drivers/ata/sata_qstor.c      | 20 ++++++++++++--
 drivers/ata/sata_rcar.c       |  5 ++++
 drivers/ata/sata_sil.c        |  4 +++
 drivers/ata/sata_sil24.c      | 10 ++++++-
 drivers/ata/sata_sx4.c        | 11 +++++---
 drivers/ata/sata_via.c        |  1 +
 drivers/ata/sata_vsc.c        |  7 +++++
 drivers/scsi/libsas/sas_ata.c |  4 +--
 include/linux/libata.h        | 50 ++++++++++++++++++++++------------
 29 files changed, 293 insertions(+), 81 deletions(-)

