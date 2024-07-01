Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87AEC16F908
	for <linux-ide@vger.kernel.org>; Mon,  1 Jul 2024 19:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719863886; cv=none; b=fFcSy3rD50F5WVwiLhvBXnTsCpuDkAFbq8sgIZKpj2jVvjoFg4NWLgJhsGr+bMDK2L+sODmNbahbw+abcthgIG8RmfQ1cui+SFfGAuMVGgZUdH5KhSkLJLDOcAaKxPmZlxbL2+f/zLXfCyzRDkSM3lHZJ5doJL5Jlasm6fufymw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719863886; c=relaxed/simple;
	bh=hSw1RdjOYxrznscfAT9oi6pV0GG0nHZ95Pa057gthes=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=oNiTzCTuhuxVVf5UE2F0k5i40oWS8c5IhNFugBPiVeT7lqmcoBtza9zINsUB1AawPljI8LF+cpXb5LDipB0gnEHLppZLrgppu1aUsFmxiSqFWbdJl91EUIrCyDkcErcsGOemBH/sflTWKnTgYLOAcpeOrJG4OldqoxRwBU/K3VU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ipylypiv.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=q3a5gHGV; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ipylypiv.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="q3a5gHGV"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-64b5588bcafso50264807b3.1
        for <linux-ide@vger.kernel.org>; Mon, 01 Jul 2024 12:58:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719863884; x=1720468684; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=dftt+MlvtCWViWAieULl6jrTTlhrpex3YjHVP4soiYw=;
        b=q3a5gHGVt314YMTlkVHyD/i5DImGswuvqzlf5Cr/0Tx/J9MbtIijPR+6CSvMmkJEvz
         HqYbG/U9AhAQKlIXRStPwaV9gx0pfR3HcnK0JXpe6BV3cyKl1joXFKQnzUAfICa0c3EK
         +wBtKG4oPqB9kEVbvM7cZzw6pzk/SYAMuon/SxpdL73IL74jOv2tSDcBFq6Hrb9gIyVv
         Qv5/cB60+CnZZI+fCQ8EzUjKx8oGLLfqPVyBL4knaLHrhTzMUMrTb0tpBcgRKXQwYxA3
         8FjXDbnU4h0hVqUW0rVAcT/hswHTufyyj2FxYwDGWYFtI2zzvb8nxbElX+xRoS15jOUV
         MEUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719863884; x=1720468684;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dftt+MlvtCWViWAieULl6jrTTlhrpex3YjHVP4soiYw=;
        b=XN+X3kqwIQ+NNUA4f22kuBeVm+91a/QMq13BiLhg8Oa8bKHS+RJm+4oOh+bc2ENCow
         lZA1+h0HEnGbYrtU8Ewm0aCPLzukhtfkqChfPsazq6yTJ6WwaN/YqNiHN2KYgB4TpdsW
         nm2I7ir9M0/PLMI3IcrXOsm9kYOMOTGeWfY7TbkxtvVHdS5Pa2r3gsLfaVIFnPRo7Pxy
         0EUmjkjWK4vQPEHiG01M26LXY4BgMP4yY/gGD4oQQuf3tSKeIig9TY8z0tLGslipBdGx
         nXic5aa9BhD4hzfMiuZa06zrZxg2/w1fASjQcMPGhMiERG9SGbqJg30YYqD5xEEIKRGb
         aw2Q==
X-Forwarded-Encrypted: i=1; AJvYcCXjpgedTTkWpFI6y0laab8hjHgfo1gTXjxnF/kiLYgmQemjM6r+3O7Rzu0oBkoeKaCluHRhyiw7t5WnBEHsyGlmXkrWlKNPxS2v
X-Gm-Message-State: AOJu0YxX3EX26cFcyIeYZotvKsQ2xz6QRzCmy88/BOzTxawVITkoVe9j
	dnqYg1nCIK/GQ02J/v30kTo4Zqau3qwrKtLTWWFPZdYzSeOnF2LAgEqcEqO9GN0HJh+iz1ZQWvh
	5z2LB0P/+HA==
X-Google-Smtp-Source: AGHT+IFpDUJj3GPXAd+cOb6o2Mm1A3wbQxbX0ENvMajqChQd2DnD0Mhx8tyIK7+N3sJ3kHkwr1Seg5QXz3LUbA==
X-Received: from ip.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:57f3])
 (user=ipylypiv job=sendgmr) by 2002:a05:6902:c07:b0:dfb:fb2:ebd with SMTP id
 3f1490d57ef6-e036ec147e8mr16080276.8.1719863884021; Mon, 01 Jul 2024 12:58:04
 -0700 (PDT)
