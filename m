Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 026BF7D08A
	for <linux-ide@vger.kernel.org>; Mon,  4 Mar 2024 22:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709590116; cv=none; b=EXcHOIos4CueNbR/jBgLdf0QuSYkJNdq2/eWqnYilPY+QFwOoAzZZS1A2FeVA+PH0xB7tiWGik7fD7KXgdeUCrU+UgIdGnBaVA1EleRok4lPB2TfxfrvzEHXwexKLfdMzWwjsMgzujNAP9FVc0oVXZtmfR/U1GG80ky5HR7oACY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709590116; c=relaxed/simple;
	bh=7lui4HEwt3nyzuBq3kOGgxhbVfQ4kTvXlTnHRxF4y2g=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=DCNC6JHW6pZZ9K4WkAjzr8JfEcSMtLSVaTZAqdxu/0TKYLhb0qcfJEJOhU2+nWztsXx5GpgBLlDkaYiygO1h12Zuarzg1Epo7g81REluvP6KXAGb41TvhC+nWJK2yCYk8UOzMviEkiup+gkOYqpecdUNNvm1kTcduZFvtdtb/EE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ipylypiv.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OyE/bcIB; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ipylypiv.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OyE/bcIB"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-607838c0800so66009857b3.1
        for <linux-ide@vger.kernel.org>; Mon, 04 Mar 2024 14:08:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709590112; x=1710194912; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=fllhBTjW6GX9iEnv/LwNN/tFNgKMHmXcnmtxo/1RJIg=;
        b=OyE/bcIBE9zeJ/Bm0iuOrgXR/lfkIGCqbljW+669V6DIikYmROin9LG7goN/I+b1s2
         PBjjWjYK0kMp3ezTV6VPVPoh/rrzORxIMi8F9vCxLKOnfRM7Tien7sU/ywiYMZP+3V96
         j44FvMTXl0ojTaG9VeepmRf0cjjQneTS7A4Jpby24hqq7pY5pcY/j6zCq8NJWg16Cxn6
         B6ztXIcXrUXmWRJwBAoAguW4D0thCdddkP3KrxPHD5O1VrJ5Gc676hae7ohrCYftAb5k
         e+8Znkp0lO01iIzbFvsmjoxJAeZ9onKBgWMhuwBBq+E5/Zr4QW2w97OjpZ+xjdtFiyl8
         WP9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709590112; x=1710194912;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fllhBTjW6GX9iEnv/LwNN/tFNgKMHmXcnmtxo/1RJIg=;
        b=QAaICc7ZVB8esWX8TtZBcol6op8+jmmX1X8k8Ldo3fWiuQH0V78IOs1bjgcpn2rk2s
         0KXSHQlifiqxHzBGVlpOjCcjYfwhPjqLPhlKsJzUD3a3O88dg7VYgczWof1WMtUupt7p
         PrS/1+/9lqQ7XMQwin10f7Da8h2BVr46u6xx5dgQvROrGqzoIIpeDhRAyWrIwCzZtYwJ
         LxSTZSuJmUVfn2UYT3iQpqpYhZ4GEMS9UR/T6P5KRYvBw8m4/zr303i9i6cRs1ywP2ld
         hrSB4vgeIhi5xksLiV35Yzuj8MA+NV7KFpOozufwg5qh6OMtKXPDzLCDx7psso2Ke6K6
         KwRg==
X-Forwarded-Encrypted: i=1; AJvYcCWfFjAhAyLNv8hYrK12xhJwkX2DxakTmbsk/e4+veYNQKz2bIoTNVa4+IgS6WyRa/3FD29MyhN92BmE0Zor4J6RTLZFWbf6ibMf
X-Gm-Message-State: AOJu0Yx1sdnSBRTDqbit53U2UKFa+nbVx3VM2bRtf1XXJXnLkDVcbyZi
	XlLy6Ojus0F6BC0GsKwZU9sqZpw5jRZ7fqzfEH6QitXbYwRUtho03m8ZX4CDZlB0AQD0tap8ogc
	KwVp3EXnFdQ==
X-Google-Smtp-Source: AGHT+IHptqL+KH146p/jJHXv8G+GG/vYikPUWRaYAjtq0JMV4p7qsJi+Ner0U+3RmjBfP4O7X2Cx+gNL7fNivw==
X-Received: from ipylypiv.svl.corp.google.com ([2620:15c:2c5:13:e901:e760:20cd:d870])
 (user=ipylypiv job=sendgmr) by 2002:a25:8a87:0:b0:dc7:463a:46d2 with SMTP id
 h7-20020a258a87000000b00dc7463a46d2mr158322ybl.0.1709590112026; Mon, 04 Mar
 2024 14:08:32 -0800 (PST)
Date: Mon,  4 Mar 2024 14:08:12 -0800
In-Reply-To: <20240304220815.1766285-1-ipylypiv@google.com>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240304220815.1766285-1-ipylypiv@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Message-ID: <20240304220815.1766285-5-ipylypiv@google.com>
Subject: [PATCH v4 4/7] scsi: mvsas: Add libsas SATA sysfs attributes group
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

