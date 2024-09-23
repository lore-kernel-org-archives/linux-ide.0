Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87A8E19993F
	for <linux-ide@vger.kernel.org>; Mon, 23 Sep 2024 13:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727098794; cv=none; b=Z5IBZF65cAZfZipqK/mqTBWK7ioHhPafasdLctAbTPc5VeyYy1rmQo/rHeDv0DZ7ZXUeLG2NWSUA0JlSJzJmDfbZjOqCqIVLJU+j7azyXn/PjPaIikuoqcHQ8Fri7Cjac2zf8CjPLDbbWFKqxplhHoJt5GqS96XP1J1a0UoO47k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727098794; c=relaxed/simple;
	bh=cKRffpQl67AEJMBjmSGQafTRy7itVFCXPBwzTOy9Wsk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tZg8r4iue/x6fB1HfJNNLfjdBWc7MTmM0dVebGa7yFRzTkDmOx4i5Uh42BSFcb6eBa37nbV4ekZHwyXlqhSxRhlOSrZ8YmCPwwLlN6vkLWVjz2Bddfy3QIS3T1mbrEafZKt5KmR5Pigca9m6iggm9Y6sAnB1hWHmFO+q4Eu6aKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jDJlkWdW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jDJlkWdW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1FA7C4CEC4;
	Mon, 23 Sep 2024 13:39:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727098794;
	bh=cKRffpQl67AEJMBjmSGQafTRy7itVFCXPBwzTOy9Wsk=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=jDJlkWdWx7cvfbGd0NNefSnSwv28jRmGiWVKfeQkbFM2j8OIAezP35gK3gTSdDFno
	 GLGvOAbqhtVMeBbL04X39krpXN01LxYMGvvj4WlseZhYAQDrGWC0UcV9EOHScIxH1P
	 OtCuxZGzOJX3ztDmxYObf2j/EAQVdoHp71CJmlMAcI/oXqAVq5fJH8ND7YuDVo/mmP
	 yvhXfVTudOQF57zSCM6LeB+F24fE8XLg3xJZPqc23hYE1wZJRSPNNrOeG4pVVtcebd
	 dhBHtZoOtjDLGE4UEb0HMAF50sda8csmEWqPPfEFSYeqZ9Hj/tgdbtZEUZ3VToEY9u
	 izSNH0QypvaSg==
From: Damien Le Moal <dlemoal@kernel.org>
To: linux-ide@vger.kernel.org,
	Niklas Cassel <cassel@kernel.org>
Subject: [PATCH 2/2] ata: libata-scsi: Fix ata_msense_control() CDL page reporting
Date: Mon, 23 Sep 2024 22:39:49 +0900
Message-ID: <20240923133949.286295-3-dlemoal@kernel.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240923133949.286295-1-dlemoal@kernel.org>
References: <20240923133949.286295-1-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When the user requests the ALL_SUB_MPAGES mode sense page,
ata_msense_control() adds the CDL_T2A_SUB_MPAGE twice instead of adding
the CDL_T2A_SUB_MPAGE and CDL_T2B_SUB_MPAGE pages information. Correct
the second call to ata_msense_control_spgt2() to report the
CDL_T2B_SUB_MPAGE page.

Fixes: 673b2fe6ff1d ("scsi: ata: libata-scsi: Add support for CDL pages mode sense")
Cc: stable@vger.kernel.org
Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
---
 drivers/ata/libata-scsi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index 97c84b0ec472..ea7d365fb7a9 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -2350,7 +2350,7 @@ static unsigned int ata_msense_control(struct ata_device *dev, u8 *buf,
 	case ALL_SUB_MPAGES:
 		n = ata_msense_control_spg0(dev, buf, changeable);
 		n += ata_msense_control_spgt2(dev, buf + n, CDL_T2A_SUB_MPAGE);
-		n += ata_msense_control_spgt2(dev, buf + n, CDL_T2A_SUB_MPAGE);
+		n += ata_msense_control_spgt2(dev, buf + n, CDL_T2B_SUB_MPAGE);
 		n += ata_msense_control_ata_feature(dev, buf + n);
 		return n;
 	default:
-- 
2.46.0

