Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF21029CE9
	for <linux-ide@vger.kernel.org>; Thu,  2 Jul 2026 01:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782957419; cv=none; b=VnNPuKqpuVvYtqAwxuuFa2jO9xSZiG9lpWcsR83A103ND4JSnuSXAfIVFx/S+3pHjjGTdRWsbR3OrE7kAbNScuQNVNkAIyoz+7h9tSTAqIxzVUPSYvHxTe7BAZFa/nQUhLn2NrpevTNZnQ3B2oIk469Dx6mpTWA4Dj0CE8ah5+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782957419; c=relaxed/simple;
	bh=Tz4Np0c3CrH4BTkjXQSYm81zCgJt5CWIwBRCFOi/X1I=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=Ff4DS1QFZGsxyUOHDdvOajqeLafmByvLfqwcqkIkAjV06B1iJABVIUoGFcF93viPHnKDUXVzPbglOolWKncPhXgTIYwGZDgkyblLz432czjnRSDZ7yRfvfqwAhlMjutgBFIQq/zsVpBvoNIdlC/kFCsE5DQaWo21cFO8QvzouXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HPQ6EolJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HPQ6EolJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27D231F000E9;
	Thu,  2 Jul 2026 01:56:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782957418;
	bh=tdCd808GrQCqNgKpHVwGbr0Dl6lHL+WoUgBYb0VTdBg=;
	h=From:To:Subject:Date;
	b=HPQ6EolJbnALoo1Mi1Mv18NRjFgAE8bSoAv5dVqXL2Au0uwlRubqhMCnEk0nMLiYE
	 jZuobpN2IeBkzEMqzxQdz5UnTPL26j4rjOLN4Rcsv5ExSsFf2QNMW8vt6LFTAYp8CU
	 HPSwPU9a/pboe/A/pbqd5ulCdLzqK+6hrYJqaKzMP6PA/VXQbhIRCyjEaMjhun6Y7/
	 QY2M62eVpS6qnV7c8M6o9N62jsuh48g9JKS6et3NgsP+UnEpiweUGnKGg2+Pv9I2ZW
	 K87ZiJSLvR+ujD5viTQFQ0EbZ0hHhxh6/seRiTxO+gqdM/86RwcSXyRwhY2WXQ0krZ
	 4R97BWwgIXT7A==
From: Damien Le Moal <dlemoal@kernel.org>
To: linux-ide@vger.kernel.org,
	Niklas Cassel <cassel@kernel.org>
Subject: [PATCH v1 0/6] Improve ata_scsi_report_supported_opcodes()
Date: Thu,  2 Jul 2026 10:56:40 +0900
Message-ID: <20260702015646.1702539-1-dlemoal@kernel.org>
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
      7f                 32    0,0    Variable length
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

Damien Le Moal (6):
  ata: libata: rename ata_dev_is_zac()
  ata: libata-scsi: refactor ata_scsi_report_supported_opcodes()
  ata: libata-scsi: improve service action support in
    ata_scsi_report_supported_opcodes()
  ata: libata-scsi: improves checks for ZBC_IN and ZBC_OUT commands
    support
  ata: libata-scsi: support reporting options 2 in REPORT SUPPORTED
    OPERATION CODES
  ata: libata-scsi: support the all command format for reporting
    supported commands

 drivers/ata/libata-core.c |   6 +-
 drivers/ata/libata-scsi.c | 252 +++++++++++++++++++++++++++++---------
 drivers/ata/libata.h      |   2 +-
 3 files changed, 199 insertions(+), 61 deletions(-)

-- 
2.54.0