Date: Mon,  1 Jul 2024 19:57:50 +0000
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.2.803.g4e1b14247a-goog
Message-ID: <20240701195758.1045917-1-ipylypiv@google.com>
Subject: [PATCH v4 0/8] ATA PASS-THROUGH sense data fixes
From: Igor Pylypiv <ipylypiv@google.com>
To: Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>
Cc: Tejun Heo <tj@kernel.org>, Hannes Reinecke <hare@suse.de>, linux-ide@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Igor Pylypiv <ipylypiv@google.com>
Content-Type: text/plain; charset="UTF-8"

This patch series is fixing a few ATA PASS-THROUGH issues:
1. Not reporting "ATA Status Return sense data descriptor" / "Fixed format
   sense data" when ATA_QCFLAG_SENSE_VALID is set.
2. Generating "fake" sk/asc/ascq based on ATA status/error registers when
   ATA_QCFLAG_SENSE_VALID is set and CK_COND=1.
3. Fixed format sense data was using incorrect field offsets for ATA
   PASS-THROUGH commands.
4. Using qc->result_tf in ATA sense data generation functions without
   checking if qc->result_tf contains a valid data.

Changes since v1:
Thanks Damien and Niklas for the reviews!

- Squashed two v1 patches 2/4 and 3/4 into one patch with a different
  implementation.
- Added 'Cc: stable@vger.kernel.org' tags to patches that are fixing bugs.
- Reordered patches with the 'Cc: stable@vger.kernel.org' tag to be applied
  first in order to simplify backports to stable releases.
- Restored the buffer memset in atapi_eh_request_sense().
- Updated declaration order in v1 patch 4/4.
- Added a patch to cleanup unused ATA device id in ata_to_sense_error().
- Updated fill_result_tf() to set ATA_QCFLAG_RTF_FILLED after populating
  the result taskfile. Removed now redundant flag sets/checks from ahci.
- Updated ATA sense data generation functions to return early if result_tf
  is not filled. Added WARN_ON_ONCE checks to generate a warning when
  ATA_QCFLAG_RTF_FILLED is not set and libata needs to generate sense data.

Changes since v2:
- Moved v2 2/6 patch (fixed ATA PT offsets) to be the first one in v3.
- Removed unused variable 'sb' from ata_gen_passthru_sense().
- Removed WARN_ON_ONCE checks and added ata_dev_dbg() logs instead.
- Removed the Fixes tag from v2 4/6 patch because the patch is doing
  a cleanup and is not fixing any bugs.

Changes since v3:
- Changed "RTF" to "result TF" in the log messages to make it more clear.
  Removed capitalization and punctuation to be consistent with existing logs.
- Marked the stable tag of the v3 2/6 patch with the 4.19+ LTS version.
- Added a patch to honour the D_SENSE bit for CK_COND=1 and no error commands.
- Fixed a bug in the v3 5/6 patch which caused the qc->result_tf.flags field
  assignment to be skipped if ahci_qc_ncq_fill_rtf() was executed.
- Added a patch proposed by Niklas to improve the readability of the complex
  ATA PASS-THROUGH handling in ata_scsi_qc_complete().

Igor Pylypiv (8):
  ata: libata-scsi: Fix offsets for the fixed format sense data
  ata: libata-scsi: Do not overwrite valid sense data when CK_COND=1
  ata: libata-scsi: Honour the D_SENSE bit for CK_COND=1 and no error
  ata: libata-scsi: Remove redundant sense_buffer memsets
  ata: libata-scsi: Do not pass ATA device id to ata_to_sense_error()
  ata: libata-core: Set ATA_QCFLAG_RTF_FILLED in fill_result_tf()
  ata: libata-scsi: Check ATA_QCFLAG_RTF_FILLED before using result_tf
  ata: libata-scsi: Make ata_scsi_qc_complete() more readable

 drivers/ata/libahci.c     |  12 +--
 drivers/ata/libata-core.c |   8 ++
 drivers/ata/libata-scsi.c | 209 +++++++++++++++++++++-----------------
 3 files changed, 128 insertions(+), 101 deletions(-)

-- 
2.45.2.803.g4e1b14247a-goog

