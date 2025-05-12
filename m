Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE1C4B672
	for <linux-ide@vger.kernel.org>; Mon, 12 May 2025 08:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747039444; cv=none; b=uZYno8lI3ogJTcIVSsprnnqEN4ze7a8tLHbqaMkjB0fq+SQJyORylerLBUhfN/IvG1nQZADyX/TLNiwY3CfJysr8hbIJiKl/kFp//AMCa+rtTMhA10gtXaSdEuoNv3cEEywL4M+b9ATJL55QkC2TcC2fX0V31I4IoOGZawbIKTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747039444; c=relaxed/simple;
	bh=qgIyzTXRJCi8yQ2iJlykGl4bZB9RAMigh3l6/XbQhYc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BA1qlj9xJYwvs4N3LjNUrtauH/z+3EClpXk/3kWOavxQkh0VQueLCyB3auK6jrvPFE4nyVfk14abxYTtj1fobLtzgbtELg2wJXrpstFfehPgqOX6IphiVRmgOBi2G+4iCjOHiGtQfHF3ORFoJbXUXopWW8Yx7tEeFPv1Indbt6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QLFjwdxW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QLFjwdxW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E97FC4CEE7;
	Mon, 12 May 2025 08:44:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747039444;
	bh=qgIyzTXRJCi8yQ2iJlykGl4bZB9RAMigh3l6/XbQhYc=;
	h=From:To:Cc:Subject:Date:From;
	b=QLFjwdxW1gE6ALHlW6PBQNzkDsrI3oay/wnr6fR3quhxytB3TL2LAGHF78aFvoSKn
	 9J0KW7/j1DeDOkXgjbO32MGXnsSia3kC7pdSPaJ3QlfDYUSjpbTOTiGaPLW9a+n6fL
	 rUWr0ndfNjLwUoF4qCakK/vOnV7r0nz/Do7f8q83g+eLGuAY7k419iVyn3/+Zutj+S
	 6YOXlQczywKCjB9ZYB5Rl1zPbnxe9uAjyzC91UOwZcfWouh/ACDacianDXrJHlLjeZ
	 kyCDVqgA4YWU0sGN042emX6fVd+YS/qBYBeZBvt5V0LcMpkBeKCACrOxJyeYqG6j7W
	 oUgVCofVRbLZQ==
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>
Cc: Mikko Korhonen <mjkorhon@gmail.com>,
	linux-ide@vger.kernel.org
Subject: [PATCH] ata: libata: Print if port is external on boot
Date: Mon, 12 May 2025 10:44:00 +0200
Message-ID: <20250512084359.62178-2-cassel@kernel.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1744; i=cassel@kernel.org; h=from:subject; bh=qgIyzTXRJCi8yQ2iJlykGl4bZB9RAMigh3l6/XbQhYc=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGDIUt5z3Ss/a7CkV0/XOYq3riYlVmi7JfcVTrES+XK04K GeydsKqjlIWBjEuBlkxRRbfHy77i7vdpxxXvGMDM4eVCWQIAxenAExEu4yR4f6FrOiH/w4n1H42 v2+tmhDTeSRk9s83gaceWezwisjvucDI0B5u7vdArvPWvRwF52sc7lJe/aYHawSLTT88mmX3vm8 fEwA=
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

Commit affccb16c117 ("ata: ahci: print the lpm policy on boot") added a
lpm-pol print during boot, which shows the LPM policy used by each port.

While the LPM policy is usually determined by the Kconfig
CONFIG_SATA_MOBILE_LPM_POLICY, the Kconfig value is overridden e.g. if
firmware has marked the port as hotplug capable / external.

Commit f97106b10d9a ("ata: ahci: Add debug print for external port") did
add a debug print to show if LPM was disabled because firmware has marked
the port as external, however, because devices having broken LPM (even
though they claim to support it) is more common than one would have hoped,
print "ext" during boot if firmware has marked the port is external.

This will make it easier to debug certain LPM issues, e.g. if firmware has
enabled/marked only some of the ports as hotplug capable / external.

Before (port marked as external by firmware):
ata1: SATA max UDMA/133 abar m4096@0xfebd3000 port 0xfebd3100 irq 57 lpm-pol 0

After (port marked as external by firmware):
ata1: SATA max UDMA/133 abar m4096@0xfebd3000 port 0xfebd3100 irq 57 lpm-pol 0 ext

Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 include/linux/libata.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/libata.h b/include/linux/libata.h
index 98affa1d9136..31be45fd47a6 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -1618,6 +1618,8 @@ static inline void ata_port_desc_misc(struct ata_port *ap, int irq)
 {
 	ata_port_desc(ap, "irq %d", irq);
 	ata_port_desc(ap, "lpm-pol %d", ap->target_lpm_policy);
+	if (ap->pflags & ATA_PFLAG_EXTERNAL)
+		ata_port_desc(ap, "ext");
 }
 
 static inline bool ata_tag_internal(unsigned int tag)
-- 
2.49.0

