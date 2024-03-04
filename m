Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6319A79DCE
	for <linux-ide@vger.kernel.org>; Mon,  4 Mar 2024 22:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709590105; cv=none; b=XQcXI3sHnM05Oe/MRCcbJhe+/3zeYNWrQwlZgqifHOjewftVKLV78B5/MV8rv0zQlW8Zk2r+5gUA02bQmzKWNA1SNy/ydOezqx0nUunq1fHS1/FzH8H+4TKx+XXejfueZqiIs1G88LQ/ErbJmawnQsA9i3Y1cuca7AuJtMQUq+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709590105; c=relaxed/simple;
	bh=KIrzPff8X5XmBjckpJFSRt5Ce/eTKlP0CC/qHYRxzi0=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=cvW0ZJbwf6M8LRLYluAYiXMVMpp5Pm0bUGcpx3lL3r/RA7Z/A1/OSf4Jue5/DsyPDcuTI+IwU0RnlBaRhghco2Pq2rYndqvzpOUsiP0wmCJnRwAVqGwsnr5rTPl+CDC4w+ugJzvP7xwiFg6knbeLvetJcpGTbGLbEKJWIUwgPco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ipylypiv.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gK69VB13; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ipylypiv.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gK69VB13"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-5ee22efe5eeso76240777b3.3
        for <linux-ide@vger.kernel.org>; Mon, 04 Mar 2024 14:08:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709590103; x=1710194903; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=iiyGGgw6bcoBER0ifxC4m6qALOEoGZjmpZBnddiCFAg=;
        b=gK69VB13A5WQRg3IyuSkO5W2U06HQ/NfhISbOS2R3sfkLrA0LnjxrHtUS0YNItIZJD
         4WSt3SlFr5Iu35Z+m0hWwTXJaVPGW/4+r6aYK+l8K1f8YXTm0kTytz9IpoR64AY600if
         DvknDbOuRz5IFOT/G9TH90+L6/zdRfVEVnqT9iNrDN8nl2ByeQ1/m2UIN7jQ3+BvSxEw
         khZqZRm5peD9ouZmY0d/prurBHz4Ab/h5MmiUWK2KI5Mu/igvyKR/83toUtUSFANE+U3
         Z4wLkpbLcG0hjh9yRBt4w1kJ6K8iX3VjMoq1ZUzu74RB0RFAiCnljPzcG4XAF0V29Pvd
         OeKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709590103; x=1710194903;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iiyGGgw6bcoBER0ifxC4m6qALOEoGZjmpZBnddiCFAg=;
        b=FSVZtrE2+zKs6dbqRewnGs38mDD6Hd+qN0M0O+i0/Ep2DtBp3Ryy3fDdGO9jbb7CUf
         9W+QzWZyDPEpoABvpm2crO/nCpWyqLB1YBdwuRhReAShtY3KPPnq0wcW6OXZo7e8jNfa
         gwH+/eAY7T860WgFW1EOquRM2b0dNyh82sI6BLIG4fzCL08yS9mwhf8o9ux+YozsVfFX
         xMibKqp2duYz4SzWCoEdOb8ItsseYH9H1MMNuu4Goo/lzRFkVQ45H/6ZKhGabbi5P/Fs
         B+LFpfvT39Pl26Le/dTv9UoFVCRHqe/ZDilGWCokEtYydHj1vnfS21Mfppj/2Q9VzDXJ
         nT3A==
X-Forwarded-Encrypted: i=1; AJvYcCVvmhAYfQszFr6/9hSJ4jfMiyllbmqEQ1piVBWOnPHYp87hQHuZ/lN9voLo58o4y66fzVg9tVcTrdSsaEq1E1YvwzRzWMIFzBch
X-Gm-Message-State: AOJu0YxsJgx2apf2K2tImYg6PDYpmIr37AjiAVDrWaH7kFtK/RXr2NAL
	09U0i8rRc1fE5jR7kXq2dMlkvKiMCgTGa8rbaSS6Jr8NON1mWcXB5AubdN8aY2Rwv34slwjDI1q
	xkwCO0s8VbA==
X-Google-Smtp-Source: AGHT+IGsSvRu6925/ExZ3ABV5J9532cs88Tl/YIa/JO0Nr+gzNoaIb13r29iBifRSQrCWjWrgQVYP70iNzAyuA==
X-Received: from ipylypiv.svl.corp.google.com ([2620:15c:2c5:13:e901:e760:20cd:d870])
 (user=ipylypiv job=sendgmr) by 2002:a05:6902:70d:b0:dc6:c94e:fb85 with SMTP
 id k13-20020a056902070d00b00dc6c94efb85mr357414ybt.2.1709590103406; Mon, 04
 Mar 2024 14:08:23 -0800 (PST)
Date: Mon,  4 Mar 2024 14:08:08 -0800
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Message-ID: <20240304220815.1766285-1-ipylypiv@google.com>
Subject: [PATCH v4 0/7] NCQ Priority sysfs sttributes for libsas
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

