Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C223E134AB
	for <linux-ide@vger.kernel.org>; Sat,  2 Mar 2024 00:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709338628; cv=none; b=QKX904LcI/zDMRcDYYzZnOYGbhVlZKKqkbSWMQp4QW5v4N/7ShQjEDzUzAiFaqfraVC0gHnJ1gveX6jAtL2UsifVhtB9tFm4z5+Wk+9XqT4BHoAmQBs7TyCEjOuJb7GRL524l2RbSb3EVhUeHFLVJ40SKnoY5Fd0o6dkGPZSUFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709338628; c=relaxed/simple;
	bh=oCEOlszWbRebAJRFgYlHh9o1ZpJRj0ce/17rkZ3A3M8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=bfekMw5Syx99Tsqbzs7lmKdXE/1YjpLgoc2FXKbwvVgSfggFm/S9fQST384Oxy+C1NA1U/FuNcSyxuIvt4hAbEX8CBpWk9E/PDCYYUDm4DKYAXLnGEbNtw5iy9j0iGVQdRz+BUL2tg80GxA+ZIS6SNTPuSZXTTFtlMFJk/wtFMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ipylypiv.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jYVAZdBK; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ipylypiv.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jYVAZdBK"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc6b26ce0bbso5587372276.1
        for <linux-ide@vger.kernel.org>; Fri, 01 Mar 2024 16:17:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709338625; x=1709943425; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=aUX3zhIus5O92bJYySj4+GAcqh6w/58AkwOdnSqPEQ8=;
        b=jYVAZdBKuXRtcp4BjBWfmc5UDZO96hwuu7bUwh+4e/ozYcVOBeE0yUhlatuICmexaR
         BL3rGl6HsgBqVKrB+MqxxcTwmo4qCZsv6aSA4/Tb4r1gLOOfdzCc45r0bmVaPwDMeXyy
         cd6pKDsC5vyHpFXQ0EpPcwMTtUP6iftDzMP9wDKX1BZcoepB90aKJMZJV6Cf7imyJPWE
         u4RDK1vYJn0Ca0PXvbKMVbCzsJVl06PhL8y9Qho92KAjibmuXYKqMb87lftrISsQNNXu
         OfLw4dIpo+tywywhLbYXmcdTHJnGaPqm+vXQC12rdBspVUFKlAwIK3U19QC288L6YXx6
         4M7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709338625; x=1709943425;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aUX3zhIus5O92bJYySj4+GAcqh6w/58AkwOdnSqPEQ8=;
        b=ryq34SBziEqHwMYS7gTV3H3vdGb+lc2abn/Pz8ziOxGmWNqsFRjFhcKITyIWLwdOcd
         f51ewO+yIf94TvuCltaQwA9K+aX7gVYgloKdASb4q9mwbYFeings/Zj5MIbZ3k+qA/Ki
         JlSO7g1fyvzBGT7n0H0VtWCpNySiDVTctXMSXE1q4ud6T366X3bZVTIcqxaS1ibWvyK/
         IaksLd/9gjM4IqQrRWIQLlRkcjc0PPtEZVbbu4mN4rBf0gi6QM1kvvCGb5BTxuxQVMpw
         iN9ptFxsTggZNxfR/3fVhSA9+iijqeP3+ScKL2dcuyMFXPFGI3z2fkKTzWvzifboq2gW
         Rf5w==
X-Forwarded-Encrypted: i=1; AJvYcCWjWXVeNMbFYaqH141U8t3UzXdhjc6S8MLl3eQsbVpg+t9CcJ7NOsGisv8wOBytEsBLnZcncQIlQ7xlkVhdpX9RU0CcUcrLkOK1
X-Gm-Message-State: AOJu0Yzr2ka+pYqdVeqwK4FncKPCofja2v4osN2FHFGYNq/MzjZKq+Sg
	Apnzag1+z85B2zSWHCztDOLgPgTEijcI2+DK9syLyP5uwU1hXt8EN/tQiPD1RQTd3RQXnNMAMgC
	BbgFaDcGpyQ==
X-Google-Smtp-Source: AGHT+IGpYFdkSZO93d6Cb08S6RbmCk+UgL9HtoRDFxC19PmO95Bu0m/cSiB1RLQRMZ3KLzRi+Dc+F4zpVgTKYw==
X-Received: from ipylypiv.svl.corp.google.com ([2620:15c:2c5:13:2afe:1a8e:f846:999f])
 (user=ipylypiv job=sendgmr) by 2002:a05:6902:2492:b0:dcb:b9d7:2760 with SMTP
 id ds18-20020a056902249200b00dcbb9d72760mr751756ybb.13.1709338624882; Fri, 01
 Mar 2024 16:17:04 -0800 (PST)
