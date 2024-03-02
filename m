Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C73A017F3
	for <linux-ide@vger.kernel.org>; Sat,  2 Mar 2024 00:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709338616; cv=none; b=rPsvUNZzyXxmfLtoTDNjmAl/He0TobPBkzNLaTCDN+muqBm/GMpZnfDzaZqWh7mSu3Xr3GrGPLoPOXwP121lWYSIBldBYqRlRExJr1Q3oqJ/jVGwJXJ3uRiIEBqemZOyttzgjJ6DeiB8lJqdmKKOvn8pkovLYx93G5ATIr0at54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709338616; c=relaxed/simple;
	bh=pgSiW+xTZmFhlX83o7Jy94TLdmZvLPZgS0gnfRjbOfE=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=jl8SuPjPxLLXA9muT093AgbELlvSyvi2lwipabKNNYoSveYkQg6vNBUT4y0DTP3yfwumKDpyFrpon7VF6lJh5BEdtCuFr4hebYmnkc/w9BByY4P3/7o9kcivMF1EbsfyYOSyE8ARgdbW/N0lqyE9blCvh5v9hpnJzDwKaZfbupk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ipylypiv.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Uc0F4Ca6; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ipylypiv.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Uc0F4Ca6"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dcf22e5b70bso4745527276.1
        for <linux-ide@vger.kernel.org>; Fri, 01 Mar 2024 16:16:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709338614; x=1709943414; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=XJVqfGzfplRxpO5E0p6+cO7VAdJkT8FDhuCSfsmbM5I=;
        b=Uc0F4Ca6r8FXVZSUSeciJODpxecUFJ/UH7kkvl3HBmmg/tnNFI76oedrrciyfRf6Y1
         E1jOXF4ihLc1zmwvOgWN3Kl0aOyJ0azxqpHreaSEc0Kj3upVwVp/bNvz/RZbgnC395Ij
         rDPZbS8QSTFTYfvOb0Oww8lruD1oaiyIeaJFTbosCz0/MNWm4qlH0ug/svU9uYhijzzg
         d8pugB0guCjYycedqAJ4bDhh8DzbBrJq0EkbDjnfKc/oFjFQNAjZwpz6NHfLbnOEY7EY
         c02pkEpj/IaNrWg2F4jabQYmXd1XzgD11FSLo/qjcUh3ZB+i2nWmIfqVtMpnPUeWLI9z
         JXhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709338614; x=1709943414;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XJVqfGzfplRxpO5E0p6+cO7VAdJkT8FDhuCSfsmbM5I=;
        b=d+3LkxhNuqP1bDrtONAdpvDQc91wdFBQggE4CzHdTa2ryl40D0nlT+j4jksZm11veB
         qG2qahkEYBR8TgWbOn1pXr8FdXWWSGfzHshlJhRsEYjteMIXOTP++vbaHrcs9Zeoqgbd
         MYXxoCTKO2vmeNIKfvgj60Il4uzYXetWLTx62WhSNB6p1+u6L3tNsEbj4wxJAY/hgskJ
         t8Qwwu/3AEEgngRSiafpPmdX2dDC+20K7/6y/LBJnt3mkwfpZVBQ9Y4GYUsLoqM9f8FO
         AN8AQUImzLSctQa7fC7nPD0JO8ReXXVBhX225AaOQSdmkViMv8ZMUEfqQN46SUeolx2J
         8g+Q==
X-Forwarded-Encrypted: i=1; AJvYcCVQoa3PQuO7IYCfwcEtECR/Rkd1b8Sd1u5vV6bsnpgAZr18VPS1uEGAIODMzppZQcq20S6cj29fWWpbV/VTaMGOlnkU5doLErXR
X-Gm-Message-State: AOJu0Yw0LC3nJD8+SkTX3K77oEOXfR26vG2SzMMwa1Y1PTkqf6e9NTO3
	4YJ7X/PAJvlzM+RPwml8w51FQrI3GRRjE7gR7cpxE+7cpQ0sOI0ZPQM7fhbYihspDCr+Fn+Ynga
	HhhmrncfrxA==
