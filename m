Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B66F7D086
	for <linux-ide@vger.kernel.org>; Mon,  4 Mar 2024 22:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709590116; cv=none; b=C9Wm0n1iTACYeHNObyxiVNaFa7RAFhFu8HQTrao1ydhYDtWOhuG41w3BeS0dFiBI+a0TejdazzP35UeFB/zoBi/shH13OX0Bf01g2PW4EKB2zssSUqyhk7OvFp18TPSwcvjnQttWeLG7URB5S+N3BbTQ41rUzljIcUN6tZMyHRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709590116; c=relaxed/simple;
	bh=SbjbdjZWUXBzT2LxbKT4DNqotCfdqsZJ3zhnbS10R1g=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=syuXygb2DXYfb4LBXNd8xkR2YUbJXmzQPBrPzOdXJSjx1hjqxDgOnMDlAqum3pD8sdzyp3FOpMnDJSX6mplMnM+wJ/lEsT5DaIAFxIcecYbbWC1KJtA7qHsFKFks1S2KMNo8ENPc08kC//eneSml4B0fpJxdyHAL1ctmCyBX9oY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ipylypiv.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YFF2GFFk; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ipylypiv.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YFF2GFFk"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc647f65573so8751789276.2
        for <linux-ide@vger.kernel.org>; Mon, 04 Mar 2024 14:08:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709590114; x=1710194914; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=u66W4yA8M+KF0Llg68xH23MwaMjWX70CKgHvWJ3oECY=;
        b=YFF2GFFkect0CcmJBk6glB9KZUeLUXgxIcsgpYgUr8T2Vq4vqlCF+bQLvgOP1ZTmtO
         GF7PseOy70CcoeozA+NodicCvjCi+rtuVIy6j9QTUlHIRgzSNRCJOK6jHc+/GfpgvGJr
         FerfHqQupkyZadxBDohuqNYYH6jGkcZUKDuRO6pZfTCt4UoPI+siEvXAz2ud89LpsCOg
         D8zyHD20UKBwW7Ow458+3eBrPUp7ryWU81E7SPRMPXM/Jw6gh+L8yxnLl1KGi/nDI0mj
         IHxLHI710sjYLhN/TsbzlWye5+YAH5no1nS5CdLpcpLiSMzXtUvCJAH1thNdKgRp27yL
         sRYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709590114; x=1710194914;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=u66W4yA8M+KF0Llg68xH23MwaMjWX70CKgHvWJ3oECY=;
        b=IkmJnFRDmtwP9nCnHZC52yKyb/Lt3YLZTYhoLmeHBAS6CWsi0ciI0u6zgE+SQHzmV/
         hFt6dAo8sWJN1nrasMKYjbch9tSzCCr8Pk1tYEOQv9pEHM/3kotfEAebYWmj//ynbl4A
         R6NIzgoziPQg+mFb2Sg3YbPeV6I9HoON3aDBUurdNFWo1gM/MPB3JYyW6lY0iiPGBJT6
         8uVcokfE8rdxDXrW0Sjn4RU5ZJn7eSw+0ROI6cyKIAZSwqpmDZuKvEsglmz0PjZyK8Gk
         mVinBMP2ECkxusM+WvD/aLFcFFm51GaKoJS+EwyRff3x+nlciaX9A1R9Z25/ts0FELY/
         p+Hg==
X-Forwarded-Encrypted: i=1; AJvYcCXJd6cfrdpx8TyPzs/Qlm3n1Wf8zaqhvo+rSXIMXt5QnXJc/Lm4bCYHX2SMC7/PF+PPzqImrGM35oYTgiVjUTtuut86LucJ3GLT
X-Gm-Message-State: AOJu0Yw9SurhZG4/KPH3YrtEq6J+t7q5tAieyyu4Nmbc0qI69FWxwJiL
	OM3qzyl+cMCI3md+z+23dELhassLrUYwOscdnWfhAmdFW09a7fj2sd5bXhYmXibFbnxsR9+uava
	Hop4Mhu0qug==
X-Google-Smtp-Source: AGHT+IFZfyS+uFwGZLzMHFOeD5UY68eEdzKNnsQfushZQwAV/48zAAnVPGQYWTjxCo6N90NONLdqyIYTRFvRSQ==
X-Received: from ipylypiv.svl.corp.google.com ([2620:15c:2c5:13:e901:e760:20cd:d870])
 (user=ipylypiv job=sendgmr) by 2002:a25:abc2:0:b0:dc6:e5e9:f3af with SMTP id
 v60-20020a25abc2000000b00dc6e5e9f3afmr2651172ybi.9.1709590114389; Mon, 04 Mar
 2024 14:08:34 -0800 (PST)
Date: Mon,  4 Mar 2024 14:08:13 -0800
In-Reply-To: <20240304220815.1766285-1-ipylypiv@google.com>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240304220815.1766285-1-ipylypiv@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Message-ID: <20240304220815.1766285-6-ipylypiv@google.com>
Subject: [PATCH v4 5/7] scsi: hisi_sas: Add libsas SATA sysfs attributes group
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

