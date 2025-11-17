Received: from exactco.de (exactco.de [176.9.10.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD5FD32D45E
	for <linux-ide@vger.kernel.org>; Mon, 17 Nov 2025 12:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=176.9.10.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763383395; cv=none; b=G8drvc5os8NjMcbPfWnmVf5vm384xiWq1WMx42ugwW0DE69keBvVYouSIR2MsZiosvZ8I5AmVzilTusUHnXASN4KD9Z//CMCv9PipVsixLBoyyihtZRTtomvVt/lIWejLw8wAEDEBeaVkuv5qvxowSe358hOmVrUIf5axuLFJQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763383395; c=relaxed/simple;
	bh=dz5nOm8DJekHsaFXZubv/xzWZab417F28Z9cgwBEV28=;
	h=Date:Message-Id:To:Cc:Subject:From:Mime-Version:Content-Type; b=M9bJ3R8vbD4H6BVS5A93Vl9llg7WQh/SnwpGSKj9wDAvbuuM+TMLzQIJwRq7Ml9alijDLBRfCb3EMm8snjiTjMC/Ocl6gJ4LqxkYEhKYDHFNUGxuX/WVuBGgbBmCQAQ1Y7LGyKXFnBi1g+X27ixeEG+Zwq/x6w9Hgp9gbe7UP+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=exactco.de; spf=pass smtp.mailfrom=exactco.de; dkim=pass (2048-bit key) header.d=exactco.de header.i=@exactco.de header.b=YDRIdj/E; arc=none smtp.client-ip=176.9.10.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=exactco.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=exactco.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=exactco.de header.i=@exactco.de header.b="YDRIdj/E"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=exactco.de;
	s=x; h=Content-Transfer-Encoding:Content-Type:Mime-Version:From:Subject:Cc:To
	:Message-Id:Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
	List-Owner:List-Archive; bh=/nkaC8WLs0nxuMt0EEQXrCk/Yavdt2GnfRKFMiHBRL0=; b=Y
	DRIdj/EihAQ/JN2lcDzmSc6XXWJe0ZMQX7GGE17BnNth5+z1k1PIKjoJEpmZqkzZB3YdhQWSXpgZG
	HnP8pzYIJ7tvdUoJxbcBUJDk3i+SqOUjz39ScUnX9V/hiiCahaf8L1Oelms5QUqV3eOSBX8h4kM8e
	3nZfZNOXj/XII2NkwVgSmK1aNFcjDY4O61Po5nZwJxL7goJqu7Cj8+yHzvwXFsUkhtr50+CVnaOUJ
	FBw5Rt3qrg0CkIjQD0wfXluyVEspzOIlgZpYe7M3hZgz/VWbAgDxGjjkPHZDScD5pDOt7UyLQb5wu
	g+vVq1tGn3Dk8R7f2l529f3JKL1j1N5Eg==;
Date: Mon, 17 Nov 2025 13:43:21 +0100 (CET)
Message-Id: <20251117.134321.1327313572065130952.rene@exactco.de>
To: linux-ide@vger.kernel.org
Cc: Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>
Subject: [PATCH] fix PCMCIA Iomega Clik! 
From: =?iso-8859-1?Q?Ren=E9?= Rebe <rene@exactco.de>
X-Mailer: Mew version 6.10 on Emacs 30.2
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

Add PCMCIA Iomega Clik! ID to pata_pcmcia.

-- Signed-off-by: René Rebe <rene@exactco.de>

--- a/drivers/ata/pata_pcmcia.c	2025-02-27 18:51:20.641993816 +0100
+++ b/drivers/ata/pata_pcmcia.c	2025-02-27 18:56:22.022992807 +0100
@@ -362,6 +362,7 @@
 	PCMCIA_DEVICE_PROD_ID12("STI", "Flash 5.0", 0xbf2df18d, 0x8cb57a0e),
 	PCMCIA_MFC_DEVICE_PROD_ID12(1, "SanDisk", "ConnectPlus", 0x7a954bd9, 0x74be00c6),
 	PCMCIA_DEVICE_PROD_ID2("Flash Card", 0x5a362506),
+	PCMCIA_DEVICE_PROD_ID2("PCMCIA ATA/ATAPI Adapter", 0x888D7B73),
 	PCMCIA_DEVICE_NULL,
 };
 
-- 
  René Rebe, ExactCODE GmbH, Berlin, Germany
  https://exactco.de | https://t2linux.com | https://rene.rebe.de
