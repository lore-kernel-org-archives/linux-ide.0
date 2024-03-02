Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A61A810A22
	for <linux-ide@vger.kernel.org>; Sat,  2 Mar 2024 00:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709338623; cv=none; b=WZGHDZKFAqv76XnNPNj6Ge2vSJSdkkkG6gTlHlY9mZb6h63B/vju7+ZrXcFmOPzVOnQZ4fj5YU4+Cc51j1cYCmqng1ntSOUc+k61z+953YpmRoIGXHsdU52tZPJhHYtV1OtoYThyUvuFSpbivmNDkKEmldvWJd5ttOeQXY7S9s4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709338623; c=relaxed/simple;
	bh=KWCF/wRFo5DDf67uvUwFxQaljHz80tfPANfuy0kjn8k=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=mbZwpLWi8wAU58wqRr/C7LvkmA0gDBdG+D/c3uKApfyLGApqOJyZnMwik07+Uh7AtOrosr3t7zvPv2PDCJD1n8tKl/f6Q9+S/Ff/X4qL+P7oLxs7/hcjbJSnSITux/qfcbC6Ms/jCQf2ai6D/Ami7/pG3n0UPLz4WuOK8iksz4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ipylypiv.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PPcCR5CE; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ipylypiv.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PPcCR5CE"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-5f38d676cecso49623857b3.0
        for <linux-ide@vger.kernel.org>; Fri, 01 Mar 2024 16:17:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709338620; x=1709943420; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=jZVgry90rEYwnQ29s3Mz+RKBDNtmCmbKQoUc6PEOd2Y=;
        b=PPcCR5CEhwa0igG15qOeDKade+YVH33V+GStmueu6YH5qGA3tH4ZqBlo2/XdZ+EJUv
         WG8rglQlpML/1MyFJXYK1W7r4FeX+GhaGDeAPyHqpNPNjuBTamFp1gzMJWI5YZ8zV0w1
         mZ4KJsmXNkuinhEXPO4WmRrHF04fS//fG+ZFHdZpPB0KgyrBM6Vn0W6IUBzRMR5vtuxi
         DyfiqEKujt3wn1Wua03zsYWpp5weiXFdED7VRifzic0u8GZbni1HD4UTDn3bbUDyEDhp
         TMwkLekUaYUSyUgF3WMZB8ASjvk4hPTwyz/0jhLOYo1qHNtInjtBHDy8/yp+xqaz/o7l
         rq/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709338620; x=1709943420;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jZVgry90rEYwnQ29s3Mz+RKBDNtmCmbKQoUc6PEOd2Y=;
        b=TBBNKw86y+HObjeo86iYPHudd/WVT4zQ8dgm00xUyNrHA1rPKHkffWlLa1FUsQS2nu
         95kwNuglKw/ZfHY9jDKotE6FDM2RtgGgiuQiwvgkVrf4stdw963aUVWTWgCRi7LFJ9Z4
         S8JUmsespEUmgNHTPeuQDswSrwhNXIWjTmlOZHEUrvgiBVm0khQvJeVS19tpH79Z1Z/y
         Tt0KzXSkLLxUMKqi4gp3jJrpCuTP+VIyHcHZ2drhKcTI7lASLZKPuhHzcdfZ1E4trykC
         uZn+sa1IZ1fFC2bfKB7MXntheDVOWyJJHSRXGr0EN1ADoWsPYYiqeOYCn8MtfjvPY5q4
         oxgw==
X-Forwarded-Encrypted: i=1; AJvYcCW5Jy4M1CGZT0oAqsoti7aBLY5u9bb8R61ZIQcktELaEBEYPo4fLZveLj1Xvat5J9Wglsi1wDWGWIANHRo6zXLpMxD8o2LRPu9n
X-Gm-Message-State: AOJu0YzolnyAsJ0aKYWuJaIXRmAnQC9nknTtliIA8Xu+CcZ/S4wEv9fq
	9sd6fZU85RkC4+dZC+hiUGoMTqOVFrozJMbsRUXiPR34uvnteabinExRFgE71nZAr+ectJhJw49
	7JdngENaSVA==
