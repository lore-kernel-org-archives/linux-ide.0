Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83D7C143729
	for <linux-ide@vger.kernel.org>; Thu,  7 Mar 2024 21:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709847881; cv=none; b=A9sCRfYKdGtYkkE2JKODuhqi8MevhXK8FgKoz747fFvFYdXc6wHWM48eMJ+ZHHYLBejz57icuq3NnTXAImxNWAeXC7G60RnmHB7+U8mMnkWvwXGRwGFKOVq3NYSA7A+eMxul18WuggHRhAGnGM/fGzU9Csm1zw01m0cfZqnf8YQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709847881; c=relaxed/simple;
	bh=oKUWwFJtdtWNhMzwdWgAICCV9qWEtrIx7hjp1hett1A=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=tf+fM5Cj2aCoktOfXiGNbowfAi++qwPEw1yOp12vcFeTmhIlykqFu01mwbEbdZmsFqJOLmqpmwwTF5/1nJLr5o7AsR5QRWp+dM/FuaCdfPodJTmzY85iEQKBeu85JssFdAbQCm4Na9RBFXJuFEcm3n/wJ2wn0sQflKfEZ9LpsYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ipylypiv.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=q7lLRLLL; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ipylypiv.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="q7lLRLLL"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dc6b26783b4so493827276.0
        for <linux-ide@vger.kernel.org>; Thu, 07 Mar 2024 13:44:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709847878; x=1710452678; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=2vpzIuphj8BSvlf66XaaBIKXyJGCME8GN7Op/FUvHdM=;
        b=q7lLRLLLqj4ZixcWweKKNskOKVXZYteWJ2f6RkN2f18wlyun41QTyc/lZd7UOpdT+D
         xEa0hyQtbsXCoK7Z9w4+jgv2M6zAJV+FEeMUK5aqLq0dmkl79bSF0M60VYy/EGHaOoNF
         vDAqT47BnwLK4wZ0Mm2+ilSBUaMcrPKuDIxzDdQzBu8QkBFYTjMt2RA010cHSEMlEiKT
         gR/Q6gD11MhTmpRYbBM8PbRbH2f+FRE5vrYLWTxYCnywtF35vTe2q5PdHbOQcwgyxWut
         XRFv2MqTMY25YDDHfns1TzHISy3dhAR395zZ8w/wqHTujVvy/anEjgZjUYSIrbDkzXZT
         wFbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709847878; x=1710452678;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2vpzIuphj8BSvlf66XaaBIKXyJGCME8GN7Op/FUvHdM=;
        b=GEcB4ZSl9YjtAVyuROvHZ1Weai5Nog4b01T58kuUH0ErEJIsHUvULeGbJTTdxwxXf1
         LOuWSklUSj4Cem2Ksn5QTm/n2encJpGlgSK5UlgGCTD77b8TIIZEBSgFsO+Q87mdx1oC
         +w7Yac2MXzwdZHWqqZCHuTmiHhl4f6/pIzmdX7bwuHbHZvliQkQwNXgzRMhwEWDgf655
         kcThuQ79Y86ePD/S0UNwrphfYBJH/x8csJPw5F/BBjctPeSuQV8MOE3Uyv6sqlMR+aQD
         bWdnAgjnfejBW/xGcd+NC964sw4y13Si3mUGkeqjcakiCRWn8d20je9+dQXDl86+t1Px
         RNAg==
X-Forwarded-Encrypted: i=1; AJvYcCXfODbEZZ5wo9DfKujg3pGG4fazNWp8CxqbCky47W+rquX+nVZIghRjafhOUR2X8RP5LgoDweCitq5XovWDUlURHzEJtg5AqU99
X-Gm-Message-State: AOJu0Yyfn2B7VYaP2Qk6bwndSAmV4aR8A2UQhta1YXDbniMOIBaj4vgN
	J6GIaqOb11EfqZ+AxAcdjw0qbMLGMTecvA/nLHORwOv2PFfaIDzboz4gaql0MWXuLmLKLCo+w3b
	69xITL1LRAg==
X-Google-Smtp-Source: AGHT+IEJLNyfct4IVxJM1xng3J7p5UWMEzEo7qnqC43CO2vkdOobv3kRmpH4aDa8M7rwEpAdkiwZw+qBIcq8/Q==
X-Received: from ipylypiv.svl.corp.google.com ([2620:15c:2c5:13:69c0:c447:593d:278c])
 (user=ipylypiv job=sendgmr) by 2002:a05:6902:1009:b0:dbe:387d:a8ef with SMTP
 id w9-20020a056902100900b00dbe387da8efmr656689ybt.1.1709847878739; Thu, 07
 Mar 2024 13:44:38 -0800 (PST)
Date: Thu,  7 Mar 2024 13:44:18 -0800
In-Reply-To: <20240307214418.3812290-1-ipylypiv@google.com>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240307214418.3812290-1-ipylypiv@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Message-ID: <20240307214418.3812290-8-ipylypiv@google.com>
Subject: [PATCH v8 7/7] scsi: isci: Add libsas SATA sysfs attributes group
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
Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Niklas Cassel <cassel@kernel.org>
Signed-off-by: Igor Pylypiv <ipylypiv@google.com>
---
 drivers/scsi/isci/init.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/scsi/isci/init.c b/drivers/scsi/isci/init.c
index 6277162a028b..8658dcd61b87 100644
--- a/drivers/scsi/isci/init.c
+++ b/drivers/scsi/isci/init.c
@@ -149,6 +149,11 @@ static struct attribute *isci_host_attrs[] = {
 
 ATTRIBUTE_GROUPS(isci_host);
 
+static const struct attribute_group *isci_sdev_groups[] = {
+	&sas_ata_sdev_attr_group,
+	NULL
+};
+
 static const struct scsi_host_template isci_sht = {
 
 	.module				= THIS_MODULE,
@@ -176,6 +181,7 @@ static const struct scsi_host_template isci_sht = {
 	.compat_ioctl			= sas_ioctl,
 #endif
 	.shost_groups			= isci_host_groups,
+	.sdev_groups			= isci_sdev_groups,
 	.track_queue_depth		= 1,
 };
 
-- 
2.44.0.278.ge034bb2e1d-goog

