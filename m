Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CED01381B08
	for <linux-ide@vger.kernel.org>; Thu, 23 Apr 2026 16:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776962613; cv=none; b=sWNNEKIVmeoLkfkLKtBqmZH4xg+4sNwFMCGEOQKQc+7pl9ELhou9Bf+QfbV2Cdd5T9Uz4nherRFiPboKbxX8Q/oGjXuTOeEaQ/+NkMC3hkSZsujaUTnzPf7ko9v/Tg/7V52X35RFZQRM0RYqbBZhFAI9vyOyLxT8XTu2YACD4/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776962613; c=relaxed/simple;
	bh=Mj4nOBRfej/BaMPaoOnah8ivfMpDlepKNgt1eAFdS+I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IkbOaqpMjKXC35vPWU+pndQ7GzdBYZRUCJkwWZ2pNrtIpkAxpZpTXlFVnVTf6nXfioko/EPGIvlyHkfdaKaRHjlPfTWZ/qPctUvjG45edv2OLSFxnJ+/1fXH3yzgXl7fvDE7Kz+As1Mm38dcmzPWp7Ux2zCatOpTvXpAvV2BnyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V2LSsSwc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V2LSsSwc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83394C2BCB3;
	Thu, 23 Apr 2026 16:43:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776962613;
	bh=Mj4nOBRfej/BaMPaoOnah8ivfMpDlepKNgt1eAFdS+I=;
	h=From:To:Cc:Subject:Date:From;
	b=V2LSsSwcNUYImv8Z0o4VtrQVm4Hx29+5qqqESQqSHMbKqhA/XMuuUsOmd/q6gp3k7
	 dYn983DQTZhn5AgYF3/xjt9h95eMAtetoioRyqvyjT0ca9LdyvFTi2q3QHivksxZxr
	 QHc5gBR9qZx3C5coGHIK4ADw33eqJrHrC9LJrM7xch9ireKbFIoITb3I0rqowkBAav
	 xuXCQS3An2bVQ7pikSpsddkgISKUACkPTFXZbN7FkBUEcAfLkF5nFd8imzGiuPQs+I
	 zE+6Z9+AVv6Ut5/72K019kjaNKfgII1t1oCFE5AXNGCnaCY6OFJf+9Jtx+jArnnEuO
	 IlQllGyo04IiQ==
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>
Cc: linux-ide@vger.kernel.org
Subject: [PATCH] ata: libahci: use ahci_nr_ports() helper
Date: Thu, 23 Apr 2026 18:43:30 +0200
Message-ID: <20260423164329.1541337-2-cassel@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=595; i=cassel@kernel.org; h=from:subject; bh=Mj4nOBRfej/BaMPaoOnah8ivfMpDlepKNgt1eAFdS+I=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGDJf+Ri+Z2vf/80rq/HDSfGD2T/OuB1Va5gWJDLBbtNqp nOxwZNOdJSyMIhxMciKKbL4/nDZX9ztPuW44h0bmDmsTCBDGLg4BWAiJ98yMvxMrbFbGBDoZhuY 1PZKlpFLIEzRrHtx7u4PNv6c9r5yfgz/gxm5zh/qzlq14NmDtkgp6/BNjosjYpW85jDe2bMz/90 fbgA=
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

Use ahci_nr_ports() helper instead of open coding the same.

No functional change.

Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 drivers/ata/libahci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ata/libahci.c b/drivers/ata/libahci.c
index c79abdfcd7a9..7169e9e89034 100644
--- a/drivers/ata/libahci.c
+++ b/drivers/ata/libahci.c
@@ -2636,7 +2636,7 @@ void ahci_print_info(struct ata_host *host, const char *scc_s)
 		,
 
 		hweight32(impl),
-		(cap & 0x1f) + 1,
+		ahci_nr_ports(cap),
 		impl);
 
 	dev_info(host->dev,
-- 
2.53.0

