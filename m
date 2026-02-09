Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB6B230F7FE
	for <linux-ide@vger.kernel.org>; Mon,  9 Feb 2026 21:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770672118; cv=none; b=tChfXWmLF5Rd+ykLUopFKcKpq9rsebGhd2kTUA4PAllF3zalGF+8SSKpmqMkmXDGvcHOuvUCxnoopC+ZMnZ7X3JxzSQDjyDleEU8AefvQAlK5V8OFNv+HR50gNJby2pd7vM3OcnPYxq08BU/MdI7lN1UqBMa9oCWx+3fK4eR9Z4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770672118; c=relaxed/simple;
	bh=jgWvaQR0EIAORcGXYrAtndNCUokb7X0l1Mv6K8fcCfw=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=nsFvzvHSsOoIZun+sMUq3EYW3G0w3Ot18poAIPk9uQJavntJewWf1VxzwsB7yhJrn93lOHogrj0r34kVy+neIBIppiydU4Ha/HH5YYQeanUohUy+jOBbSPpQfXAaVRWvmbG8T3mb3yvTz9+6uQmVZc3AM65e8yVlf7qqZUR+ka0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ipylypiv.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TfmwBafU; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ipylypiv.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TfmwBafU"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-3562370038dso113511a91.3
        for <linux-ide@vger.kernel.org>; Mon, 09 Feb 2026 13:21:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770672115; x=1771276915; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=GP/nw0GntmUv4Aco/T3zEuIFJQ9TGTiXcOsKoDvcON0=;
        b=TfmwBafUCrkX+YM3Ll28XgY7kMvPcbOkEbxESiS21BR7elgq/DWy9kkVcnssOhuLGE
         hoQuefTj5IDpdYhULy+RS8de5MCOQRsQ5JReVAo3y/771TVJjmMmrgPNuFTH2QG8P6oh
         a6x3nmuNeqFDQmdWcnwVyKiXyvOSSNjLjvNJ4vZf7NOy8Bf090u8kOArf5b7jzSdF4KS
         3/Lv3OilEvJDe2OFPdCJP6CQyhitaMeLZ3OfqBNYCoDPLPZTeLSobcvj4RS5woyIZEsL
         nbSGh6/U+orO8Le+USD3hTlSv4o7UHBWY4QcS9ngkIjBNKY5/vieP+5TAIhIKfFqdX5n
         vKaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770672115; x=1771276915;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GP/nw0GntmUv4Aco/T3zEuIFJQ9TGTiXcOsKoDvcON0=;
        b=wUMl89Xki5WF233YkLmMnrw2kmhgi5d3a0nrS7tOLnxCIt/nk5M+7expn54D72wOsZ
         qUrNyBls72d9lCzP7Kquc3amUEPdEMuZDhYxTHpf0YgkPEeKKblz6y9PLghjE4U4kQBl
         h2CWUXIOFjc62hkiCTPxMYkFdUZv8yyjO0kLCZ8NEjIxpBVOWYcYazERXzSiC35/wStc
         IiCBSYPvn90Q6z5IGes97nSfODHMuYQQgXhA+wgHUs5pXs4knLsWivovOuiBVOdfFy7/
         SqXR4VF2dSYNyqeEl/i8h9nLV8eSuFxkyj34FoZMF01DMjstLM+MH+2LYbgxgE7YVvDP
         Hq1Q==
X-Forwarded-Encrypted: i=1; AJvYcCXTjThKH3i8i3ZFemIWLm5A+wDKvqAjJwLoSMR5uU22x5hM8SRBQQa6IySR40X1c6Y2I3vRTwlwycc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzURZzpkf0iHbJi/xqmlD5xcFZQ+XLcE4W/+MUV7jEVb9SGhie/
	2J4sTtmKLvWUkD6IP5Vt6xkuknaWJact9bsUwK+lU0IeMhmA+x0NLPGIC6+/HZcEdAx8QYgCxlP
	ich1C/YRuohjvKA==
