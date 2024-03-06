Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 417D618E3F
	for <linux-ide@vger.kernel.org>; Wed,  6 Mar 2024 01:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709688162; cv=none; b=kmrSf05MzpBwtI9BPNw/EbzN3K7M2b82UhGG8Th6LUcW1G9KXR+BcATpfyWZCECxCYjIbcNLEb/4H3RrcFG8PafD4I676fgmajrWKlcnFeq43piYXAU+4fAqVE5jyyWJ4mKj/El58XiMrQfonYi3vuZC9wLtbf6vqL7mfJaLfTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709688162; c=relaxed/simple;
	bh=maF5o+8NzF6pdVwJjN4aGBE4hXXZ0tcVypbGypFOmGg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=SrAA6Q2EpiCWpEwfOfO41PRB36lQCRJpr2LXikhkaEHvg0xmGsfzyfRW/XWWbDmTa7EyBXNgQAI9KZq3akgE1lOLZcc8/Gqueis/oTNHpmVn9K/0q9bshBWE9tzqsu9z7jO1yw+LItNEIilS62hVOKuKvxc9bEwr3NSjsQ5KpXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ipylypiv.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EOzeZQPJ; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ipylypiv.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EOzeZQPJ"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dbe9e13775aso771183276.1
        for <linux-ide@vger.kernel.org>; Tue, 05 Mar 2024 17:22:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709688160; x=1710292960; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=9D3wwHTaGXoUxTIIC0KnLIe431yjbfic0tFZoCaTHSU=;
        b=EOzeZQPJB5Y3+i9PAUfMpeIF/jgl9XXjEiQhZgn6oouhpApROH362BOIX2etaWYvDZ
         2b8SYqu21gI4lUPwzLEV5hlijNFTpy5sg7OhWKmwwTeR6XaA2X00zDs3gGB838HIP5rD
         2G3UdYmLmL+bMAo23lfrZ2BBY7Rg4D3n5LaJM8foKOdk7V+ufBg31nYcdGos3HtieJ6G
         BNqvYACdqaFmFj0LY4FVfTdNLNWLynOi7Wn4Spv8ps2Ix6CB8qgKvRtLXaGbDLx82rZS
         GW1AtVsxHK+JBOfLNaGR/dVxP8xFySX8PltjfifuZnIL+61nFsRFD7NxJAIjElInwKMi
         RpNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709688160; x=1710292960;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9D3wwHTaGXoUxTIIC0KnLIe431yjbfic0tFZoCaTHSU=;
        b=teDizdBNC2buldjkgwlCKPTZLE13naGQztAzKsyQcK465eJFPfMlG7J9C5Ix5zFvl5
         BfIyFVBHsBE8nYz7VkeNpt6Hr6sFX03aBjN6TfLpJjV27oHCfQwz5kMm9Y5COhyRRUpP
         ptaP6cfcD/DRuV4m21malJyO6OtkSPnT6qIWK2+kLRR6dzpzj5quP+UNQkbfzHDq+m0+
         4tmL8L9bdnyhAkuvu5baUJrchykBJOrlfpS8meGx1q5UEJaNVCiCpG7uMDB7IBMuCMzv
         NOde4tSawObb+vo8LZH0yGkPIN1+kLZSKYAI793v62ozm5r6T0U8DgwLITJMUvTt1ovr
         NWRQ==
X-Forwarded-Encrypted: i=1; AJvYcCWKqmWORcm8weg4e/o8QVg97jM+WjazPp8UCHrLQGYCC5Oq6BEReLC+gtHTY7St4c5+KTsgWlPopSo0xN8ikezw/Mkdp+sfWmBH
X-Gm-Message-State: AOJu0YzZIB078vpyqyxzWV4hSMLnqdBAb9y3okaG34Sbv/rM7PAnOwQe
	LbSxTfzonAh0NePzeFLBTWa76642iXi/bvmRxf3OpWquhpyRLm1h5VVz/4j3ILngDkkbZUCLGTE
	SWyra5hDZew==
X-Google-Smtp-Source: AGHT+IHUVYeEphfP5HL9mrtHhMSdBzXskMFsuX4hlP6MoR2AXyYRNthWw2ahxT53h1qtzX1/VYFvhVvxyPZ22w==
X-Received: from ipylypiv.svl.corp.google.com ([2620:15c:2c5:13:69ff:df2c:aa81:7b74])
 (user=ipylypiv job=sendgmr) by 2002:a05:6902:1004:b0:dc7:42:ecd with SMTP id
 w4-20020a056902100400b00dc700420ecdmr3434562ybt.6.1709688160545; Tue, 05 Mar
 2024 17:22:40 -0800 (PST)
Date: Tue,  5 Mar 2024 17:22:24 -0800
In-Reply-To: <20240306012226.3398927-1-ipylypiv@google.com>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240306012226.3398927-1-ipylypiv@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Message-ID: <20240306012226.3398927-6-ipylypiv@google.com>
Subject: [PATCH v7 5/7] scsi: hisi_sas: Add libsas SATA sysfs attributes group
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
 drivers/scsi/hisi_sas/hisi_sas_v2_hw.c | 6 ++++++
 drivers/scsi/hisi_sas/hisi_sas_v3_hw.c | 6 ++++++
 2 files changed, 12 insertions(+)

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

