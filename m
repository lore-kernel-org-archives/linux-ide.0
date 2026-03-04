Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5386134E74B;
	Wed,  4 Mar 2026 07:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772609010; cv=none; b=ugYNMwncQJuVSkMArzlRF8BvgoiB/3IAXIYnzzVnrcD3QfJta9GtL4OpPFJKW/2L0xbGKBN9LeVGlcbIrbj7MUI7NcEx+NFTEna1Vxkbj/6LKVpLvKOqmRd4pMXln/nQDI6I3KA6vbdnn0bWWW4oGojSW9qs/dYGSl7LkZdxCxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772609010; c=relaxed/simple;
	bh=KdmgAK+7ggqqpwEu8fM3JCIkl93RuBKBu1gCIi0rB7I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=eq1LQoIivjCFUCp3F/4n5Mcv5GsKHUqnwdXfIUI9/rCxGuVSSL0ZtrdlC0DtviDIDRXuNt6iUhoi0xHIBfzWaFBJJuldfFNCHp/zQBp6BnPl+vxlNqTYzFxbBVDqSVwp6+w+1dgKhnrOBvVXiCeDksXrsMYRsLDdxDSaTH6dGRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ghRTIXEj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ghRTIXEj"
Received: by smtp.kernel.org (Postfix) with ESMTPS id D98A1C19423;
	Wed,  4 Mar 2026 07:23:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772609009;
	bh=KdmgAK+7ggqqpwEu8fM3JCIkl93RuBKBu1gCIi0rB7I=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=ghRTIXEjjuxjpuNgcKU8M84i3Y86sQd1bik7MJN4qryrGqYxhdSz0G1glyN38N0TD
	 b24+nIU4grVUUrcRccwTCwEGAAAKTMbnwq69X+xUiST8KRF9Sk6l3QD0Af53JKyvvb
	 TKts8oT1JuFwoBsqSDF+4N4ox+f6jsQ4NZ6zhsIucLLaC6tNDlO8iWrybMptCF8s7g
	 gRcEGoSoEgmc1r5qrY19bQVPnz4Ma/7e+YkwhY6+z9tiGuosw/hbcjkOw5S+s/oCSM
	 +YFXhELORLzOHniAPtgcFX7KJY/X0uixdG29ksQAFnZayxeRxdSyTMF++kzyLIKOwL
	 HtN8KZ3KbDxzQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDFDED58E4D;
	Wed,  4 Mar 2026 07:23:29 +0000 (UTC)
From: Maximilian Pezzullo via B4 Relay <devnull+maximilianpezzullo.gmail.com@kernel.org>
Date: Wed, 04 Mar 2026 08:22:59 +0100
Subject: [PATCH v2] ata: libata-core: Disable LPM on ST1000DM010-2EP102
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260304-ata-libata-core-disable-lpm-on-st1000dm010-2ep102-v2-1-607f8e157ad2@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6WOOw6DMBBErxK5zkZr81Wq3COisPECK9kY2QglQ
 tw9hiukGr0p5s0uEkWmJJ63XUTaOHGYM6j7TfSTnkcCtpmFQlVjgQXoVYNjc0YfIoHlpI0jcIu
 HMENaJSJajxJB0SJRgUHTVjW2hEUp8u4SaeDP5Xx3mSdOa4jf68Imz/Yf2yZBQom2sqaom6FuX
 qPX7B598KI7juMHNbP4LPIAAAA=
X-Change-ID: 20260303-ata-libata-core-disable-lpm-on-st1000dm010-2ep102-b0b85608e034
To: Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Filippo Baiamonte <filippo.ba03@bugzilla.kernel.org>, 
 Maximilian Pezzullo <maximilianpezzullo@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1772609008; l=1494;
 i=maximilianpezzullo@gmail.com; s=20260303; h=from:subject:message-id;
 bh=saHBIhc7+aT9k8g5jtyMKjiw++M8L1TETZ1DOdKurbA=;
 b=J2LclK5KJztj6z5o89JHnIqzAe77SCAARl8eUum9m/HTMc991DQ5uMZ3qu6Q4pm7nrlwuYmx2
 kCt9y9gkdZCBdwdTRQU/mU/Z89gk206yzqJ7m7PEZ45P8tlu5d8KeKt
X-Developer-Key: i=maximilianpezzullo@gmail.com; a=ed25519;
 pk=TRTR4c2Vb1IfluQvv5OUDPg7EE+pIzdPBND85UU559w=
X-Endpoint-Received: by B4 Relay for maximilianpezzullo@gmail.com/20260303
 with auth_id=658
X-Original-From: Maximilian Pezzullo <maximilianpezzullo@gmail.com>
Reply-To: maximilianpezzullo@gmail.com

From: Maximilian Pezzullo <maximilianpezzullo@gmail.com>

According to a user report, the ST1000DM010-2EP102 has problems with LPM,
causing random system freezes since kernel 6.15. The drive belongs to the
same BarraCuda family as the ST2000DM008-2FR102 which has the same issue.

Reported-by: Filippo Baiamonte <filippo.ba03@bugzilla.kernel.org>
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=221163
Signed-off-by: Maximilian Pezzullo <maximilianpezzullo@gmail.com>
---
Changes in v2:
- EDITME: describe what is new in this series revision.
- EDITME: use bulletpoints and terse descriptions.
- Link to v1: https://lore.kernel.org/r/20260303-ata-libata-core-disable-lpm-on-st1000dm010-2ep102-v1-1-40d5db367f67@gmail.com
---
 drivers/ata/libata-core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index ccbf320524da..76b012f544ea 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -4189,6 +4189,7 @@ static const struct ata_dev_quirks_entry __ata_dev_quirks[] = {
 						ATA_QUIRK_FIRMWARE_WARN },
 
 	/* Seagate disks with LPM issues */
+	{ "ST1000DM010-2EP102",	NULL,		ATA_QUIRK_NOLPM },
 	{ "ST2000DM008-2FR102",	NULL,		ATA_QUIRK_NOLPM },
 
 	/* drives which fail FPDMA_AA activation (some may freeze afterwards)

---
base-commit: af4e9ef3d78420feb8fe58cd9a1ab80c501b3c08
change-id: 20260303-ata-libata-core-disable-lpm-on-st1000dm010-2ep102-b0b85608e034

Best regards,
-- 
Maximilian Pezzullo <maximilianpezzullo@gmail.com>


