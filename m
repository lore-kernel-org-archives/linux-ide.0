Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8C4C7EF17
	for <linux-ide@vger.kernel.org>; Mon,  4 Mar 2024 22:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709590121; cv=none; b=QJcYxZ+Hjv6oDPAzPliieFqlsahuc7/4nePLCiHs0+yoGP7FftMVRgzIxiHm8HlQLRT05dUxXm0jVHBJSsnR/oPOGmtbaX91IARrMsSxsvogurN9u91umPr7tOD1a5XfCE6zi0l4Wj/e6sYLSm23s1tmvSIQD+rei1KVyGlRE+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709590121; c=relaxed/simple;
	bh=k2RsKVsqn0SP6W3+GcW/+9UaRpSxki2AedJQ+0T1tis=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=bvSXNh+xmNSOpVtbbJOaO17c8SOJ0V7hlLezI/Bh15Dr3BA8ieTyLScBG+EIao/B/VhP/mxA8Zgn4vx7EKhsM4BgHLqmAtLv0LBEgrfcGiQyGPn4C2O7PpnKrmdlD+2TWnGEh6oWt4HRVqRsxtYuW8ifN4fn29Jw0BHO9RAD69k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ipylypiv.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4rcYLe3e; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ipylypiv.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4rcYLe3e"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6047fed0132so75943287b3.1
        for <linux-ide@vger.kernel.org>; Mon, 04 Mar 2024 14:08:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709590119; x=1710194919; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=9BOHqZcuLWtFyhT4gaG3Cu9uWAk1ebaqFWaPcojfGUM=;
        b=4rcYLe3eKUErXai23zunRAGizqBe2Zj1IhUCSk00l+gyZc6OtX7u0H78rboYT/DtD/
         vINoZT6ZkkkY2xJRReZAbBHXWymHFSRSc5+ZYtMpjD2/OV8+QIGqblDoy65c9ibp8Q6Z
         7FlS2bDBRxmCvxKQ5EzPcLkhZQQYK7zoxnTqfW7Nc14xN2hDPaYalkkEYX6+bfyYcdae
         KOlHMZhI4poYEikDdJ0zg4ZPT/kIcpsrdmvHHUkSU6QwZS35sQZZuT1TOxlMeId3HWni
         9iitkZd4xSIx5dHNVihsPKCrTrtZ6EhxZGQZ0cICF+bZ7Gs3nT5K25jo6AQPanN56T+F
         fmnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709590119; x=1710194919;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9BOHqZcuLWtFyhT4gaG3Cu9uWAk1ebaqFWaPcojfGUM=;
        b=GvH0PKsIH4geL+I7MtCzW++uoz/9fyHpXpyIT0PmU6oSzq9iyRRWa3diqBPka5plgu
         KV+kfMZzHt10Gg2eJTDCmXn7Pj2QlajznVejIbUnTLPzO33CarefldtHFfCrBntcCAdS
         HJIBazlouUOgqHWhSQNEurw+onHfdNc8UIoELt0dJKy9Ss/jPzM28SHoYAGTcUQFbBE0
         Y+RH6LvNTBkzBgey/mKRjCtrB8iCBUgjxkujB2qsQCdM9lEqhktDIqwBX29aMw0spsSP
         ZGVFbh1yRPXuqR9UAG396SeY7/fYsrXR0ldc3t7POlpPdVy/1uzVpH47XMrL6Z6xz9hF
         ttTA==
X-Forwarded-Encrypted: i=1; AJvYcCUWxEJqP9IrOI2U2EyAPz/l0Eq58/O55Ffsj6zr22xCtRo02bQakPnpMFaQ3L5JfQ+g+BO2BHfFKA2q4RgvnvmQUgnhWrg5Bvyi
X-Gm-Message-State: AOJu0Yxiy8vAcAuSeBxuDVdK7+4lCnPl0aMGubfckqBKDV3/Zj2OH/Tc
	8BM75x7xAQWp/0IC3XaHo3zP9Sxua2ZyXautUwW5pqDEUb4tCLSwZRuw9wtw8ahIht38bJYvBlR
	nDNTg2s+xbQ==
X-Google-Smtp-Source: AGHT+IFKnkpuBehKxAI5KNP9ibb1U2ESkcGB5dQvh7Jo0lfObivCLCwOiAc4Lh6eu52G+uxOMieIcl2LF17sIA==
X-Received: from ipylypiv.svl.corp.google.com ([2620:15c:2c5:13:e901:e760:20cd:d870])
 (user=ipylypiv job=sendgmr) by 2002:a25:dc4c:0:b0:dc6:d1d7:d03e with SMTP id
 y73-20020a25dc4c000000b00dc6d1d7d03emr444115ybe.8.1709590118871; Mon, 04 Mar
 2024 14:08:38 -0800 (PST)
Date: Mon,  4 Mar 2024 14:08:15 -0800
In-Reply-To: <20240304220815.1766285-1-ipylypiv@google.com>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240304220815.1766285-1-ipylypiv@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Message-ID: <20240304220815.1766285-8-ipylypiv@google.com>
Subject: [PATCH v4 7/7] scsi: isci: Add libsas SATA sysfs attributes group
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

