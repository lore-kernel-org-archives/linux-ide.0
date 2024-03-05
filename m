Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 143BF134CEC
	for <linux-ide@vger.kernel.org>; Tue,  5 Mar 2024 23:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709683126; cv=none; b=RnrszV92igFHNfvJxyeV4Am3OEPcXTI/MzVKoOoOKM2B7pJ/lU827Vqr0Nj4VyQQwdZ7iOyKRyknG5YEO2gAc29/iwfI9qKcoU57BMSkWMnAMY7PRLQK65Vcvyd7ygr6wkmL6VSQhpng7B4vSFcTSzzhl5UUZUqPD1XoL+sEsaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709683126; c=relaxed/simple;
	bh=ZQgGWVSWytcgK5MJZ6jggoBjQfFJugefhTJSzcVcgYk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=rggp95OLKU35eSmIPD81X2UjMCAzMMddjEhPMivkhs8BJTRq2sgU1D2ZRL03O+5Y/Prjh5jXYmK3ePFYTBoFVm4lsxAVpM5t7xh+22aPbOtjr/dANodRjSzp4Vv7me4RCRAvmLA5GoTmiEdagK9+ADfzkiNfK4YSL95VvFBT54U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ipylypiv.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1FLFJf6l; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ipylypiv.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1FLFJf6l"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dcc4563611cso9753042276.3
        for <linux-ide@vger.kernel.org>; Tue, 05 Mar 2024 15:58:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709683124; x=1710287924; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=iW4+YjuNAKvAoJg+NmQ5C96xY/u5WzV8UruESW/Bs4M=;
        b=1FLFJf6lYz6MXkeWmkVOPVP/dTbCxipBlQKRRdIQQrIYT5xVRz2QD10+XwMkhELTOO
         A4bGpVLhcmi5j+DnbpFoSzd4qZy7nptJpe1yKBTq/h3HhcClu/RlxuWKpoH35rVoeUDN
         TEytp1a72dm/AWNBXa6KmfCNWxBk2r5PzZnEkgRNkWpbBygTujZQslKPMjWF4AwGSs6Y
         uhovgu9ZM/lL1czkaTMxO7dyD7W4XstRdBTElHPp7UafjG1xNJbmsc6XrgK6QNR93jZ4
         TrBbGjYn6qCWRNdf7Mcr9hTZiuPEU+DRpRD4KN8rWLyQg2u9P8lyCJgU/vuRphq/21lo
         w/IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709683124; x=1710287924;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iW4+YjuNAKvAoJg+NmQ5C96xY/u5WzV8UruESW/Bs4M=;
        b=mAF/BXexZNheKNWNqLLJyehyTAlUfU4dPBKfqWQrKB5N2c9JGz7HRE27Y2Fw3yHs+G
         e03HrRpuJ0R04istngmfFPPXUGDwgvRWpPxMMQahzUJAdr7NulgszvUILSMEGK0hm04G
         HeDGo2ifwGpZNd2wxWPfH+eZVS4qzjgODI1/sm3KF3jLL5b76p1mZt7DMPI84slvo/dm
         hAjUf8PXxfrw/5FcMtue/U/7E8I+CmebfEZMrbfWv8E1rxcK11dB6/1YuHzc0Q5zTH9S
         eFUNq8FutJFC4soR5L9vraB0bydubu2feRm60T/tKedS8FHtTi817ElJ1eF+iaX+2NaL
         DYiQ==
X-Forwarded-Encrypted: i=1; AJvYcCU7HC0RoM+r9xYh3BpAFNL8G/5N4UB9ptXwcaED9MWWgBt+bNf/iXeZ8xKsDLA+fNM2wCs5+RVuAmwfkGPK5/Su39lDdCJxYIoT
X-Gm-Message-State: AOJu0Yz1SQgSg7qptj4DGScsGGTkNoa8N2THa2s2Sb4kpHwBiKBQdmfL
	jppLTBK6BBOQHBLYqe7o72SHr8MkwTZzu3frPpPwa7xSEhBf30vBlhyEKWl4q767Oz0qPdSm2Ks
	o6P/MLBlxEQ==
X-Google-Smtp-Source: AGHT+IHCo10p/LCIUXuR4X0ieD7GA4BMa+s0Kua3rnoaoX1L1KdO+HKSNyVkjWeL08MQ/A07Bzu15QUgFpNe/A==
X-Received: from ipylypiv.svl.corp.google.com ([2620:15c:2c5:13:69ff:df2c:aa81:7b74])
 (user=ipylypiv job=sendgmr) by 2002:a05:6902:728:b0:dc2:1f34:fac4 with SMTP
 id l8-20020a056902072800b00dc21f34fac4mr3509623ybt.2.1709683124213; Tue, 05
 Mar 2024 15:58:44 -0800 (PST)
Date: Tue,  5 Mar 2024 15:58:22 -0800
In-Reply-To: <20240305235823.3308225-1-ipylypiv@google.com>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240305235823.3308225-1-ipylypiv@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Message-ID: <20240305235823.3308225-8-ipylypiv@google.com>
Subject: [PATCH v6 7/7] scsi: isci: Add libsas SATA sysfs attributes group
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

The added sysfs attributes group enables the configuration of NCQ Priority
feature for HBAs that rely on libsas to manage SATA devices.

Reviewed-by: John Garry <john.g.garry@oracle.com>
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Jason Yan <yanaijie@huawei.com>
Signed-off-by: Igor Pylypiv <ipylypiv@google.com>
---
 drivers/scsi/isci/init.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/scsi/isci/init.c b/drivers/scsi/isci/init.c
index 6277162a028b..8658dcd61b87 100644
--- a/drivers/scsi/isci/init.c
+++ b/drivers/scsi/isci/init.c
@@ -149,6 +149,11 @@ static struct attribute *isci_host_attrs[] = {
 
 ATTRIBUTE_GROUPS(isci_host);
 
+static const struct attribute_group *isci_sdev_groups[] = {
+	&sas_ata_sdev_attr_group,
+	NULL
+};
+
 static const struct scsi_host_template isci_sht = {
 
 	.module				= THIS_MODULE,
@@ -176,6 +181,7 @@ static const struct scsi_host_template isci_sht = {
 	.compat_ioctl			= sas_ioctl,
 #endif
 	.shost_groups			= isci_host_groups,
+	.sdev_groups			= isci_sdev_groups,
 	.track_queue_depth		= 1,
 };
 
-- 
2.44.0.278.ge034bb2e1d-goog

