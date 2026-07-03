Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7510D320A37
	for <linux-ide@vger.kernel.org>; Fri,  3 Jul 2026 08:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783068725; cv=none; b=o1Ym6Ks+g6Lbf+n9HEWz3KXnAbiR1BhmrzrV8Tmq0x+Q+69N64zNHbAisXpCMq2nl5VsIPQTy5N4LiDXV9INQepsmPvTqCRXKvPUWX9g3+W9BC3PB0HLy6Lv+zRxBj0pHuDhPaxKTiNZhegQdP1p8lZ7uVG03BdMgoVJrQMLZYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783068725; c=relaxed/simple;
	bh=WJg0MO3tM+UeLQKplcwPjK2wJHmgMNyOdlJtZ1mFjRk=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=juHsdy6WF1yEn5dtke4vx33VVonXczmI8GjOzzRslIADsfIZPIiWUm9QJMcgoaQm/pgR/CII493rUcnoSw3W+sYRM+QEHyiliqzkjztGm4frqFbtfMeL9EUMI4IMUH+DWkk2uxkJI/XW8PTweYNX2RDKE1rfdR7UHJzoY5/Mmno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FpwbE5Xd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FpwbE5Xd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B44EB1F000E9;
	Fri,  3 Jul 2026 08:52:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783068724;
	bh=j7LEKmdE7CYw35csef0enRHcMQ92TsBeyFgkHQo/oVE=;
	h=From:To:Subject:Date;
	b=FpwbE5XdP/idBB6Wyiyusdnmzq5IFnWGcqWyzhRmS3fl17aEPK7yx+BtH3/V+EiF8
	 REeSaVF+iP0QOvtJmZ8rcfGuhA6cuqNDKKgOH/HXMn6N/sJArJJ4ExZ0me7D3I9A7B
	 V/QFXB6z9l4I/FXyv9OGcbpQ/OvybzEYW6zYjO9W1weFp+IiZgP7wqk5bSGwVRt85u
	 VhZlUrm6vs7/scpynolLiAdUd18Sq+tvBwFz0V5+ev/3vDRSVC/FTJ1qwOt6hm2qbW
	 oSjMLLEcqyeSQFV+wZYzzvtNMslOt2vA7TPFTBQTmOmzWKhR1NHV32GSZUHzABeWb7
	 v0jd1Ebsd/oMg==
From: Damien Le Moal <dlemoal@kernel.org>
To: linux-ide@vger.kernel.org,
	Niklas Cassel <cassel@kernel.org>
Subject: [PATCH v4 0/5] Improve ata_scsi_report_supported_opcodes()
Date: Fri,  3 Jul 2026 17:51:47 +0900
Message-ID: <20260703085152.2350034-1-dlemoal@kernel.org>
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
 - Patch 2: cleaned up the switch-case in ata_scsi_cmd_is_supported()

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
 drivers/ata/libata-scsi.c | 279 ++++++++++++++++++++++++++++++--------
 drivers/ata/libata.h      |   2 +-
 3 files changed, 226 insertions(+), 61 deletions(-)

-- 
2.54.0

