Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82B631487C7
	for <linux-ide@vger.kernel.org>; Fri, 14 Jun 2024 19:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718392728; cv=none; b=W93uybVHiibMScgGcZC9YV9FQim5Df43Rwcl/fjpIccf9zaRBZABiJn8RihSl5hHeejEgS075I+LOjPxtL1nbplwUNMztqBDua9IjwGcZv5i9M7jVayq233f6WsLeZC6K1q/3mslps621Vflby6sAcPASsLz10UKKuXlU17bbJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718392728; c=relaxed/simple;
	bh=MlT2UHhe380nkp9ttQmhAIbQuw1laeS/Uejo9GbqM/k=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=ULkvFeqcvEKS8iQ+0z3TKPkygaNdCAvfxMALAzTiWR2sRFUHoHxyPvHjCpUbQeU9eCEVV0NxJ1+4Ho4i2oqaVOlgVnhDeHIOCG60G4lBmXd4S8ZvsCn5ON1LM1Zg4ANa+M9akfge2onVpDCgHaA1Mfb9BHSPE0TLYPQR1/0+WCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ipylypiv.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yRKgWLOg; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ipylypiv.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yRKgWLOg"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-62fa28ecb7fso40322557b3.3
        for <linux-ide@vger.kernel.org>; Fri, 14 Jun 2024 12:18:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718392726; x=1718997526; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=jrmWp60aVeCWXrY6kwQHhqo9qwrjn/e4JEeFk/uELP4=;
        b=yRKgWLOghXAu6veStz/CqSVUMquw0xACmM+qG3K/7SIW9jZGplDnhknQ0+gZaWGklJ
         J9CEC4j42nySZnBcfVt+v8EgC8Q1Owt3MGf8O4zJq7JyngnCH8tTIiCEjq9L+wD324fI
         pQ9QsIQtZHGaSr8cShqyb1or3fIk4ZrCP4DEnbodA+UT9J3huT4zoE5J98JEQ/GuhUei
         eu21kSjGIPg03sHBv2iNCEgAlHsDY6KmtAzKOZCuOJhHzmabe1d8IZy1VmzAEzDV3XK9
         SYQVzwIanprk/NCBzzLXKVLJl+pNpYdBlb3S3A3/L4P84iyJzWj13cDgUF63c4htw8t4
         p4Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718392726; x=1718997526;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jrmWp60aVeCWXrY6kwQHhqo9qwrjn/e4JEeFk/uELP4=;
        b=wFnrEgRKZ0rtwikr3iFljzCvs17mg15JEPGWXWQIrkXr9A5A4v6KO7bd3iH1GlYJHL
         jzNbb6+5ZpSyBnnsQXLZ4B3/YAfhtXI8YNq1hDy09B7gdIdq2WMtC+9C1ZU1w1XS/btf
         WhkBGdkDo0S9GWPTiXfpbYwSsCRJ7h9omrtCT+DtO7dQcvTMz5R8FXOjcJD5juN7vhkd
         aeQEry9wIBb8Cxh8fXnfryqxogxfinj9v7sez2mSSydIQcZQCe34EeOIMgC+38vLOGSp
         Zf6pEBvJYLACoLekM/UGX+xtHAQMr5I85kCKhsU7eVZXRFsgBBEOKpAUzTEU8RM16to/
         ZKDA==
X-Forwarded-Encrypted: i=1; AJvYcCWrOFq3ny0TAGxKK9lP6fGE4hHcHvw/95nyOhVVtvvV0tpAR8zLR4TLfgPo++ZYZW7c35SCmCMd0Rk53tY/tuB9+Nwc+uaAEeRY
X-Gm-Message-State: AOJu0Yx59+gKPuaUrcZ9nqSIikgRy6aqiiGw4p+l8YfRSRMOYWCFGnOb
	wXvZEo5V5dc3AzwE5mhUKKn5p/4YRl0rOxg4QxrOrWPNAMt3kK9HbzAm0msbV0GwhswECobSZHa
	fiA42KGjHZA==
X-Google-Smtp-Source: AGHT+IGLrqJZAjVk49RRhDnJAw4q3ZNkoRivcI2IJKQhXabVF5QImj7XjJ/TVfso+Ht5gHtMalkF2VCTuwngvg==
X-Received: from ip.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:57f3])
 (user=ipylypiv job=sendgmr) by 2002:a05:690c:6f13:b0:622:c8eb:6ffd with SMTP
 id 00721157ae682-6321f6863cfmr6757507b3.0.1718392726537; Fri, 14 Jun 2024
 12:18:46 -0700 (PDT)
Date: Fri, 14 Jun 2024 19:18:31 +0000
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.2.627.g7a2c4fd464-goog
Message-ID: <20240614191835.3056153-1-ipylypiv@google.com>
Subject: [PATCH v1 0/4] ATA PASS-THROUGH sense data fixes
From: Igor Pylypiv <ipylypiv@google.com>
To: Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>
Cc: Tejun Heo <tj@kernel.org>, Hannes Reinecke <hare@suse.de>, linux-ide@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Igor Pylypiv <ipylypiv@google.com>
Content-Type: text/plain; charset="UTF-8"

This patch series is fixing a few ATA PASS-THROUGH issues:

1. Not reporting the sense data when ATA error happens and CK_COND is 0.
2. Generating "fake" sense data based on ATA status/error registers even
   though a valid sense data was already fetched from a disk.
3. Fixed format sense data was using incorrect field offsets for ATA
   PASS-THROUGH commands.

Igor Pylypiv (4):
  ata: libata: Remove redundant sense_buffer memsets
  ata: libata-scsi: Generate ATA PT sense data when ATA ERR/DF are set
  ata: libata-scsi: Report valid sense data for ATA PT if present
  ata: libata-scsi: Fix offsets for the fixed format sense data

 drivers/ata/libata-eh.c   |  2 --
 drivers/ata/libata-scsi.c | 53 ++++++++++++++++++++-------------------
 2 files changed, 27 insertions(+), 28 deletions(-)

-- 
2.45.2.627.g7a2c4fd464-goog

