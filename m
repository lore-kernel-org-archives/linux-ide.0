Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7574CDDAD
	for <linux-ide@vger.kernel.org>; Tue,  5 Mar 2024 00:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709599876; cv=none; b=pztYBbtUqLx2CnYvbw9/cuPWbtM4JYCupRNBGvM2jxER1SzoBMV5iyIx1sr7A78rssUZhPKFJbzibCNSYTFoKZ7Cy9KAyAxguI2T7YAaDgZQcdHD/Th0CmS4n31NG96T2fM7JQLUAMqCFSE/Vs5U7S9Fco2KxkmrsI5vWlqtrgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709599876; c=relaxed/simple;
	bh=x2hilrY6KpOzbV02gq6hK1kGpEZfvE2peqVvFcuy54o=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=t/J+h16p74fpI3WuBh2JUHkRqyaRPFAxM7VaURqvAIKzmPGDijEWbWfleiW4ybIzrGzutfOuEFCRYwTnmRe5UdA2/rFNU0QfcmcFG4f5oEe4j11od8w8Q5xDLChu6dnI5Zvh23eQ7grxJhGNapqrXXvx27634pasO3c7csKHcJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ipylypiv.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lpnhucVh; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ipylypiv.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lpnhucVh"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dbf618042daso7782134276.0
        for <linux-ide@vger.kernel.org>; Mon, 04 Mar 2024 16:51:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709599873; x=1710204673; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=lC7LnbzAeSHiH+Q2OB99L1Wy9pJ7fHavEqwaSfllwSM=;
        b=lpnhucVh3uqp+iAk90K17N6Xzme5PLZQYEG5LVyx5icpMABjqQFj3oJXv6kTd3O4h3
         CfnGU/uWrbK/jwnuG3XvzXV2N/1rykgMXHJ3afE0BMnI3rA5n2+pXxW24ON4m8LtoZ3M
         bgyNOXpVIQbrkvy2HcEn8HLJOmK8J8ki3VAuOTUgbPfgz9klw0HQyrAzilzMUiABu9wD
         W4Ad1T2cYpkBXeqUoCQ+zCVMGJCUGA+mLHT/Kj3XNy+srgWJe1Zqg7u79wZdhV7JEJcU
         m4RmIdeeUUlSqjI5ZslZtXulkTKMnmb0uehL6DiryEeBQu/D1Igb7XWzTIip58jMGOdz
         vlWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709599873; x=1710204673;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lC7LnbzAeSHiH+Q2OB99L1Wy9pJ7fHavEqwaSfllwSM=;
        b=izRIhalkRfCdzoaAO/lYziYFTHdKd2haml4Pw5bAVmMSNaQ2vNL4rUp9Wfwe093Gpc
         SVaMHBslWFp5FTS1O8Pb0GOgYt6Bk8AekTxnFCAw2WG2n8lrbAXse3F06A5JxT3xiIEz
         Fse8ZAl3XGoc+uSQsFZeqzdk9lMW9zPmBZODjKfT/Yqy6SIRrzF2IZj4zqw8uqTpZOP6
         u2OX2aIhG6XjxawDppo1ZwY1CDngZ87RN29q5FM+XT70ULp4MCHJmXw4OgdBSlPLE8/s
         vwVcGs4Y/Ky8rkOVc0cF1zBSmdjTt3PeQAYvuziO3VeIebGK9OXFuw6ot8NDCUkBfrVR
         fkLA==
X-Forwarded-Encrypted: i=1; AJvYcCWqEs1AG4Mb/q5LP/T3T9IB42ga10/4/jGAjjIBzIGdtw6Lpzd1dgoWINfGcEMSre07rmSjpXIgi0aBUdu2T27AzY72R4D422b0
X-Gm-Message-State: AOJu0YzABiRp+1kjFjn/4/vjZ97fAXVjX/VwbgPwxb7ok0CZ+8VHsbnt
	nd0guCUPZbLW2NlpWIaW2r8qWXZQVn/JylDxNt7lNUaxSBfv3IxyzxfNuFM8SpGV2YIqlD6YDJO
	cbMvjFs5UAg==
X-Google-Smtp-Source: AGHT+IHkvvrou4Sz7eyD4ve2xHQ0fzUP9Va/aVVoMDauBZqMVhzlZCI+ssSFGnQhQ9fD64bXbprrz0Tv/s/FQw==
X-Received: from ipylypiv.svl.corp.google.com ([2620:15c:2c5:13:e901:e760:20cd:d870])
 (user=ipylypiv job=sendgmr) by 2002:a25:e095:0:b0:dc6:4bf5:5a74 with SMTP id
 x143-20020a25e095000000b00dc64bf55a74mr406631ybg.11.1709599873516; Mon, 04
 Mar 2024 16:51:13 -0800 (PST)
Date: Mon,  4 Mar 2024 16:50:59 -0800
In-Reply-To: <20240305005103.1849325-1-ipylypiv@google.com>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240305005103.1849325-1-ipylypiv@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Message-ID: <20240305005103.1849325-4-ipylypiv@google.com>
Subject: [PATCH v5 3/7] scsi: pm80xx: Add libsas SATA sysfs attributes group
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
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
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

