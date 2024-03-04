Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C26E7E77E
	for <linux-ide@vger.kernel.org>; Mon,  4 Mar 2024 22:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709590118; cv=none; b=diThJoGu+Rd8D8l9uQD7a9dIrHKstNh4rJ6DlU/H4CGET8RTo4ET1jcheGLFh5b2pAw2+vpBOeGtMzI6WrXHv4IUFmtuX4GOPGvd2XMUg0ZWSuBeg44QQAxEKop5FiyCoI0eFSPcwVJSAFZqkQXF124RCLFj5/k5ByGzQHcYtb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709590118; c=relaxed/simple;
	bh=+W8+jAS8TcKEHOvO1hK8FP573ZHzjv14SAApm78n2C8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=nENXTV7EAZyZYwIP6ADOXJisSvt0M4b2cL0acbRqOGy8OZ4HOzHGpVvjbybb5jL9c5Su5N9D/tRwYxRitlUQHECNNhmg5B1dhEx/pHnErf/lFD5acTGVzqQNW3WDdlAagfp8Tk51cIi5mPOBPiSzueXhWxl/P5ZPOFcxCjRrvh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ipylypiv.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jq5CMMTs; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ipylypiv.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jq5CMMTs"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc64b659a9cso9123679276.3
        for <linux-ide@vger.kernel.org>; Mon, 04 Mar 2024 14:08:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709590116; x=1710194916; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=a8s/WnKeWQhMXiOREl+4FjUl4dsbGRC/O45o0rQHXl0=;
        b=jq5CMMTszGoc6KtHjXu93dCbv3ZkNK7hKQopicErzvbiRtfHSNUprthlrLj/DJuW76
         x7USHaYPNSEtnRaXd3+V1Vl4FNjcVvB+mqjSCesUMVbPUG4rAzcIH0raALcUCIUTaUoR
         cfF4TR/sv9PPn5Fmc6EedOMNL2msewbB8DTlj64ZWP2AnckqGsciK21fagPnysEYIEz9
         v2L1dA+aFC8JTGV+85yQlligmwTwyIjW1dcM/pzbD9jNPKi1XEDXaeK9sqttZi1m0ddL
         mF3lJ5w1FQacQ9f64c4zKxp+KfPTkZn7WlU+5ivrIrfaoiqCcrSJrnCv19oAedDAIfC5
         5xHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709590116; x=1710194916;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a8s/WnKeWQhMXiOREl+4FjUl4dsbGRC/O45o0rQHXl0=;
        b=Gxn1BtBj/bHJILDTXmJh1fCR+o/4k0zIS6SXsOnJRPwOnqBJNfUa2gm6G+4FaGOOcV
         6fL3984k1tvpFPlLwLj0mlSiSm/HcCXpime3NwjuPbcus603oyc9Aorb6SVliC9DIuY5
         m1ztKu9ATUDFNKNO9JBqTX9emiODjcKqgVU0uhAyD4DfjwbH+6US7WYlFEos4BVHNm5e
         KQre0Gh+PRZZI9gZ9TtltJLbzWsNCwGVwmkobobbLMM7CbHx9nT5+lbMYLh9/SA2twCm
         EdeDuVlmdQp7Gm6Iy6Th9y/hNVY+fyfR3OdF14oblHLurXDfZW4/8h7rKLXu2pC7y+V+
         gw9g==
X-Forwarded-Encrypted: i=1; AJvYcCUr7bclzaU+/YUw66mxpiymRp/Q2YC9k8yQoYdGql2ujHDL3ky/9LcbD6a5sMmXndH7P8ZA8hDhGw0OuuSSRg/fYlQwFjgGcRdL
X-Gm-Message-State: AOJu0YwXLSg9soiShS/WZlL62FTLZ6FzbbL8pEXnywQTGOwBbevK1yr7
	EHrlm1umbQet7Rrj4pTLhPZ07vf4J5LYMZS/brC14rCU5Hbwerlx2lrC98zE118oa/ZNeSPl9/q
	UtzvlO0FrmQ==
X-Google-Smtp-Source: AGHT+IEBxY4gG1avJfrX23Im3p+o1GJRwp1gaa7HUGf3AiaFkIi5rLcnT340Q/8auSlTGt7JW3Xn5y3De4hTRw==
X-Received: from ipylypiv.svl.corp.google.com ([2620:15c:2c5:13:e901:e760:20cd:d870])
 (user=ipylypiv job=sendgmr) by 2002:a05:6902:1004:b0:dc7:42:ecd with SMTP id
 w4-20020a056902100400b00dc700420ecdmr2634387ybt.6.1709590116613; Mon, 04 Mar
 2024 14:08:36 -0800 (PST)
Date: Mon,  4 Mar 2024 14:08:14 -0800
In-Reply-To: <20240304220815.1766285-1-ipylypiv@google.com>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240304220815.1766285-1-ipylypiv@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Message-ID: <20240304220815.1766285-7-ipylypiv@google.com>
Subject: [PATCH v4 6/7] scsi: aic94xx: Add libsas SATA sysfs attributes group
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

