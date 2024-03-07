Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DF8A1428EA
	for <linux-ide@vger.kernel.org>; Thu,  7 Mar 2024 21:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709847878; cv=none; b=LZ1I96MitfGZhpowEkhMTexubhnof7T/wySCsLVkqT+qmRRtEJ0UYdVVBOBCjTgVQwS3gcNidd64S+RNapZNaM0VyQ9CZ6RzMncxtFhIWhiQbFXsRzGtalXSbsQP418hHy9noopeFDhJO4MlNuhCy5Lb0muWp2o9AyqmLweiV5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709847878; c=relaxed/simple;
	bh=3IHdm2Kbt7Oqnq7hLlZmkndR1cR6l2HysmJJhv/D7aw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=KaPN7enLthy60KmP0WaoRvLlbKcvdt1x8AJG2wuvIr/9lqKJSfqBN7XkabX/ZG1YkuWrT+9N36h9GZPNWFALFpMjAIUal+QGpmZGz4ed07IptXXnRyyTZCQl9BYWP+/pBZyENJsR/iMzu3fOA1HPdP8R1uQlPujnhs2mKyfEqLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ipylypiv.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=t12Sbg0f; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ipylypiv.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="t12Sbg0f"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-609fb4fc058so4710657b3.3
        for <linux-ide@vger.kernel.org>; Thu, 07 Mar 2024 13:44:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709847876; x=1710452676; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=bwEvId1GeDg0DYsAPfhWaL+EMmX4DxPU1q6ezkgbZrY=;
        b=t12Sbg0fmiaJ8ZPu1iNR/moz/Rv7t0woY9Uo/tp3vQRv3UYDh+D9Mz37JF4+D2vR8d
         gGL6Hd5oT741qaEVFSpJVAOXrlAhgrwQSXvkaIHINhnV87bbHBvUp9p/+bf+Noxs5H0i
         7XRRQZsqZPmvS8wi8b1Ran6Ern7ffGEV5XEkbPqNiXUI/PjhI/VOuRhaRBmbMXrtEgR4
         2hsbygjgg8akvUdHVewVHGQZ2/I9d4QpcN0B3ZJTNsW0Y1GGwYfp7/CY7nxgNsN4RPxL
         AOkjER25vHQcwAk0qdGv7eDY8NZAPzAUuTZ6OocIgLz5Co5MjCpSeQt8oIswcVBublTn
         nrTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709847876; x=1710452676;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bwEvId1GeDg0DYsAPfhWaL+EMmX4DxPU1q6ezkgbZrY=;
        b=wCfnwUkqJYcNrDr/ORKdzSfryOFz7reSFTWdv8ods+hLz+V8pB9Sk4+48wdrtX7HFw
         dfrUd4WaepHQcb5z+8/M+CJJoLoIrm7rpAHV4Rh9Bc6O/xfhUe2ojtnxznX4VlrN7GSH
         S9XduA6rp7l4rh1go4ptVNBtEDOD3iyxsopSJtM5wgDYmXX9mYLu58q+jrVzNMUQQLGy
         zYY38EoBwT0SIztKOt3/L28Nq4bR9f1tTFohLTJTH4OvDhhu5fwq38ZY2SdV0B2mzJXJ
         sOPsNtBHUzPIDED496zirOHsYAQFisb9xpc7cEk3TOCfStmWzIx6lR0A7emckwmVNoMg
         M5bA==
X-Forwarded-Encrypted: i=1; AJvYcCVFgS/J8N4ThiGSJBMAPgJI6rhY30oeI9XmRgggQylVh7C3NX4SnOdCdl9Mm7dpFi6caHnRPisKi36X4TTh1mXeqbGSJVvyIGAO
X-Gm-Message-State: AOJu0YwOKLujjzMaaTewTNZ1U24ezOcMFuWppzfnNJTFUX1iLK3F7qwR
	zDPYbr+O6b62pc5vB7bZW7zZQ726rHzbKKXVVsdAKFsRlw9++g9MVQJlce5trGpGVO7vznl7ioK
	yVJca2RSCtw==
X-Google-Smtp-Source: AGHT+IFayAfHaKkEPZo+rNikCLiHI2VeVbBzc8tGK0HM4m0xNsouXgxkmZIRd60W1RhGlE+CFfrrZUPbCKvAZQ==
X-Received: from ipylypiv.svl.corp.google.com ([2620:15c:2c5:13:69c0:c447:593d:278c])
 (user=ipylypiv job=sendgmr) by 2002:a05:6902:1209:b0:dc6:e20f:80cb with SMTP
 id s9-20020a056902120900b00dc6e20f80cbmr701381ybu.3.1709847876592; Thu, 07
 Mar 2024 13:44:36 -0800 (PST)
Date: Thu,  7 Mar 2024 13:44:17 -0800
In-Reply-To: <20240307214418.3812290-1-ipylypiv@google.com>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240307214418.3812290-1-ipylypiv@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Message-ID: <20240307214418.3812290-7-ipylypiv@google.com>
Subject: [PATCH v8 6/7] scsi: aic94xx: Add libsas SATA sysfs attributes group
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
 drivers/scsi/aic94xx/aic94xx_init.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/scsi/aic94xx/aic94xx_init.c b/drivers/scsi/aic94xx/aic94xx_init.c
index 8a3340d8d7ad..ccccd0eb6275 100644
--- a/drivers/scsi/aic94xx/aic94xx_init.c
+++ b/drivers/scsi/aic94xx/aic94xx_init.c
@@ -14,6 +14,7 @@
 #include <linux/firmware.h>
 #include <linux/slab.h>
 
+#include <scsi/sas_ata.h>
 #include <scsi/scsi_host.h>
 
 #include "aic94xx.h"
@@ -34,6 +35,7 @@ MODULE_PARM_DESC(use_msi, "\n"
 static struct scsi_transport_template *aic94xx_transport_template;
 static int asd_scan_finished(struct Scsi_Host *, unsigned long);
 static void asd_scan_start(struct Scsi_Host *);
+static const struct attribute_group *asd_sdev_groups[];
 
 static const struct scsi_host_template aic94xx_sht = {
 	.module			= THIS_MODULE,
@@ -60,6 +62,7 @@ static const struct scsi_host_template aic94xx_sht = {
 	.compat_ioctl		= sas_ioctl,
 #endif
 	.track_queue_depth	= 1,
+	.sdev_groups		= asd_sdev_groups,
 };
 
 static int asd_map_memio(struct asd_ha_struct *asd_ha)
@@ -951,6 +954,11 @@ static void asd_remove_driver_attrs(struct device_driver *driver)
 	driver_remove_file(driver, &driver_attr_version);
 }
 
+static const struct attribute_group *asd_sdev_groups[] = {
+	&sas_ata_sdev_attr_group,
+	NULL
+};
+
 static struct sas_domain_function_template aic94xx_transport_functions = {
 	.lldd_dev_found		= asd_dev_found,
 	.lldd_dev_gone		= asd_dev_gone,
-- 
2.44.0.278.ge034bb2e1d-goog

