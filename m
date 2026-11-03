Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793739306;
	b=VJa1NH89CquapAbeLkCl+UIo7ZHpuf53DRigk6+tCoWAxd6lY9v3ryt6XJ0Hl4olGCFX
	 /DGennKb33H6PkHjfLts49TjUSnbrWwkwdjBbniAaQFQ6xrgKGNaMcYYKFNwoXaJtvKTl
	 6UPFsLxOri7n1ROhuki/dHB7WML6MXKMQMDtLb/rn09Ri4OJbMU9pe2dQYbldR8gvWsb0
	 RWslAw5H8XP50ywCw3cZx4vNC68/X1KOCnql33FF4N1CN2k9HTuh0ojbXQSZGEEmJwXMR
	 jiG2/gGmfndIMDxhs8dDym3vEi2+tF1+yXc9TOmiSo10wInkvsbVqxaINBtNfCAYt1w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793739306;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:X-Developer-Signature:
	 X-Developer-Key:Content-Transfer-Encoding;
	bh=KyKk6TMU/5kqUTUg9L52l50cyR043eHhu15ssELUMOo=;
	b=h8bNe2b9p4fa13vMM5B2J8cXxWfoN+w4v8cTuFsGdlzWVn71cZEfaAGvsJhh7FAJb/ey
	 eyQOVV8P8Bba71wSLTJHZtFA/olGzKw4foP9Oozv8mOjH2XBDtNENss2u01PC110dJpQ+
	 bsPJrBwgQEtTgWTRsQjoTSkWQvQ/ytQmXvwDqws/WLaOSxBgGD5hpX7m7kwXZYovDvgzB
	 ogWZQYD5wxGNp5tltrh7Cp5ly7Yl3WHG6m8L1yx5kh8jMtANYDc35yZHcok/Q+1KWTPA2
	 CaxN2XUVusJrv8Yt10qEDz/N2VxR7nlvIsFuoJkMLUWlxotwTldV61WuVCiEjP6ZpWA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YQ2hYAkQ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 875C7606A31B
	for <linux-ide@vger.kernel.org>; Tue,  3 Nov 2026 20:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YQ2hYAkQ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1820C1F00919;
	Tue,  3 Nov 2026 20:55:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793739306;
	bh=KyKk6TMU/5kqUTUg9L52l50cyR043eHhu15ssELUMOo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=YQ2hYAkQ3cQx96eBfpgLeGMdTmj6ZtCoW7ixEGJm32Y700aybYOKsoOrd9Xyva3+8
	 I2Dwik/qRMeFV1b6G4XtjiOtuYG0TqJod1fipVbcFyukO6K1Yw+jQ1r+FvAm6w7m7x
	 bx/OfuvB+iUx7w47otVHy/uQ3a+A3ETTwDhDziF9vrcvCZ8Ui88lVbq3nhG95RoYTG
	 5JFWiqFGy/27wIQGpRKiGA73H391rKsf+LBzHG18vSbR/BLey15zfD85CJDsCtHzh0
	 4byYZPDz65o7YDQwM1AZDWoffnrrSKfFOvcHudVC7e6vzrsfJgfj/u/efdQ1s9XuUR
	 ACjOCfHXInriw==
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: linux-ide@vger.kernel.org,
	Igor Pylypiv <ipylypiv@google.com>,
	Shao Mingyin <shao.mingyin@zte.com.cn>,
	Hannes Reinecke <hare@kernel.org>,
	Niklas Cassel <cassel@kernel.org>
Subject: [PATCH 4/8] ata: libata-scsi: fix MODE SELECT field pointer for unsupported subpages
Date: Tue,  3 Nov 2026 21:54:53 +0100
Message-ID: <20261103205448.931471-14-cassel@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1725; i=cassel@kernel.org; h=from:subject; bh=F/OSW/UGxjnOquiJMb29YfijzN4L9qlgLxvxB8yE8RY=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGLJeecn6ZLzcnHDr4OPC3fOktlQ/0d/sp6h+8IdrerTu4 nDu2tr3HaUsDGJcDLJiiiy+P1z2F3e7TzmueMcGZg4rE8gQBi5OAZhIeQXDH+7PE1+9ypZSvvdl VlDoZqFDIi9q59x/uM49zGbLvvrTT/0Y/jt/SM/60dUQv8r77uVnLozsW0pipe/l3W6e8P6P2L3 g1RwA
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

When the mode page of a MODE SELECT parameter list has an unsupported
SUBPAGE CODE, ata_scsi_mode_select_xlat() sets the FIELD POINTER of the
INVALID FIELD IN PARAMETER LIST sense data to the SUBPAGE CODE byte of
the mode page header (byte 1 of the page) if the SPF bit is set, and to
the PAGE CODE byte (byte 0 of the page) otherwise.

However, the SPF bit is tested on p[0] after p has already been advanced
past the mode page header, so the test reads bit 6 of the first byte of
the mode page data instead. If the parameter list ends with the mode
page header, it even reads the byte that follows the parameter list in
buffer, which is not initialized when no data beyond the parameter list
was transferred.

The test is not needed anyway: spg can only be non-zero for a mode page
in sub_page format, i.e. with the SPF bit set, and the field in error is
the SUBPAGE CODE. Always set the FIELD POINTER to the SUBPAGE CODE byte,
which follows the mode parameter header, the block descriptors and the
PAGE CODE byte.

Fixes: 7780081c1f04 ("libata-scsi: Set information sense field for invalid parameter")
Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 drivers/ata/libata-scsi.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index 7b0a02903fda..782f31feee0a 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -4664,8 +4664,7 @@ static unsigned int ata_scsi_mode_select_xlat(struct ata_queued_cmd *qc)
 				break;
 			fallthrough;
 		default:
-			fp = (p[0] & 0x40) ? 1 : 0;
-			fp += hdr_len + bd_len;
+			fp = hdr_len + bd_len + 1;
 			goto invalid_param;
 		}
 	}
-- 
2.56.0

