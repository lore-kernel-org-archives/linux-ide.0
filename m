Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793739313;
	b=PuCOtMq20c/6i6ahkmrgt+uJ4EGthK+MpLnXmcaUvRfR/fp4PU3zILXG3Mcx+FU4RtRY
	 h9+DPjJ1FIepI11MieCCygm3bfwgXERH/XPgGu630VG7WL/zmGUyvY/CTyFMaPJ5ex9PW
	 SBl+GP9bk/DS+BSfRcPa5lM+o3y1cHR0izyTTNtHAL5wKGnyP+irPJsZ3Sf+YjiEyUjlq
	 7GP1k0h5oc6VzFjNAjiOHnfznxZjxwsJ164yEKDAOFl1aJ8w8utLN8vJD1lxMTNgdss/V
	 QCiP/a9qmAhRxAmP7yEjagIUhDuKhlOSkcXK68OyfonZ1Z7kRvOoQgLcFmGFDzIN5uw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793739313;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:X-Developer-Signature:
	 X-Developer-Key:Content-Transfer-Encoding;
	bh=cD/l8Qg2U+khxOgm5rsYBpuFN9u/NIcZofMfVCBmKAE=;
	b=Ph/AIfI5MBacTEKKg+NRPGShjxmZYv3C3+t4FukDgEbApnOhxK2q/c64et9+0nrtksFC
	 rBF2xq2Gxak6lXlHnQZXrqI7H3f+uZzk7dpoQwIi+CKP0wnuR8yRmcVHCH+WxFV3WLNLg
	 DkJjk+Dc8TnkZDm5TFypvis7Rwy2u+bUwW/Htm4N+XlDC3Fprq7lORigsMA+zPjCZi9s1
	 z8nMFPbxr+V9x2vGtctaP3j6eszBNTTXzYdSLM1vf5i7fOtvpTrd7LHxtgbOg9yceh8hL
	 GiU/al5eBI748WdYPHEfzeVtclH5/VdZq2fxQGJSYZEyBwKFJeLSjIqFhKcm3wuyqBQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IN6ZeTiN;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C923606A32E
	for <linux-ide@vger.kernel.org>; Tue,  3 Nov 2026 20:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IN6ZeTiN
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E97E1F00919;
	Tue,  3 Nov 2026 20:55:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793739313;
	bh=cD/l8Qg2U+khxOgm5rsYBpuFN9u/NIcZofMfVCBmKAE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=IN6ZeTiNS0sRyFR/lTMnVAIsosGPQgnwrdngPmIIebTl0490/Zb6r/xMGuaO4nNW1
	 j54L1WEPUA4Ev1AXwpg4nJe+J/EgV59oPdAmyrxZioK0AE7br06NGRBYkZ5v5lOnVx
	 jYXft0aWCXSWv0b0Taw6qpz46ClfDgPpqkH6alVpnmHRdPHQH0x+yVoPhL/Sqqs61u
	 cC03zW7ZLU//085XNKldKYqoR30pX/nzIhhU/wQpxIu2A54/Q4EIQvauLKFXk7+VEC
	 /6nmpZQl/rLgo4Y2MMep3dPSSN+yj18XDgs9XncxiH/MlwkncQPSVB+vjFGft3RuVf
	 Pa+XfalRNrw/Q==
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: linux-ide@vger.kernel.org,
	Igor Pylypiv <ipylypiv@google.com>,
	Shao Mingyin <shao.mingyin@zte.com.cn>,
	Hannes Reinecke <hare@kernel.org>,
	Niklas Cassel <cassel@kernel.org>
Subject: [PATCH 8/8] ata: libata-scsi: document the MODE SENSE mode page functions
Date: Tue,  3 Nov 2026 21:54:57 +0100
Message-ID: <20261103205448.931471-18-cassel@kernel.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261103205448.931471-10-cassel@kernel.org>
References: <20261103205448.931471-10-cassel@kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Post: <mailto:linux-ide@vger.kernel.org>
List-Help: <mailto:linux-ide+help@vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-ide+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7245; i=cassel@kernel.org; h=from:subject; bh=1UgNMzD9leWGP3CAsq08Ke2EwpfxNR1srTC0kGDEpko=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGLJeecn+cmZ3PXDnRNGRCifdpadKlbkUP9SxPsjl++jE/ C9aolyjo5SFQYyLQVZMkcX3h8v+4m73KccV79jAzGFlAhnCwMUpABO5spqRYRJzafBhkf62h+Iy val7k+00zoY5LlGo0d5lsnptUOgbd0aGezuNFSv/6ykITS3VWrORrSlLV7HE+tn1lobX8d+lt9/ jBQA=
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

