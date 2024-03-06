Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E1D7A50
	for <linux-ide@vger.kernel.org>; Wed,  6 Mar 2024 01:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709688152; cv=none; b=knVS1b2ZcSM8FeQfzTcelLxpFGW/Q8+Ok2pPApiDphmwXXFCt2b2GWwuwjV95rR1j2eA0yKdlAsUUzXLP9nog1wqKo6bH3z4tR87P0qAmbVD1jyEH6BuRIVY9oBEXwsyaow7e92aWyt3clVW/VmNGxt0uXKPHPT4Y2vDLqOMd4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709688152; c=relaxed/simple;
	bh=ovWANtziTLgaKyP6RnT4RlvydmnOGNyzgBpAYyn9GeY=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=drxV+BG50iWZ+B2pUZZxItTbjvYY7vECtNiiWi6wCRBST+MimUgr/2LN46PTVRDBdDWm5L7wCCYmz1ANA+oep64Te4Jkav03RbXWtB8yptTaNtcz5XHe+YNawIgV5vU5Qvc8UMowYDDB3B/PN3jH4huGxoz9/sCWhmje7/LzW74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ipylypiv.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=r//sWaZO; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ipylypiv.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="r//sWaZO"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dbf216080f5so10531758276.1
        for <linux-ide@vger.kernel.org>; Tue, 05 Mar 2024 17:22:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709688150; x=1710292950; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=rWap45PpMlOg/VvjoTJwWhXfR/oS7SDDWB/wilCHSAM=;
        b=r//sWaZOznVcLRjqJE56ddUu8Nej3/uSPnU4u+wX2rXgciSJ/3E50vbcZIC95wDG4I
         vBP4VGM/38XCPR8bhnQ7a1kHskXyXXrGY23/nQqjHzNEuGV18VjA/1/l4lTYMGKavl1M
         pTtAdw72ZeydPEszbkG7Hx8D1GMXrsQbSalpMmoPFv/Ynn8RpEgPBXXIJLjQbcCRiou9
         ujSNVF1uGD4qOZteSbk3LOIeY2qU+BtNr5J5yFqMUziuLPM7SfrO+w8INFqmAKZZj/so
         kIqlNjfce3bTMwRBURmYyR80v0/oedFlzuDkgBCAdmLMqtpVRjablZAch1rxFc31f88N
         dIpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709688150; x=1710292950;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rWap45PpMlOg/VvjoTJwWhXfR/oS7SDDWB/wilCHSAM=;
        b=UOa76E+BjJUBk8XOHRtlgNW2kMdOzvA05GFSoT/Fmmk7wL2zrVZL1weo2R0dxKteR7
         IG4CrA0Q3eP64rSknKmjXydt/h4cZXdC7WlkY4wkCGsMqgONYhwj93cI5h5ygnp8A1CJ
         MTuHW1AEJ09knvsaeq7YUNsbTsx1vOgmoWvte+jhSOyVAc9NqQP1pU20Fh3+p+4GDOYr
         2DTOX5WjG85QLjlFwciOIdDbBEyuCSosT/3YQ/H3ckywQwofe/Na6Dv2bDf/A/uUPclD
         czcvGB+TFPy8c35xDgiwob21LvACyxm4gOoDzilvVJA4RNalyXRorAsAKTaYid0tA4I/
         aUSA==
X-Forwarded-Encrypted: i=1; AJvYcCVOeeXid68zDwp7XCHKjCyhO36o41EjNud+g+5+EFxxnlnA5kwGTFarF7SzXqbdz9hoEnO2gqtjpCEnJIMZYJ3xJxOGphirZ8J9
X-Gm-Message-State: AOJu0YwP6rXmfe/qCCU5WS+46sICznnH3wxr3kVm2FjtzbkPe81/leZH
	R8+H6OWvHMTlyIJBeRANQtcPfpiHumT8fiElhuJdpdw/g3cWjrSCilu7OZXHd6FbPUSFlvycvhP
	5zJoCNzf2+g==
X-Google-Smtp-Source: AGHT+IE5+XiMNeVeinNc/gcfoKpqIeedSrJdv+f1LwO+7asYoPxcrr87p5WZco4jHKhMEfrqzUrLVapiDJg3/w==
X-Received: from ipylypiv.svl.corp.google.com ([2620:15c:2c5:13:69ff:df2c:aa81:7b74])
 (user=ipylypiv job=sendgmr) by 2002:a05:6902:1081:b0:dc2:550b:a4f4 with SMTP
 id v1-20020a056902108100b00dc2550ba4f4mr3564063ybu.1.1709688150355; Tue, 05
 Mar 2024 17:22:30 -0800 (PST)
