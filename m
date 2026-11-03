Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793739305;
	b=GzkMzYnAPEYIgM9bdM50oYpWlGNlitZSvd7k6jWVGaXmKfP49EjJ2M4H/I+lUmv+kv28
	 gXKAvM1HUAwTe6vaxOl9zcnMCWcGeeLNjMkImK4x5OQYTjWJokIsGiYv9NG0ComS2oRCJ
	 Agel9obQZUdnAMFDKxyWd0M4RLBNt1V8U9JH7eENiykGngrVefcB7ljnTLVZrBWzx8JlO
	 e5cA4+4vjS8128OC6dkC7HO0EloSRHPhf9iRdspnR4fIWiyi0sXVBxTkSxog3c9/96I6e
	 FDIT9Xxxjd6EyTo16IwrI/iCwojEOnzubDgRJpE5zBz//1uU4tw5aYErFviWbuniS3g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793739305;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:X-Developer-Signature:
	 X-Developer-Key:Content-Transfer-Encoding;
	bh=IzGMX5aUISUPuOvp05uILyN7/FGajnX5zWceQ23/fyo=;
	b=kc2+xY3hIuUB2JrsWvQc/JDhWFD78S6fYjbIU1iTtrhRzLrj7eNu4MsTbkyzf2QrFMsN
	 RyJcbY+qjsof3RFAQ3dPrTBkgy7nPA0ErgRzVCbdv4iJoiFwcesq9XhNbGIjKPcFtdSjw
	 sARJewxFHQ3nca2CbWYoMSF287jQgMaS2SmtVWPQrnG80Rx6zQ6YYDr5dXbMxsal1Mi9Q
	 t45/8Cdm4OL006+gd142ytbK7TSZEvz+ZXS1zxGa5gUmyZ/L7ZvxS8f5SzR4/aOG7XwIM
	 VNPSd491zrECwgU4tKGGPU3EZN8EETllX9ksRsQsjTjh+WjJLHBJr7JPH5MPfshJjww==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="KFk/dxod";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 003C0606A31B
	for <linux-ide@vger.kernel.org>; Tue,  3 Nov 2026 20:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KFk/dxod
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 578CB1F000C1;
	Tue,  3 Nov 2026 20:55:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793739304;
	bh=IzGMX5aUISUPuOvp05uILyN7/FGajnX5zWceQ23/fyo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=KFk/dxod22xChCaG2SRr426td5fHpCBiuxwzw16vlWsfC/rFMQevrhrXZd4eJ5REz
	 QjFWZFbb0TkXQLMLEjrQEz2dkeifiG0SVholGGicpztf/FIuee8Z/BrjVtk5xNoDP9
	 zd7qjGGwwFxVW+SnijGqi0Ce99NlAaSCrJttFvo99nzMnouoYyogXMX8Fhh39ez4gC
	 tUUp6TvMdsN4QB4mZ+hPm9yAyHnZAIjAmqzrs8ZlFKvmSqbd5NeYjYxl90nXkjixOx
	 e+gwEq/aAVQPm/nTJ4F0l+ZV1OMVwOkkEoXRL+n/ciLonLYzYNoxwdBNtOfgLRsBcG
	 j39IYGL4c6FvA==
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: linux-ide@vger.kernel.org,
	Igor Pylypiv <ipylypiv@google.com>,
	Shao Mingyin <shao.mingyin@zte.com.cn>,
	Hannes Reinecke <hare@kernel.org>,
	Niklas Cassel <cassel@kernel.org>
Subject: [PATCH 3/8] ata: libata-scsi: reject MODE SELECT mode pages with a wrong SPF bit
Date: Tue,  3 Nov 2026 21:54:52 +0100
Message-ID: <20261103205448.931471-13-cassel@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2108; i=cassel@kernel.org; h=from:subject; bh=7KgG6aZ8uyRa3xQ9gxvItc3yqFWLjERjRVGBy4HsOoA=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGLJeeclOv+FlPef2bvPE9H1qCzS9ag4q8f9mdeHICeCWc Er4IKnYUcrCIMbFICumyOL7w2V/cbf7lOOKd2xg5rAygQxh4OIUgIk4RzH84bN/U5OucGPXci3b z2s7eOPzDq2rcerSChUK+FLn/YF/HiPDCTbTytv5r/8rTWISDXrRci79pNJXx5rjq91FTA+U/X/ MBgA=
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

ata_scsi_mode_select_xlat() accepts the caching and control mode pages
both in page_0 format and in sub_page format with SUBPAGE CODE 00h.

However, SAT-2 and later versions of SAT define the SPF bit of the
Caching mode page and of the Control mode page as not changeable and
set to zero (see SAT-6, 10.4.9 and 10.4.6), and SPC-7 (6.12, MODE
SELECT(10) command) requires the device server to terminate a MODE
SELECT command with INVALID FIELD IN PARAMETER LIST if the application
client sets any field that is reported as not changeable to a value
other than its current value.

Reject a mode page with the SPF bit set to one and SUBPAGE CODE 00h,
with the FIELD POINTER set to the byte containing the SPF bit. The only
mode page with the SPF bit set to one that remains accepted is the ATA
Feature Control mode page (control mode page, sub-page f2h), for which
SAT-6 (12.3.4) requires the SPF bit to be set to one. The opposite case
does not need a check: a mode page in page_0 format always has subpage
code 00h, so it can never be the ATA Feature Control mode page.

This also allows the mode page handlers to rely on the format of their
mode page, which a later patch will make use of.

Fixes: 1b26d29ccd59 ("[libata] scsi: implement MODE SELECT command")
Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 drivers/ata/libata-scsi.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index d7923bc664d6..7b0a02903fda 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -4629,6 +4629,16 @@ static unsigned int ata_scsi_mode_select_xlat(struct ata_queued_cmd *qc)
 			goto invalid_param_len;
 
 		spg = p[1];
+		/*
+		 * Mode pages with subpage code 00h use the page_0 format: SAT
+		 * defines the SPF bit of the Caching and Control mode pages,
+		 * for subpage code 00h, as not changeable and set to zero.
+		 */
+		if (!spg) {
+			fp = hdr_len + bd_len;
+			goto invalid_param;
+		}
+
 		pg_len = get_unaligned_be16(&p[2]);
 		p += 4;
 		len -= 4;
-- 
2.56.0

