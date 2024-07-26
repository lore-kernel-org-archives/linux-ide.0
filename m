Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EB26FC19
	for <linux-ide@vger.kernel.org>; Fri, 26 Jul 2024 03:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721964001; cv=none; b=WP3UGZqgHmiCAT/u8rl84JgHsv7SKOgpx6EdzrBrZrYzGOs8IUWN07KO4bANQSzPZHbExPfnssMHh8lCYI1TlFe60uWHW1wPLZoORScCx8JAfWn/FiOsbHj319mOjnk85y0QTT/I1Ty2MS4y0jJrJV0i779C3EFbcWueuFXL2ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721964001; c=relaxed/simple;
	bh=fRt1WkFsV8v3M6WRmgFEmGXYVZAHldRtaY5PYMN1d6s=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nYdk2F2CBmR5xnCnTEFIZ0oVQqGrciL+MOE0CGEhtgYHXbg1Jp6WxgAzsBIw8sScvvzFHV6IqNPIGVPdNJbejJV6/jyKLolOMMYYqrywKxWlH9D6ofcCZdsHKbfUfHR6Sq+NeqJfDzWHsNVb9HT58d578wbLpHXJC+q4imtNUCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sOYIW6G3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sOYIW6G3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0F5EC32786;
	Fri, 26 Jul 2024 03:20:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721964001;
	bh=fRt1WkFsV8v3M6WRmgFEmGXYVZAHldRtaY5PYMN1d6s=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=sOYIW6G3eFxUKt1GP43E4cMh6rZZGxykHP7aiXBkQ5+EeIyMkTdCiVU94KMw7cUgL
	 G8u4nGcAeWijSkt/xVeEQI/B+9ArHtx3TKhWUIUpVCiUIOyWYStuharzcT8yRr2pzo
	 flrjOcfAmiOQ+KPtN/it2wa+xKBlOf1iEoRTnyPG2GZFrGwmweTRtULpaeqML9gjWE
	 u/+QkWB69nh5oMlMkQwqPud9Hu2Xrtxgmy1uWlUHiiuK7OCerRxsnT253h+zqraBnI
	 z5QpL+fm/dz3WODbKiJ7TbPAAUAwp4kUh8Yeikf+ejs06gMuow4/shdK4fDXZnRd7x
	 WH4qkOY93C8DA==
From: Damien Le Moal <dlemoal@kernel.org>
To: linux-ide@vger.kernel.org,
	Niklas Cassel <cassel@kernel.org>
Subject: [PATCH v6 08/11] ata: ata_piix: Remove useless comment in piix_init_sidpr()
Date: Fri, 26 Jul 2024 12:19:51 +0900
Message-ID: <20240726031954.566882-9-dlemoal@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240726031954.566882-1-dlemoal@kernel.org>
References: <20240726031954.566882-1-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove the comment using the term "blacklist" from piix_init_sidpr().
That comment is useless given that the function piix_no_sidpr() name is
clear about what is being checked.

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
---
 drivers/ata/ata_piix.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/ata/ata_piix.c b/drivers/ata/ata_piix.c
index ec3c5bd1f813..093b940bc953 100644
--- a/drivers/ata/ata_piix.c
+++ b/drivers/ata/ata_piix.c
@@ -1446,7 +1446,6 @@ static int piix_init_sidpr(struct ata_host *host)
 		if (hpriv->map[i] == IDE)
 			return 0;
 
-	/* is it blacklisted? */
 	if (piix_no_sidpr(host))
 		return 0;
 
-- 
2.45.2