X-Google-Smtp-Source: AGHT+IF8MBkXR+4X6PdgrM7IJa8RzUArE+pN73OYsy0OYujkB856aRXm5tQ58UhSH5oUu5ad9tsySL5EyAhqGQ==
X-Received: from ipylypiv.svl.corp.google.com ([2620:15c:2c5:13:2afe:1a8e:f846:999f])
 (user=ipylypiv job=sendgmr) by 2002:a05:6902:1209:b0:dc6:e20f:80cb with SMTP
 id s9-20020a056902120900b00dc6e20f80cbmr115663ybu.3.1709338613902; Fri, 01
 Mar 2024 16:16:53 -0800 (PST)
Date: Fri,  1 Mar 2024 16:15:57 -0800
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Message-ID: <20240302001603.1012084-1-ipylypiv@google.com>
Subject: [PATCH v2 0/5] NCQ Priority sysfs sttributes for libsas
From: Igor Pylypiv <ipylypiv@google.com>
To: Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>, 
	John Garry <john.g.garry@oracle.com>, Jason Yan <yanaijie@huawei.com>, 
	"James E.J. Bottomley" <jejb@linux.ibm.com>, "Martin K. Petersen" <martin.petersen@oracle.com>, 
	Jack Wang <jinpu.wang@cloud.ionos.com>, Hannes Reinecke <hare@suse.de>
Cc: TJ Adams <tadamsjr@google.com>, linux-ide@vger.kernel.org, 
	linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Igor Pylypiv <ipylypiv@google.com>
Content-Type: text/plain; charset="UTF-8"

This patch series adds sas_ncq_prio_supported and sas_ncq_prio_enable
sysfs sttributes for libsas managed SATA devices. Existing libata sysfs
attributes cannot be used directly because the ata_port location is
different for libsas.

Changes since v1:
- Dropped the "sas_" prefix to align sysfs sttributes naming with AHCI.
- Dropped ternary operators to make the code more readable.
- Corrected the formatting %u -> %d in sysfs_emit().
- Changed kstrtol() to kstrtobool() in [ata|sas]_ncq_prio_enable_store().
- Changed comments to use the "/* */" style instead of "//".
- Added libsas SATA sysfs attributes to mvsas and hisi_sas.
- Dropped the 'Reviewed-by' tags because they were not sent in-reply
  to the patch emails.

Igor Pylypiv (5):
  ata: libata-sata: Factor out NCQ Priority configuration helpers
  scsi: libsas: Define NCQ Priority sysfs attributes for SATA devices
  scsi: pm80xx: Add libsas SATA sysfs attributes group
  scsi: mvsas: Add libsas SATA sysfs attributes group
  scsi: hisi_sas: Add libsas SATA sysfs attributes group

 drivers/ata/libata-sata.c              | 139 ++++++++++++++++++-------
 drivers/scsi/hisi_sas/hisi_sas_v1_hw.c |   6 ++
 drivers/scsi/hisi_sas/hisi_sas_v2_hw.c |   6 ++
 drivers/scsi/hisi_sas/hisi_sas_v3_hw.c |   6 ++
 drivers/scsi/libsas/sas_ata.c          |  92 ++++++++++++++++
 drivers/scsi/mvsas/mv_init.c           |   7 ++
 drivers/scsi/pm8001/pm8001_ctl.c       |   5 +
 drivers/scsi/pm8001/pm8001_init.c      |   1 +
 drivers/scsi/pm8001/pm8001_sas.h       |   1 +
 include/linux/libata.h                 |   4 +
 include/scsi/sas_ata.h                 |   6 ++
 11 files changed, 233 insertions(+), 40 deletions(-)

-- 
2.44.0.278.ge034bb2e1d-goog

