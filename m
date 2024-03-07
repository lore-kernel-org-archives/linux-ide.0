Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B98113F45D
	for <linux-ide@vger.kernel.org>; Thu,  7 Mar 2024 21:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709847873; cv=none; b=IR5v35qyKIx8ECeV8AjExNHDviOxkw1gIhrscwnqAJZ5RRjs9+eoY3jPY0Cw8HZR8xprrNhznoEpaVJPJdf3CbVSwajLO3bXWDlbDaJsFCmsHiCJeOHqBtpS50B84X5twq1wWYells/x1TZrTzm36SPLcodpgYUeAKlApJtCcuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709847873; c=relaxed/simple;
	bh=kXKDe8j9cFkvG0Qo2NNWFPNOx8lWfLmANEVe8Lz+sfQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=fg7JFjR7QO5QR/MRUwmp9umGDRSTEnRTRBUODoWuFBbngy/6JVhCwVLgtjtjZQUQ253mBppDLoGWpzk1JerklzJqLgjNER+uSvBJ5rH9ak/oPqQJ6UWxUYF6Kjwt63rCLvNmUVet5OV8GpESKtypvtT0flVriUC2I2unxajzK3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ipylypiv.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=D1DpE+ab; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ipylypiv.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="D1DpE+ab"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc6b26845cdso2093885276.3
        for <linux-ide@vger.kernel.org>; Thu, 07 Mar 2024 13:44:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709847870; x=1710452670; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=DmnC3uyU6x6FeNu8iM8omlazV5ryfMaj3jlXFhUGyaE=;
        b=D1DpE+ab+naWXQGjUzfPh4S+YlIk9qcfq8LDHSB/f1uQ9eUR8Ygi+mN6oF/Lc7VdPF
         CatRjXqAkrTeqZ1RK/umviv3x5Xtxv2h0E8oYXbmJg9zETztI2mPu/a568tCcs/ouXFO
         k4aTNmdcfspyXKrT93aEA14zPP2fOFpY3TKRbiQ10NHnDX3Op7arGzcnHtnahPxG5duv
         lSCOO2kG34dwqYgueUiWshmJEM4M1iJwWDZEj/YpK/xta9xUSHZbjSFI5EYX+POahYcK
         HDbAyRGHnjLqSwlH/rwC6T0L+vbEWP5MBcst7dledXwMJMIRADqvgOSghpWttN+I1/9O
         39bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709847870; x=1710452670;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DmnC3uyU6x6FeNu8iM8omlazV5ryfMaj3jlXFhUGyaE=;
        b=MzsbW1aP8sP5hsWX/qIEAn2Lxb8LY/NEhF4NyIwmCdtD7JcllKfPNp8y1jfH0MR0PL
         W5awGAL+fgl8WnOrxQfLFwZEbBVcrb+TgUSkl5948X/cj/mbP2piTKRdgcrtf+WTH30A
         wbul48h3zG1YdspW9cvzAgsYqQLVZu4cNwxocy5Fus7npAkeEZAByLULmxY2wt7IT8tW
         TdSIycprJ2cEQ09lWiBZU8RN9E6gmNoBzCPOOJ17QlI5Z3QQ/g2Xj+CEbWmJZVzCayx8
         WWAsAigfoneQzLS2VT38wbepFP1oUZmoxcfLG5CCHTnak1xOvciU1HU0U4/xu5alsr9U
         MDuA==
X-Forwarded-Encrypted: i=1; AJvYcCWJT6MW5T7FbZB/+L9Q4c0IaibrybZ5cx4u0CFupiimP21esWnXK5CKHIuiLt02sDHYM/tkjsGT/M1tkrZXezChxJyKM4OcnHqP
X-Gm-Message-State: AOJu0YxHKPzl2V9zKwx+9xfZC+TcLAlu+RvzuC/+b4YMjRwl3k35+Dst
	xzara3vxW5hlJ7cuKqkElxjU4jlJ3Y+nAhe0SMO1JiyJKxXF6kWYa809EKfpMVsSL2B4xCBRJa2
	bVZRJsFvDQw==
X-Google-Smtp-Source: AGHT+IGtgGYTjr9pq4RmsTDLnlYdDyhrwsA9Ej+IKG1Z6YxiyO5O6tRc0vDyQXeFVxteRRR1yu9MazcedogGQA==
X-Received: from ipylypiv.svl.corp.google.com ([2620:15c:2c5:13:69c0:c447:593d:278c])
 (user=ipylypiv job=sendgmr) by 2002:a05:6902:1004:b0:dc2:3441:897f with SMTP
 id w4-20020a056902100400b00dc23441897fmr4675217ybt.6.1709847870576; Thu, 07
 Mar 2024 13:44:30 -0800 (PST)
Date: Thu,  7 Mar 2024 13:44:14 -0800
In-Reply-To: <20240307214418.3812290-1-ipylypiv@google.com>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240307214418.3812290-1-ipylypiv@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Message-ID: <20240307214418.3812290-4-ipylypiv@google.com>
Subject: [PATCH v8 3/7] scsi: pm80xx: Add libsas SATA sysfs attributes group
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
Reviewed-by: Jason Yan <yanaijie@huawei.com>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Niklas Cassel <cassel@kernel.org>
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