Date: Tue,  5 Mar 2024 17:22:19 -0800
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Message-ID: <20240306012226.3398927-1-ipylypiv@google.com>
Subject: [PATCH v7 0/7] NCQ Priority sysfs sttributes for libsas
From: Igor Pylypiv <ipylypiv@google.com>
To: Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>, 
	John Garry <john.g.garry@oracle.com>, Jason Yan <yanaijie@huawei.com>, 
	"James E.J. Bottomley" <jejb@linux.ibm.com>, "Martin K. Petersen" <martin.petersen@oracle.com>, 
	Jack Wang <jinpu.wang@cloud.ionos.com>, Hannes Reinecke <hare@suse.de>, 
	Xiang Chen <chenxiang66@hisilicon.com>, Artur Paszkiewicz <artur.paszkiewicz@intel.com>, 
	Bart Van Assche <bvanassche@acm.org>
Cc: TJ Adams <tadamsjr@google.com>, linux-ide@vger.kernel.org, 
	linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Igor Pylypiv <ipylypiv@google.com>
Content-Type: text/plain; charset="UTF-8"

This patch series adds sas_ncq_prio_supported and sas_ncq_prio_enable
sysfs sttributes for libsas managed SATA devices. Existing libata sysfs
attributes cannot be used directly because the ata_port location is
different for libsas.

Changes since v6:
- Replaced sas_ata_sdev_attr_group definition with a macro for
  the "CONFIG_SCSI_SAS_ATA is not set" case. The macro defines
  an empty rvalue struct eliminating the variable definition.

Changes since v5:
- Added __maybe_unused attribute to sas_ata_sdev_attr_group to prevent
  an unused-const-variable warning when CONFIG_SCSI_SAS_ATA is not set.

Changes since v4:
- Updated sas_ncq_prio_* sysfs functions to use WARN_ON_ONCE() instead
  of WARN_ON().

Changes since v3:
- Changed ata_ncq_prio_supported() and ata_ncq_prio_enabled() to store
  the result into a boolean variable passed by address.
- Removed the "usable with both libsas and libata" wording from
  ata_ncq_prio_* helper's function comments.
- Removed the unlikely() in ata_ncq_prio_enable() because the function
  is not in a fastpath.
- Dropped hisi_sas v1 HW driver changes because it doesn't support SATA.

Changes since v2:
- Added libsas SATA sysfs attributes to aic94xx and isci.

Changes since v1:
- Dropped the "sas_" prefix to align sysfs sttributes naming with AHCI.
- Dropped ternary operators to make the code more readable.
- Corrected the formatting %u -> %d in sysfs_emit().
- Changed kstrtol() to kstrtobool() in [ata|sas]_ncq_prio_enable_store().
- Changed comments to use the "/* */" style instead of "//".
- Added libsas SATA sysfs attributes to mvsas and hisi_sas.
- Dropped the 'Reviewed-by' tags because they were not sent in-reply
  to the patch emails.

Igor Pylypiv (7):
  ata: libata-sata: Factor out NCQ Priority configuration helpers
  scsi: libsas: Define NCQ Priority sysfs attributes for SATA devices
  scsi: pm80xx: Add libsas SATA sysfs attributes group
  scsi: mvsas: Add libsas SATA sysfs attributes group
  scsi: hisi_sas: Add libsas SATA sysfs attributes group
  scsi: aic94xx: Add libsas SATA sysfs attributes group
  scsi: isci: Add libsas SATA sysfs attributes group

 drivers/ata/libata-sata.c              | 140 ++++++++++++++++++-------
 drivers/scsi/aic94xx/aic94xx_init.c    |   8 ++
 drivers/scsi/hisi_sas/hisi_sas_v2_hw.c |   6 ++
 drivers/scsi/hisi_sas/hisi_sas_v3_hw.c |   6 ++
 drivers/scsi/isci/init.c               |   6 ++
 drivers/scsi/libsas/sas_ata.c          |  94 +++++++++++++++++
 drivers/scsi/mvsas/mv_init.c           |   7 ++
 drivers/scsi/pm8001/pm8001_ctl.c       |   5 +
 drivers/scsi/pm8001/pm8001_init.c      |   1 +
 drivers/scsi/pm8001/pm8001_sas.h       |   1 +
 include/linux/libata.h                 |   6 ++
 include/scsi/sas_ata.h                 |   6 ++
 12 files changed, 247 insertions(+), 39 deletions(-)

-- 
2.44.0.278.ge034bb2e1d-goog

