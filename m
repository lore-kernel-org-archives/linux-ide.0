Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86AC478274;
	Mon, 15 Apr 2024 12:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713185480; cv=none; b=K+LtebfFdKmC3/I1Kc7EelzKte+fe8PjPQ2ro26dOvt2230YwJQHRmfA1vraJjxqlm5D32hhJKyCUnchQYzszgKzQDYf5fyuGfBYRClg8w4AYtvcRupeeJwg0cRP8sOs7IlsOchr80anJT9yGcy/BCsA1QsqG6BFxwYATx+N28M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713185480; c=relaxed/simple;
	bh=Oq1TE7fKDL0tTwriQuglnSGXXmyWjbZCAMSjs+69IWk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uzz0Vq7cavD3+GrR0/lWwrPCcylNN5WUhd4uJbnV/EJMDdfefAxtR4/QOS57MZs3qF4CNLc8+Z08zh6BUyw09DmgPHXbR34YwdyfFkrQPVKYGI8v0tYaJlTPfWwGLHXztcFgEvemmp5l8PQcDNnyvWhKE1Vgw1mxumvv9AAkGq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YiCB6CR2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YiCB6CR2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 299C1C32783;
	Mon, 15 Apr 2024 12:51:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713185480;
	bh=Oq1TE7fKDL0tTwriQuglnSGXXmyWjbZCAMSjs+69IWk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YiCB6CR2Q3w+wCmdelauLRB3yjEeSRzD45QL7n7FfUNo7p0UY1CbvcUln6e9SZmlZ
	 xNPiTdDWl8ayXV/9evMX5pk2TDDTsDJ6wR32z0SWDGgQ8+qc73En7UC2FFY2SL6F6U
	 G9ZnO1YolklmtOuO50vtQJC0aKGpDqkQzVs0dYr2aucqVsOUgEQ2sTTnzFJW6OqHdU
	 dITiVZlsPDbK93vR62eQPLtUgLV0xQtN+SqrYeoNiskDvjMLe74ooShTzK91G5A8Or
	 4/3rxukPta+LTV4Kawm1ERTFra6t1InqR0wTdD7ekQbmLxtBY0InDCoNPs7jTtYE1E
	 drCWG/A7K+dsg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Chen Ni <nichen@iscas.ac.cn>,
	Damien Le Moal <dlemoal@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	linus.walleij@linaro.org,
	cassel@kernel.org,
	linux-ide@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 3/4] ata: sata_gemini: Check clk_enable() result
Date: Mon, 15 Apr 2024 06:05:16 -0400
Message-ID: <20240415100520.3127870-3-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240415100520.3127870-1-sashal@kernel.org>
References: <20240415100520.3127870-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 4.19.312
Content-Transfer-Encoding: 8bit

From: Chen Ni <nichen@iscas.ac.cn>

[ Upstream commit e85006ae7430aef780cc4f0849692e266a102ec0 ]

The call to clk_enable() in gemini_sata_start_bridge() can fail.
Add a check to detect such failure.

Signed-off-by: Chen Ni <nichen@iscas.ac.cn>
Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/ata/sata_gemini.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/ata/sata_gemini.c b/drivers/ata/sata_gemini.c
index 64b43943f6502..f7b4ed572ce02 100644
--- a/drivers/ata/sata_gemini.c
+++ b/drivers/ata/sata_gemini.c
@@ -200,7 +200,10 @@ int gemini_sata_start_bridge(struct sata_gemini *sg, unsigned int bridge)
 		pclk = sg->sata0_pclk;
 	else
 		pclk = sg->sata1_pclk;
-	clk_enable(pclk);
+	ret = clk_enable(pclk);
+	if (ret)
+		return ret;
+
 	msleep(10);
 
 	/* Do not keep clocking a bridge that is not online */
-- 
2.43.0

