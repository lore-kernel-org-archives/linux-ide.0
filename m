Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793739308;
	b=B2RFlck8gyS0nmmq1kci5rmlvwEef9dOL4TsgntMQTK7yuEIciFDidXiGmWqovAg92H+
	 5PbjFcwjI3LWd/2aRlYESKplh838jfrMwHBZFPXSbg8zX7+0iIwm7ClEVUoSukiAXu46p
	 rIwEKec2IsMHtsBlcm2NJYeX5MJOqaz0gTUSyislXVV2HGq47E/eeAchLY/Ic+/C8n9mg
	 LEoJOfQcFpC1XN3AYZsD+WR1SrcKLELsBhNFQtykD+ag24zldqdczlZ2AGcEymY6YRsZx
	 l4YLgtjFxlxd7SwIfgOvCl+g0Kgo4mD54E4HkLcMkCPhgTMNmdTw4C4eW8ajVpAXrKA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793739308;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:X-Developer-Signature:
	 X-Developer-Key:Content-Transfer-Encoding;
	bh=AHDsidHF76+b9atTy+F7QSDUu5F0Cg9kdU3/C0ch7hY=;
	b=Ze7KrqYPP163fBC6auFjrbQHW5o7WSrlexENJEvF9I+l5hAszlRnFIw98QXWIzNZ0cZC
	 O8GQe3ctvm6WZWTRCaEJy4CSqqJ2NnttttZSjTOhzWze0HoWMUhWrVJs77gyql16xK/Sf
	 Ux2vr/Ro+a9f4m4AvbECKEnJspDouW6DH2JWwrEi+mx2tJXsKBtqGF2rywgaCxsbkehOu
	 SP7r9cZp5J4rUlx94yDXswXUMTV0pN1P08NDMkvTp3eqWZaKCEblnEAnla3Pu66S5Cwzx
	 4scNmednM1URH2AvvxtkipwOF56mzlS1LRn+/Lsq2fy7BOVeBxDodYAxQvU5DovYFxQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=brBNWa1e;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F039606A324
	for <linux-ide@vger.kernel.org>; Tue,  3 Nov 2026 20:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=brBNWa1e
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD35F1F000C1;
	Tue,  3 Nov 2026 20:55:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793739308;
	bh=AHDsidHF76+b9atTy+F7QSDUu5F0Cg9kdU3/C0ch7hY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=brBNWa1eSZ7bloH1fEMql/W8LqAvHrTzsRwbZlA8CHzGruyRg7PKssG0JV2tthUMO
	 vpht/IzaaB4fd+LHflvc4vzii1gcYLl/s+xqs7KPkzC91201ov6nLsfeZrmKipDQtK
	 6gHBjX9Sv83umeXUAQp1o9IgOEvO5b3qTMWHbQAOPI8BPl75E4QaZU7ammRA91lJu8
	 DpFk3KpyO/k16o4eHFJdmBiZB3VxZg3P4MREKTXaCtWqUy7hyu9anbWNhfmd8nu9ki
	 Bm+rqZUnCfUTWNdgYFV05G4UBiQtdm/DHgp0YZ6yXTPmEQdoj995JpBadrGrMgrXyq
	 M3cVB/u2Yzr/w==
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: linux-ide@vger.kernel.org,
	Igor Pylypiv <ipylypiv@google.com>,
	Shao Mingyin <shao.mingyin@zte.com.cn>,
	Hannes Reinecke <hare@kernel.org>,
	Niklas Cassel <cassel@kernel.org>
Subject: [PATCH 5/8] ata: libata-scsi: fix MODE SELECT field pointer for block descriptor length
Date: Tue,  3 Nov 2026 21:54:54 +0100
Message-ID: <20261103205448.931471-15-cassel@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1595; i=cassel@kernel.org; h=from:subject; bh=dvjGrO/TrSKzdnEh+oH3IJkwZxl3Cbeul61jbhC/XvE=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGLJeecnaMWuoy/R9XcPGPG9R3OkJJw5GWYo5F1ttszNf3 N51XnVWRykLgxgXg6yYIovvD5f9xd3uU44r3rGBmcPKBDKEgYtTACZiM5HhD9fEBT82tM/ye/rk TOSd/BcTGXvcckMXMV/Je/CxUkpc7wgjw+xOMf+k1+/muu06IZ9hNMnQ6uKnueLSbQp3551Nk7D uYwcA
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

ata_scsi_mode_select_xlat() only accepts MODE SELECT parameter lists
without block descriptors or with a single 8 byte block descriptor. For
any other BLOCK DESCRIPTOR LENGTH, it terminates the command with
INVALID FIELD IN PARAMETER LIST, and the FIELD POINTER should point at
the BLOCK DESCRIPTOR LENGTH field, i.e. at byte 3 of the mode parameter
header(6) or at byte 6 of the mode parameter header(10), as SPC requires
the FIELD POINTER of a multiple-byte field to point at its first byte.

However, the mode parameter header length and the BLOCK DESCRIPTOR
LENGTH are added to the offset of the field, so the FIELD POINTER points
3 or 6 bytes after the end of the block descriptors instead. For
example, a MODE SELECT(10) with a BLOCK DESCRIPTOR LENGTH of 16 reports
byte 30 instead of byte 6.

Do not add the mode parameter header length and the BLOCK DESCRIPTOR
LENGTH to the offset of the BLOCK DESCRIPTOR LENGTH field.

Fixes: 7780081c1f04 ("libata-scsi: Set information sense field for invalid parameter")
Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 drivers/ata/libata-scsi.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index 782f31feee0a..4b8454335aef 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -4613,7 +4613,6 @@ static unsigned int ata_scsi_mode_select_xlat(struct ata_queued_cmd *qc)
 		goto invalid_param_len;
 	if (bd_len != 0 && bd_len != 8) {
 		fp = (six_byte) ? 3 : 6;
-		fp += bd_len + hdr_len;
 		goto invalid_param;
 	}
 
-- 
2.56.0

