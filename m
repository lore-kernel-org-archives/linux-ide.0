Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED9B531714B
	for <linux-ide@vger.kernel.org>; Fri,  3 Jul 2026 04:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783051554; cv=none; b=uomDzDYd8ewdcndx+O6fvibkePnHWKLbF1Mg7G6NAKBTThWfcVGKSSGXmhbhKiDeVRO94FYB1sQU17f5VanyzgdRXPmn8Y8WqyuBJM8q/eWBlLdHpHtu8PcuW1doJZFPLpXuVB9c9t9Eqz61gw+WS3dIHuruExrA3u5eRwVJ5u0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783051554; c=relaxed/simple;
	bh=foewrzNW8vSdpOfSkPjY4GvxcgJQfEeWGE7anZnfROo=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=skQYKKJWOJ0B/ecJSUNM81XEaJ/9kh+gX0T4fI7Pa12iqtpcduhRIpElKgGbNB3OsDfnAjw2A+T2XjXppUoXh6M654KLCjenjZ4QNwRJ/LZZVjZddZXIhRx7HfeJ3rZZ6FbF2qnpMFMOSD9fas5aGdscU+3cJ6rvXncEOu1sDww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PZ/dqSty; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PZ/dqSty"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB0A51F000E9;
	Fri,  3 Jul 2026 04:05:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783051544;
	bh=naB/UScOV4/uXUNqn1Ex7/t82Op2O5O2awQdMuafTqE=;
	h=From:To:Subject:Date;
	b=PZ/dqSty1QVPllpDUf1Ij8xZ9TFqLRaiTYPWdiD3LNhQ5+Fa49lsYD0XDo+ufTJBS
	 2faIW5a3izs60RK91CyVe3EgSWwcy61xNGd2EDAF3Nc1cfH6i008aeDQqhcuIF3nZS
	 q03iGPxPf+zjfE5V52JkVdyGeFZXOGwbVkb35oBvuOv/bO9f9d0QMoOxtPVj0ln4br
	 U3MkATTvJd/aQ12PLKI+Ms0oG3g2QeQYJFZ2hJlX5LPwm69S45gEbgRavfeiUPkzIZ
	 cdk2o0tUgap9i0ijuc1V1f9Kb2zqCt79TRpCDUZJSfa7zXVQllya0F0rgxtffx5K+V
	 FyyCTRSNhfVNw==
From: Damien Le Moal <dlemoal@kernel.org>
To: linux-ide@vger.kernel.org,
	Niklas Cassel <cassel@kernel.org>
Subject: [PATCH v3 0/5] Improve ata_scsi_report_supported_opcodes()
Date: Fri,  3 Jul 2026 13:05:27 +0900
Message-ID: <20260703040532.2152614-1-dlemoal@kernel.org>
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
   9e       10        16    0,0    Read capacity(16)
   a0                 12    0,0    Report luns
   a1                 12    0,0    ATA pass-through(12)
   a3        c        12    0,0    Report supported operation codes

Changes from v2:
 - Patch 2: reformatted the array of supported commands and removed
   WRITE_SAME_16 command from it.
 - Applied review tags.
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
 drivers/ata/libata-scsi.c | 283 ++++++++++++++++++++++++++++++--------
 drivers/ata/libata.h      |   2 +-
 3 files changed, 228 insertions(+), 63 deletions(-)

-- 
2.54.0

