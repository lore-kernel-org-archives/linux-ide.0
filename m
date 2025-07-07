Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com [209.85.221.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C23A01E505;
	Mon,  7 Jul 2025 12:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751891495; cv=none; b=DpdHQ9WIQvFeFG1/rKPClNdnOcMq1pcnsVrvpQPTFvgD/6aXzg92leMO/SrFHbFcyVLnryH4bQdqSa/4oa1vz52XP1ITNrtOZOl17vNZPYTd+AWyje75uyCUeiHHZ/bawlkplHvu+RI3zegq+b0ghMNukLpMt+KZEcpxBl6cSB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751891495; c=relaxed/simple;
	bh=s3pDDpFXx97+Sx3EQPnHs8UpupyLeVIWcjLWW9LMm5g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Cwg2wP/rfNFI8olkx69oN8lglW2PALo8Dc1tytCEvl/N2jxzsUIufV2UP8N1pql/EwR9lFygYCqYJ9xmTeUOmsg4AoJexvNQ/TeDTibnYbe8HNdG14hyUuS3te+jDUeHqUDInJC3xYqxyWEV/pSSIiS6TnCQ08/XbzXPm8rkddE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QA22Yq3f; arc=none smtp.client-ip=209.85.221.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QA22Yq3f"
Received: by mail-vk1-f180.google.com with SMTP id 71dfb90a1353d-531466622beso1037928e0c.1;
        Mon, 07 Jul 2025 05:31:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751891493; x=1752496293; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=w5Y/5ojhkIa9XtEOclDEI/2rgRb96fIBfSAga+PCtpI=;
        b=QA22Yq3fZlheyBG9ozhciTvm4oK7wrsQTrjUaKVH/gvDoFU5C0Xv2rKwA+OfJngJ26
         Ufxf+mw96qZMfRiQAG1w+/V2sWz+kjSN/DF74/A/1PORaI0La8mDMBN21EDIswfbhpS0
         k4V00EBNEg0eJlVmx2l2s0xMpeqTiA9I5rBX14RKeRzWDlDNxxuofN4j0NXxm31u81Ia
         q5jVkG1UV+HSFsIDavOsamO82o+5EEOyPQptytP0aqU9dUa++cxSFelNLogrReLAokPB
         v7eV3NT9bXCquHKrhtO8a/9GeerQi0E9epMt+gts+JyNFclXQlPMjA8q8wH9Ig4sHb0I
         RlAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751891493; x=1752496293;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=w5Y/5ojhkIa9XtEOclDEI/2rgRb96fIBfSAga+PCtpI=;
        b=V2+bg+x724U0HgSzg1b3Vc6oopzs5CurK9EJCFM6i91cBjTvNk3228I3mwWY7UPCr/
         u6BNbo3KTzw8VXSFbVQNkhYhF9J5RsnOGwdS8QXAcZmIEMtElRFZOfySvsXF1Z7IFwqH
         WiLUWtr6tn7utPrpIkd9KzRHxP27PK6/EzAHfxS2LmhBbZZt7clwD1+9FKhGwf/7UMCQ
         7wZojCxhI7d6WeG7NJKUGGWYy2hzhj59e33hrdJz39nBBsoP1d6cdVA55J5ZzdYJ379s
         Dcx5mkQC5U+N8XDBQg7oJDI3pmLO1oHoo7+bhxUtOP1Aq69CApxyegf0ShtY3dm1Kw30
         zOkQ==
X-Forwarded-Encrypted: i=1; AJvYcCVOIa2uXjN/qZ0knoapY2NZ5XjB+GYN/pVIwXADsOmkMDdzcu7MobNTy3qtPncs2TIZkflBI9HfSiqYgPY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzP2LTkBHGOuTKCNJMP4ggnOvieQTFxeijR5mPCRn9OeLBdbWG9
	AF3if2AseqeiSGS+onJjrtk/QJfEl2NLP7atbzDYTE/XdUjX7mBc5rKy
X-Gm-Gg: ASbGncsEPEBebWPqrczU6RkZ6mDWef9KuJTvV7Sr3OMpim+SWeIwrbjAnU6AUa45OPV
	w6sFm8P15DzwdqvBtrveE9p8oe4a/zlyyWhrmg8AjLTCBACDWIcAa9F2NbLf84DuQregxOlIHKt
	/V2TKDtjdh7SQCA3KYXRLIZBCqoBzQs5pJiRknc8C1uadvgkHfsZm/Ra5i13wx+a0kryi9L04KD
	bcT99C6cZBa6CG7dAZ68l3vkBJ61Msse7SeSP6TFpNiTPMWmXG7ggNDNYw5qBdqbd55JfKYxbIt
	wa0iL2uKyK63cjxZkerejS2yI2rsd18buQwFLGkxIp/mqUKjvZrQmbGXAAvnpDwNBYSurPuQ0sN
	aBeIy6+cySaWkU59AnyBtoD9QLRancmx7GJY3O1s=
X-Google-Smtp-Source: AGHT+IFYDKX1+EeyiZ94rnlAWM8p0evZNtPvNgaFjxinR5XWMDIn7irLF7W0020p8ShAdf7Q2SvFxQ==
X-Received: by 2002:a05:6122:3d0f:b0:520:4996:7d2a with SMTP id 71dfb90a1353d-534f6697023mr3926920e0c.10.1751891492493;
        Mon, 07 Jul 2025 05:31:32 -0700 (PDT)
Received: from Ubuntu.. (syn-097-097-020-058.res.spectrum.com. [97.97.20.58])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-534790f2a20sm1270649e0c.45.2025.07.07.05.31.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jul 2025 05:31:32 -0700 (PDT)
From: Jonathan Velez <jonvelez12345@gmail.com>
To: dlemoal@kernel.org,
	cassel@kernel.org
Cc: linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	shuah@kernel.org,
	Jonathan Velez <jonvelez12345@gmail.com>
Subject: [PATCH] ata: libata-transport: replace scnprintf with sysfs_emit for simple attributes
Date: Mon,  7 Jul 2025 12:20:04 +0000
Message-ID: <20250707122004.224770-1-jonvelez12345@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

sprintf, snprintf, and scnprintf do not consider the PAGE_SIZE maximum
of the temporary buffer used for outputting sysfs content and they may
overrun the PAGE_SIZE buffer length.

To avoid output defects with the ATA transport class simple attributes,
scnprintf() was converted to sysfs_emit(). This aligns with the sysfs
guidance provided in Documentation/filesystems/sysfs.rst.

Signed-off-by: Jonathan Velez <jonvelez12345@gmail.com>
---
 drivers/ata/libata-transport.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/libata-transport.c b/drivers/ata/libata-transport.c
index e898be49df6b..62415fe67a11 100644
--- a/drivers/ata/libata-transport.c
+++ b/drivers/ata/libata-transport.c
@@ -202,7 +202,7 @@ show_ata_port_##name(struct device *dev,				\
 {									\
 	struct ata_port *ap = transport_class_to_port(dev);		\
 									\
-	return scnprintf(buf, 20, format_string, cast ap->field);	\
+	return sysfs_emit(buf, format_string, cast ap->field);	        \
 }
 
 #define ata_port_simple_attr(field, name, format_string, type)		\
@@ -389,7 +389,7 @@ show_ata_dev_##field(struct device *dev,				\
 {									\
 	struct ata_device *ata_dev = transport_class_to_dev(dev);	\
 									\
-	return scnprintf(buf, 20, format_string, cast ata_dev->field);	\
+	return sysfs_emit(buf, format_string, cast ata_dev->field);	\
 }
 
 #define ata_dev_simple_attr(field, format_string, type)		\
-- 
2.43.0

