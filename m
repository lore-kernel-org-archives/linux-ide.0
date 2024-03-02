Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0EFD48788
	for <linux-ide@vger.kernel.org>; Sat,  2 Mar 2024 20:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709410628; cv=none; b=CQ7CUNH2YuuZ2njbf1mUmyPvr79+4vC0G4nOhdSyi7zbZH/yTd3/DL+mlcwX4MtxunFW4/YRFjTXobvPJpzGdVqu7y0S6ogWa56Gklm8HusSuz1aDEZvhoTjQ6G6SvZ2Wv1P12syDh7d1zdZV09bWtH99qJOoF3EmqfxmAtTCBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709410628; c=relaxed/simple;
	bh=VXEBiw5sEFSk6TqQvuSqUb+O1z3+B7dY5aKYWK0IdpQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=aNcSsbltSnZR5JGpba7wUun50mTDrg4OSdAIS755MvAvm1nght0FpSz1nnqia2R15ZcpGbDBTl3w0TOHAQYq93FgHLOHiIXR9BtN79MSxcv9cPchv2hLcdUXfc9XG+rYj6qU0C0uIeQ96E9UDsw9yYkrFMNfmwRCArrjVZPaoLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ipylypiv.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bUgNbILR; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ipylypiv.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bUgNbILR"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc6b2682870so5327105276.0
        for <linux-ide@vger.kernel.org>; Sat, 02 Mar 2024 12:17:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709410624; x=1710015424; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=k7XkqJ/HwZdUVuck7Rfqg1Ng2sUDChUOthoiaoWu1uo=;
        b=bUgNbILRtQA2lzC7fCLAvsTAkdCPQqxX2v33EtkT6rsLnANLFRqRLFtP6wdQfUMLxh
         QF+w3SLDTWRf9e3XLv8YXkO2LC9y4hvz8t4gD24nSjPJVfmb0RUfgx2/drB/sv1G8KQO
         YTifr8d6zF9p1V/JCz9mhkIKT0zv6fUcVJ4RlO1M18hcjkN1NSORm11TjbHiMOw7GBfD
         yFydrD9mqNZVtdoPF605COEwkCERLtdNahduD7f4e3HJ9jVOpfjNUMPnx3S/cueDnBWd
         mnAxxfdXt1KfzOefIYGGe2ccRW852KrGpZ0VrVRcJzKEUyEEkGlBrEICO8H6DJsTnWXF
         9vPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709410624; x=1710015424;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=k7XkqJ/HwZdUVuck7Rfqg1Ng2sUDChUOthoiaoWu1uo=;
        b=QlKWtbMQ5vHevsdCzcxCy8Sc5sjx9JE4Jxwqx5xQLwIFEpMhknuZhZobCMk9CvveDs
         ZDT9EUR3LO2WdiKhgQ/PTFmQSQ/6q3mVinb9N6/ZIL4xS5EKg13oZiq3aTRTvlpxMRHy
         aBBEWUNQ9PDaRj6QwTXTV9bLn5GhJZ8eDYKObPLu06Qoqn/RDMH3w6mNqidMp+NKJ1hs
         Qpt1EnYJjLqCmSgUbKlMxq4FR8XR0S2uJ/E73cW1ZWakxrI/cZqlsdlXpFc8pzWLgR07
         0SSQXmFATplAxOnNxC9nZUAaxJ1jS5YFhu1nXoqbQ5L/Kj9H40wBNlVGTs/oOjI7vaqA
         JW3w==
X-Forwarded-Encrypted: i=1; AJvYcCVtZpfbu17K6npzCFX1f1CunSeKxjwUHd27PWxT84nfnlzqUWOtsMbY27Ne2T5h9FXCRuCWSGSn6LNZp0ACjp9LWTGW5IE3YUV+
X-Gm-Message-State: AOJu0Yy6TE05PqXBOK7ry2YR9DJYMLL/bBN6ofXyLIzHVnR4QSI+b0l3
	2cuovflh1v+h7AcQQGretVhwIzMJ5sbd+muD9Fj27WaAKF1ZEtqzUmeF6kRtgnfEygg7J8h5Sza
	+KhSe5Bfwew==
X-Google-Smtp-Source: AGHT+IHX7OqSiXa63cn18dhN1pGhetViOJvO9X4ApnlXCMHETuDUNk3S4i+DaSUV4jKQ2huJ1mYI9OWXvify5A==
X-Received: from ipylypiv.svl.corp.google.com ([2620:15c:2c5:13:41a7:9019:9a7:b404])
 (user=ipylypiv job=sendgmr) by 2002:a05:6902:1741:b0:dc7:5c0d:f177 with SMTP
 id bz1-20020a056902174100b00dc75c0df177mr1258736ybb.6.1709410624534; Sat, 02
 Mar 2024 12:17:04 -0800 (PST)
Date: Sat,  2 Mar 2024 12:16:36 -0800
In-Reply-To: <20240302201636.1228331-1-ipylypiv@google.com>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240302201636.1228331-1-ipylypiv@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Message-ID: <20240302201636.1228331-8-ipylypiv@google.com>
Subject: [PATCH v3 7/7] scsi: isci: Add libsas SATA sysfs attributes group
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