X-Received: from pjbst4.prod.google.com ([2002:a17:90b:1fc4:b0:356:2fe0:f5b4])
 (user=ipylypiv job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90a:e7c3:b0:356:35a5:4a64 with SMTP id 98e67ed59e1d1-35635a5534fmr4964057a91.4.1770672114993;
 Mon, 09 Feb 2026 13:21:54 -0800 (PST)
Date: Mon,  9 Feb 2026 13:21:51 -0800
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.rc2.204.g2597b5adb4-goog
Message-ID: <20260209212151.342151-1-ipylypiv@google.com>
Subject: [PATCH v3] scsi: core: Add 'serial' sysfs attribute for SCSI/SATA
From: Igor Pylypiv <ipylypiv@google.com>
To: "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, 
	"Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Bart Van Assche <bvanassche@acm.org>, linux-scsi@vger.kernel.org, 
	linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Igor Pylypiv <ipylypiv@google.com>
Content-Type: text/plain; charset="UTF-8"

Add a 'serial' sysfs attribute for SCSI and SATA devices. This attribute
exposes the Unit Serial Number, which is derived from the Device
Identification Vital Product Data (VPD) page 0x80.

Whitespace is stripped from the retrieved serial number to handle
the different alignment (right-aligned for SCSI, potentially
left-aligned for SATA). As noted in SAT-5 10.5.3, "Although SPC-5 defines
the PRODUCT SERIAL NUMBER field as right-aligned, ACS-5 does not require
its SERIAL NUMBER field to be right-aligned. Therefore, right-alignment
of the PRODUCT SERIAL NUMBER field for the translation is not assured."

This attribute is used by tools such as lsblk to display the serial
number of block devices.

Signed-off-by: Igor Pylypiv <ipylypiv@google.com>
---

v2->v3 changes:
- Replaced sysfs_emit(buf, "%s\n", buf) with a manual newline placement
  to avoid undefined behavior of passing the output buffer as an input.

v1->v2 changes:
- Reordered declarations in scsi_vpd_lun_serial() from longest to shortest.
- Replaced rcu_read_lock()/rcu_read_unlock() with guard(rcu)().


 drivers/scsi/scsi_lib.c    | 47 ++++++++++++++++++++++++++++++++++++++
 drivers/scsi/scsi_sysfs.c  | 16 +++++++++++++
 include/scsi/scsi_device.h |  1 +
 3 files changed, 64 insertions(+)

diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
index 4a902c9dfd8b..c17fbe4dd845 100644
--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -13,6 +13,7 @@
 #include <linux/bitops.h>
 #include <linux/blkdev.h>
 #include <linux/completion.h>
+#include <linux/ctype.h>
 #include <linux/kernel.h>
 #include <linux/export.h>
 #include <linux/init.h>
@@ -3459,6 +3460,52 @@ int scsi_vpd_lun_id(struct scsi_device *sdev, char *id, size_t id_len)
 }
 EXPORT_SYMBOL(scsi_vpd_lun_id);
 
+/**
+ * scsi_vpd_lun_serial - return a unique device serial number
+ * @sdev: SCSI device
+ * @sn:   buffer for the serial number
+ * @sn_size: size of the buffer
+ *
+ * Copies the device serial number into @sn based on the information in
+ * the VPD page 0x80 of the device. The string will be null terminated
+ * and have leading and trailing whitespace stripped.
+ *
+ * Returns the length of the serial number or error on failure.
+ */
+int scsi_vpd_lun_serial(struct scsi_device *sdev, char *sn, size_t sn_size)
+{
+	const struct scsi_vpd *vpd_pg80;
+	const unsigned char *d;
+	int len;
+
+	guard(rcu)();
+	vpd_pg80 = rcu_dereference(sdev->vpd_pg80);
+	if (!vpd_pg80)
+		return -ENXIO;
+
+	len = vpd_pg80->len - 4;
+	d = vpd_pg80->data + 4;
+
+	/* Skip leading spaces */
+	while (len > 0 && isspace(*d)) {
+		len--;
+		d++;
+	}
+
+	/* Skip trailing spaces */
+	while (len > 0 && isspace(d[len - 1]))
+		len--;
+
+	if (sn_size < len + 1)
+		return -EINVAL;
+
+	memcpy(sn, d, len);
+	sn[len] = '\0';
+
+	return len;
+}
+EXPORT_SYMBOL(scsi_vpd_lun_serial);
+
 /**
  * scsi_vpd_tpg_id - return a target port group identifier
  * @sdev: SCSI device
diff --git a/drivers/scsi/scsi_sysfs.c b/drivers/scsi/scsi_sysfs.c
index 99eb0a30df61..9c4f47e7a298 100644
--- a/drivers/scsi/scsi_sysfs.c
+++ b/drivers/scsi/scsi_sysfs.c
@@ -1013,6 +1013,21 @@ sdev_show_wwid(struct device *dev, struct device_attribute *attr,
 }
 static DEVICE_ATTR(wwid, S_IRUGO, sdev_show_wwid, NULL);
 
+static ssize_t
+sdev_show_serial(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	struct scsi_device *sdev = to_scsi_device(dev);
+	ssize_t ret;
+
+	ret = scsi_vpd_lun_serial(sdev, buf, PAGE_SIZE);
+	if (ret < 0)
+		return ret;
+
+	buf[ret] = '\n';
+	return ret + 1;
+}
+static DEVICE_ATTR(serial, S_IRUGO, sdev_show_serial, NULL);
+
 #define BLIST_FLAG_NAME(name)					\
 	[const_ilog2((__force __u64)BLIST_##name)] = #name
 static const char *const sdev_bflags_name[] = {
@@ -1257,6 +1272,7 @@ static struct attribute *scsi_sdev_attrs[] = {
 	&dev_attr_device_busy.attr,
 	&dev_attr_vendor.attr,
 	&dev_attr_model.attr,
+	&dev_attr_serial.attr,
 	&dev_attr_rev.attr,
 	&dev_attr_rescan.attr,
 	&dev_attr_delete.attr,
diff --git a/include/scsi/scsi_device.h b/include/scsi/scsi_device.h
index d32f5841f4f8..9c2a7bbe5891 100644
--- a/include/scsi/scsi_device.h
+++ b/include/scsi/scsi_device.h
@@ -571,6 +571,7 @@ void scsi_put_internal_cmd(struct scsi_cmnd *scmd);
 extern void sdev_disable_disk_events(struct scsi_device *sdev);
 extern void sdev_enable_disk_events(struct scsi_device *sdev);
 extern int scsi_vpd_lun_id(struct scsi_device *, char *, size_t);
+extern int scsi_vpd_lun_serial(struct scsi_device *, char *, size_t);
 extern int scsi_vpd_tpg_id(struct scsi_device *, int *);
 
 #ifdef CONFIG_PM
-- 
2.53.0.rc2.204.g2597b5adb4-goog

