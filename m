Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1DC22BDC26
	for <linux-ide@vger.kernel.org>; Thu,  2 Jul 2026 06:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782974065; cv=none; b=rbcdgu5rxwGkv1M/DKJNkqm2cantWXMU3HxFfmhLTTcrQv4U8nRDMJp4sKRkfuHEh67AJfGMKHl05dr0kXr2CW/LBc6gqjfiSH5b/F3lqknLK72U6MAsr7BJAXxvLnsi9cu14cjJOJh8RxwLyqZgXglji32ax1HKngTCCRkIZQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782974065; c=relaxed/simple;
	bh=MSimrW6AvUaKtMHscmz9JUsa7h+ZDh5zqBhGL8zH4MA=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=cp8VLKCdPC92b5ziEeHFayyadJ2NdZPmH7h9tprrRZz3c33fX1uJf28xlx4ru9aJEuTZ5xst4lx5WV7mRuau8fY+LINsQdSi+xJHcR3Ypkj+mJoJQUOeGtPUzWV6SjOxTE2ZLhD7av8ZYGLFLdX/I+9Fig5b8zhU++2doIaGKDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AIm/FFyo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AIm/FFyo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8266E1F000E9;
	Thu,  2 Jul 2026 06:34:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782974063;
	bh=dN6bnRgwjFvYB5I54djDyG0DvT6BHJqURh8TjJ+Wd+Q=;
	h=From:To:Subject:Date;
	b=AIm/FFyopOGAzSdjS8h9Ywwl/rcdsV8Y3g5rrZl8MxcOVDhIQ53HV1wx0Wpc2BAUy
	 Jwh6aoEzSY+csVovM12/lG0CDrfKzyGS1sHto6HgWbPeDx/PMkPAbj0Qvy+5GFM3I0
	 FyWHdCGefNVNM5EhMTcO5iZxFPeCeSOadOPMVoqOUA68ATD3soBNoXmlscx+nqaEnW
	 NWnD5EJhoc0skrsSVRVsmXbfrEbXny1+ythV6ZdXOTWPtZPEjalvedr7uPkxeP5GvT
	 Zvf+K6/CGTeFCDSmlkqoRgMETyrk7DZVerPAPkIvmctGiveNaVaJ2VxLgm8C0fYj9V
	 rHt7+1f3Pqi1g==
From: Damien Le Moal <dlemoal@kernel.org>
To: linux-ide@vger.kernel.org,
	Niklas Cassel <cassel@kernel.org>
Subject: [PATCH v2 0/5] Improve ata_scsi_report_supported_opcodes()
Date: Thu,  2 Jul 2026 15:34:07 +0900
Message-ID: <20260702063412.1892584-1-dlemoal@kernel.org>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The implementation of ata_scsi_report_supported_opcodes() mostly satisfies
the internal use when an ATA device is probed from the SCSI layer, but it
is very incomplete. The code is also not very flexible for extending
support for new commands.

This patch series address these issues, cleaning up the implementation and
making REPORT SUPPORTED OPERATION CODES fully functional. E.g., with these
changes, sg_opcodes can be used for listing all SCSI commands that are
supported by libata-scsi and a device.

Example:

  # sg_opcodes /dev/sda
    ATA       WDC  WUH722626AL  WZ41
    Peripheral device type: disk

  Opcode  Service    CDB  RWCDLP,  Name
  (hex)   action(h)  size   CDLP
  -----------------------------------------------
   00                  6    0,0    Test Unit Ready
   01                  6    0,0    Rezero Unit
   03                  6    0,0    Request Sense
   08                  6    0,0    Read(6)
   0a                  6    0,0    Write(6)
   0b                  6    0,0    Seek(6)
   12                  6    0,0    Inquiry
   15                  6    0,0    Mode select(6)
   1a                  6    0,0    Mode sense(6)
   1b                  6    0,0    Start stop unit
   1d                  6    0,0    Send diagnostic
   25                 10    0,0    Read capacity(10)
   28                 10    0,0    Read(10)
   2a                 10    0,0    Write(10)
   2b                 10    0,0    Seek(10)
   2f                 10    0,0    Verify(10)
   35                 10    0,0    Synchronize cache(10)
   55                 10    0,0    Mode select(10)
   5a                 10    0,0    Mode sense(10)
   7f     1ff0        32    0,0    ATA pass-through(32)
   85                 16    0,0    ATA pass-through(16)
   88                 16    1,1    Read(16)
   8a                 16    1,2    Write(16)
   8f                 16    0,0    Verify(16)
   91                 16    0,0    Synchronize cache(16)
   93                 16    0,0    Write same(16)
   9e       10        16    0,0    Read capacity(16)
   a0                 12    0,0    Report luns
   a1                 12    0,0    ATA pass-through(12)
   a3        c        12    0,0    Report supported operation codes

Changes from v1:
 - Patch 2: Added an sa_valid field to the array of supported command to
   correctly handle sa == 0 being a valid service action (report zones) in
   patch 3
 - Dropped v1 patch 4
 - Patch 5: correctly set the servact field based on the sa_valid field of
   the array of supported commands.

Damien Le Moal (5):
  ata: libata: rename ata_dev_is_zac()
  ata: libata-scsi: refactor ata_scsi_report_supported_opcodes()
  ata: libata-scsi: improve service action support in
    ata_scsi_report_supported_opcodes()
  ata: libata-scsi: support reporting options 2 in REPORT SUPPORTED
    OPERATION CODES
  ata: libata-scsi: support the all command format for reporting
    supported commands

 drivers/ata/libata-core.c |   6 +-
 drivers/ata/libata-scsi.c | 242 +++++++++++++++++++++++++++++---------
 drivers/ata/libata.h      |   2 +-
 3 files changed, 189 insertions(+), 61 deletions(-)

-- 
2.54.0

