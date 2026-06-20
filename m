Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3927511CAF;
	Sat, 20 Jun 2026 02:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781922990; cv=none; b=Q2STXZah4vi4DDsFm2x6empVUxfTqA2bnahpCdDw0RdYpBONRCgpvbq2JEOVB5pUNCUXUOiUkLLR4xsVgt2Gcvf2DKc/6gtsbc6h0UaN9H+eFmgoCewMNsBs5KotupIw49tLMVtBCZ+2DM2Ct3sBx4+UDu19dxVZ//DDY2ChIdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781922990; c=relaxed/simple;
	bh=05hX4PBoe99es2DmqhiFiXlzEy0u08QWfegJpYeFjkw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Mm0cDtqSeoD/xQfvGJTq22o4BH6xH0m4dSxvhrYmimv1U+n9PPPyyds48GzASjyBLh1CnOTzMxKsAsGAYKLQBCbtcFSnUy5VmMVLPTu1Bj9lKAlmRshQG7SnBCHJO6B1M3zBM1Tq5JaLw0HaI2TcW6MG+zMdWMnf6V2VgHcotOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jRhIz2tv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jRhIz2tv"
Received: by smtp.kernel.org (Postfix) with ESMTPS id E84B5C2BCC9;
	Sat, 20 Jun 2026 02:36:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1781922989;
	bh=05hX4PBoe99es2DmqhiFiXlzEy0u08QWfegJpYeFjkw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=jRhIz2tvX98fvt/gRcpFH702sasGsIp/PGWsg9WpPnftR18LYlSr1LurpGjuEhkpv
	 uxFEtDrc0Q6eb02SSAYgLt6HC/vONaDwnsNUaY6/KmDc8NBnIthBc21TpN8oAezit5
	 OYNJf+m6PZAbEoUoBlwdazD7SUOnyGbIEA4xnvmko9XVJyqLQ0H9JTJq1lPOTVOJu3
	 WwdwD4LYEIo53TDtaSaU0ZWr2Sf6KODpazg6l9mmvf7ckl4NeqQJE9Ai3QBQ9yFP9G
	 1JL7YY/tJxp53nQadSI+H9tFgcoy4z+Ievdq5tIrmSXPN1Sib7KzZxYr4ydF+VA1Qq
	 Hk2uoxgrH24dw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5D0ECDB46B;
	Sat, 20 Jun 2026 02:36:29 +0000 (UTC)
From: Bryam Vargas via B4 Relay <devnull+hexlabsecurity.proton.me@kernel.org>
Date: Fri, 19 Jun 2026 21:36:29 -0500
Subject: [PATCH 1/2] ata: libata-core: Clamp the concurrent positioning
 ranges count
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260619-b4-disp-6200c44e-v1-1-4624a4707d9e@proton.me>
References: <20260619-b4-disp-6200c44e-v1-0-4624a4707d9e@proton.me>
In-Reply-To: <20260619-b4-disp-6200c44e-v1-0-4624a4707d9e@proton.me>
To: Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781922988; l=1600;
 i=hexlabsecurity@proton.me; s=proton; h=from:subject:message-id;
 bh=8PNoOz3QbWUZ2Z1u7nRPinneyr22XG/IsUnvRsy1/Zo=;
 b=xTKR/NgL29fdsQcXNnou7yNH31sszPGgziqf/bsJFN0stPsP4wI2ma0JvRGzp/krJfGNO2V66
 QSxtOKuQMWKDQJ7XwobHaZP3EpZMCHTZDNNR8+jHrWTzFG9hcjdR1WG
X-Developer-Key: i=hexlabsecurity@proton.me; a=ed25519;
 pk=dmppBMZNLLoPzxHi9l8tZDzEZUunPbgsYqIZYXeUrL0=
X-Endpoint-Received: by B4 Relay for hexlabsecurity@proton.me/proton with
 auth_id=814
X-Original-From: Bryam Vargas <hexlabsecurity@proton.me>
Reply-To: hexlabsecurity@proton.me

From: Bryam Vargas <hexlabsecurity@proton.me>

ata_dev_config_cpr() sizes the log buffer from the length reported in
the GPL directory but takes the number of range descriptors from buf[0],
which the device reports independently. A device advertising a small log
but a large count makes the descriptor loop read past the buffer: a
one-sector log with buf[0] = 255 reaches up to 7704 bytes beyond the
512-byte allocation, a slab out-of-bounds read whose contents are then
handed to the initiator through INQUIRY VPD page B9h.

Clamp the descriptor count to what the allocated buffer holds, as
sd_read_cpr() already does on the SCSI side.

Fixes: c745dfc541e7 ("libata: fix reading concurrent positioning ranges log")
Cc: stable@vger.kernel.org
Signed-off-by: Bryam Vargas <hexlabsecurity@proton.me>
---
 drivers/ata/libata-core.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 3d0027ec33c2..e8d708f0810e 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -2832,6 +2832,17 @@ static void ata_dev_config_cpr(struct ata_device *dev)
 	if (!nr_cpr)
 		goto out;
 
+	/*
+	 * The log size is reported in the GPL directory independently of the
+	 * number of range descriptors in buf[0]. Clamp the count to what the
+	 * allocated buffer holds so the loop below cannot read past it.
+	 */
+	if (buf_len < 64 + (size_t)nr_cpr * 32) {
+		nr_cpr = buf_len > 64 ? (buf_len - 64) / 32 : 0;
+		if (!nr_cpr)
+			goto out;
+	}
+
 	cpr_log = kzalloc_flex(*cpr_log, cpr, nr_cpr);
 	if (!cpr_log)
 		goto out;

-- 
2.43.0


