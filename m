Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB367179B2
	for <linux-ide@vger.kernel.org>; Wed,  6 Mar 2024 01:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709688161; cv=none; b=Fj2p5vHty+0MoQiHlkP3XpFo5QXjEJ3IgztJC0o5OKjbPe06azKlbZvwCTBXBzOKfpQzQtP50ffRYDdtvd25/mlYEQNLTB2GR4KsVqrq3KBq7Z1X5eYUg/5C1Pc2q7ZFUs7zTXv+b49lEVtxvAfYE9Afkk3xgv6NPAPBcgxNgeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709688161; c=relaxed/simple;
	bh=wcg4s+VBRSyuqCYnMen4yuigKnSiE8NtEjtig8qUC2o=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=CoYwTGIpOWwD6E7Q35BlVFboPUjzqjbioLkcRPRsHxkHWNjQmKlQ5Nn9A6bRE4UPDuV3GdGEpddA/3v8fZSzclQKNxlNra8ex6gbNNvz4FJ1JQpoOumGQckyBonfLNW1nHsNkNLuudaG3Qk2/Xn+pqaEV54bGLy8+VF4OnWVUlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ipylypiv.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mroJrfGy; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ipylypiv.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mroJrfGy"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dcbee93a3e1so10794181276.3
        for <linux-ide@vger.kernel.org>; Tue, 05 Mar 2024 17:22:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709688158; x=1710292958; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=xvuQ4kezab1KlrTxoR3eIfXTgSjXQ9ZPEoqhGuVUIVQ=;
        b=mroJrfGyyEw0InFhfjPw6H4li267zjABJNkx4asSKDHCLlYGmazQQMdXZ42j4fnS+e
         +JOtE6KxovlBawr+yzBahaDx5mzghMSexEyPiJMR8LrzDK1tHuPwJPFnOeQYrhSW9HDW
         3hsqucdPShK+iNw+YxMgbd8+txfQ3BcxIRP4/jxBBIi//noGuUqgoqhBG1K5y05MXm96
         LPu32UoVScy08MR1c6arGd6thA78Fo1lPGi6Lq47Q4459P9Mx9/Yzr0ZISaCtq0GmN0h
         /OjtJFgBElSoLz1OkKVlGpyLfwkyytgk2+CTRn0qlFpoY44CKTzhgCzZUp3qbIRopK9O
         0jgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709688158; x=1710292958;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xvuQ4kezab1KlrTxoR3eIfXTgSjXQ9ZPEoqhGuVUIVQ=;
        b=kQcTYfs1PYZp1rnNE+zfdP8G5dw2dzeGws3WeO9EALHwTXBNjW8wVkXbVP098qA1VA
         +7mAJ7NQY5DZY1iiHJlIukLaOnesWlbl4Qv43o4QT9+U8oYvVlPT0eP7GoDtkB1aE/fE
         EorHFl9gF0DJkAPRVF8ds8kIsPWvgiTWS94UMxtK5zgzgttsZ4dzUhmaPT18HxVk61rv
         ZdoVF4R3qk7iqqx0MeZW6ab11+2IQ8s+Pcw1tydJM+K5NPKBBf0v3EoLL2MuJyZmMKXy
         aB5UWL4ICSeOiRiYlJL8BtBAfOFe2rk7BgDjHYq0+ZIXcDgQ0zGayNDINzNK/rspMbfn
         tHRQ==
X-Forwarded-Encrypted: i=1; AJvYcCXvVvl27jsR23Whvo2pGsff9r6K+SYh4aE2cd+6yCMIWFJw5+SmBMEeWnzDN2Chr53fbc4hp5R9nQHmizRNPPypCytdAVNiRBU1
X-Gm-Message-State: AOJu0Yz/K59QiK5E6Neud95ul4PxBEd2TmKUwcM+u3GVLZ6vfJWVcOey
	0YlFKmw9fGftoPF6rwksOfE90f0Hr1u0Ruj8oAnbPETENOqohiqPwW6eMK5U6tFyxyPBleJY6h2
	OcBF5qQC+CQ==
X-Google-Smtp-Source: AGHT+IHtVVDAQr0HlC7Y5wW7LyESC5hemfsg9S9HuZaVvIMxC3e30XENP7rU5kXxBG6Pcf0SSGSVZruuEt/ECw==
X-Received: from ipylypiv.svl.corp.google.com ([2620:15c:2c5:13:69ff:df2c:aa81:7b74])
 (user=ipylypiv job=sendgmr) by 2002:a25:c585:0:b0:dc2:2ace:860 with SMTP id
 v127-20020a25c585000000b00dc22ace0860mr493435ybe.2.1709688158684; Tue, 05 Mar
 2024 17:22:38 -0800 (PST)
Date: Tue,  5 Mar 2024 17:22:23 -0800
In-Reply-To: <20240306012226.3398927-1-ipylypiv@google.com>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240306012226.3398927-1-ipylypiv@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Message-ID: <20240306012226.3398927-5-ipylypiv@google.com>
Subject: [PATCH v7 4/7] scsi: mvsas: Add libsas SATA sysfs attributes group
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

