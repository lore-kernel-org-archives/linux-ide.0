Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70A4A7C0A8
	for <linux-ide@vger.kernel.org>; Mon,  4 Mar 2024 22:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709590112; cv=none; b=OBwIPKUID1fuVaHirv0yo3sJ9YaFa2WwRcHft32HBE8E0NeVO9qsAbDUadA45qVwnB6HJHrsIc4W+DFm5S+wTBdqEyrblpXBT6svleMdmPpLsziB6m/KrGa1759dm+6Sdu9UfUGX5G6vdA84vP3n2Tlsp/LRhabDJuMLtfBIr+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709590112; c=relaxed/simple;
	bh=4eQXovcqrUDWoGBWOuiv3q6lQ/J5LYDMhi5YjcOJ/04=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=pE3TU1C3Xpouhk26NYGnmJeYueo3Em2OuMImUD/uVu+iTGKtmMjgXdDYsSym6bFZmnIw2HsnKgLzPbCq5M9JemF8g0nn4qA0GxsVz6nHnnx0ZEDhWYOuUU9UqqavKcxgeg91e8tFtmmtcaY9ozXpUylQdTGDNpKhWnULJ4vxsmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ipylypiv.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dQpeHjQ7; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ipylypiv.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dQpeHjQ7"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6092bf785d7so92908167b3.0
        for <linux-ide@vger.kernel.org>; Mon, 04 Mar 2024 14:08:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709590109; x=1710194909; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=wUKdE6MTHBYVYLvqGpfj3dqBxke0cNrMBiaXjFQf2rA=;
        b=dQpeHjQ7QA1pIn72m6EPynv0sAURg/7YHYkUXYOYH7v4eiqXDr4HbB+wkkKeWBe5Kg
         GfPVdgiDgJZvZ/vodAYi6cXnd1+Ofv3QPq7Slgp+QLqdYUhWZbSxnZbPayw3+MCJ+jCj
         /5tvEqOsAy1KxicWnfc3zQvTxMYaqeab1fextsOe7IANm81qC1JxdrjOcfn5K9bvmemU
         /XY7rVnEypG4dEFyjqXyFk4KOEv517xPRNPWw5bAyzUMUxGo54RccMcr525HMofP6+5p
         jPJmEUgJhYVpmMtMQW1z7ezDyttaBaJ4jrQNMpsnla3mjQoBSl7MAq2aN31WvKRCAi6Y
         LiWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709590109; x=1710194909;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wUKdE6MTHBYVYLvqGpfj3dqBxke0cNrMBiaXjFQf2rA=;
        b=q5GPEEt5Htgfd3CGt/hMN1APXpZNvFjSRc4inkAbzD4Z6AMkR31MlR2Kq+cttclv2X
         u7aUTrEQjaAiDoVJOj5ly5c5KLttYKyXwaclDhGm5N8vnIAr1O7ZZDYyRz+duQbqS59P
         4Rqr/Zk1Jkx7ZmasDdlZekhYFan7LoQvclUgGW5bT7dZOVeZMFVMX59HSa15gJF578Zc
         wp4wvMuMT95Ptf3UL01eg3GIK3Ps1YH/nF0vweNgfGLZBwzftRVmKgEq+i3Ke2GA/XZQ
         AkIY4L2VWSlFJ3fh3qHEmjAZzhE4nXBVorxtNvXjWRw9lZOpUpKs40UQF+rbuBjRxVrC
         s49A==
X-Forwarded-Encrypted: i=1; AJvYcCWm/6tbSacn2ZeURdoACvyBLdYVRk1N3Be3ATtXAVQWkL6jUjlcVCDxVucmiLyUzQzeOVDGb1vhO0Bec/zrDNIgbNDuYa98438c
X-Gm-Message-State: AOJu0Ywdb/FoD3N2b1tHWtpqhlYFEg/Y/uFb64UXdZ0pPlKhsKDtO/2+
	GNmPSpNMORoN9BWOqiRCH8xmupAMRU1KLjVp/IyPxDWGkDqDUdjnZHxtufjTc7BtB806aTh1rKu
	A2/B8EVCnVQ==
X-Google-Smtp-Source: AGHT+IE8lX6WVuWWnn+9WEDVf2LWVefLzFHcWIYYTkcxD81I7BR8+w/C+POVnwC/z3ALXprVXAPmFcSXSykyhA==
X-Received: from ipylypiv.svl.corp.google.com ([2620:15c:2c5:13:e901:e760:20cd:d870])
 (user=ipylypiv job=sendgmr) by 2002:a81:98cf:0:b0:608:bee6:150c with SMTP id
 p198-20020a8198cf000000b00608bee6150cmr3168816ywg.8.1709590109648; Mon, 04
 Mar 2024 14:08:29 -0800 (PST)
Date: Mon,  4 Mar 2024 14:08:11 -0800
In-Reply-To: <20240304220815.1766285-1-ipylypiv@google.com>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240304220815.1766285-1-ipylypiv@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Message-ID: <20240304220815.1766285-4-ipylypiv@google.com>
Subject: [PATCH v4 3/7] scsi: pm80xx: Add libsas SATA sysfs attributes group
From: Igor Pylypiv <ipylypiv@google.com>
To: Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>, 
	John Garry <john.g.garry@oracle.com>, Jason Yan <yanaijie@huawei.com>, 
	"James E.J. Bottomley" <jejb@linux.ibm.com>, "Martin K. Petersen" <martin.petersen@oracle.com>, 
	Jack Wang <jinpu.wang@cloud.ionos.com>, Hannes Reinecke <hare@suse.de>, 
	Xiang Chen <chenxiang66@hisilicon.com>, Artur Paszkiewicz <artur.paszkiewicz@intel.com>, 
	Bart Van Assche <bvanassche@acm.org>
Cc: TJ Adams <tadamsjr@google.com>, linux-ide@vger.kernel.org, 
	linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Igor Pylypiv <ipylypiv@google.com>, Jack Wang <jinpu.wang@ionos.com>
Content-Type: text/plain; charset="UTF-8"

The added sysfs attributes group enables the configuration of NCQ Priority
feature for HBAs that rely on libsas to manage SATA devices.

Acked-by: Jack Wang <jinpu.wang@ionos.com>
Reviewed-by: John Garry <john.g.garry@oracle.com>
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

