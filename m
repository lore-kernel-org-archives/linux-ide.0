Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B9A4FC19
	for <linux-ide@vger.kernel.org>; Fri, 26 Jul 2024 03:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721964002; cv=none; b=HIhDy2+JjuMlcmpa7Q9PLlQRPeYIAdTpAVNazrCfbiO0duV+f4u1jmPNNlU50hx3z08GEC0ef/nxvOxH++xOfGBcpICOfV4S+iYF8vcXUT4LHxmzKoa3WVDqybl3gJVGX9VBgsEf7ORbzeZJylOSkMGXmatSqzjiCrmGtmmMHgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721964002; c=relaxed/simple;
	bh=XYD3ZBbK20+gqDonbEE7YMNYjl/BAwjpBSMgGZGpzVs=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aAdu6hzmdtf/AMCxMz8ZYwH7jUurxMLd8TfKTqdsxQUlui7RlyHU+pAK0ZmabXAv53ouRSGvsYORDyESBdFC6Wz0BhWK3TW1gNxOkSwq5rboqjUzVCJPtxVs7z80WUJrMpQe8u2PFuzvTP5VgcCteHHmmTFGLO1BNhZIL8QV4b4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kD3Smo9D; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kD3Smo9D"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99252C32786;
	Fri, 26 Jul 2024 03:20:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721964001;
	bh=XYD3ZBbK20+gqDonbEE7YMNYjl/BAwjpBSMgGZGpzVs=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=kD3Smo9DuxPjigiZ54s2K2Y7hdvr90q/fCgiWhBRJ1VXlLKUvhNSREYK7hQ1vDvAH
	 TdsKWhFPv5R2cDQF15y5MHUipA9iIVVLgdVZrGqYWMbkMgzy3lcmBugy09MnabZ9xi
	 T/0chJ2Spp/YU2wtTwTeau3lVke5/XvrZ5UPxGxUOtj5/DeelmkBdduvET8coMKTN9
	 71JPX9tmq37cih3auXQlhhXKAboZ3iFj47ywwEkBYnD8jL47xe1ykJ78DxP8Hg2lbP
	 rt4qUKA9Zj6gErgMTswlPd0B3+MwfNJiT0lxdHh4DFADu0LhxiIj9NvpV6rTRtUEx1
	 +aBaAa/Qmt7Fg==
From: Damien Le Moal <dlemoal@kernel.org>
To: linux-ide@vger.kernel.org,
	Niklas Cassel <cassel@kernel.org>
Subject: [PATCH v6 09/11] ata: pata_cs5520: Rephrase file header comment
Date: Fri, 26 Jul 2024 12:19:52 +0900
Message-ID: <20240726031954.566882-10-dlemoal@kernel.org>
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

Remove the use of the term "blacklist". What the comment using that term
refers to does not seem to exist at all anyway as the driver does not
have such list but rather only a list of compatible controllers.

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
---
 drivers/ata/pata_cs5520.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/ata/pata_cs5520.c b/drivers/ata/pata_cs5520.c
index 027cf67101ef..3163c8d9cef5 100644
--- a/drivers/ata/pata_cs5520.c
+++ b/drivers/ata/pata_cs5520.c
@@ -8,9 +8,9 @@
  *	PIO mode and smarter silicon.
  *
  *	The practical upshot of this is that we must always tune the
- *	drive for the right PIO mode. We must also ignore all the blacklists
- *	and the drive bus mastering DMA information. Also to confuse matters
- *	further we can do DMA on PIO only drives.
+ *	drive for the right PIO mode and ignore the drive bus mastering DMA
+ *	information. Also to confuse matters further we can do DMA on PIO only
+ *	drives.
  *
  *	DMA on the 5510 also requires we disable_hlt() during DMA on early
  *	revisions.
-- 
2.45.2

