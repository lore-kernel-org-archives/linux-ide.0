Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04FE516DECE
	for <linux-ide@vger.kernel.org>; Wed, 26 Jun 2024 23:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719443066; cv=none; b=F8muXYMu9Xmb9RHqZaGx89xjBWWVWnckYi91j2dja9vkALXIOKi2Q4BlVchTWPeMTbTWh10ALSG8VtTEFXEZJEIUW8DYHLk4MymEI+OBdAO5mubssx5WC7lzdMp1bgPlg8IP7ma6Ux2l2JTZYswNAdOLUSDZ8azZnRPWn1wU/Q8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719443066; c=relaxed/simple;
	bh=thNpQ3XYjq0l29bHmAjAvzZEbiDdbYAYS9BgZ/I1OXI=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=QyfRax8vSlXHAtcsUutHCJRFyv8vWlNd3fJOB4rF2r/5LtPlrhEpGn9H051vZMXiViarWo4eItQiDKPtgyLLHYpC47dq4W33n3Bh8y6id2CEwyAFft9X2Z9ubPns0t5XMKgO1TksPno+fH6CNseshqAtbvziHWD0hRHmFb8zshg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ipylypiv.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=itP0ymUG; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ipylypiv.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="itP0ymUG"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-70663dee272so6639790b3a.0
        for <linux-ide@vger.kernel.org>; Wed, 26 Jun 2024 16:04:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719443064; x=1720047864; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Bm68GtolQcVfm/zlh3Xt5ndaIClcGdvUgqN+Vz8Uozw=;
        b=itP0ymUGck1OM4nV5zVGsqkXfafdYwAt9q1ghEY63q04+FfQKmKW7B4mPadB/33f2U
         I1dlgIKWtqXyQ991yXK4NrO5yLnX4e71s1ukuDxZ6L6mRGgELzbPesSiY6TZcO/r7BMU
         Y9vU/vmY+2/lTBEeZJnhVtaLWwbIt24N1n/BwgDaAc5RPFwlAvFOQL1AZebFxx4dSGLs
         Bt82Fj0TVANNU5pyLnMJzfRtYv/xbHemxePv6U0ZHZHwDt2ylxrHM/t5kJtjtY5ccYz1
         Z9EJ9qevEZUWvzfyiku1KgcJGt/ciH3NSqXBHv/1vhHR3di5AsQCZnLNRk/Ndk4d0lUa
         MUVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719443064; x=1720047864;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Bm68GtolQcVfm/zlh3Xt5ndaIClcGdvUgqN+Vz8Uozw=;
        b=Q+4NlV53+4xW4Z2iG0BxT85e9YoyUlCFMgO/P06FJElQDLQUuc1w0ahE5mUFGSNFbK
         vzBVrq6Y9HpNfolpkN8dwVWLQCdI8Vz0oaH3ANlx5jrx8gOE/qpMKYNSGZR9JrOM4D2R
         p54S2KDpcb+wQF0abJ0AIs89duoxeqIAtR8ImAahWpQ2xe5kB5ODf1/EwOkCkiGe4rdg
         A0evRzjgCov/pTq4edy70GVtWKjvIYOLxwHC4Kpmor8wB2x0VmSdq8dMofFlwWWADWkW
         3m93lgZE8Wl58N7cHLHV5hn4UbW8vT8cL/AjnAK2oDWrbM7wluYrpa9pUQdpEL4Weiui
         fivA==
X-Forwarded-Encrypted: i=1; AJvYcCUasIlo3X+/vbsCt0OZFjJ6oRTrhPOkgfnK/P6HuaC0upE0sDqaT2DvX2baYUsG/uZMhE9GnbmE1/JykLQ1cSdFyvdqmtEbxUiQ
X-Gm-Message-State: AOJu0YzuDWW1d3pVpH5HXtPedN+h+Y7JdCAek3FLkp11tnU1l7QjE6jK
	G633508ExcxRgnbzXEq+kIeA6NWOtS8ifbXZAconM3coYCNTMiHl7Anpg+ZW5mKQiT8tCER5MGL
	F/rbOw/1ahg==
X-Google-Smtp-Source: AGHT+IFxJ9oT13vAPMG8xv8MlGSAD37M21uBQiWSjojeUBluSfgjzrf8aJcLBnNasGrAR0DzF55xJBbtwAHOMQ==
X-Received: from ip.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:57f3])
 (user=ipylypiv job=sendgmr) by 2002:a05:6a00:4094:b0:704:26cc:fe68 with SMTP
 id d2e1a72fcca58-706746afe47mr202249b3a.3.1719443064178; Wed, 26 Jun 2024
 16:04:24 -0700 (PDT)
Date: Wed, 26 Jun 2024 23:04:05 +0000
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.2.803.g4e1b14247a-goog
Message-ID: <20240626230411.3471543-1-ipylypiv@google.com>
Subject: [PATCH v3 0/6] ATA PASS-THROUGH sense data fixes
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

Igor Pylypiv (6):
  ata: libata-scsi: Fix offsets for the fixed format sense data
  ata: libata-scsi: Do not overwrite valid sense data when CK_COND=1
  ata: libata-scsi: Remove redundant sense_buffer memsets
  ata: libata-scsi: Do not pass ATA device id to ata_to_sense_error()
  ata: libata: Set ATA_QCFLAG_RTF_FILLED in fill_result_tf()
  ata: libata-scsi: Check ATA_QCFLAG_RTF_FILLED before using result_tf

 drivers/ata/libahci.c     |  10 --
 drivers/ata/libata-core.c |   8 ++
 drivers/ata/libata-scsi.c | 188 ++++++++++++++++++++++----------------
 3 files changed, 115 insertions(+), 91 deletions(-)

-- 
2.45.2.803.g4e1b14247a-goog

