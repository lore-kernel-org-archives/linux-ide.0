Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793739312;
	b=5WulrjeKTZD9hygsJUWhkKstW/dCPucZzXddV4V6ixV5+FrCKlwtM3XfjpYkIdNLRhet
	 4sVrNuIfM4CxLSgKd08uD+ceDjWfxvExxCpGFeUyzsfC1FvxW4WmOBU9PdL2vRDvy10IR
	 7LRn05JMJNfV/FLRk1IXxYCrYnlQSaooJNImjBKXrspqYYWko+NHSdLj7HfTA7quQP407
	 kp92xeVA6ey4MPcBNLVfL2ewV5dByuq9rIxZl7EfLins1YlkT8g6H6m0H+tz2+eL/hQr9
	 lFWV2QFLze8Uz4X7DL0gB+gs8Dy2ldEZifBOHdMePCEoP2ROlw00YNWIqWH08wbMFjw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793739312;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:X-Developer-Signature:
	 X-Developer-Key:Content-Transfer-Encoding;
	bh=FG+ZrGEvHAyxgERwK6R84GUMYx7SDGGKimLNWBEwIvg=;
	b=WldDh3rhhMCOaL3/FwmZ6RqFZVShzm396ixBJ4Gn2VwXIxXDp1CfRpQeZsjg2TDu9imn
	 59Qfe5z6McfoM1wBcowyMxN4G+h9BqOv85UGY53zNVCv5eMZnUl2jucp+5N4zesRkNlik
	 148FblBpRy9qvZ/hAf1YxE2zw/Fh4svFY7J7qPnQzxBhle8qw4USysMnu2yCublwi1mjj
	 TmxhqmoqjimztlA5kYH/2mI7gpn6HpbW/k/8ttJ64sKT9by4+pFvXuCDEvcFbslin5q1X
	 ZPJBTI1KwjxDl48tHjfe6qcDgImzlXjNYH8R+4z1PCWmpnHWt3zEaoiShBoKxsv2u6Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=B+X0utQm;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0B4A606A31B
	for <linux-ide@vger.kernel.org>; Tue,  3 Nov 2026 20:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=B+X0utQm
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DEBF1F000C1;
	Tue,  3 Nov 2026 20:55:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793739311;
	bh=FG+ZrGEvHAyxgERwK6R84GUMYx7SDGGKimLNWBEwIvg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=B+X0utQmJF+RefeRarbmD8M4Eb3RD79KnNs82T5OS1b9MUL8u+eNiC6lcr+HBv7g4
	 6Z0C5NW/dtzLkU7KeNhKc1sI3Ok3JvPexlF/VaomAkrs6fBCBJozl4G1GqmBWzWZdA
	 He+vND/wCK3kJC8sNPxtA0gMFGOIsb0HG/mXN5zZjXOdRzciPs7IYytks4nSs2EZ1X
	 xNH+RV+DnPLiQoIBSAGUvfrFwlvDqguhgSfwdZ/XUvjNP6PuuFmcIv5FkSWma9sh4M
	 Y4QTPGSEtyvTsrrt7i5Ewv8ToBq9WXKqhPMkMR5ZzQala0FXLpVvRHFbDOQXBmgHTZ
	 VUH58Qzt1XPgw==
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: linux-ide@vger.kernel.org,
	Igor Pylypiv <ipylypiv@google.com>,
	Shao Mingyin <shao.mingyin@zte.com.cn>,
	Hannes Reinecke <hare@kernel.org>,
	Niklas Cassel <cassel@kernel.org>
Subject: [PATCH 7/8] ata: libata-scsi: set the field pointer when rejecting CDL
Date: Tue,  3 Nov 2026 21:54:56 +0100
Message-ID: <20261103205448.931471-17-cassel@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1615; i=cassel@kernel.org; h=from:subject; bh=+Q6HXjL0jV2HGsQt6j+nOkmu26XwOiYrVgUT8R42ccQ=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGLJeeckeW8wruPBXA0NYu4NSxtHPqisjmRd1c9+PXHEwM 3brRM/FHaUsDGJcDLJiiiy+P1z2F3e7TzmueMcGZg4rE8gQBi5OAZhI+kaGn4x6Ej3rHn+Xe35s 5eQYycuTyqu29i4/pnrF1OCMXOk/gzcM/3NDpO6wGTzQkZgSHbxC+9a0Qr/3ixjMLRomed0zL7W +zwEA
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

From: Shao Mingyin <shao.mingyin@zte.com.cn>

ata_mselect_control_ata_feature() rejects enabling CDL while NCQ
priority is enabled, but unlike its other error branches it returns
without setting *fp.

ata_scsi_mode_select_xlat() initializes fp to 0xffff and, when the
handler fails, adds the offset of the mode page in the parameter list
to it, i.e. the length of the mode parameter header and of the block
descriptors. As fp is a u16, this wraps around, so the resulting sense
data reports the byte before the mode page, i.e. the last byte of the
mode parameter header or of the block descriptors, as the FIELD
POINTER, instead of the byte containing the CDL_CTRL field that
requests enabling CDL.

Set *fp to 4, i.e. to the byte containing the CDL_CTRL field, like the
branch rejecting an invalid CDL_CTRL value does.

Fixes: df60f9c64576 ("scsi: ata: libata: Add ATA feature control sub-page translation")
Signed-off-by: Shao Mingyin <shao.mingyin@zte.com.cn>
[cassel: set *fp to 4, the offset of CDL_CTRL in the mode page]
Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 drivers/ata/libata-scsi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index 3257bbbba5b6..e91920659c22 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -4521,6 +4521,7 @@ static int ata_mselect_control_ata_feature(struct ata_queued_cmd *qc,
 		if (dev->flags & ATA_DFLAG_NCQ_PRIO_ENABLED) {
 			ata_dev_err(dev,
 				"NCQ priority must be disabled to enable CDL\n");
+			*fp = 4;
 			return -EINVAL;
 		}
 		ata_dev_dbg(dev, "Enabling CDL\n");
-- 
2.56.0