Date: Fri,  1 Mar 2024 16:16:02 -0800
In-Reply-To: <20240302001603.1012084-1-ipylypiv@google.com>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240302001603.1012084-1-ipylypiv@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Message-ID: <20240302001603.1012084-6-ipylypiv@google.com>
Subject: [PATCH v2 5/5] scsi: hisi_sas: Add libsas SATA sysfs attributes group
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
 drivers/scsi/hisi_sas/hisi_sas_v1_hw.c | 6 ++++++
 drivers/scsi/hisi_sas/hisi_sas_v2_hw.c | 6 ++++++
 drivers/scsi/hisi_sas/hisi_sas_v3_hw.c | 6 ++++++
 3 files changed, 18 insertions(+)

diff --git a/drivers/scsi/hisi_sas/hisi_sas_v1_hw.c b/drivers/scsi/hisi_sas/hisi_sas_v1_hw.c
index 3c555579f9a1..97864b56a71f 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_v1_hw.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_v1_hw.c
@@ -1734,6 +1734,11 @@ static struct attribute *host_v1_hw_attrs[] = {
 
 ATTRIBUTE_GROUPS(host_v1_hw);
 
+static const struct attribute_group *sdev_groups_v1_hw[] = {
+	&sas_ata_sdev_attr_group,
+	NULL
+};
+
 static const struct scsi_host_template sht_v1_hw = {
 	.name			= DRV_NAME,
 	.proc_name		= DRV_NAME,
@@ -1758,6 +1763,7 @@ static const struct scsi_host_template sht_v1_hw = {
 	.compat_ioctl		= sas_ioctl,
 #endif
 	.shost_groups		= host_v1_hw_groups,
+	.sdev_groups		= sdev_groups_v1_hw,
 	.host_reset             = hisi_sas_host_reset,
 };
 
diff --git a/drivers/scsi/hisi_sas/hisi_sas_v2_hw.c b/drivers/scsi/hisi_sas/hisi_sas_v2_hw.c
index 73b378837da7..b5d379ebe05d 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_v2_hw.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_v2_hw.c
@@ -3544,6 +3544,11 @@ static struct attribute *host_v2_hw_attrs[] = {
 
 ATTRIBUTE_GROUPS(host_v2_hw);
 
+static const struct attribute_group *sdev_groups_v2_hw[] = {
+	&sas_ata_sdev_attr_group,
+	NULL
+};
+
 static void map_queues_v2_hw(struct Scsi_Host *shost)
 {
 	struct hisi_hba *hisi_hba = shost_priv(shost);
@@ -3585,6 +3590,7 @@ static const struct scsi_host_template sht_v2_hw = {
 	.compat_ioctl		= sas_ioctl,
 #endif
 	.shost_groups		= host_v2_hw_groups,
+	.sdev_groups		= sdev_groups_v2_hw,
 	.host_reset		= hisi_sas_host_reset,
 	.map_queues		= map_queues_v2_hw,
 	.host_tagset		= 1,
diff --git a/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c b/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
index b56fbc61a15a..9b69ea16a1e6 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
@@ -2929,6 +2929,11 @@ static struct attribute *host_v3_hw_attrs[] = {
 
 ATTRIBUTE_GROUPS(host_v3_hw);
 
+static const struct attribute_group *sdev_groups_v3_hw[] = {
+	&sas_ata_sdev_attr_group,
+	NULL
+};
+
 #define HISI_SAS_DEBUGFS_REG(x) {#x, x}
 
 struct hisi_sas_debugfs_reg_lu {
@@ -3340,6 +3345,7 @@ static const struct scsi_host_template sht_v3_hw = {
 	.compat_ioctl		= sas_ioctl,
 #endif
 	.shost_groups		= host_v3_hw_groups,
+	.sdev_groups		= sdev_groups_v3_hw,
 	.tag_alloc_policy	= BLK_TAG_ALLOC_RR,
 	.host_reset             = hisi_sas_host_reset,
 	.host_tagset		= 1,
-- 
2.44.0.278.ge034bb2e1d-goog