X-Google-Smtp-Source: AGHT+IF844ROWPX3UQs43uVCN1uIg10aXS00abyrZckT+88C0Iv9L0+XF5s4z+na8MnK1JL2LOmk+VVkTvDt+w==
X-Received: from ipylypiv.svl.corp.google.com ([2620:15c:2c5:13:2afe:1a8e:f846:999f])
 (user=ipylypiv job=sendgmr) by 2002:a05:6902:505:b0:dc7:4ca0:cbf0 with SMTP
 id x5-20020a056902050500b00dc74ca0cbf0mr1203600ybs.3.1709338620711; Fri, 01
 Mar 2024 16:17:00 -0800 (PST)
Date: Fri,  1 Mar 2024 16:16:00 -0800
In-Reply-To: <20240302001603.1012084-1-ipylypiv@google.com>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240302001603.1012084-1-ipylypiv@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Message-ID: <20240302001603.1012084-4-ipylypiv@google.com>
Subject: [PATCH v2 3/5] scsi: pm80xx: Add libsas SATA sysfs attributes group
From: Igor Pylypiv <ipylypiv@google.com>
To: Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>, 
	John Garry <john.g.garry@oracle.com>, Jason Yan <yanaijie@huawei.com>, 
	"James E.J. Bottomley" <jejb@linux.ibm.com>, "Martin K. Petersen" <martin.petersen@oracle.com>, 
	Jack Wang <jinpu.wang@cloud.ionos.com>, Hannes Reinecke <hare@suse.de>
Cc: TJ Adams <tadamsjr@google.com>, linux-ide@vger.kernel.org, 
	linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Igor Pylypiv <ipylypiv@google.com>
Content-Type: text/plain; charset="UTF-8"

The added sysfs attributes group enables the configuration of NCQ Priority
feature for HBAs that rely on libsas to manage SATA devices.

Signed-off-by: Igor Pylypiv <ipylypiv@google.com>
---
 drivers/scsi/pm8001/pm8001_ctl.c  | 5 +++++
 drivers/scsi/pm8001/pm8001_init.c | 1 +
 drivers/scsi/pm8001/pm8001_sas.h  | 1 +
 3 files changed, 7 insertions(+)

diff --git a/drivers/scsi/pm8001/pm8001_ctl.c b/drivers/scsi/pm8001/pm8001_ctl.c
index 5c26a13ffbd2..9ffe1a868d0f 100644
--- a/drivers/scsi/pm8001/pm8001_ctl.c
+++ b/drivers/scsi/pm8001/pm8001_ctl.c
@@ -1039,3 +1039,8 @@ const struct attribute_group *pm8001_host_groups[] = {
 	&pm8001_host_attr_group,
 	NULL
 };
+
+const struct attribute_group *pm8001_sdev_groups[] = {
+	&sas_ata_sdev_attr_group,
+	NULL
+};
diff --git a/drivers/scsi/pm8001/pm8001_init.c b/drivers/scsi/pm8001/pm8001_init.c
index ed6b7d954dda..e6b1108f6117 100644
--- a/drivers/scsi/pm8001/pm8001_init.c
+++ b/drivers/scsi/pm8001/pm8001_init.c
@@ -134,6 +134,7 @@ static const struct scsi_host_template pm8001_sht = {
 	.compat_ioctl		= sas_ioctl,
 #endif
 	.shost_groups		= pm8001_host_groups,
+	.sdev_groups		= pm8001_sdev_groups,
 	.track_queue_depth	= 1,
 	.cmd_per_lun		= 32,
 	.map_queues		= pm8001_map_queues,
diff --git a/drivers/scsi/pm8001/pm8001_sas.h b/drivers/scsi/pm8001/pm8001_sas.h
index 3ccb7371902f..ced6721380a8 100644
--- a/drivers/scsi/pm8001/pm8001_sas.h
+++ b/drivers/scsi/pm8001/pm8001_sas.h
@@ -717,6 +717,7 @@ int pm80xx_fatal_errors(struct pm8001_hba_info *pm8001_ha);
 void pm8001_free_dev(struct pm8001_device *pm8001_dev);
 /* ctl shared API */
 extern const struct attribute_group *pm8001_host_groups[];
+extern const struct attribute_group *pm8001_sdev_groups[];
 
 #define PM8001_INVALID_TAG	((u32)-1)
 
-- 
2.44.0.278.ge034bb2e1d-goog