The ata_msense_*() functions generate the mode pages returned by MODE
SENSE, and are also used by the MODE SELECT mode page handlers to check
the mode page data. They do not document where their buf argument points
and what they return, and some of them do not have a kernel-doc comment
at all.

Add kernel-doc comments for all of them, stating that the mode page is
written to buf starting with its mode page header, which matches how
the MODE SELECT mode page handlers get the mode page, and that they
return the length of the mode page, including the mode page header.

No functional change.

Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 drivers/ata/libata-scsi.c | 100 +++++++++++++++++++++++++++++++++-----
 1 file changed, 88 insertions(+), 12 deletions(-)

diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index e91920659c22..efdaf20b0ca4 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -2645,15 +2645,23 @@ static void modecpy(u8 *dest, const u8 *src, int n, bool changeable)
 /**
  *	ata_msense_caching - Simulate MODE SENSE caching info page
  *	@id: device IDENTIFY data
- *	@buf: output buffer
+ *	@buf: Output buffer for the mode page, including the mode page header
  *	@changeable: whether changeable parameters are requested
  *
  *	Generate a caching info page, which conditionally indicates
  *	write caching to the SCSI layer, depending on device
  *	capabilities.
  *
+ *	The mode page is written to @buf starting with its mode page header,
+ *	so offsets in @buf are the byte numbers of the mode page. For MODE
+ *	SENSE, the mode parameter header and the block descriptors are written
+ *	by ata_scsiop_mode_sense().
+ *
  *	LOCKING:
  *	None.
+ *
+ *	RETURNS:
+ *	Length of the mode page, including the mode page header.
  */
 static unsigned int ata_msense_caching(u16 *id, u8 *buf, bool changeable)
 {
@@ -2667,8 +2675,25 @@ static unsigned int ata_msense_caching(u16 *id, u8 *buf, bool changeable)
 	return sizeof(def_cache_mpage);
 }
 
-/*
- * Simulate MODE SENSE control mode page, sub-page 0.
+/**
+ *	ata_msense_control_spg0 - Simulate MODE SENSE for control sub-page 0
+ *	@dev: ATA device of interest
+ *	@buf: Output buffer for the mode page, including the mode page header
+ *	@changeable: whether changeable parameters are requested
+ *
+ *	Simulate MODE SENSE control mode page, sub-page 0, which reports the
+ *	sense data format (D_SENSE) used for the device.
+ *
+ *	The mode page is written to @buf starting with its mode page header,
+ *	so offsets in @buf are the byte numbers of the mode page. For MODE
+ *	SENSE, the mode parameter header and the block descriptors are written
+ *	by ata_scsiop_mode_sense().
+ *
+ *	LOCKING:
+ *	None.
+ *
+ *	RETURNS:
+ *	Length of the mode page, including the mode page header.
  */
 static unsigned int ata_msense_control_spg0(struct ata_device *dev, u8 *buf,
 					    bool changeable)
@@ -2700,9 +2725,27 @@ static inline u16 ata_xlat_cdl_limit(u8 *buf)
 	return min_t(u32, limit / 10000, 65535);
 }
 
