Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46C79140E29
	for <linux-ide@vger.kernel.org>; Thu,  7 Mar 2024 21:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709847875; cv=none; b=rPdmEkf9e8aoiJYHUc4bU3yQlr7D5NQloozWWWGvJh601kgKfgrQ8fBDICQ7jNFh1VbUzURmr7qPXdEVuZnvGQeQiHmPyE3J80dneUyOTpsBKFEdjvUm6/kBslLglbgWqyy77WHW8MjC4ruyY/CXTy3WQqfaAE7Dr7uaAhg0RUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709847875; c=relaxed/simple;
	bh=2cCuW0dKXiDPC1nTNSQxTi3GScOXsxTSOfJ1DyyKmYo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ROLIz8N64Jb1BnwqsEWMKFtRlLUguer3H60BkOr+S08WuYrVHQPznz44oyhWNLQBMWm2lsMV0OTz/gyGNJIouEuVO0WpD2MjMyzM04xiJtw5akmC/P9hhozalN9grzIU6nsrGYkVebti8FumucUmp+OijKESVmSuDrhM7eiGYAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ipylypiv.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DbowNptD; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ipylypiv.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DbowNptD"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-60996cdc37cso22272647b3.2
        for <linux-ide@vger.kernel.org>; Thu, 07 Mar 2024 13:44:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709847872; x=1710452672; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=xCVD89QW7GNEyZMm3uxDu0K7SFt0NpK9jCVrU7O98fk=;
        b=DbowNptDu6GvfsIZLO4YQ2liRah+Fqru+SdAchb/1kbO6ATGPXFMWAABtOZb+Wv/ac
         ysVlcDkKiUmTamNNsu0E4QyFhfhE0eUDSye22dmEXTgBENkVn2R7k4b6sTQNZj9SteFZ
         GnO1kvIEg1AtJn89E3PvxoHxy698YepXVHU6Pi6vqMBUvilbytJSe/mdA743WwDckPZn
         T49OdtSvKRqz7o8kHO9br/jRQpb+/A7FfNK34MYtXiAqs68Hcm3hhbq1MgkjQFPQM/+5
         0mKaGjsdIAmKe/8iJj21GiGU6zn7uUFXErZC+F0iztbXY7mwN3rzIIiyDKAKFnj9euYF
         WuIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709847872; x=1710452672;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xCVD89QW7GNEyZMm3uxDu0K7SFt0NpK9jCVrU7O98fk=;
        b=YuLT42MWVfIby57M70sGAm+QP+EM1NYW6PTxZdykmoqWvaemVlbzldAmYgwCyQ64wv
         JtE64uqxQ6p2MC+qK5SEORVRpl6k8u5vY9XbdKqXfR8Zcnh4AA/R9oTGTz6BkRf6gGmy
         c2pwMpetzHA6En/inKU7ArXPotITRluxneuhx/nve17Dmx1cL0YVPIe6ME7WBMbvWlG+
         s+A+ixrPT2WnvSSkhgj63itL6jx1mt6c0v5AaF4PBJqc14RtMa4e9Ie0qgHyMvXpR/b4
         +6ne6p3rgawwGBSTcQ7kGERE2eGywsyMc9tqbA/wvWC9a3l1AeWlNmogCmal9fAT8M8e
         8wbg==
X-Forwarded-Encrypted: i=1; AJvYcCXhOZOJF8ME5em8fcAZDBbU2+2ZxO9KhWtUJhCyn5+WC3s3Ak0aK5MN3infMZjdcGNWenD39IL+yTHlAXHqCf5snvn/5fPxiEkG
X-Gm-Message-State: AOJu0Yy1/PyGQ/X5MYF6GhaHhzHD76eoc0vqqyWCQPfTEizBANk1K6nn
	ASWLqA9M7Ir9kGuxRF2J/vQdUY5oIaO5JyKY07CUt7mogaB1G0E//hM1Y9KudkfCamsevGFXz9w
	6+Q/1TPsKyg==
X-Google-Smtp-Source: AGHT+IHFQpQPPxJUddGyW0JiXEzVAvGBFFo64g+1nPyj7FNywLHMbgXYRR0N15fZG9B2KbpTYVn4kNRzaytYCg==
X-Received: from ipylypiv.svl.corp.google.com ([2620:15c:2c5:13:69c0:c447:593d:278c])
 (user=ipylypiv job=sendgmr) by 2002:a05:690c:d0c:b0:607:d300:77c1 with SMTP
 id cn12-20020a05690c0d0c00b00607d30077c1mr4165254ywb.4.1709847872495; Thu, 07
 Mar 2024 13:44:32 -0800 (PST)
Date: Thu,  7 Mar 2024 13:44:15 -0800
In-Reply-To: <20240307214418.3812290-1-ipylypiv@google.com>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240307214418.3812290-1-ipylypiv@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Message-ID: <20240307214418.3812290-5-ipylypiv@google.com>
Subject: [PATCH v8 4/7] scsi: mvsas: Add libsas SATA sysfs attributes group
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
Reviewed-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Igor Pylypiv <ipylypiv@google.com>
---
 drivers/scsi/mvsas/mv_init.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/scsi/mvsas/mv_init.c b/drivers/scsi/mvsas/mv_init.c
index 43ebb331e216..f1090bb5f2c9 100644
--- a/drivers/scsi/mvsas/mv_init.c
+++ b/drivers/scsi/mvsas/mv_init.c
@@ -26,6 +26,7 @@ static const struct mvs_chip_info mvs_chips[] = {
 };
 
 static const struct attribute_group *mvst_host_groups[];
+static const struct attribute_group *mvst_sdev_groups[];
 
 #define SOC_SAS_NUM 2
 
@@ -53,6 +54,7 @@ static const struct scsi_host_template mvs_sht = {
 	.compat_ioctl		= sas_ioctl,
 #endif
 	.shost_groups		= mvst_host_groups,
+	.sdev_groups		= mvst_sdev_groups,
 	.track_queue_depth	= 1,
 };
 
@@ -779,6 +781,11 @@ static struct attribute *mvst_host_attrs[] = {
 
 ATTRIBUTE_GROUPS(mvst_host);
 
+static const struct attribute_group *mvst_sdev_groups[] = {
+	&sas_ata_sdev_attr_group,
+	NULL
+};
+
 module_init(mvs_init);
 module_exit(mvs_exit);
 
-- 
2.44.0.278.ge034bb2e1d-goog

