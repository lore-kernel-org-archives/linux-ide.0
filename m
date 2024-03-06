Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 921AF1BC22
	for <linux-ide@vger.kernel.org>; Wed,  6 Mar 2024 01:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709688167; cv=none; b=ezryq9A1RQ84ebZaVrLSs9Rep+TC5Ja/zHhy6i6FFpNO7PNoL401Kqub3R4rQCZOY5V8GyIiJEUlSeBKzdITset9TgPO6yhykVqAdH6+drja+KXmdK6XLD9uivU8nMGpxRHUUq3isGnPN7MJmT3oWeYi7Wn7IgUFQt2TH5XOMNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709688167; c=relaxed/simple;
	bh=ZQgGWVSWytcgK5MJZ6jggoBjQfFJugefhTJSzcVcgYk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=MQvPTq24EpMH0mLjVNSbLuPMWEmLf+WHQS+jGw/u+8piL0IUK0aoyF12a+UBxLUrTF9K++5m7T6gaX4alHRrTmMFmQeJ4qc8W2asL1M0eecrTP1kV2sz7DOu/DLlpCvkriVdhSwhAY4llOVt58MMYkix4n4l0Wl43LSNm9o2zos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ipylypiv.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=k8jNQqeK; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ipylypiv.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="k8jNQqeK"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dc6ceade361so10563008276.0
        for <linux-ide@vger.kernel.org>; Tue, 05 Mar 2024 17:22:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709688164; x=1710292964; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=iW4+YjuNAKvAoJg+NmQ5C96xY/u5WzV8UruESW/Bs4M=;
        b=k8jNQqeK7gQKIbzMge/onFNDkBDQoWlKZc9e1Yu5CHgqUsTYSSqY8AvFKi/KUny4DT
         eopA1+krKRaFD23m9rv6jQF0VejsCHmxr5u0R4oLH64/KmvAcIQjvVSnFCrglueIk5rE
         +811v4ySFHjV5W/G5zybxXKbGN0RpuM7A38KXr+KiDdgsOLYSVDgsScifR4XuFNE/Ofe
         fR2HaeDOz1SeyUQvp1ZJTkm1mPCMLLlTWozsmEswBw3jTw0VlgxDspSE6qhgysp/RktO
         u8X9t2eA4dFH37vUCJ8LIM+t+2ck2ck3LO5L1Yc3Yl86HRj1EiYR+uMWrGhWMAau+QtH
         BaYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709688164; x=1710292964;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iW4+YjuNAKvAoJg+NmQ5C96xY/u5WzV8UruESW/Bs4M=;
        b=UBiYDojLYmsIfjU4kcB46zXg5cyALA27Ld9/dX3iEPC/e5W65QCP94sJtuvop1jZhS
         Y4Em9nn3C7rDJViMFQJncxFGRafPt/q5DXdfvcmO96WOlER8QJ999NNKfK86Hbj/zigv
         8qa0rr0kLa+tmtIscWjZIdXBEXEi7hM6+9MxfVoqUT3DQBYCAlf9A6lhYdqU6FkwO33E
         1f+AtgaINUqvG//J7wMO+n4EeyznMxA9ARkvEWM6XRiDCPurAWhQTv74uHCFpEZ6X+st
         bdCj2tJMgb2XTzcLtf1saGwfGodfOYXszNE7kHBbEutNhV7PawMNGmzPa5ypP7EoKNnT
         Josw==
X-Forwarded-Encrypted: i=1; AJvYcCXbf/sAUKJdeikbRN4tuDHy6fN2AXy5l6GIcb4Oq8ChYMK4wy7hwDBefAgR10q9ZfKqO4Or3fVbFbfqfeeX/Gis2MKociSFeX+z
X-Gm-Message-State: AOJu0YyeH1cyNczwAZbWE9x8XUjyWLptBYHJ3fo1jim7vMvvP7Ul5ekJ
	nwVyhtlezc19S/UlorshBZodMqbswvqZ1BPFaRhzGJis/u56TQI3jIQgw/VkJ0sHCJ8f4wZbFbO
	IwzNmzuJm5Q==
X-Google-Smtp-Source: AGHT+IHdUO0CSTTXSxP9RMH2G/OtJPNDHKSmhMwQ7efvIbVrkR+X7rTKxQ+kI29DRE6cGTrNY3Jc+MzpCV3TDQ==
X-Received: from ipylypiv.svl.corp.google.com ([2620:15c:2c5:13:69ff:df2c:aa81:7b74])
 (user=ipylypiv job=sendgmr) by 2002:a05:6902:728:b0:dc2:1f34:fac4 with SMTP
 id l8-20020a056902072800b00dc21f34fac4mr3554574ybt.2.1709688164688; Tue, 05
 Mar 2024 17:22:44 -0800 (PST)
Date: Tue,  5 Mar 2024 17:22:26 -0800
In-Reply-To: <20240306012226.3398927-1-ipylypiv@google.com>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240306012226.3398927-1-ipylypiv@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Message-ID: <20240306012226.3398927-8-ipylypiv@google.com>
Subject: [PATCH v7 7/7] scsi: isci: Add libsas SATA sysfs attributes group
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

