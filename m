Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1472132C1B
	for <linux-ide@vger.kernel.org>; Tue,  5 Mar 2024 23:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709683120; cv=none; b=KrqOsT+NvbCYhNaYdf4ZLBtq2HyjE6HvZgBCWWftDFk9ncLc2lXuHr74cjLeox3EBjRDcuLJp0FCfhvYsV9SXk2MEMWYfw8jltP9LkY07ziKc8jNLU283kUQAgijlPdtsHk52v94hHDWYZukYPU5s3N1KW3qiXQqoTlmQX8fhdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709683120; c=relaxed/simple;
	bh=wcg4s+VBRSyuqCYnMen4yuigKnSiE8NtEjtig8qUC2o=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Ax0VqclVTOWLgmAgKSLXGGpeJa/J5+DigAaOCSp2d0+Z967JbLNIIWn/Lm+kRog2IkDmbNbxmlpQX6812zSexlq7KN01rDr2tJme51dv/E9tT73krtw6RWVmBaIH8xLb3iTXWOLIjLXQhYwZwlpagufDd6WQTN2IzGPQc360iHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ipylypiv.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3PfmTzhw; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ipylypiv.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3PfmTzhw"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dcd1779adbeso2390938276.3
        for <linux-ide@vger.kernel.org>; Tue, 05 Mar 2024 15:58:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709683118; x=1710287918; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=xvuQ4kezab1KlrTxoR3eIfXTgSjXQ9ZPEoqhGuVUIVQ=;
        b=3PfmTzhwDKA93OixEyrwssx1reDbrAso4vCUSVvzOAlxljbFw+Wk41SC08uwKmUFqZ
         TUoXGviboMm+Y7rUnSh+Iuw80yr5e96qJK3lMmdOzy3fxxEovTHnt5fh79gmMEs4yN/X
         7+WfAG1v1hnwV7CGntih9yCpJ31uAYFib5lKX+52f1sTYos/XO4jXUiOQhms5qtheU5E
         bgiQAYk6MuXRteAfBicI/2doHzzjz0oi9gJs5xCNdZtC8C5LHP1cymbM7hPuh9i+6QzE
         QoELo6Iu/XfY28HY5woEAJsSxaJRD/3hKX3N5JoBjaZG3S+MHkkF7EUHoVFIs0z3zX4U
         U/eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709683118; x=1710287918;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xvuQ4kezab1KlrTxoR3eIfXTgSjXQ9ZPEoqhGuVUIVQ=;
        b=SDSMabrRB4DIp+coKXlIcCGsAJD1yq7dumnOMzLvx7n9ltMDSqTPZw/bbBC9W8j4RF
         Fhv4kOquWAIHs+IoYW70/+9EoHX+fWPS53ZyKCXJZBQY01v9F89q2/LUae3PoZA7+yYy
         i2zhl17C2v7CbWZ/3hDi2qFseVFS0BSjKn52EqpfkaK5BiTlbIlpZtJhplKrBbZ4WYYR
         swqrJk55JsJJMrK7jvD4ObT8njD6CGNmWMj2NjJGQlnZ8vwGishSVW+upvd0oa2sulAy
         vC6p51EfBxvrKTJv8ir5qMK98HRuON6i+7pgMl8k6b5Ag5oDdbHAVwo6pE7k3HpDCQgT
         DUmg==
X-Forwarded-Encrypted: i=1; AJvYcCUs+BEX4iC9CHM5XtCH3y7hEgo3EDD5thCvh7fkZRuvqJtF0cfsQTyH/QVMKhPUMDFkRZQGgjD7ugic0c/6sm+sWKbz4ZnhwUbf
X-Gm-Message-State: AOJu0YwdU5WOA7U3AyFoO4huMTiBszunI/s1xjhP7EHYPEQr4yPodpGF
	lBq5yH47K4jEI3minye4FsVXXRyOx59tUtZKLTtzNG2Q7qiDw5boGIvsAlAeZN3t7wlix3tyEpi
	8O087v1r5+g==
X-Google-Smtp-Source: AGHT+IH1hHkf29V1XyPDBt0CQu2LWVM63bBNgWVVRoBOTORS8w/8zocs5xCBpGV/hvXRoCTlFFp4aWovjESAlA==
X-Received: from ipylypiv.svl.corp.google.com ([2620:15c:2c5:13:69ff:df2c:aa81:7b74])
 (user=ipylypiv job=sendgmr) by 2002:a05:6902:1081:b0:dcd:3172:7279 with SMTP
 id v1-20020a056902108100b00dcd31727279mr3670994ybu.8.1709683117944; Tue, 05
 Mar 2024 15:58:37 -0800 (PST)
Date: Tue,  5 Mar 2024 15:58:19 -0800
In-Reply-To: <20240305235823.3308225-1-ipylypiv@google.com>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240305235823.3308225-1-ipylypiv@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Message-ID: <20240305235823.3308225-5-ipylypiv@google.com>
Subject: [PATCH v6 4/7] scsi: mvsas: Add libsas SATA sysfs attributes group
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

