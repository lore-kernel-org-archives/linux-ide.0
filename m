Received: from devloop.tasossah.com (devloop.tasossah.com [145.239.141.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FB131B4F0F
	for <linux-ide@vger.kernel.org>; Mon, 19 May 2025 08:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=145.239.141.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747644967; cv=none; b=pVKl2KXSpqr4EWJPBLeFYPfVrLnqbEnHOmIOgPXSsNl7qChdFu8tw6JQiqJDnRfaA97HWM39//jr3Q8YTUfe4p4t+fKhTeBB8CZfEOWHMgICacOXX0/H0aZZp9ckJ64syARfN9ms+Gx8Mt5LmmXKndZAuMoZSoDKlM98S16Cdkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747644967; c=relaxed/simple;
	bh=ZSD5oE03RtytTCqoP9fva8O5/lam1xXDxHMpiL60YFI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GKJ7B/Y/ugkedK67f9QM/Ej95I7lmaqIbWmVK9+ks3un7SFVMidwprDzdgRLS70O4ac0Vrc3xHM50L87yFrCYWV1NxDq+CBmsa0EFN5yRM+nJ2UxIhxJhRrAGdZrAVtb06ioF3sLiSvupa8Z3vwzi8nbEdGj9UVlAXH/ewNnx+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=tasossah.com; spf=pass smtp.mailfrom=tasossah.com; dkim=pass (4096-bit key) header.d=tasossah.com header.i=@tasossah.com header.b=Tbvgc3nH; arc=none smtp.client-ip=145.239.141.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=tasossah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tasossah.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=tasossah.com header.i=@tasossah.com header.b="Tbvgc3nH"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=tasossah.com; s=devloop; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=ETqGfmNK2Nc7pFXxsfpzqmJm9AdGdUZDYuGtdK/F+T0=; b=Tbvgc3nHjEdEmWUU9oMXth5s/L
	0cfwR/zxDhmHs3zbWaP+lEwOq0OqLAA0fgjGWPbDHu+JQbOGWyuIQbu7Tek9kbgCIWg9LN9UOMcif
	ZGNMHt4BxKK9Q9je3SIhTCGtuw9seOFwTKFgRkr6yTCvyoOn1NEWDgirrQrmd+QH4a13PXXBqg+sh
	yBTVj2LBXfvl3SDK6+hqKtg98b1Wr+5C/nJwTZkT894feHHuLL5e7C3851DtxXVaK6s7Vpf7ykRLf
	8uNyhSivCcSkRB9ndbsoHhxTpgWI8Jk5vNlrl/q6bdcixrFIjbfZ7ne1H4TuNTEdN5BdLo7WzlMrG
	GtpbjVTCECp2HowmThQ6Yo3rgUgbREK+T/uCkN0RdIrsZ59+mMoESHqI6myiBRIntxmfpMl7edk/x
	ssw6crZbUwLwMJz1IkTNmO7col9AyYnKqTaqIi5s+uLkoDW2DLK+SYcyCMq51CIAJjxOCWQQDlVdr
	0QR8Gepe+HSwzE7hRc0bpsrSXUCqYdBGNe43iumaOM2o9H+7yVC5CvPEEaiJUypw9d+TlEjFQxIJD
	W+ctOAJnXhf34sezOgsBC1v8b4027Sf6yrQWIrKJuGy1Ikw+pgPjlC4dBH33Z5wRPgigO4JPE05OW
	dza/Joef8nPZDfQ3ImYQfRSR3JYUGtItgoqP813pw=;
Received: from [2a02:587:6a09:4a00:71b3:b927:f95e:c3f5] (helo=localhost.localdomain)
	by devloop.tasossah.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.97)
	(envelope-from <tasos@tasossah.com>)
	id 1uGwHu-0000000CGRg-1lJS;
	Mon, 19 May 2025 11:55:58 +0300
From: Tasos Sahanidis <tasos@tasossah.com>
To: linux-ide@vger.kernel.org
Cc: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	Tasos Sahanidis <tasos@tasossah.com>
Subject: [PATCH v2] ata: pata_via: Force PIO for ATAPI devices on VT6415/VT6330
Date: Mon, 19 May 2025 11:49:45 +0300
Message-ID: <20250519085508.1398701-1-tasos@tasossah.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The controller has a hardware bug that can hard hang the system when
doing ATAPI DMAs without any trace of what happened. Depending on the
device attached, it can also prevent the system from booting.

In this case, the system hangs when reading the ATIP from optical media
with cdrecord -vvv -atip on an _NEC DVD_RW ND-4571A 1-01 and an
Optiarc DVD RW AD-7200A 1.06 attached to an ASRock 990FX Extreme 4,
running at UDMA/33.

The issue can be reproduced by running the same command with a cygwin
build of cdrecord on WinXP, although it requires more attempts to cause
it. The hang in that case is also resolved by forcing PIO. It doesn't
appear that VIA has produced any drivers for that OS, thus no known
workaround exists.

HDDs attached to the controller do not suffer from any DMA issues.

Link: https://bugs.launchpad.net/ubuntu/+source/linux/+bug/916677
Signed-off-by: Tasos Sahanidis <tasos@tasossah.com>
---
 v1 -> v2: Wrap long line

 drivers/ata/pata_via.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/ata/pata_via.c b/drivers/ata/pata_via.c
index 696b99720dcb..d82728a01832 100644
--- a/drivers/ata/pata_via.c
+++ b/drivers/ata/pata_via.c
@@ -368,7 +368,8 @@ static unsigned int via_mode_filter(struct ata_device *dev, unsigned int mask)
 	}
 
 	if (dev->class == ATA_DEV_ATAPI &&
-	    dmi_check_system(no_atapi_dma_dmi_table)) {
+	    (dmi_check_system(no_atapi_dma_dmi_table) ||
+	     config->id == PCI_DEVICE_ID_VIA_6415)) {
 		ata_dev_warn(dev, "controller locks up on ATAPI DMA, forcing PIO\n");
 		mask &= ATA_MASK_PIO;
 	}
-- 
2.43.0

