Received: from smtp.smtpout.orange.fr (smtp-27.smtpout.orange.fr [80.12.242.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB0283F8D0;
	Mon,  1 Apr 2024 13:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.27
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711977489; cv=none; b=FamyEzKbLV/tiu2pdAHzHfViOH6KdiHygjz8uu8eo5TG/kNdhCG0J6vqqhJT7+HoRwF0yxarototwBMI0vQExjV9SvdDXZwos321COqLyXAI7ZGHgWIO5JGp/5RfYX5yw1UNuuWM7SI711BD1Yru2K45UzNd5kvXWvKcIiZwWWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711977489; c=relaxed/simple;
	bh=kRLfKL0JGLQjQTaM8tLA39C/3K27Jq4C8G3X1iw/RH4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=B761CmliPOY+n85y+U5iaMNTkHjKp1J8oZeQkteBzJf6161X9pjlHd6iVj3pOVPdVePNrixrsWHdGWUDeJXOYrvkQ4LOBaoZeXtgu5B0LbzMUmD532dxITWtgTprlyyJ2UPvKlgybiKXeTqgs6ZCZiQHHJuzUcRONVpNOKqQ/8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=Ew3UVoD1; arc=none smtp.client-ip=80.12.242.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="Ew3UVoD1"
Received: from fedora.home ([86.243.17.157])
	by smtp.orange.fr with ESMTPA
	id rH1hrOZwdvgJFrH1hr3sW9; Mon, 01 Apr 2024 14:44:38 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1711975478;
	bh=Yu8leq0vscV/4JPRiTZKtnUrj46s9nQc5F/iD/konlQ=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=Ew3UVoD10l//SFm8GppZswThlk91Da+AnocbMuCrrpiOB4IbAQy7631GwO2+eWUpi
	 QEFyHRTXcwWPucTNej7HHJ5WTTvVgNw8iseGVfrMjDganGtAXIWo4mRrJISskoGuVi
	 YahysPiPR2io4eQrAZkoXnwS9gK22rEho2F/FuBwQ25cY9z5q344Hc1CTfLaZIFks+
	 wiO1LfGA5vnhguf8evdWE8xM/C2Xo9VMh4CQJ4O1kJPu0ypJFSZDIx+elRsWmiL8Gr
	 xgZ+OmoQqm2Dd93N+g7HSA9K8xDx1fI3ZKZs3sjFhBzuSvmgDgXZBPWaZ2BvFAlBTD
	 setNZnc7nev1Q==
X-ME-Helo: fedora.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Mon, 01 Apr 2024 14:44:38 +0200
X-ME-IP: 86.243.17.157
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: Patrice Chotard <patrice.chotard@foss.st.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	linux-arm-kernel@lists.infradead.org,
	linux-ide@vger.kernel.org
Subject: [PATCH] ata: ahci_st: Remove an unused field in struct st_ahci_drv_data
Date: Mon,  1 Apr 2024 14:44:29 +0200
Message-ID: <f1804954a746e93382429cf38e4f1f9fb46bb578.1711975449.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In "struct st_ahci_drv_data", the 'ahci' field is unused.
Remove it.

Found with cppcheck, unusedStructMember.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
Apparently, it has never be used. It is not a left-over from a refactoring.

Compile tested only.
---
 drivers/ata/ahci_st.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/ata/ahci_st.c b/drivers/ata/ahci_st.c
index d4a626f87963..79a8b0aa37bf 100644
--- a/drivers/ata/ahci_st.c
+++ b/drivers/ata/ahci_st.c
@@ -30,7 +30,6 @@
 #define ST_AHCI_OOBR_CIMAX_SHIFT	0
 
 struct st_ahci_drv_data {
-	struct platform_device *ahci;
 	struct reset_control *pwr;
 	struct reset_control *sw_rst;
 	struct reset_control *pwr_rst;
-- 
2.44.0