-/*
- * Simulate MODE SENSE control mode page, sub-pages 07h and 08h
- * (command duration limits T2A and T2B mode pages).
+/**
+ *	ata_msense_control_spgt2 - Simulate MODE SENSE for CDL T2A/T2B pages
+ *	@dev: ATA device of interest
+ *	@buf: Output buffer for the mode page, including the mode page header
+ *	@spg: Sub-page code, CDL_T2A_SUB_MPAGE or CDL_T2B_SUB_MPAGE
+ *
+ *	Simulate MODE SENSE control mode page, sub-pages 07h and 08h
+ *	(command duration limits T2A and T2B mode pages), from the command
+ *	duration limit descriptors read from the device.
+ *
+ *	The mode page is written to @buf starting with its mode page header,
+ *	so offsets in @buf are the byte numbers of the mode page. For MODE
+ *	SENSE, the mode parameter header and the block descriptors are written
+ *	by ata_scsiop_mode_sense().
+ *
+ *	LOCKING:
+ *	None.
+ *
+ *	RETURNS:
+ *	Length of the mode page, including the mode page header, or 0 if the
+ *	device does not support command duration limits.
  */
 static unsigned int ata_msense_control_spgt2(struct ata_device *dev, u8 *buf,
 					     u8 spg)
@@ -2759,9 +2802,25 @@ static unsigned int ata_msense_control_spgt2(struct ata_device *dev, u8 *buf,
 	return CDL_T2_SUB_MPAGE_LEN;
 }
 
-/*
- * Simulate MODE SENSE control mode page, sub-page f2h
- * (ATA feature control mode page).
+/**
+ *	ata_msense_control_ata_feature - Simulate ATA Feature Control page
+ *	@dev: ATA device of interest
+ *	@buf: Output buffer for the mode page, including the mode page header
+ *
+ *	Simulate MODE SENSE control mode page, sub-page f2h (ATA feature
+ *	control mode page), which reports whether command duration limits are
+ *	enabled.
+ *
+ *	The mode page is written to @buf starting with its mode page header,
+ *	so offsets in @buf are the byte numbers of the mode page. For MODE
+ *	SENSE, the mode parameter header and the block descriptors are written
+ *	by ata_scsiop_mode_sense().
+ *
+ *	LOCKING:
+ *	None.
+ *
+ *	RETURNS:
+ *	Length of the mode page, including the mode page header.
  */
 static unsigned int ata_msense_control_ata_feature(struct ata_device *dev,
 						   u8 *buf)
@@ -2787,14 +2846,23 @@ static unsigned int ata_msense_control_ata_feature(struct ata_device *dev,
 /**
  *	ata_msense_control - Simulate MODE SENSE control mode page
  *	@dev: ATA device of interest
- *	@buf: output buffer
+ *	@buf: Output buffer for the mode pages, including the page headers
  *	@spg: sub-page code
  *	@changeable: whether changeable parameters are requested
  *
- *	Generate a generic MODE SENSE control mode page.
+ *	Generate sub-page @spg of the control mode page, or all supported
+ *	sub-pages of the control mode page if @spg is ALL_SUB_MPAGES.
+ *
+ *	The mode pages are written to @buf one after the other, each starting
+ *	with its mode page header. For MODE SENSE, the mode parameter header
+ *	and the block descriptors are written by ata_scsiop_mode_sense().
  *
  *	LOCKING:
  *	None.
+ *
+ *	RETURNS:
+ *	Total length of the mode pages written to @buf, including their mode
+ *	page headers.
  */
 static unsigned int ata_msense_control(struct ata_device *dev, u8 *buf,
 				       u8 spg, bool changeable)
@@ -2822,13 +2890,21 @@ static unsigned int ata_msense_control(struct ata_device *dev, u8 *buf,
 
 /**
  *	ata_msense_rw_recovery - Simulate MODE SENSE r/w error recovery page
- *	@buf: output buffer
+ *	@buf: Output buffer for the mode page, including the mode page header
  *	@changeable: whether changeable parameters are requested
  *
  *	Generate a generic MODE SENSE r/w error recovery page.
  *
+ *	The mode page is written to @buf starting with its mode page header,
+ *	so offsets in @buf are the byte numbers of the mode page. For MODE
+ *	SENSE, the mode parameter header and the block descriptors are written
+ *	by ata_scsiop_mode_sense().
+ *
  *	LOCKING:
  *	None.
+ *
+ *	RETURNS:
+ *	Length of the mode page, including the mode page header.
  */
 static unsigned int ata_msense_rw_recovery(u8 *buf, bool changeable)
 {
-- 
2.56.0

