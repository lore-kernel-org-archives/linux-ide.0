Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 394B313C901
	for <linux-ide@vger.kernel.org>; Mon, 24 Jun 2024 22:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719267149; cv=none; b=jUfgRCjiF70T7lWilHKwqc1bI7/+PYTy3xTRN8UEYVT3LK057Q9kCGf2/AkRwrIEyHvbfiH8rVPdIGxUMfwRVI9WGEefdo2SIudFubPQ2l0pAYc7x+B/Gj5Sz3lwS61ilacAtexlDDherRoMqhChV55vVx6It1lr+lENuTyi70s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719267149; c=relaxed/simple;
	bh=V88kbQYMmksLo0hGgVvNJpR1yEr6VGpMad/TuUmx0Gk=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=QNoTLb1I1DnubclQJyKsnv4JP85bcbUJ71euG4owW+Euiq9Jw6xZW4TvOPY9hfKevT1GZU5L+1AhjR8nLuQhZ88NOVz1MKJ/BlLiIfp5O+GxS+FYPGRR7waV86Wts2mep0ZNlAyuA6oKNuJgUeEWIlJtAFX9gc1EB7Yp0Y9E53c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ipylypiv.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3okE+k5H; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ipylypiv.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3okE+k5H"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e02fff66a83so3982316276.0
        for <linux-ide@vger.kernel.org>; Mon, 24 Jun 2024 15:12:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719267147; x=1719871947; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=TL/yt1aeykxZxZD2zlQYwkIf/JVQR0dKRLPmP/BJTrE=;
        b=3okE+k5HpseRB3Jn204qhQCa9l+4Uw8/ZQiGIWCRTvH6KwdYxyKZYDlkcrqxd/2ICn
         GsYfGURVoRbTcNxMdHglZuegXGsna64SAMYlc8PFphZucKYzG/iqMEfev8hC1hlGy/oz
         0WstlA42fT4iKDQl8DnvDVxBw852/kdd5RZKpdMju6Hfp5Ac57+NhglqQvBxVvRjebGF
         RqYD8ZFNAdbxM+Ii20YqUGmI74e38A4H7fA46oU2TCd4Z4BPllaCAbFG0pltGvP0Md/b
         NWIWsAMsNl0ZBiAldwohS/6wKPI6c6UVEd76P4DiaX9DFVClZgz2gxfJRiyzEpdK7nL9
         ODHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719267147; x=1719871947;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TL/yt1aeykxZxZD2zlQYwkIf/JVQR0dKRLPmP/BJTrE=;
        b=TR2R1PpTbuLdUzh6RzEj2ClLiU2tMX1vNrRfsxXEp1EbphEMCPF4W3uiE78grdRo2w
         7noDWxck0hop4SCogz8jCXl0Hg5cm8F4E47bJRHRcMcH+sPvJtA07dOdt5PexwmymOwG
         TvGnWU53iNpN6kVXMkfPNz57WX7U/HiD/HL7hS2dhg+UHyljsmoEqAS+lhD2HYCM45zY
         XZvhVjqwvY7xdJLEjX9kgYGXZxvxpE0VeLInjHLIBO9Y6rQDnLvGNCKEEht6tzbEz4WE
         0zvOqBbhJQMUTqrjB8+irxvSh64YBkxKE9IzRaKW0GCjjUmbcy8XIU5PSkhvo6FePoHc
         50Sw==
X-Forwarded-Encrypted: i=1; AJvYcCXsskmFHNGZ/gW4M26T15hfS/Rc+46M9IRGW7jyz+MxB+imAhtGgV/TQpOy1GggNBQlAdTythgx3LGzsLM+KTUr1MjEm+8sdWxK
X-Gm-Message-State: AOJu0YyToN1x/P2MMcXvnSklsgq+f6jTywylntw53/d6BUqtalh5aRoS
	PNH18j2a7VI2hDy/7C2rfhLpIHgq91TsoERj1KQODBtB5TrVOWk5fS16VMgwuhcwUWim1H6I9bK
	UtDGW6yf1qw==
X-Google-Smtp-Source: AGHT+IGlHRclBh4I8qdw95Zucf/j3km06XZvKd5bHZ5qYEohmfuPkKF/QDVdh2oto2O1iYTdnDAvlgr3u83Ixw==
X-Received: from ip.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:57f3])
 (user=ipylypiv job=sendgmr) by 2002:a05:6902:1242:b0:df4:920f:3192 with SMTP
 id 3f1490d57ef6-e0301031c99mr14887276.8.1719267147153; Mon, 24 Jun 2024
 15:12:27 -0700 (PDT)
Date: Mon, 24 Jun 2024 22:12:04 +0000
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.2.741.gdbec12cfda-goog
Message-ID: <20240624221211.2593736-1-ipylypiv@google.com>
Subject: [PATCH v2 0/6] ATA PASS-THROUGH sense data fixes
From: Igor Pylypiv <ipylypiv@google.com>
To: Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>
Cc: Tejun Heo <tj@kernel.org>, Hannes Reinecke <hare@suse.de>, 
	"Martin K. Petersen" <martin.petersen@oracle.com>, Jason Yan <yanaijie@huawei.com>, 
	linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Igor Pylypiv <ipylypiv@google.com>
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

Igor Pylypiv (6):
  ata: libata-scsi: Do not overwrite valid sense data when CK_COND=1
  ata: libata-scsi: Fix offsets for the fixed format sense data
  ata: libata-scsi: Remove redundant sense_buffer memsets
  ata: libata-scsi: Do not pass ATA device id to ata_to_sense_error()
  ata: libata: Set ATA_QCFLAG_RTF_FILLED in fill_result_tf()
  ata: libata-scsi: Check ATA_QCFLAG_RTF_FILLED before using result_tf

 drivers/ata/libahci.c     |  10 ---
 drivers/ata/libata-core.c |   8 ++
 drivers/ata/libata-scsi.c | 179 +++++++++++++++++++++-----------------
 3 files changed, 107 insertions(+), 90 deletions(-)

-- 
2.45.2.741.gdbec12cfda-goog

