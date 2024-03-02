Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31F7245BE1
	for <linux-ide@vger.kernel.org>; Sat,  2 Mar 2024 20:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709410625; cv=none; b=UginxOiXHoVq97IYyH7h35+3BmzhqE2mig86VqoTI4ZIp7cgspg3rDgmoH/R+NtqymoJ/VvFqD6SJ/6npR8UDWmoQJkPQ/mRVcvjIhIYFXe2s3RbqmAgrLL25tmYEYEUGF640biPLd3FCO36uDhRbXnxwAQ+noEGIaXS5IyjFwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709410625; c=relaxed/simple;
	bh=NmBOqWZxMsasMb5PgbvxyvjHON2/Pw2TXxQ33JzQhZE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Z8pZP8NIXDQYemHt/ZnFeWEAuxBUY3wu6THWkU2KhBUr09dcnIzGR+hDsnUae3Zoma0tK/w0DEI8aZaUJYgqu4frUgew4nvykezxCY26t9rRlfbzaiwP70ZbI8ieop3lwHTmnq1jsP3/HxgUqK85J1tql9PQkowCK7YjzWiRNls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ipylypiv.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ku3hPp3S; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ipylypiv.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ku3hPp3S"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-609a14c450cso1108517b3.0
        for <linux-ide@vger.kernel.org>; Sat, 02 Mar 2024 12:17:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709410622; x=1710015422; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=6eLIO8kHvIyF+nVEO24K/+ffrh7ExfG12XLwVuO+HAI=;
        b=ku3hPp3Sq6hCgHmpghYtwwY9SLbxMKkDaVnD5/m6bFHMPGCv3kEhjELXhOg6Z6vopB
         hQfj7P/mye80iGn1PK66WNz3vq0cQ+msBnGEAZX+mDFPCBqqGCyZARKXgPdNvkCAFic+
         Fn/Zq6bB/yar9vMn16Uo1BACsD168wmkXQu9gXOhpRX+GQjvk0C2D8pqhF8C1T4AxCPO
         2n/4333sL6x6O1FPyDJYfwpdk+a/96h+1Ft7s8JtTUNUJKG73wqzJAJOdhK7RdQu13vi
         LIdMgPnyxV4aifLm4c3DzE+BgWNec3PUT7vx3ipfWuH5dhP7NaLf+9obVBvwiYWpWd/f
         lsAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709410622; x=1710015422;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6eLIO8kHvIyF+nVEO24K/+ffrh7ExfG12XLwVuO+HAI=;
        b=oaMLosfYtSeKW649UU6FSkpp1XrD1StdMkV65hskUBvUyOxywS7tsMkQMDb/S0adlA
         otJSbhxTxGIYHcIxeMxZw5yRI6Fi8BD9+JLoG55SxBbwSGhismjX+c1UnA9WKFast3kF
         57NoATglytwnf+mxjkoCoo2nZ9r2/2Sp6HcOhS+ZL5giyBZCx2/nFN5zK4OHAss9nRQQ
         ORJ3sou0pIdv7v3rECHexdrv0pe+1DM5seFYaiGXEnFpwuB2HIRzZESKsJFbEvH9DZeA
         zWlcQNbpOohL1OSU9cJD6j43y5JX0pFOUNGJ9EZOJLBeMOiETF1ezVx+FFLlL9oAHwax
         ye9g==
X-Forwarded-Encrypted: i=1; AJvYcCVCuElsiNYP1Ig7PFOZG+Z6GRpaUBJZq9CLDHnuyGg4ZpnrBk/3A4pfBvss1OVnMQPq02wgQweMsLeFEtz2vq3guRVmswTApwRA
X-Gm-Message-State: AOJu0Yz//T8EX0XkiolpKgGQ23VkxAPY51+Lf+Z7nuwCyb68+3r2rG3k
	t0E1qzYAs2Zx5/M7PGneyn7Ug7b3AeTPpw8H+sM0qNPodhwwnBuk0hNJ1/7N4ijxrb3skvk3ysQ
	9jc8yV/jrXQ==
X-Google-Smtp-Source: AGHT+IHVcwSaZuZmZ9deKrJ3ncOBw+VoBZaGyTpyjC/Szw/zx9zZRKAZkBkaArbOfb7Vo3UcGo0wQ6r/kETiHg==
X-Received: from ipylypiv.svl.corp.google.com ([2620:15c:2c5:13:41a7:9019:9a7:b404])
 (user=ipylypiv job=sendgmr) by 2002:a81:9950:0:b0:609:4d6f:7c0b with SMTP id
 q77-20020a819950000000b006094d6f7c0bmr1094668ywg.4.1709410622201; Sat, 02 Mar
 2024 12:17:02 -0800 (PST)
Date: Sat,  2 Mar 2024 12:16:35 -0800
In-Reply-To: <20240302201636.1228331-1-ipylypiv@google.com>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240302201636.1228331-1-ipylypiv@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Message-ID: <20240302201636.1228331-7-ipylypiv@google.com>
Subject: [PATCH v3 6/7] scsi: aic94xx: Add libsas SATA sysfs attributes group
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

