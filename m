Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A55D4207A
	for <linux-ide@vger.kernel.org>; Sat,  2 Mar 2024 20:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709410618; cv=none; b=WILOAY613JCtR2l8aZSEBnYEU3gVZckEpKOi+MpzxGZ4zjDaCv8/7WgBGo8m95xAip4mnH+zUMUCaVSCM0hnpl1JJy7BrrJr6odSMnLVNr7HswGpuMIOs/Wn+rYIGsMhTQiV0G6E7BmJQKQX+5jDdwrvkxlobiWOqu67Ynd6bts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709410618; c=relaxed/simple;
	bh=KWCF/wRFo5DDf67uvUwFxQaljHz80tfPANfuy0kjn8k=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Ljk90qhx2UFvkHoKw5qQ/4IPb+VrDHpCcnyikTR7AoqbzL9HumuRv7tHEkkIinTYDk1TXNVGXDI59ExkpsvXgU0x1pG8sfkLLaXIIPeof/ROLE6jCbkNe2Q2bXn05UDZ/dxLIplA82uzWub3+CXAwxpV4qWasoecbzdO2AzcdM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ipylypiv.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BJfL6C0X; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ipylypiv.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BJfL6C0X"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc6b267bf11so3719351276.2
        for <linux-ide@vger.kernel.org>; Sat, 02 Mar 2024 12:16:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709410615; x=1710015415; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=jZVgry90rEYwnQ29s3Mz+RKBDNtmCmbKQoUc6PEOd2Y=;
        b=BJfL6C0Xzs6wghQ+RU/vyClfzNjlSaa8C3sYe4b8S9XTPS3xcX4+5C3s2QP6bORXzB
         OwtHDcahIc4br3A1Xa8Au6b/j6Botz/oCAZdhwokbEWqKfdT7xHw0ILeq6GoRdbQHyJE
         0DzRqKfWF01P8nq9hwWnC57Kri9fZXLXXo3fSj6WVL972jbAMqvP01eDPSCMXVIWM/ks
         kSt1rcJYYZFXHwg+5tbLWaEtUJFFTa8pATM/WnRaDkx+l7gGdDVsyKgMOF1s2cYMAWJY
         wG32XXefyCiEtO7F+TocvT2fQ9KdH3sWrTbT8WlhC0xTiG5Mn9clDAvgzDEOcEh2GjQG
         j07Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709410615; x=1710015415;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jZVgry90rEYwnQ29s3Mz+RKBDNtmCmbKQoUc6PEOd2Y=;
        b=Gn5mau3JQcO6UHrj6lFJWujRU9kq4tW2YA8YquPc8HHQaXKqCx2oxpTotwLElNk444
         zzPrpoXsqt8l/Bvh64D+xyx4aUQZGIJ/yiAGwsMZXV+gNYAtNqNo7oBwRjI2+ytwwLz7
         7MWj3Otprglg7hewazwzbcyqZb1W5TLBbAJ5SOMTWqEaibiIttDMoTsq6z577I5b+UAZ
         Wmx71Vijw/I9mGlrEU+sX1Lrj+/Z5YmiLBF0XpkYX8pP6OooMHdi7Qe0Omt762i4itF0
         RwL01W/C3HKVOoTQJ2rGmKyq8PRBadcCWsJO3Gze8/XccFD0vqIAJrpflc0t0Uy0aAnr
         zdkA==
X-Forwarded-Encrypted: i=1; AJvYcCUDfQnPgTCqXE1/ORRGaVzFqzbyxKS/0i6c/aM235KNjLTA1VJAx6Pp7k3bTM+jklvgPuRB3TaeQGkMVthDIXk800BSj2FdaCou
X-Gm-Message-State: AOJu0Yz60BWC9cxXIsQySo1UMIzj9QjuZ2eR1pMisl6XfbchhJw40h0X
	5hFcPX9RRLiWx4BrX3u3DYetFBsekvzWXby5HOoVb0jvxHa/e51dYKhqVp06JcDYkUYlAZbINSG
	BTdLD4JDEiw==
X-Google-Smtp-Source: AGHT+IEnSk2Y3x8oCi5AN0TxB8bOTAxxMMr2bkZsFSHegFkEgU2tAVWqbB7S8UuQeE3B1FqjL8CudwlDT6LN0Q==
X-Received: from ipylypiv.svl.corp.google.com ([2620:15c:2c5:13:41a7:9019:9a7:b404])
 (user=ipylypiv job=sendgmr) by 2002:a25:a009:0:b0:dc6:b982:cfa2 with SMTP id
 x9-20020a25a009000000b00dc6b982cfa2mr177837ybh.8.1709410615275; Sat, 02 Mar
 2024 12:16:55 -0800 (PST)
Date: Sat,  2 Mar 2024 12:16:32 -0800
In-Reply-To: <20240302201636.1228331-1-ipylypiv@google.com>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240302201636.1228331-1-ipylypiv@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Message-ID: <20240302201636.1228331-4-ipylypiv@google.com>
Subject: [PATCH v3 3/7] scsi: pm80xx: Add libsas SATA sysfs attributes group
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

